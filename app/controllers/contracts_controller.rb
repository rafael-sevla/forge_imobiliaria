class ContractsController < ApplicationController
  before_action :set_contract, only: %i[show edit update destroy]

  def index
    @contracts = Contract.includes(:property, :seller, :buyer, :tenant).order(created_at: :desc)
  end

  def show
    @payments = @contract.payments.by_date
  end

  def new
    @contract = Contract.new(status: "active", rental_due_day: 1)
    load_form_data
  end

  def create
    @contract = Contract.new(contract_params)

    if @contract.save
      redirect_to contracts_path, notice: "Contrato criado com sucesso."
    else
      load_form_data
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    load_form_data
  end

  def update
    if @contract.update(contract_params)
      redirect_to contracts_path, notice: "Contrato atualizado com sucesso."
    else
      load_form_data
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @contract.destroy
    redirect_to contracts_path, notice: "Contrato removido com sucesso."
  rescue ActiveRecord::DeleteRestrictionError
    redirect_to contracts_path, alert: "Não é possível remover este contrato pois ele possui pagamentos vinculados."
  end

  private

  def set_contract
    @contract = Contract.find(params[:id])
  end

  def load_form_data
    @properties    = Property.order(:title).pluck(:title, :id)
    @clients       = Client.order(:name).pluck(:name, :id)
    @templates     = ContractTemplate.order(:name).pluck(:name, :id)
  end

  def contract_params
    params.require(:contract).permit(
      :contract_number, :contract_type, :status,
      :property_id, :seller_id, :buyer_id, :tenant_id,
      :start_date, :end_date, :signed_at,
      :sale_price, :sale_commission,
      :rental_fee, :rental_deposit, :rental_commission, :rental_due_day, :penalty_per_day,
      :contract_template_id, :contract_content, :notes
    )
  end
end
