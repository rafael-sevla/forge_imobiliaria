carlos    = Client.find_by!(document_number: "123.456.789-00")
mariana   = Client.find_by!(document_number: "987.654.321-00")
horizonte = Client.find_by!(document_number: "12.345.678/0001-99")

cep_paulista   = Cep.find_by!(cep: "01310-100")
cep_se         = Cep.find_by!(cep: "01001-000")
cep_vila_mad   = Cep.find_by!(cep: "05434-000")
cep_campinas   = Cep.find_by!(cep: "13083-970")
cep_ipanema    = Cep.find_by!(cep: "22410-003")
cep_copacabana = Cep.find_by!(cep: "22010-001")

properties = [
  {
    title: "Apartamento Paulista - 3 quartos",
    description: "Apartamento moderno com 3 quartos, 2 banheiros e vaga de garagem. Vista para a Avenida Paulista.",
    is_for_sale: true,
    is_for_rent: false,
    sale_price: 950_000.00,
    commission_on_sales: 47_500.00,
    rental_deposit: 0.00,
    rental_fee: 0.00,
    rental_fee_due_day: 1,
    penalty_for_each_day_of_rent_overdue: 0.00,
    commission_on_rentals: 0.00,
    area: 110.50,
    cep: cep_paulista,
    address_number: "1000",
    complement: "Apto 142",
    owner: carlos
  },
  {
    title: "Casa Vila Madalena - 4 quartos",
    description: "Casa espaçosa em condomínio fechado, 4 quartos sendo 1 suíte, jardim e 2 vagas.",
    is_for_sale: false,
    is_for_rent: true,
    sale_price: 0.00,
    commission_on_sales: 0.00,
    rental_deposit: 7_200.00,
    rental_fee: 3_600.00,
    rental_fee_due_day: 10,
    penalty_for_each_day_of_rent_overdue: 3.60,
    commission_on_rentals: 360.00,
    area: 220.00,
    cep: cep_vila_mad,
    address_number: "80",
    owner: carlos
  },
  {
    title: "Cobertura Ipanema - 2 quartos",
    description: "Cobertura duplex com vista para o mar, 2 quartos, terraço e piscina privativa.",
    is_for_sale: true,
    is_for_rent: true,
    sale_price: 3_500_000.00,
    commission_on_sales: 175_000.00,
    rental_deposit: 30_000.00,
    rental_fee: 15_000.00,
    rental_fee_due_day: 5,
    penalty_for_each_day_of_rent_overdue: 15.00,
    commission_on_rentals: 1_500.00,
    area: 185.00,
    cep: cep_ipanema,
    address_number: "120",
    complement: "Cobertura",
    owner: mariana
  },
  {
    title: "Sala Comercial Centro - 45m²",
    description: "Sala comercial no centro de São Paulo, andar alto, recepção e 3 ambientes.",
    is_for_sale: true,
    is_for_rent: true,
    sale_price: 420_000.00,
    commission_on_sales: 21_000.00,
    rental_deposit: 8_000.00,
    rental_fee: 4_000.00,
    rental_fee_due_day: 15,
    penalty_for_each_day_of_rent_overdue: 4.00,
    commission_on_rentals: 400.00,
    area: 45.00,
    cep: cep_se,
    address_number: "200",
    complement: "Sala 501",
    owner: horizonte
  },
  {
    title: "Apartamento Copacabana - 1 quarto",
    description: "Apartamento compacto a 2 quadras da praia, totalmente reformado, mobiliado.",
    is_for_sale: false,
    is_for_rent: true,
    sale_price: 0.00,
    commission_on_sales: 0.00,
    rental_deposit: 5_000.00,
    rental_fee: 2_500.00,
    rental_fee_due_day: 10,
    penalty_for_each_day_of_rent_overdue: 2.50,
    commission_on_rentals: 250.00,
    area: 42.00,
    cep: cep_copacabana,
    address_number: "890",
    complement: "Apto 201",
    owner: mariana
  }
]

properties.each do |attrs|
  Property.find_or_create_by!(title: attrs[:title], owner: attrs[:owner]) do |p|
    p.description                        = attrs[:description]
    p.is_for_sale                        = attrs[:is_for_sale]
    p.is_for_rent                        = attrs[:is_for_rent]
    p.sale_price                         = attrs[:sale_price]
    p.commission_on_sales                = attrs[:commission_on_sales]
    p.rental_deposit                     = attrs[:rental_deposit]
    p.rental_fee                         = attrs[:rental_fee]
    p.rental_fee_due_day                 = attrs[:rental_fee_due_day]
    p.penalty_for_each_day_of_rent_overdue = attrs[:penalty_for_each_day_of_rent_overdue]
    p.commission_on_rentals              = attrs[:commission_on_rentals]
    p.area                               = attrs[:area]
    p.cep                                = attrs[:cep]
    p.address_number                     = attrs[:address_number]
    p.complement                         = attrs[:complement]
    p.owner                              = attrs[:owner]
  end
end

puts "Properties: #{Property.count}"
