# Default admin user
if AdminUser.count == 0 && !Rails.env.test?
  admin = User.create!(active: true, firstname: 'Admin', lastname: 'One', institution: 'Vizzuality', username: 'admin', email: 'admin@vizzuality.com', password: '12345678', password_confirmation: '12345678')
  admin.create_admin_user
end

puts ''
puts '***************************************************************************************'
puts '*                                                                                     *'
puts '* Admin user created (login: "admin@vizzuality.com" or "admin", password: "12345678") *'
puts '*                                                                                     *'
puts '***************************************************************************************'