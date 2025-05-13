require 'rest-client'

class PaymentsController < ApplicationController
  before_action :authenticate_request

  def create
    order_id = "ORDER_#{SecureRandom.hex(10)}"
    amount = params[:amount].to_f
    customer_name = params[:name]
    customer_email = params[:email]
    customer_phone = params[:phone]
    
    payload = {
      order_id: order_id,
      order_amount: amount,
      order_currency: "INR",
      customer_details: {
        customer_id: "CUST_#{SecureRandom.hex(5)}",
        customer_name: customer_name,
        customer_email: customer_email,
        customer_phone: customer_phone
      },
      order_meta: {
        # return_url: "http://localhost:3001/payments/success?order_id=#{order_id}",
        return_url: "http://localhost:3000/payment/status?order_id=#{order_id}",
        notify_url: "http://localhost:3001/payments/webhook"
      }
    }.to_json

    headers = {
      "Content-Type": "application/json",
      "x-client-id": CASHFREE_APP_ID,
      "x-client-secret": CASHFREE_SECRET_KEY,
      "x-api-version": "2022-01-01"
    }

    begin
      p CASHFREE_BASE_URL
      p "CASHFREE_BASE_URL--------------"
      response = RestClient.post("#{CASHFREE_BASE_URL}/pg/orders", payload, headers)
      response_data = JSON.parse(response.body)
      p response_data
      p '----------------------------------------------------------------------------------'
      render json: { payment_link: response_data["payment_link"] }, status: :ok
    rescue RestClient::ExceptionWithResponse => e
      render json: { error: e.response }, status: :unprocessable_entity
    end
  end

  def success
    order_id = params[:order_id]
    p "----------------seccuss"
    p CASHFREE_BASE_URL
    headers = {
      "Content-Type": "application/json",
      "x-client-id": CASHFREE_APP_ID,
      "x-client-secret": CASHFREE_SECRET_KEY,
      "x-api-version": "2022-01-01"
    }

    response = RestClient.get("#{CASHFREE_BASE_URL}/pg/orders/#{order_id}", headers)
    payment_data = JSON.parse(response.body)
    p payment_data 

    if payment_data["order_status"] == "PAID"
      # Update order status in your database
      render json: { message: "Payment Successful", order_id: order_id }, status: :ok
    else
      render json: { error: "Payment not completed" }, status: :unprocessable_entity
    end
  end

  def webhook
    p "wehook------------"
    webhook_data = JSON.parse(request.body.read) # Read the incoming JSON payload
    order_id = webhook_data["order_id"]
    payment_status = webhook_data["order_status"] # Can be "PAID", "FAILED", etc.

    if payment_status == "PAID"
      # Update order status in the database
      # Order.find_by(order_id: order_id)&.update(status: "paid")
    elsif payment_status == "FAILED"
      # Handle failed payment
      # Order.find_by(order_id: order_id)&.update(status: "failed")
    end

    head :ok # Respond with HTTP 200 to acknowledge receipt
  end


end
