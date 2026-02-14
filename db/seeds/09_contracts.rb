carlos   = Client.find_by!(document_number: "123.456.789-00")
mariana  = Client.find_by!(document_number: "987.654.321-00")
roberto  = Client.find_by!(document_number: "321.654.987-00")
ana      = Client.find_by!(document_number: "456.789.123-00")
horizonte = Client.find_by!(document_number: "12.345.678/0001-99")

prop_paulista   = Property.find_by!(title: "Apartamento Paulista - 3 quartos")
prop_vila_mad   = Property.find_by!(title: "Casa Vila Madalena - 4 quartos")
prop_ipanema    = Property.find_by!(title: "Cobertura Ipanema - 2 quartos")
prop_copacabana = Property.find_by!(title: "Apartamento Copacabana - 1 quarto")

tmpl_sale       = ContractTemplate.find_by!(name: "Contrato Padrão de Compra e Venda")
tmpl_rent_res   = ContractTemplate.find_by!(name: "Contrato Padrão de Locação Residencial")

contracts = [
  # Contrato de venda - Apartamento Paulista para Roberto
  {
    contract_number: "VND-2026-0001",
    property: prop_paulista,
    contract_type: "sale",
    status: "completed",
    seller: carlos,
    buyer: roberto,
    tenant: nil,
    signed_at: Date.new(2026, 1, 10),
    start_date: Date.new(2026, 1, 10),
    end_date: Date.new(2026, 2, 10),
    sale_price: 950_000.00,
    sale_commission: 47_500.00,
    contract_template: tmpl_sale,
    notes: "Imóvel vendido com mobília incluída por acordo entre as partes."
  },
  # Contrato de aluguel - Casa Vila Madalena para Ana
  {
    contract_number: "LOC-2026-0001",
    property: prop_vila_mad,
    contract_type: "rent",
    status: "active",
    seller: carlos,
    buyer: nil,
    tenant: ana,
    signed_at: Date.new(2026, 1, 15),
    start_date: Date.new(2026, 2, 1),
    end_date: Date.new(2027, 1, 31),
    rental_fee: 3_600.00,
    rental_deposit: 7_200.00,
    rental_commission: 360.00,
    rental_due_day: 10,
    penalty_per_day: 3.60,
    contract_template: tmpl_rent_res,
    notes: "Locatária responsável pelas contas de água, luz e condomínio."
  },
  # Contrato de aluguel - Cobertura Ipanema para Horizonte
  {
    contract_number: "LOC-2026-0002",
    property: prop_copacabana,
    contract_type: "rent",
    status: "active",
    seller: mariana,
    buyer: nil,
    tenant: horizonte,
    signed_at: Date.new(2026, 2, 1),
    start_date: Date.new(2026, 3, 1),
    end_date: Date.new(2028, 2, 28),
    rental_fee: 2_500.00,
    rental_deposit: 5_000.00,
    rental_commission: 250.00,
    rental_due_day: 10,
    penalty_per_day: 2.50,
    contract_template: tmpl_rent_res,
    notes: "Uso para hospedagem corporativa. IPTU por conta do locador."
  }
]

contracts.each do |attrs|
  Contract.find_or_create_by!(contract_number: attrs[:contract_number]) do |c|
    c.property           = attrs[:property]
    c.contract_type      = attrs[:contract_type]
    c.status             = attrs[:status]
    c.seller             = attrs[:seller]
    c.buyer              = attrs[:buyer]
    c.tenant             = attrs[:tenant]
    c.signed_at          = attrs[:signed_at]
    c.start_date         = attrs[:start_date]
    c.end_date           = attrs[:end_date]
    c.sale_price         = attrs[:sale_price] || 0.00
    c.sale_commission    = attrs[:sale_commission] || 0.00
    c.rental_fee         = attrs[:rental_fee] || 0.00
    c.rental_deposit     = attrs[:rental_deposit] || 0.00
    c.rental_commission  = attrs[:rental_commission] || 0.00
    c.rental_due_day     = attrs[:rental_due_day] || 1
    c.penalty_per_day    = attrs[:penalty_per_day] || 0.00
    c.contract_template  = attrs[:contract_template]
    c.notes              = attrs[:notes]
  end
end

puts "Contracts: #{Contract.count}"
