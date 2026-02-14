neighborhoods = [
  { name: "Centro",          city: "São Paulo",      state: "SP" },
  { name: "Paulista",        city: "São Paulo",      state: "SP" },
  { name: "Vila Madalena",   city: "São Paulo",      state: "SP" },
  { name: "Centro",          city: "Campinas",       state: "SP" },
  { name: "Barão Geraldo",   city: "Campinas",       state: "SP" },
  { name: "Centro",          city: "Rio de Janeiro", state: "RJ" },
  { name: "Ipanema",         city: "Rio de Janeiro", state: "RJ" },
  { name: "Copacabana",      city: "Rio de Janeiro", state: "RJ" },
  { name: "Centro",          city: "Belo Horizonte", state: "MG" },
  { name: "Savassi",         city: "Belo Horizonte", state: "MG" }
]

neighborhoods.each do |attrs|
  state = State.find_by!(abbreviation: attrs[:state])
  city  = City.find_by!(name: attrs[:city], state: state)
  Neighborhood.find_or_create_by!(name: attrs[:name], city: city)
end

puts "Neighborhoods: #{Neighborhood.count}"
