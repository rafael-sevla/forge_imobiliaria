class DashboardController < ApplicationController
  def index
    @total_clients    = Client.count
    @total_properties = Property.count
    @total_contracts  = Contract.count
    @total_payments   = Payment.count

    @active_contracts  = Contract.active.count
    @sale_contracts    = Contract.active.sales.count
    @rental_contracts  = Contract.active.rentals.count

    @properties_for_sale = Property.for_sale.count
    @properties_for_rent = Property.for_rent.count

    # Receita do mês atual
    start_of_month = Date.current.beginning_of_month
    end_of_month   = Date.current.end_of_month
    @monthly_revenue = Payment.where(payment_date: start_of_month..end_of_month).sum(:amount)

    # Receita total
    @total_revenue = Payment.sum(:amount)

    # Contratos recentes
    @recent_contracts = Contract.includes(:property, :seller)
                                .order(created_at: :desc)
                                .limit(5)

    # Pagamentos recentes
    @recent_payments = Payment.includes(contract: :property)
                              .order(payment_date: :desc)
                              .limit(5)
  end
end
