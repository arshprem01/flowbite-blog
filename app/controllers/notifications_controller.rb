class NotificationsController < ApplicationController
  def index
    if Current.user
      @notifications = Current.user.notifications.order(created_at: :desc)
      Current.user.notifications.unread.update_all(read_at: Time.current)
    else
      redirect_to new_session_path, alert: "Please log in to view notifications"
    end
  end
end
