#
# Copyright (C) 2014 Proudsugar.com
# Author Luis Merino <luis@proudsugar.com>
#

require 'pages/home'

Given /^I arrive to the page$/ do
  @home = Home.new
  @home.load
end

Then /^I should get that track_pageview has been called one time$/ do
  @home.should have_intro
  call_count = page.evaluate_script('mixpanel.track_pageview.callCount')
  expect(call_count).to equal(1)
end

Then /^I should get that event "([^"]*)" has been called one time$/ do |event_name|
  call_count = page.evaluate_script('__mixpanel.track.callCount')
  expect(call_count).to equal(1)

  event = page.evaluate_script('__mixpanel.track.getCall(0).args[0]')
  expect(event).to eq(event_name)
end

And /^I should get that page-view yields properties:$/ do |table|
  expected = table.hashes().first
  expected['on-page'] = @home.current_url
  actual   = page.evaluate_script('__mixpanel.track.getCall(0).args[1]')
  expect(actual).to eq(expected)
end
