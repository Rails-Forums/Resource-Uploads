# Setting up Stripe for Rails 6

## Getting Started

#### Install python 2.7 (If using webpacker)

* [Python 2.7 Installer Page](https://www.python.org/downloads/release/python-2718/)
* Grab the installer that works for your machine
* Please not that brew no longer supports this version

#### Install the gem
```
gem 'stripe-rails'
bundle update
``` 
#### Add stripe_id to users
```
rails g migration AddStripe_idToUsers stripe_id:string
```

## Call checkout in Application layouts
#### Add the following lines
```
// Stripe
= javascript_include_tag 'https://checkout.stripe.com/checkout.js'
```

## Setting up the controllers
#### The Billing controller goes in the main folder
#### If using devise put the registration controller in the model you want to use devise for
* If not using devise grab the lines of code you need from that file. Which will be seen inside

## Configuring the Routes
```
# Stripe Billing
get 'billing/index', as: :billing
get '/card/new' => 'billing#new_card', as: :add_payment_method
post "/card" => "billing#create_card", as: :create_payment_method
get '/success' => 'billing#success', as: :success
post '/subscription' => 'billing#subscribe', as: :subscribe

# Devise controller reconazation
devise_for :users, controllers: {
  registrations: 'users/registrations'
}
```
* Devise route is optional if you dont have devise(If you have devise you need it)

### Place the billing folder in the views
#### This will have the neccessary files needed edit to what fits you're needs best

### Setting up Stripe

* Go to stripe.com
* Create a Account
* Get to the Dashboard screen
* Turn on Test Mode
* Go to More/Billing (Here you can add what you would like)
* Click the developers option (Top Bar)
* Click Api Keys
* Add these keys to the master.key file

## Edit the master.key
#### Run the command below
```
EDITOR="code --wait" bin/rails credentials:edit
```
Edit "pk_test" "sk_test" "pk_live" and "sk_live" with your own

```
stripe:
  development:
    publishable_key: "pk_test_..."
    secret_key: "sk_test_..."
  production:
    publishable_key: "pk_live_..."
    secret_key: "sk_live_..."
```

## Applying the keys
#### Adding the keys to config/environments/development.rb
Add the following lines
```
# Stripe Keys
config.stripe.secret_key = Rails.application.credentials.stripe[:development][:secret_key]
config.stripe.publishable_key = Rails.application.credentials.stripe[:development][:publishable_key]
```
#### Adding the keys to config/enviroments/production.rb
Add the following lines
```
# Stripe Keys
config.stripe.secret_key = Rails.application.credentials.stripe[:production][:secret_key]
config.stripe.publishable_key = Rails.application.credentials.stripe[:production][:publishable_key]
```

## Adding a paywall (Optional)
#### Adding the Helper file
* Put the billing helper file into the helpers folder
* Edit the helper file to edit routes and @user

Call the helper in Application Helper
```
include BillingHelper
```
Call Application Helper in the Application controller
```
include ApplicationHelper
```
Add this to controllers you want to pay wall
```
before_action :check_billing
```
