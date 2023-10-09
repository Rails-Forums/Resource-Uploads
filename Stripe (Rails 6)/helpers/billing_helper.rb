module BillingHelper
  def check_billing
    if user_signed_in?
      if current_user.role == "admin"
      else
        if current_user.stripe_id == nil
          redirect_to billing_path, notice: "You need to be paying in order to use this"
        else
          # Grab the customer and subscription
          customer = Stripe::Customer.retrieve current_user.stripe_id
          subscriptions = Stripe::Subscription.list(customer: customer.id)

          if subscriptions.first == nil
            redirect_to billing_path, notice: "You need to be paying in order to use this"
          end
        end
      end
    end
  end
end
