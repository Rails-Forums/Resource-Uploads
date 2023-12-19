# Webpacker to Esbuild
## Before Starting

* Need to be on Rails 7.x.x 
* Have Node installed
* Have Yarn installed

## Removing Webpacker
### Remove the following files
* /.browserslistrc
* /babel.config.js
* /postcss.config.js
* /config/webpack
* /config/webpacker.yml
* /bin/webpack
* /bin/webpack-dev-server

### Find and replace
If you have any of these lines change them
```
= image_pack_tag('example.jpeg') 
= favicon_link_tag asset_pack_path ('media/imagesfavicon.ico')
= stylesheet_pack_tag 'application', media: 'all', 'data-turbolinks-track': 'reload'
= javascript_pack_tag 'application', 'data-turbolinks-track': true
```
To this
```
= image_tag('example.jpeg')
= favicon_link_tag ('favicon.ico')
= stylesheet_link_tag "application", "data-turbo-track": "reload"
= javascript_include_tag "application", "data-turbo-track": "reload", defer: true
```
### Remove the following lines
In the Gemfile remove
```
gem 'webpacker', '~> 5.x'
gem 'cocoon', '~> 1.2.10'
gem 'turbolinks', '~> 5'
```

In the package.json remove
```
"turbolinks": "^5.2.0",
"webpack": "^4.46.0",
"webpack-cli": "^3.3.12"
"@rails/webpacker": "5.4.3",
"webpack-dev-server": "^3",
```
### Finishing Touches
* Move app/packs/stylesheets to app/assets
* Move app/packs/images to app/assets
* If you have any other media folders in here move them to app/assets as well
* Move app/packs/entrypoints/application.scss to app/assets/stylesheets
* Fix all stylesheet calls in app/assets/stylesheets/application.scss

## Installing Esbuild
### Add the following gems to the Gemfile

```
gem 'jsbundling-rails'
gem 'cssbundling-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'sprockets-rails'
gem 'sassc-rails'
```

### Adding to gitignore

* Add the following lines

```
/app/assets/builds/*
!/app/assets/builds/.keep
```

## Adding esbuild

* Run the following commands
```
yarn install
bundle install
yarn add sass
rails javascript:install:esbuild
rails turbo:install:node
rails stimulus:install:node
```

* Add this line to the scripts part of the package.json file
```
"build:css": "sass ./app/assets/stylesheets/application.sass.scss ./app/assets/builds/application.css --no-source-map --load-path=node_modules"
```

* Add these lines to both Procfiles
```
js: yarn build --watch
css: yarn build:css --watch
```

* Replace the items in the app/assets/config/manifest.js
```
//= link_tree ../images
//= link_tree ../builds
```

* Rename /app/assets/stylesheets/application.scss to application.sass.scss

* Add all of your custom javascript files into the app/javascript folder from the app/packs then delete app/packs
* Make the apporate calls to these files in the app/javascript/application.js
```
# Example
import "./custom/direct_upload"
```

### Adding jquery
Run the following command
```
yarn add jquery
```

Add the following lines to app/javascript/application.js
```
import jquery from "jquery"
window.jQuery = jquery
window.$ = jquery
```

# Converting Fondation to Esbuild (Optional)
## Getting Started

### Setting it up
Add the following lines to app/javascript/application.js

```
import Foundation from 'foundation-sites'

$(document).on('turbo:load', function () {
  $(document).foundation();
});
```

Fix the following calls made in the foundation files

In _settings.scss change
```
@import 'node_modules/foundation-sites/scss/util/util';
```
To
```
@import 'foundation-sites/scss/util/util';
```