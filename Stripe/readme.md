# Setting up Stripe for Rails

### Getting Started
#### Need to install the gem

```
gem 'stripe-rails'
``` 

### Need to place the controllers in the controller folder
#### The Billing controller goes in the main folder
#### If using devise put the registration controller in the model you want to use devise for
* If not using devise grab the lines of code you need from that file. Which will be seen inside

### Add the appropriate routes needed and place them in config/routes.rb
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

### Edit the master.key
#### Run
```
EDITOR="code --wait" bin/rails credentials:edit
```
#### Insert what is in the masterkey.example file
* Edit the neccassary things

### Adding a paywall (Optional)
#### Check out the paywall file to see how to add a basic one.
