# Importmap to Esbuild
## Before Starting

* Need to be on Rails 7.x.x
* Have Node installed
* Have Yarn installed
* Download the [.zip file](https://github.com/Rails-Forums/Resource-Uploads/raw/main/Friendly%20Id/Simple%20User%20Show%20Page.zip) for the necessary files

## Getting Started
### Add the following gems to the Gemfile

```
gem 'jsbundling-rails'
gem 'cssbundling-rails'
```

### Creating/deleting the files

* Add the package.json file in the home directory
* Add any missing packages being called in the config/importmap.rb file to package.json with yarn add "package-name"
* Delete config/importmap.rb

### Adding to gitignore

* Add the following lines

```
/node_modules
yarn-error.log
/app/assets/builds/*
!/app/assets/builds/.keep
```

## Replacing importmap to esbuild

* Run the following commands
```
yarn install
bundle install
yarn add sass
rails javascript:install:esbuild
rails turbo:install:node
rails stimulus:install:node
```

* Add these lines to layouts/application (Replace the current ones for the last two)
```
= csp_meta_tag
= stylesheet_link_tag "application", "data-turbo-track": "reload"
= javascript_include_tag "application", "data-turbo-track": "reload", defer: true
```

* Add these lines to both Procfiles
```
js: yarn build --watch
css: yarn build:css --watch
```

* Replace the items in the app/assets/config/manifest.js
```
//= link_tree ../images
//= link_tree ../fonts
//= link_tree ../builds
```

* Rename /app/assets/stylesheets/application.scss to application.sass.scss

# Converting Fondation to Esbuild (Optional)
## Getting Started

* Run the following Commands
```
yarn add foundation-sites
yarn add motion-ui
yarn add what-input
```

* Add the foundation stylesheets to the stylesheets folder

* Add the following gems
```
gem 'foundation-rails'
gem 'autoprefixer-rails'
```

### Setting it up
* Add the following lines to app/javascript/application.js
```
import Foundation from 'foundation-sites'

$(document).on('turbo:load', function () {
  $(document).foundation();
});
```

* Add the following line to application.sass.scss
```
@import "foundation_and_overrides";
```