# name: desk
# about: create and view status of desk.com case within each topic
# version: 0.4
# authors: Josh Sorchik. Forked from https://github.com/shivpkumar/Zendesk-Plugin
# url: https://github.com/jsorchik/discourse-desk-plugin

# gem 'addressable', '2.3.7', require: false
# gem 'simple_oauth', '0.2.0'
# gem 'desk_api', '0.6.1'
gem 'inflection', '1.0.0'
gem 'scrub_rb', '1.0.1'
gem 'zendesk_api', '1.14.0'

register_asset 'javascripts/discourse/initializers/discourse-zendesk-button.js.es6'
register_asset 'stylesheets/buttons_cont.css.scss'

after_initialize do
  load File.expand_path('../controllers/zendesk_controller.rb', __FILE__)
  load File.expand_path('../lib/zendesk_ticket.rb', __FILE__)
  load File.expand_path('../lib/new_zendesk_ticket.rb', __FILE__)
  load File.expand_path('../lib/existing_zendesk_ticket.rb', __FILE__)

  Discourse::Application.routes.prepend do
    post 'zendesk/create_ticket' => 'zendesk#create_ticket'
    get 'zendesk/find_ticket' => 'zendesk#find_ticket'
  end
end
