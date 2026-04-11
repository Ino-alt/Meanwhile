class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_user

  # cookieのguest_idをもとにUserを取得または作成する。ビューからも参照可能
  def current_user
    @current_user ||= User.create_or_find_by!(guest_id: guest_id_from_cookie)
  end

  private

  # cookieにguest_idが存在すればその値を返す。なければUUIDを生成してsigned cookieに1年間保存する
  def guest_id_from_cookie
    cookies.signed[:guest_id] || begin
      uuid = SecureRandom.uuid
      cookies.signed[:guest_id] = { value: uuid, expires: 1.year }
      uuid
    end
  end
end
