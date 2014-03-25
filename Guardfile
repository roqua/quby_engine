rspec_options = {
  cmd: "bundle exec rspec",
  failed_mode: :focus,
  all_after_pass: false,
  all_on_start: false
}

teaspoon_options = {
  keep_failed: false,
  all_after_pass: false,
  all_on_start: false
}

guard :rspec, rspec_options do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  # Capybara request specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }
end

guard :teaspoon, teaspoon_options do
  watch(%r{spec/javascripts/.+_spec\.(js\.coffee|js|coffee)$})
  watch(%r{app/assets/javascripts/(.+?)\.(js\.coffee|js|coffee)$}) { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
  watch(%r{app/assets/javascripts/(.+?)\.hamlc$})                  { |m| "spec/javascripts/#{m[1]}_spec.js.coffee" }
end

guard :rubocop, all_on_start: false, cli: ['-D'] do
  excludes = YAML.load_file('.rubocop.yml')['AllCops']['Excludes']
  watch(%r{(.+\.rb)$}) { |m| m[0] unless excludes.find {|excluded| File.fnmatch(excluded, m[0]) } }
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
