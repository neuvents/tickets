class OrdersController < ApplicationController
  def create
    render json: create_order, serializer: OrderSerializer
  end

  private

  def create_order
    Orders::Create.new(Orders::Params.new(order_params)).run
  end

  def order_params
    params.require(:order).permit(
      :first_name, :last_name, :email,
      :payment_type, :date, :legal_entity,
      :company, :company_uid, :company_vat_uid,
      :country, :city, :zip, :address,
      tickets: [
        :ticket_type,
        :first_name,
        :last_name,
        :email,
        fields: [:name, :value]
      ]
    )
  end
end
