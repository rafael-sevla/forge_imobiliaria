contract_venda   = Contract.find_by!(contract_number: "VND-2026-0001")
contract_loc_001 = Contract.find_by!(contract_number: "LOC-2026-0001")
contract_loc_002 = Contract.find_by!(contract_number: "LOC-2026-0002")

payments = [
  # Pagamento da venda (entrada + saldo)
  {
    contract: contract_venda,
    amount: 190_000.00,
    payment_date: Date.new(2026, 1, 10),
    payment_method: "bank_transfer",
    notes: "Entrada de 20% do valor total"
  },
  {
    contract: contract_venda,
    amount: 760_000.00,
    payment_date: Date.new(2026, 2, 5),
    payment_method: "bank_transfer",
    notes: "Saldo via financiamento bancário"
  },

  # Aluguéis da Casa Vila Madalena
  {
    contract: contract_loc_001,
    amount: 3_600.00,
    payment_date: Date.new(2026, 2, 10),
    payment_method: "pix",
    notes: "Aluguel fevereiro/2026"
  },
  {
    contract: contract_loc_001,
    amount: 3_600.00,
    payment_date: Date.new(2026, 3, 10),
    payment_method: "pix",
    notes: "Aluguel março/2026"
  },

  # Aluguéis Copacabana
  {
    contract: contract_loc_002,
    amount: 2_500.00,
    payment_date: Date.new(2026, 3, 10),
    payment_method: "bank_transfer",
    notes: "Aluguel março/2026"
  }
]

payments.each do |attrs|
  Payment.find_or_create_by!(
    contract: attrs[:contract],
    payment_date: attrs[:payment_date],
    amount: attrs[:amount]
  ) do |p|
    p.payment_method = attrs[:payment_method]
    p.notes          = attrs[:notes]
  end
end

puts "Payments: #{Payment.count}"
