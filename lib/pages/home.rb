#
# Copyright (C) 2014 Proudsugar.com
# Author Luis Merino <luis@proudsugar.com>
#

require 'sections/intro'

class Home < SitePrism::Page
  set_url '/'

  section :intro, IntroSection, '#zone-content'
end
