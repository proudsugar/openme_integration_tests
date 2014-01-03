#
# Copyright (C) 2014 Proudsugar.com
# Author Luis Merino <luis@proudsugar.com>
#

require 'pages/home'

Given /^I arrive to the home page$/ do
  @home = Home.new
  @home.load
  wait_for_mixpanel
end

When /^I choose to "browse-cards" clicking on the button$/ do
  @home.should have_intro
  @home.intro.browse_cards.click
end

Then /^I should get that event "([^"]*)" yields properties$/ do |event_name|
  actual = page.evaluate_script("mixpanel.track.lastCall.args[0]")
  expect(actual).to eq(event_name)

  expected = {'on-page' => @home.url}
  actual = page.evaluate_script("mixpanel.track.lastCall.args[1]")
  expect(actual).to eq(expected)
end
