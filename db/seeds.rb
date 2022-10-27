# frozen_string_literal: true

User.where(name: 'admin').delete
user = User.new
user.name = 'admin'
user.email = 'admin@example.com'
user.password = 'password'
user.password_confirmation = 'password'
user.save
