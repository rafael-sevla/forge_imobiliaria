ceps = [
  { cep: "01310-100", street: "Avenida Paulista",          neighborhood: "Paulista",      city: "São Paulo",      state: "SP" },
  { cep: "01001-000", street: "Praça da Sé",               neighborhood: "Centro",        city: "São Paulo",      state: "SP" },
  { cep: "05434-000", street: "Rua Aspicuelta",            neighborhood: "Vila Madalena", city: "São Paulo",      state: "SP" },
  { cep: "13010-111", street: "Rua Conceição",             neighborhood: "Centro",        city: "Campinas",       state: "SP" },
  { cep: "13083-970", street: "Avenida Albert Einstein",   neighborhood: "Barão Geraldo", city: "Campinas",       state: "SP" },
  { cep: "20040-020", street: "Avenida Rio Branco",        neighborhood: "Centro",        city: "Rio de Janeiro", state: "RJ" },
  { cep: "22410-003", street: "Rua Visconde de Pirajá",    neighborhood: "Ipanema",       city: "Rio de Janeiro", state: "RJ" },
  { cep: "22010-001", street: "Avenida Nossa Sra. Copacabana", neighborhood: "Copacabana", city: "Rio de Janeiro", state: "RJ" },
  { cep: "30130-110", street: "Rua dos Carijós",           neighborhood: "Centro",        city: "Belo Horizonte", state: "MG" },
  { cep: "30130-170", street: "Rua Pernambuco",            neighborhood: "Savassi",       city: "Belo Horizonte", state: "MG" }
]

ceps.each do |attrs|
  state        = State.find_by!(abbreviation: attrs[:state])
  city         = City.find_by!(name: attrs[:city], state: state)
  neighborhood = Neighborhood.find_by!(name: attrs[:neighborhood], city: city)
  Cep.find_or_create_by!(cep: attrs[:cep]) do |c|
    c.street       = attrs[:street]
    c.neighborhood = neighborhood
  end
end

puts "Ceps: #{Cep.count}"
