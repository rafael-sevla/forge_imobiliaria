class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]

  def index
    @clients = Client.order(:name)
  end

  def show
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    set_cep_from_code
    set_phones_from_text

    if @client.save
      redirect_to clients_path, notice: "Cliente criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    set_cep_from_code
    set_phones_from_text

    if @client.update(client_params)
      redirect_to clients_path, notice: "Cliente atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @client.destroy
    redirect_to clients_path, notice: "Cliente removido com sucesso."
  rescue ActiveRecord::DeleteRestrictionError
    redirect_to clients_path, alert: "Não é possível remover este cliente pois ele possui registros vinculados."
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(
      :name, :document_type, :document_number, :marital_status,
      :cep_id, :address_number, :complement,
      :email, :birth_date, :nationality, :profession
    )
  end

  def set_cep_from_code
    cep_code = params.dig(:client, :cep_code)&.gsub(/\D/, "")
    return if cep_code.blank?

    cep = Cep.find_by(cep: cep_code)
    @client.cep = cep if cep
  end

  def set_phones_from_text
    phones_text = params.dig(:client, :phones_text)
    return if phones_text.nil?

    @client.phones = phones_text.split(/[\n,]/).map(&:strip).reject(&:blank?)
  end
end
