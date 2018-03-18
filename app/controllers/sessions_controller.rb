class SessionsController < ApplicationController
  def new
    callback_url = request.base_url + sessions_path + '/callback'
    state = SecureRandom.hex

    session[:state] = state

    @demo_login_url = sessions_path + '/callback/Demo?state=' + state
  end

  def callback
    if params[:state] != session[:state]
      redirect_to new_session_path, alert: "Invalid State!"
      return
    end

    session.delete :state

    if params[:platform] == 'Demo'
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
    if params[:user] == '1'
      user = Role.where(title: 'Student').first.users.first
      return user.login_credentials.first.credential
    end

    if params[:user] == '2'
      user = Role.where(title: 'Student').first.users.second
      return user.login_credentials.first.credential
    end

    if params[:manager] == '1'
      user = Role.where(title: 'Manager').first.users.first
      return user.login_credentials.first.credential
    end
  end
end
