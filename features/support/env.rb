begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'capybara' 
require 'capybara/dsl' 
require 'capybara/cucumber'
require 'cucumber/formatter/unicode'
Capybara.default_driver = :selenium
Capybara.app_host = 'http://mail.ru' 
World(Capybara) 
