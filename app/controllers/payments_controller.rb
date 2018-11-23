class PaymentsController < ApplicationController
    def paypal
        puts "Paypal..."

        # require "./config/initializers/stripe"
        # @amount = 200
        
        # customer = Stripe::Customer.create(
        #     :email => "test@test.com",
        #     :source  => "tok_amex"
        # )

        # charge = Stripe::Charge.create(
        #     :customer    => customer.id,
        #     :amount      => @amount,
        #     :description => 'Rails Stripe customer',
        #     :currency    => 'usd'
        # )

        require 'paypal-sdk-rest'
        
        PayPal::SDK.configure(
            :mode => "sandbox", # "sandbox" or "live"
            :client_id => "AajDkIeamLrQkjCqsm1hP1DvWXJjdSzs5R5YZRHUJ-S8ppUdD-ImPtaZTVZbM8cKkvEtlHB6TA-TyEWJ",
            :client_secret => "EGMUPJw3Fvy1pdbrmNUDRoWB8E4HkvRfZfBZdgiQfJp1Nmi5BvJ9ZVwL8y6u4FTL7wWdPWFhkLbpTmZx",
            :ssl_options => { } )

        # Update client_id, client_secret and redirect_uri
        PayPal::SDK.configure({
            :openid_client_id     => "client_id",
            :openid_client_secret => "client_secret",
            :openid_redirect_uri  => "http://google.com"
        })
        include PayPal::SDK::OpenIDConnect
        
        # Generate URL to Get Authorize code
        puts Tokeninfo.authorize_url( :scope => "openid profile" )
        
        # Create tokeninfo by using AuthorizeCode from redirect_uri
        tokeninfo = Tokeninfo.create("Replace with Authorize Code received on redirect_uri")
        puts tokeninfo.to_hash
        
        # Refresh tokeninfo object
        tokeninfo = tokeninfo.refresh
        puts tokeninfo.to_hash
        
        # Create tokeninfo by using refresh token
        tokeninfo = Tokeninfo.refresh("Replace with refresh_token")
        puts tokeninfo.to_hash
        
        # Get Userinfo
        userinfo = tokeninfo.userinfo
        puts userinfo.to_hash
        
        # Get logout url
        put tokeninfo.logout_url


        # Build Payment object
        @payment = Payment.new({
            :intent =>  "sale",
            :payer =>  {
                :payment_method =>  "paypal" },
            :redirect_urls => {
                :return_url => "http://localhost:3000/payment/execute",
                :cancel_url => "http://localhost:3000/" },
            :transactions =>  [{
                :item_list => {
                :items => [{
                    :name => "item",
                    :sku => "item",
                    :price => "5",
                    :currency => "USD",
                    :quantity => 1 }]},
                :amount =>  {
                    :total =>  "5",
                    :currency =>  "USD" },
                :description =>  "This is the payment transaction description." }]
        })

        if @payment.create
            @payment.id     # Payment Id
        else
            @payment.error  # Error Hash
        end

    end

end
