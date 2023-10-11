# Friendly Id Setup
## Getting Started
#### This can be used for anything used users as an example 
#### How to get started
* Follow the offcial [GitHub page](https://github.com/norman/friendly_id)
* If you need a basic show user page [Download the zip](https://github.com/Rails-Forums/Resource-Uploads/raw/main/Friendly%20Id/Simple%20User%20Show%20Page.zip)
* Add the user folder to views
* Add the user controller to the controllers folder
* Add this to the routes
```
resources :users
```
* Add this to the topbar or where you wish to add the profile view
```
= link_to "Profile" , user_path(current_user)
```