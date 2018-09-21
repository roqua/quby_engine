# frozen_string_literal: true

def screenshot(name, options = {})
  page.driver.render "tmp/screenshots/#{name}.png", full: true
  if options[:height]
    page.driver.resize(screen_width, screen_height)
  end
end
