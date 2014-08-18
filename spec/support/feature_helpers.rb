def wait_until_focussed(selector)
  wait_for do
    test = "$(document.activeElement).is('#{selector}')"
    page.driver.evaluate_script(test)
  end
end

# Make ruby wait for some condition to evaluate to true, useful for waiting on capybara
# - Provide a block evaluating a condition returning true when ruby should proceed
# - Wait max optionally overrides the default max wait time
# - Step optionally overrides the wait time for each step
def wait_for(wait_max: 3, step: 0.001, &block)
  stop_at = wait_max.seconds.from_now

  sleep step while !block.call && (@time = Time.now) < stop_at

  fail "Timeout of #{wait_max} seconds exceeded!" unless @time < stop_at
end
