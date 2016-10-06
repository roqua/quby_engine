rspec_options = {
  cmd: 'bundle exec rspec',
  failed_mode: :none,
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
  watch(%r{^spec/support/(.+)\.rb$})                  { |m| "spec/support_specs/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^lib/quby/(.+)\.rb$})                      { |m| "spec/quby/#{m[1]}_spec.rb" }
  # Capybara request specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }

  # Specials
  watch('app/controllers/application_controller.rb')        { "spec/controllers" }
end

guard :teaspoon, teaspoon_options do
  watch(%r{spec/javascripts/.+_spec\.(js\.coffee|js|coffee)$})
  watch(%r{app/assets/javascripts/(.+?)\.(js\.coffee|js|coffee)$}) { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
  watch(%r{app/assets/javascripts/(.+?)\.hamlc$})                  { |m| "spec/javascripts/#{m[1]}_spec.js.coffee" }
end

guard :rubocop, all_on_start: false, cli: ['-D'] do
  excludes = YAML.load_file('.rubocop.yml')['AllCops']['Exclude']
  watch(%r{(.+\.rb)$}) { |m| m[0] unless excludes.find { |excluded| File.fnmatch(excluded, m[0]) } }
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

# TODO: enable again after upgrading guard and guard-teaspoon to a compatible version
=begin
guard :bundler do
  require 'guard/bundler'
  require 'guard/bundler/verify'
  helper = Guard::Bundler::Verify.new

  watch(helper.real_path('Gemfile'))
end
=end
