class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth["provider"], :uid => auth["uid"]).first_or_initialize(
      :refresh_token => auth["credentials"]["refresh_token"],
      :access_token => auth["credentials"]["token"],
      :expires => auth["credentials"]["expires_at"],
      :name => auth["info"]["name"],
    )

    complete_login(user)
  end

  def login_as
    raise "Not supported outside of test" unless Rails.env.test?

    user = User.find(params[:user_id])
    complete_login(user)
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Signed out!"
    redirect_to root_url
  end

  private

  def complete_login(user)
    return_to = session[:return_to]
    session[:return_to] = nil

    if user.save
      session[:user_id] = user.id
      flash[:notice] = "Signed in!"

      url = return_to || default_login_url(user)
      url = root_path if url.eql?('/logout')
      logger.debug "URL to redirect to: #{url}"

      redirect_to url, :notice => notice
    else
      raise "Failed to login"
    end
  end

  def default_login_url(user)
    if user.team_members.any?
      dashboard_team_member_path(user.team_members.first)
    else
      root_path
    end
  end
end
