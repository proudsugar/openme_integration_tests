#
# Copyright (C) 2014 Proudsugar.com
# Author Luis Merino <luis@proudsugar.com>
#

require 'pages/base'
require 'sections/preview_sidebar'
require 'sections/popup'

class PreviewCard < Base
  set_url '/card-templates/{id}'
  set_url_matcher /\/card-templates\/\d+/

  section :sidebar, PreviewSidebarSection, '.card-customize-sidebar'
  section :popup, PopupSection, '.fb-login-overlay-inner'
end
