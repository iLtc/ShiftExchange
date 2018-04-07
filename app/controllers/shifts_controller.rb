class ShiftsController < ApplicationController
  before_action :load_current_user
  # skip_before_action :verify_authenticity_token

  include ApplicationConcern

  def index
    @shifts = Shift.where('date >= ?', Date.today)

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @shifts.to_json }
    end
  end

  def new
    @available_locations = list_locations
  end

  def create
    flash[:alert] = nil
    @available_locations = list_locations

    required_params = {
      date: 'Date',
      period: 'Period',
      start: 'Start Time',
      end: 'End Time',
      location: 'Location'
    }

    allowed_period = %w(breakfast lunch afternoon dinner)

    required_params.keys.each do |key|
      if params[key].nil?
        return render_error(required_params[key] + ' should not be empty!')
      end
    end

    date = check_date params[:date]
    return unless date

    # TODO: Check if date in range

    unless allowed_period.include? params[:period]
      return render_error('Period is unknown!')
    end

    start_time = check_time params[:date], params[:start]
    return unless start_time

    end_time = check_time params[:date], params[:end]
    return unless end_time

    # TODO: Check if time in range

    if start_time >= end_time
      return render_error('Start Time should not later than End Time!')
    end

    location = check_location params[:location]
    return unless location

    result = check_permission start_time, params[:further], params[:comment]
    return render 'new' unless result

    shift = Shift.new
    shift.location = location
    shift.shift_type = if params[:further] == 'permission'
                         'permission'
                       elsif params[:further] == 'post'
                         'post'
                       else
                         'normal'
                       end

    shift.status = if params[:further] == 'permission'
                     'pending'
                   else
                     'approved'
                   end

    shift.date = date
    shift.period = params[:period]
    shift.start = start_time
    shift.end = end_time

    shift.save

    shift_user = ShiftUser.new
    shift_user.shift = shift
    shift_user.user = @current_user
    shift_user.role = 'poster'

    shift_user.save

    flash[:notice] = if shift.status == 'approved'
                       'Your shift has been posted!'
                     else
                       'Your shift has been submitted! A manager will review it.'
                     end
    redirect_to shifts_path
  end

  private

  def load_current_user
    if session[:uid].nil?
      unless params[:action] == 'index'
        redirect_to new_session_path
      end
      return
    end

    @current_user = User.find session[:uid]
  end

  def list_locations
    places = []
    KeyValue.where(key_type: 'locations').each do |place|
      places << place.value
    end
    places.join(';')
  end

  def render_error(msg, type=:alert)
    flash[type] = msg
    render 'new'

    false
  end

  def check_date(date)
    date = Date.strptime(date, '%m/%d/%Y')

    if date <= Date.today
      return render_error('Date should be in the future!')
    end

    date
  rescue => error
    render_error('Error: ' + error.message)
  end

  def check_time(date, time)
    Time.strptime("#{date} #{time}", '%m/%d/%Y %I:%M %P')
  rescue
    render_error('Error: invalid time')
  end

  def check_location(place)
    key_value = KeyValue.find_by key_type: 'locations', value: place

    return render_error('Location not found!') if key_value.nil?

    key_value.key
  end

  def check_permission(start_time, further, comment)
    @further_info = nil

    if @current_user.credits <= 0
      @further_info = 'You do not have enough credits. '
    end

    if start_time < Time.now + 7.days
      @further_info = if @further_info.nil?
                        'Your Start Time is less than 7 days. '
                      else
                        @further_info += 'Your Start Time is less than 7 days. '
                      end
    end

    return true if @further_info.nil?

    return true if further == 'post'

    if further == 'permission'
      if comment.empty?
        flash[:alert] = 'Please fill a comment!'
        return false
      else
        return true
      end
    end

    false

  end
end
