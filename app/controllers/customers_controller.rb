class CustomersController < ApplicationController
  before_action :set_customer, only: %i[ show update destroy ]

  # GET /customers
  def index
    @customers = Customer.includes(:address).all
    render json: @customers.map { CustomerSerializer.new(_1) }
  end

  # GET /customers/1
  def show
    render json: CustomerSerializer.new(@customer)
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: CustomerSerializer.new(@customer), status: :created
    else
      render json: @customer.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params)
      render json: CustomerSerializer.new(@customer)
    else
      render json: @customer.errors, status: :unprocessable_content
    end
  end

  # DELETE /customers/1
  def destroy
    @customer.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.includes(:address).find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.permit(:address_id, :name, :email, :tax_id, :phone,
        address_attributes: [ :link, :place, :cep, :number, :address, :complement, :neighborhood, :city, :state ]
      )
    end
end
