require 'rails_helper'

RSpec.describe ChargesController, type: :controller do 

  before(:all) do 
    @token = Stripe::Token.create(
      :card => {          
        :number => "4242424242424242",
        :exp_month => 7,
        :exp_year => 2019,
        :cvc => "314",
        :address_line1 => Faker::Address.street_address,
        :address_city => Faker::Address.city,
        :address_zip => Faker::Address.postcode,
        :address_country => 'United Kingdom'
      }
    )
  end  

  describe "GET #new" do
    it "responds to GET" do
      get :new
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    it 'Stripe payment complete' do     
      params = {
        authenticity_token: "rljEmgoIzFnA3tOYQuFZPla3SwIyqjnFq3yaI+1eqTK191B3bphNrwass9WSSy4S/fRD2wT22ePnnIMvZZCYvw==",
        stripeToken: @token.id,
        stripeTokenType: "card",
        stripeEmail: "mkmailapp@gmail.com"
      } 
      post :create, params: params      
      expect(response.status).to eq 200
    end

    it 'call stripe api and get successful output' do
      customer = Stripe::Customer.create({
        email: 'mkmailapp@gmail.com',
        source: @token.id
      })

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => 500,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
      )
      expect(response.status).to eq 200
      expect(customer.email).to eq('mkmailapp@gmail.com')
      expect(charge.description).to eq('Rails Stripe customer')
    end
  end 
end