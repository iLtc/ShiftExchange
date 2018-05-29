module ApplicationConcern
  extend ActiveSupport::Concern

  included do
    helper_method :get_weekday
  end

  def get_weekday(date)
    Date::DAYNAMES[date.wday]
  end

  def add_comment(user, content, target)
    if target.class == Shift
      Comment.create(user_id: user.id, content: content, target_type: 'shift', target_id: target.id)
    end
  end

  def add_log(user, action, target, data = nil)
    if target.class == Shift
      Log.create(user_id: user.id, action: action, target_type: 'shift', target_id: target.id, data:data.to_json)
    end
  end
end