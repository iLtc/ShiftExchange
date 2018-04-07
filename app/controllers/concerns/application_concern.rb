module ApplicationConcern
  extend ActiveSupport::Concern

  included do
    helper_method :get_weekday
  end

  def get_weekday(date)
    Date::DAYNAMES[date.wday]
  end
end