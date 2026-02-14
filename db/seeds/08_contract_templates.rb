templates = [
  {
    name: "Contrato Padrão de Compra e Venda",
    contract_type: "sale",
    content: <<~TEXT
      CONTRATO PARTICULAR DE COMPRA E VENDA DE IMÓVEL

      Pelo presente instrumento particular, as partes abaixo qualificadas:

      VENDEDOR: {{seller_name}}, {{seller_document_type}} nº {{seller_document_number}},
      residente à {{seller_address}}.

      COMPRADOR: {{buyer_name}}, {{buyer_document_type}} nº {{buyer_document_number}},
      residente à {{buyer_address}}.

      Têm entre si justo e contratado o seguinte:

      CLÁUSULA 1ª – DO OBJETO
      O VENDEDOR vende ao COMPRADOR o imóvel situado à {{property_address}},
      com área de {{property_area}} m².

      CLÁUSULA 2ª – DO PREÇO
      O preço total da venda é de R$ {{sale_price}}, a ser pago conforme
      acordado entre as partes.

      CLÁUSULA 3ª – DA COMISSÃO
      A comissão de corretagem no valor de R$ {{sale_commission}} será paga
      à imobiliária.

      CLÁUSULA 4ª – DO PRAZO
      A transferência do imóvel ocorrerá em até 30 dias após a assinatura deste contrato.

      E por estarem justos e acordados, as partes assinam o presente contrato.

      Local e data: {{signed_at}}

      ___________________________          ___________________________
      VENDEDOR                                         COMPRADOR
    TEXT
  },
  {
    name: "Contrato Padrão de Locação Residencial",
    contract_type: "rent",
    content: <<~TEXT
      CONTRATO DE LOCAÇÃO RESIDENCIAL

      Pelo presente instrumento, as partes:

      LOCADOR: {{seller_name}}, {{seller_document_type}} nº {{seller_document_number}},
      residente à {{seller_address}}.

      LOCATÁRIO: {{tenant_name}}, {{tenant_document_type}} nº {{tenant_document_number}},
      residente à {{tenant_address}}.

      Têm entre si justo e contratado:

      CLÁUSULA 1ª – DO OBJETO
      O LOCADOR cede ao LOCATÁRIO o imóvel situado à {{property_address}},
      para fins residenciais.

      CLÁUSULA 2ª – DO PRAZO
      O prazo de locação é de 12 (doze) meses, com início em {{start_date}}
      e término em {{end_date}}.

      CLÁUSULA 3ª – DO ALUGUEL
      O aluguel mensal é de R$ {{rental_fee}}, com vencimento todo dia {{rental_due_day}}
      de cada mês.

      CLÁUSULA 4ª – DO DEPÓSITO CAUÇÃO
      O LOCATÁRIO deposita a título de caução o valor de R$ {{rental_deposit}},
      a ser devolvido ao término do contrato, deduzidos eventuais débitos.

      CLÁUSULA 5ª – DA MULTA POR ATRASO
      O não pagamento no prazo acarretará multa de R$ {{penalty_per_day}} por dia de atraso.

      CLÁUSULA 6ª – DA COMISSÃO
      A comissão de administração no valor de R$ {{rental_commission}} será descontada
      mensalmente do repasse ao LOCADOR.

      E por estarem justos e acordados, as partes assinam o presente contrato.

      Local e data: {{signed_at}}

      ___________________________          ___________________________
      LOCADOR                                          LOCATÁRIO
    TEXT
  },
  {
    name: "Contrato de Locação Comercial",
    contract_type: "rent",
    content: <<~TEXT
      CONTRATO DE LOCAÇÃO COMERCIAL

      Pelo presente instrumento, as partes:

      LOCADOR: {{seller_name}}, {{seller_document_type}} nº {{seller_document_number}},
      residente à {{seller_address}}.

      LOCATÁRIO: {{tenant_name}}, {{tenant_document_type}} nº {{tenant_document_number}},
      com sede à {{tenant_address}}.

      Têm entre si justo e contratado:

      CLÁUSULA 1ª – DO OBJETO
      O LOCADOR cede ao LOCATÁRIO o imóvel situado à {{property_address}},
      para fins comerciais.

      CLÁUSULA 2ª – DO PRAZO
      O prazo de locação é de 24 (vinte e quatro) meses, com início em {{start_date}}
      e término em {{end_date}}.

      CLÁUSULA 3ª – DO ALUGUEL
      O aluguel mensal é de R$ {{rental_fee}}, com vencimento todo dia {{rental_due_day}}.

      CLÁUSULA 4ª – DO DEPÓSITO CAUÇÃO
      O LOCATÁRIO deposita caução de R$ {{rental_deposit}}.

      CLÁUSULA 5ª – DA MULTA POR ATRASO
      Multa de R$ {{penalty_per_day}} por dia de atraso no pagamento.

      CLÁUSULA 6ª – DA COMISSÃO
      Comissão de administração de R$ {{rental_commission}} mensal.

      E por estarem justos e acordados, as partes assinam o presente contrato.

      Local e data: {{signed_at}}

      ___________________________          ___________________________
      LOCADOR                                          LOCATÁRIO
    TEXT
  }
]

templates.each do |attrs|
  ContractTemplate.find_or_create_by!(name: attrs[:name]) do |t|
    t.contract_type = attrs[:contract_type]
    t.content       = attrs[:content]
  end
end

puts "Contract Templates: #{ContractTemplate.count}"
