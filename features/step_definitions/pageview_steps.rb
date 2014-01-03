#
# Copyright (C) 2014 Proudsugar.com
# Author Luis Merino <luis@proudsugar.com>
#

require 'pages/cards'

Given /^I arrive to any given page$/ do
  @home = Cards.new
  @home.load
  wait_for_mixpanel
end

Then /^I should get that track_pageview has been called one time$/ do
  called = page.evaluate_script('mixpanel.track_pageview.called')
  expect(called).to be_true
end

Then /^I should get that event "([^"]*)" has been called one time$/ do |event_name|
  call_count = page.evaluate_script('__mixpanel.track.callCount')
  expect(call_count).to equal(1)

  event = page.evaluate_script('__mixpanel.track.lastCall.args[0]')
  expect(event).to eq(event_name)
end

And /^I should get that page-view yields properties:$/ do |table|
  expected = table.hashes().first
  expected['on-page'] = @home.current_url
  actual = page.evaluate_script('__mixpanel.track.lastCall.args[1]')
  expect(actual).to eq(expected)
end
