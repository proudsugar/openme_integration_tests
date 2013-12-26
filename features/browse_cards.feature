#
# Copyright (C) 2014 Proudsugar.com
# Author Luis Merino <luis@proudsugar.com>
#

Feature: BrowseCards
  In order to track browse cards
  As a headless browser with Mixpanel
  I need to verify that tracking is in place

  Scenario: Browsing to Home page
    Given I arrive to the home page
    When I choose to "browse-cards" clicking on the button
    Then I should get that event "browse-cards" yields properties
