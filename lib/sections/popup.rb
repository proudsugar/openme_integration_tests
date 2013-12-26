#
# Copyright (C) 2014 Proudsugar.com
# Author Luis Merino <luis@proudsugar.com>
#

class PopupSection < SitePrism::Section
  element :sign_in, '.facebook-login[href^="http"]'
end
