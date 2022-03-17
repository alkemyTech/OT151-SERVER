# frozen_string_literal: true

module RequestHelpers
  def body_json
    JSON.parse(response.body)
  end

  def attributes_json
    if body_json['serialize_user']
      JSON.parse(body_json['serialize_user'])['data']['attributes']
    else
      body_json['data']['attributes']
    end
  end

  def auth_header(user_id)
    { 'Authorization' => "Bearer #{JsonWebToken.encode({ user_id: user_id })}" }
  end

  def admin_header
    admin_id = create(:user, role_id: create(:role, name: 'admin').id).id
    auth_header(admin_id)
  end

  def image_path
    Rails.root.join('spec/factories_files/test.png')
  end
end
