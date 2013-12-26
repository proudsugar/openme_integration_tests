#
# Copyright (C) 2014 Proudsugar.com
# Author Luis Merino <luis@proudsugar.com>
#

require 'sections/top_nav'

class Base < SitePrism::Page
  section :top_nav, TopNavSection, '#zone-header'
end
