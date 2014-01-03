#
# Copyright (C) 2014 Proudsugar.com
# Author Luis Merino <luis@proudsugar.com>
#

Feature: Login
  In order to track login-click
  As a headless browser with Mixpanel
  I need to verify that tracking is in place

  Scenario: LoginBeforeSendCard
    Given I am on the preview a card page
    When I click on "Preview and Send" in the sidebar
    Then I click on "Sign in with Facebook" in the popup
    And I should get that second event "login-click" yields properties:
      | trigger |
      | pop-up  |
