class PaymentsController < ApplicationController
  before_action :set_contract
  before_action :set_payment, only: %i[edit update destroy]

  def new
    @payment = @contract.payments.build
  end

  def create
    @payment = @contract.payments.build(payment_params)

    if @payment.save
      redirect_to contract_path(@contract), notice: "Pagamento registrado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @payment.update(payment_params)
      redirect_to contract_path(@contract), notice: "Pagamento atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @payment.destroy
    redirect_to contract_path(@contract), notice: "Pagamento removido com sucesso."
  end

  private

  def set_contract
    contract_id = params[:contract_id] || Payment.find(params[:id]).contract_id
    @contract = Contract.find(contract_id)
  end

  def set_payment
    @payment = @contract.payments.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :payment_date, :payment_method, :notes)
  end
end
