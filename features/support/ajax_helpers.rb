module AjaxHelpers
  def wait_for_mixpanel
    Timeout.timeout(Capybara.default_wait_time) do
      loop do
        active = page.evaluate_script('snooper._loaded')
        break if active == true
      end
    end
  end
end

World(AjaxHelpers)
