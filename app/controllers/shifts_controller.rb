class ShiftsController < ApplicationController
  before_action :load_current_user
  # skip_before_action :verify_authenticity_token

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

    required_params.keys.each do |key|
      return render_error(required_params[key] + ' should not be empty!') if params[key].nil?
    end

    date = check_date params[:date]
    return unless date
    # TODO: Check if date in range

    start_time = check_time "#{date} #{params[:start]}"
    return render_error('Start Time should not be empty!') if start_time.nil?

    end_time = check_time "#{date} #{params[:end]}"
    return render_error('End Time should not be empty!') if end_time.nil?

    # TODO: Check if time in range

    return render_error('Start Time should not later than End Time!') if start_time >= end_time

    location = check_location params[:location]
    return if !location

    result = check_permission start_time
    if params[:further].nil? && !result
      return render_error(@further_info)
    end

    shift = Shift.new
    shift.start = start_time
    shift.end = end_time
    shift.from = @current_user

    shift.status = if result
                     'approved'
                   elsif params[:further] == 'post'
                     'post'
                   else
                     'pending'
                   end

    shift.save
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
    Date.strptime(date, '%m/%d/%Y')
  rescue => error
    render_error('Error: ' + error.message)
  end

  def check_time(time)
    Time.zone.parse time
  rescue => error
    render_error('Error: ' + error.message)
  end

  def check_location(place)
    key_value = KeyValue.find_by key_type: 'locations', value: place

    return render_error('Location not found!') if key_value.nil?

    key_value.key
  end

  def check_permission(start_time)
    if @current_user.credits <= 0
      @further_info = 'You do not have enough credits.'
    end

    if start_time < Time.now + 7.days
      @further_info = 'Your Start Time is less than 7 days.'
    end

    return true if @further_info.nil?

    false
  end
end
