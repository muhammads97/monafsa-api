json.user do
  json.partial! 'user', user: @user
end

json.token @token
json.expires_at @time