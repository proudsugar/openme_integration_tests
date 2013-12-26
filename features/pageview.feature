#
# Copyright (C) 2014 Proudsugar.com
# Author Luis Merino <luis@proudsugar.com>
#

Feature: Pageview
  In order to describe the pageview events and native event
  As a headless browser with Mixpanel
  I need to verify that tracking is in place

  Scenario: Browsing to a given page
    Given I arrive to any given page
    Then I should get that track_pageview has been called one time
    Then I should get that event "page-view" has been called one time
    And I should get that page-view yields properties:
      | card-category | card-subcategory | card-title |
      | empty         | empty            | empty      |
