json.users @users.each do |user|
  json.call(user, :id, :first_name, :last_name, :email, :role, :created_at, :updated_at)
end
