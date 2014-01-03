#
# Copyright (C) 2014 Proudsugar.com
# Author Luis Merino <luis@proudsugar.com>
#

Feature: Login
  In order to track login-click
  As a headless browser with Mixpanel
  I need to verify that tracking is in place

  Scenario: LoginFromMenu
    Given I am on the home page
    When I click on "Sign in with Facebook" at the top
    Then I should get that first event "login-click" yields properties:
      | trigger |
      | header  |
