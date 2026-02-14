puts "\n== Limpando o banco de dados =="
[
  Payment, Contract, ContractTemplate,
  Property, Client,
  Cep, Neighborhood, City, State,
  User
].each do |model|
  model.delete_all
  puts "   #{model.name} removido"
end

puts "\n== Carregando seeds =="
Dir[File.join(__dir__, "seeds", "*.rb")].sort.each do |seed|
  puts "\n--> #{File.basename(seed)}"
  load seed
end

puts "\n== Resumo =="
puts "   Users:               #{User.count}"
puts "   States:              #{State.count}"
puts "   Cities:              #{City.count}"
puts "   Neighborhoods:       #{Neighborhood.count}"
puts "   Ceps:                #{Cep.count}"
puts "   Clients:             #{Client.count}"
puts "   Properties:          #{Property.count}"
puts "   Contract Templates:  #{ContractTemplate.count}"
puts "   Contracts:           #{Contract.count}"
puts "   Payments:            #{Payment.count}"
puts ""
