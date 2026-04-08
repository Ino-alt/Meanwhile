class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_user

  def current_user
    @current_user ||= User.find_or_create_by!(guest_id: guest_id_from_cookie)
  end

  private

  def guest_id_from_cookie
    cookies[:guest_id] ||= { value: SecureRandom.uuid, expires: 1.year }
  end
end
