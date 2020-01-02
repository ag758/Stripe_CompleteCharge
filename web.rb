require 'sinatra'
require 'stripe'
require 'json'

#2
Stripe.api_key = 'sk_live_Uzg5XubmD84VMDC1uLEcINwg00zyaIxk9r'

#3
get '/' do
    status 200
    return "TicketHawk backend has been set up correctly"
end

#4
post '/charge' do
    #5
    payload = params
    if request.content_type.include? 'application/json' and params.empty?
        payload = indifferent_params(JSON.parse(request.body.read))
    end
    
    begin
        #6
        
        charge = Stripe::Charge.create(
                                       {
                                       amount: payload[:amount],
                                       currency: payload[:currency],
                                       source: payload[:token],
                                       description: payload[:description],
                                       application_fee_amount: payload[:application_fee_amount],
                                       
                                       transfer_data: {
                                      
                                       destination: payload[:account_id]
                                       
                                       }
                                       
                                       }
                                       )
                                       #7
                                       rescue Stripe::StripeError => e
                                       status 402
                                       return "Error creating charge: #{e.message}"
        
        
        
    end
    #8
    status 200
    return "Charge successfully created"
    
    end
