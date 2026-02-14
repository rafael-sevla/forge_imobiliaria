class ContractTemplatesController < ApplicationController
  before_action :set_template, only: %i[show edit update destroy]

  def index
    @templates = ContractTemplate.order(:name)
  end

  def show
  end

  def new
    @template = ContractTemplate.new
  end

  def create
    @template = ContractTemplate.new(template_params)

    if @template.save
      redirect_to contract_templates_path, notice: "Modelo criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @template.update(template_params)
      redirect_to contract_templates_path, notice: "Modelo atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @template.destroy
    redirect_to contract_templates_path, notice: "Modelo removido com sucesso."
  end

  private

  def set_template
    @template = ContractTemplate.find(params[:id])
  end

  def template_params
    params.require(:contract_template).permit(:name, :contract_type, :content)
  end
end
