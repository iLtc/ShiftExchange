class SessionsController < ApplicationController
  def new
    callback_url = request.base_url + sessions_path + '/callback'
    state = SecureRandom.hex

    session[:state] = state

    @demo_login_url = sessions_path + '/callback/demo?state=' + state
  end

  def callback
    if params[:state] != session[:state]
      redirect_to new_session_path, alert: "Invalid State!"
      return
    end

    session.delete :state

    if params[:platform] == 'demo'
      # TODO: Remove Demo Users in the future
      uid = demo_callback
    else
      redirect_to new_session_path, alert: "Invalid Platform!"
      return
    end

    if uid.nil?
      redirect_to new_session_path, alert: "Unexpected Error: UID is nil"
      return
    end

    result = LoginCredential.where('credential = ? AND platform = ?', uid, params[:platform])

    if result.count.zero?
      redirect_to new_session_path, alert: "Login Credential Not Found!"
      return
    end

    user = result.first.user

    session[:uid] = user.id # TODO: Create Session Model

    # TODO: Redirect to previous page
    redirect_to root_path, notice: "Welcome, #{user.show_name}!"
  end

  def destroy
    session.delete :uid
    redirect_to root_path, notice: "Sign out successfully!"
  end

  private

  # TODO: Remove Demo Users in the future
  def demo_callback
    return 'SeO9xAuLuRrJgpiFJ9k0LdF7T_cFm5IZ' if params['manager'] == '1'

    'N8dg0KM5U_l3kAr7JkEegC8zxqanqRbo'
  end
end
