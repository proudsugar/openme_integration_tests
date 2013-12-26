#
# Copyright (C) 2014 Proudsugar.com
# Author Luis Merino <luis@proudsugar.com>
#

require 'pages/base'
require 'sections/intro'

class Home < Base
  set_url '/'

  section :intro, IntroSection, '#zone-content'
end
