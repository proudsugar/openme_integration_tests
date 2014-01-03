#
# Copyright (C) 2014 Proudsugar.com
# Author Luis Merino <luis@proudsugar.com>
#

require 'bundler'
Bundler.setup(:test)

require 'capybara'
require 'capybara/cucumber'
require 'site_prism'

SitePrism.configure do |config|
  config.use_implicit_waits = true
end

Capybara.configure do |config|
  config.default_driver = ENV['CAPYBARA_DRIVER'] || :poltergeist
  config.app_host = 'http://openme.com'
  config.default_wait_time = 5
  config.run_server = false
end

Capybara.register_driver :poltergeist do |app|
  require 'capybara/poltergeist'
  Capybara::Poltergeist::Driver.new(app, {
    :js_errors => false,
    #:inspector => true,
    :phantomjs_options => ['--load-images=no', '--ignore-ssl-errors=yes'],
    :extensions => ['vendor/bind.js', 'vendor/sinon-1.7.3.js', 'vendor/snooper.js']
    #:extensions => ['//cdnjs.cloudflare.com/ajax/libs/sinon.js/1.7.3/sinon-min.js', '//gist.github.com/Rendez/58d20457a89f90631ebb/raw/dde83fd81afd7607d3315269e8a46c653208c202/snooper.js']
  })
end

Capybara.register_driver :selenium do |app|
  require 'selenium/webdriver'
  Selenium::WebDriver::Firefox::Binary.path = "/Applications/Firefox.app/Contents/MacOS/firefox"
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
  # TODO set-up a proxy to inject Javascript before page load, the same way PhantomJS is doing.
end

Before do
  if Capybara.current_driver.to_s == 'poltergeist'
    page.driver.headers = { 'User-Agent' => 'Poltergeist' }
  end
end

After do
  page.reset_session!
end

World(Capybara)
