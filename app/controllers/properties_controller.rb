class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]

  def index
    @properties = Property.includes(:owner, cep: { neighborhood: { city: :state } }).order(:title)
  end

  def show
  end

  def new
    @property = Property.new(is_for_sale: true, rental_fee_due_day: 1)
    load_form_data
  end

  def create
    @property = Property.new(property_params)
    set_cep_from_code

    if @property.save
      redirect_to properties_path, notice: "Imóvel criado com sucesso."
    else
      load_form_data
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    load_form_data
  end

  def update
    set_cep_from_code

    if @property.update(property_params)
      redirect_to properties_path, notice: "Imóvel atualizado com sucesso."
    else
      load_form_data
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy
    redirect_to properties_path, notice: "Imóvel removido com sucesso."
  rescue ActiveRecord::DeleteRestrictionError
    redirect_to properties_path, alert: "Não é possível remover este imóvel pois ele possui contratos vinculados."
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def load_form_data
    @clients = Client.order(:name).pluck(:name, :id)
  end

  def property_params
    params.require(:property).permit(
      :title, :description, :area,
      :cep_id, :address_number, :complement,
      :owner_id,
      :is_for_sale, :sale_price, :commission_on_sales,
      :is_for_rent, :rental_fee, :rental_deposit, :commission_on_rentals,
      :rental_fee_due_day, :penalty_for_each_day_of_rent_overdue
    )
  end

  def set_cep_from_code
    cep_code = params.dig(:property, :cep_code)&.gsub(/\D/, "")
    return if cep_code.blank?

    cep = Cep.find_by(cep: cep_code)
    @property.cep = cep if cep
  end
end
