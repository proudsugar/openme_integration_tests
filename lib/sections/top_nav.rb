#
# Copyright (C) 2014 Proudsugar.com
# Author Luis Merino <luis@proudsugar.com>
#

class TopNavSection < SitePrism::Section
  element :sign_in, '.facebook-login2[href^="http"]'
end
