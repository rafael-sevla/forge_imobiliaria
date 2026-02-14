# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
Rails.application.config.assets.paths << Rails.root.join("vendor/assets/stylesheets")
Rails.application.config.assets.paths << Rails.root.join("vendor/assets/javascripts")
Rails.application.config.assets.paths << Rails.root.join("vendor/assets/fonts")

# Precompile vendor assets
Rails.application.config.assets.precompile += %w[
  coreui.min.css
  coreui-icons.min.css
  coreui.bundle.min.js
]
