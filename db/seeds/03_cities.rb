cities = [
  { name: "São Paulo",       state: "SP" },
  { name: "Campinas",        state: "SP" },
  { name: "Rio de Janeiro",  state: "RJ" },
  { name: "Belo Horizonte",  state: "MG" },
  { name: "Curitiba",        state: "PR" },
  { name: "Porto Alegre",    state: "RS" },
  { name: "Salvador",        state: "BA" },
  { name: "Fortaleza",       state: "CE" },
  { name: "Brasília",        state: "DF" },
  { name: "Manaus",          state: "AM" }
]

cities.each do |attrs|
  state = State.find_by!(abbreviation: attrs[:state])
  City.find_or_create_by!(name: attrs[:name], state: state)
end

puts "Cities: #{City.count}"
