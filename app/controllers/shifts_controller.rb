class ShiftsController < ApplicationController
  def new
    @available_places = get_places
  end

  def create
    flash[:alert] = nil
    @available_places = get_places

    date = check_date params[:date]
    return if date.nil?
    # TODO: Check if date in range

    start_time = check_time "#{date} #{params[:startTime]}"
    return if start_time.nil?

    end_time = check_time "#{date} #{params[:endTime]}"
    return if end_time.nil?

    # TODO: Check if time in range

    if start_time >= end_time
      flash[:alert] = 'Error: Start Time should not later than End Time'
      render 'new'
      return
    end

    place = check_place params[:place]
    return if place.nil?

    result = check_permission start_time
    if params[:further].nil? && !result
      render 'new'
      return
    end

    shift = Shift.new
    shift.start_time = start_time
    shift.end_time = end_time
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

  def get_places
    places = []
    KeyValue.where(key_type: 'places').each do |place|
      places << place.value
    end
    places.join(';')
  end

  def check_date(date)
    return Date.strptime(date, '%m/%d/%Y')
  rescue => error
    flash[:alert] = 'Error: ' + error.message
    render 'new'
  end

  def check_time(time)
    return Time.zone.parse time
  rescue => error
    flash[:alert] = 'Error: ' + error.message
    render 'new'
  end

  def check_place(place)
    key_value = KeyValue.find_by key_type: 'places', value: place

    if key_value.nil?
      flash[:alert] = 'Error: Place Not Found'
      render 'new'
      return
    end

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
