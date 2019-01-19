class PaymentsController < ApplicationController
    TRANSACTION_SUCCESS_STATUSES = [
        Braintree::Transaction::Status::Authorizing,
        Braintree::Transaction::Status::Authorized,
        Braintree::Transaction::Status::Settled,
        Braintree::Transaction::Status::SettlementConfirmed,
        Braintree::Transaction::Status::SettlementPending,
        Braintree::Transaction::Status::Settling,
        Braintree::Transaction::Status::SubmittedForSettlement,
    ]
  
    def new
        puts "PAYMENTS NEW"
        @client_token = gateway.client_token.generate
    end

    def show
        puts "PAYMENTS SHOW"
        @transaction = gateway.transaction.find(params[:id])
        @result = _create_result_hash(@transaction)
    end

    def create
        puts "PAYMENTS CREATE"
        amount = params["amount"] 
        nonce = params["payment_method_nonce"]

        result = gateway.transaction.sale(
            amount: amount,
            payment_method_nonce: nonce,
            :options => {
                :submit_for_settlement => true
            }
        )
        
        puts result.inspect

        if result.success? || result.transaction
            puts "[SUCCESS] Payment completed"
            redirect_to "http://192.168.69.100:3000/success"
        else
            puts "[ERROR] Payment NOT completed"
            error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
            redirect_to "http://192.168.69.100:3000/error"
        end
    end

    def _create_result_hash(transaction)
        status = transaction.status

        if TRANSACTION_SUCCESS_STATUSES.include? status
            result_hash = {
                :header => "Sweet Success!",
                :icon => "success",
                :message => "Your test transaction has been successfully processed. See the Braintree API response and try again."
            }
        else
            result_hash = {
                :header => "Transaction Failed",
                :icon => "fail",
                :message => "Your test transaction has a status of #{status}. See the Braintree API response and try again."
            }
        end
    end

    def gateway
        env = ENV["BT_ENVIRONMENT"]

        @gateway ||= Braintree::Gateway.new(
            :environment => :sandbox,
            :merchant_id => "hsst2kkt55f4s9cz",
            :public_key => "ztqjzs2wmjm344mq",
            :private_key => "76c6309f7aa452b19137cfd8fb4e36ae",
        )
    end

    private
    def payments_params
        params.permit(:price, :orderId, :amount, :payment_method_nonce) #:orderId jeszcze?
    end
end
