User.find_or_create_by!(email: "admin@forgeimobiliaria.com.br") do |user|
  user.name = "Administrador"
  user.password = "password123"
  user.password_confirmation = "password123"
  user.is_active = true
end

puts "Users: #{User.count}"
