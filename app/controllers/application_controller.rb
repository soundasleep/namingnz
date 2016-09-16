class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_team_member

  private

  def must_be_team_member
    return redirect_to root_path unless current_user.present?
    return redirect_to home_pending_path unless current_user.team_member?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_team_member
    raise "You have too many team members" unless current_user.team_members.count == 1
    current_user.team_members.first
  end
end
