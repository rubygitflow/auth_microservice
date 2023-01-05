# frozen_string_literal: true

old_user_ids = User.where(name: 'admin').map(:id)
UserSession.where(user_id: old_user_ids).delete
User.where(name: 'admin').delete
user = User.new
user.name = 'admin'
user.email = 'admin@example.com'
user.password = 'password'
user.password_confirmation = 'password'
user.save
