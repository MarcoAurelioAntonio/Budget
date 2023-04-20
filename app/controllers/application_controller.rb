class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  check_authorization unless: :devise_controller?

  before_action :update_allowed_parameters, if: :devise_controller?

  def current_guest
    @current_guest ||= User.find(session[:guest_user_id] ||= create_guest_user.id)
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  private

  def create_guest_user
    guest_username = "guest_#{Time.now.to_i}"
    guest_user = User.create(name: guest_username, guest: true)
    session[:guest_user_id] = guest_user.id
    guest_user
  end
end
