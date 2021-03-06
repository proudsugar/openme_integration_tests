#
# Copyright (C) 2014 Proudsugar.com
# Author Luis Merino <luis@proudsugar.com>
#

require 'pages/preview_card'

Given /^I am on the preview a card page$/ do
  @preview_card = PreviewCard.new
  @preview_card.load :id => 1
  expect(@preview_card.displayed?).to be_true
  wait_for_mixpanel
end

When /^I click on "Preview and Send" in the sidebar$/ do
  @preview_card.should have_sidebar
  @preview_card.sidebar.should have_preview_and_send
  @preview_card.sidebar.preview_and_send.click
end

Then /^I click on "Sign in with Facebook" in the popup$/ do
  @preview_card.should have_popup
  @preview_card.popup.should have_sign_in
  @preview_card.popup.sign_in.click
end

And /^I should get that second event "([^"]*)" yields properties:$/ do |event_name, table|
  actual = page.evaluate_script("mixpanel.track.lastCall.args[0]")
  expect(actual).to eq(event_name)

  expected = table.hashes().first
  expected['on-page'] = @preview_card.current_path
  actual = page.evaluate_script("mixpanel.track.lastCall.args[1]")
  expect(actual).to eq(expected)
end
