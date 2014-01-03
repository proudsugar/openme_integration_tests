#
# Copyright (C) 2014 Proudsugar.com
# Author Luis Merino <luis@proudsugar.com>
#

require 'pages/home'

Given /^I am on the home page$/ do
  @home = Home.new
  @home.load
  wait_for_mixpanel
end

When /^I click on "Sign in with Facebook" at the top$/ do
  @home.should have_top_nav
  @home.top_nav.should have_sign_in
  @home.top_nav.sign_in.click
end

Then /^I should get that first event "([^"]*)" yields properties:$/ do |event_name, table|
  actual = page.evaluate_script('mixpanel.track.getCall(0).args[0]')
  expect(actual).to eq(event_name)

  expected = table.hashes().first
  expected['on-page'] = @home.url
  actual = page.evaluate_script('mixpanel.track.getCall(0).args[1]')
  expect(actual).to eq(expected)
end
