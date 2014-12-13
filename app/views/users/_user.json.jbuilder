json.call(user,
          :id, :first_name, :last_name, :display_name,
          :profile_picture, :created_at, :updated_at
)

if defined?(include_authorization) && include_authorization
  json.call(user, :token)
end
