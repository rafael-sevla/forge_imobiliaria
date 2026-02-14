cep_paulista    = Cep.find_by!(cep: "01310-100")
cep_se          = Cep.find_by!(cep: "01001-000")
cep_vila_mad    = Cep.find_by!(cep: "05434-000")
cep_campinas    = Cep.find_by!(cep: "13010-111")
cep_rio_branco  = Cep.find_by!(cep: "20040-020")
cep_ipanema     = Cep.find_by!(cep: "22410-003")
cep_copacabana  = Cep.find_by!(cep: "22010-001")
cep_bh_centro   = Cep.find_by!(cep: "30130-110")

clients = [
  # Proprietários (owners)
  {
    name: "Carlos Eduardo Mendes",
    email: "carlos.mendes@email.com",
    phones: [ "(11) 99234-5678" ],
    document_type: "cpf",
    document_number: "123.456.789-00",
    nationality: "Brasileiro",
    birth_date: Date.new(1975, 4, 12),
    profession: "Empresário",
    marital_status: "married",
    cep: cep_paulista,
    address_number: "1000"
  },
  {
    name: "Mariana Fonseca Lima",
    email: "mariana.lima@email.com",
    phones: [ "(21) 98876-5432" ],
    document_type: "cpf",
    document_number: "987.654.321-00",
    nationality: "Brasileira",
    birth_date: Date.new(1968, 9, 3),
    profession: "Médica",
    marital_status: "divorced",
    cep: cep_ipanema,
    address_number: "45",
    complement: "Apto 302"
  },
  # Compradores (buyers)
  {
    name: "Roberto Augusto Silveira",
    email: "roberto.silveira@email.com",
    phones: [ "(11) 97654-3210", "(11) 3344-5566" ],
    document_type: "cpf",
    document_number: "321.654.987-00",
    nationality: "Brasileiro",
    birth_date: Date.new(1982, 7, 28),
    profession: "Engenheiro",
    marital_status: "married",
    cep: cep_se,
    address_number: "200",
    complement: "Sala 501"
  },
  # Inquilinos (tenants)
  {
    name: "Ana Paula Rodrigues",
    email: "ana.rodrigues@email.com",
    phones: [ "(31) 99123-4567" ],
    document_type: "cpf",
    document_number: "456.789.123-00",
    nationality: "Brasileira",
    birth_date: Date.new(1990, 2, 14),
    profession: "Professora",
    marital_status: "single",
    cep: cep_bh_centro,
    address_number: "78"
  },
  {
    name: "Construtora Horizonte Ltda",
    email: "contato@horizonte.com.br",
    phones: [ "(11) 3211-4500" ],
    document_type: "cnpj",
    document_number: "12.345.678/0001-99",
    nationality: "Brasileira",
    marital_status: "not_informed",
    cep: cep_vila_mad,
    address_number: "350",
    complement: "Andar 8"
  }
]

clients.each do |attrs|
  Client.find_or_create_by!(document_number: attrs[:document_number]) do |c|
    c.name           = attrs[:name]
    c.email          = attrs[:email]
    c.phones         = attrs[:phones] || []
    c.document_type  = attrs[:document_type]
    c.nationality    = attrs[:nationality]
    c.birth_date     = attrs[:birth_date]
    c.profession     = attrs[:profession]
    c.marital_status = attrs[:marital_status]
    c.cep            = attrs[:cep]
    c.address_number = attrs[:address_number]
    c.complement     = attrs[:complement]
  end
end

puts "Clients: #{Client.count}"
