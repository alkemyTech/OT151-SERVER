# frozen_string_literal: true

module RequestHelpers
  def auth_header(user_id)
    { 'Authorization' => "Bearer #{JsonWebToken.encode({ user_id: user_id })}" }
  end

  def admin_header
    admin_id = create(:user, role_id: create(:role, name: 'admin').id).id
    auth_header(admin_id)
  end
end
