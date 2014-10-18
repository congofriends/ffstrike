class ChargesController < ApplicationController

	def new
	end

	def create
	  @amount = params[:donation].to_i*100
	  @comment= params[:comment]

	  customer = Stripe::Customer.create(
	    :email => params[:stripeEmail],
	    :card  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    customer:     customer.id,
	    amount:       @amount,
	    description:  'Rails Stripe customer',
	    currency:     'usd'
	  )
	  redirect_to root_path, notice: "Thank you for your contribution to Friends of the Congo.  Your donation of #{ActionController::Base.helpers.number_to_currency(@amount/100)} USD will help support the efforts of the Congo Youth Initiative." and return if charge
	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to charges_path

	end


end
