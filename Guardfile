jasmine_options = {console: :always, errors: :always, timeout: 10000, keep_failed: false, all_after_pass: false, all_on_start: false, server: :webrick, rackup_config: 'spec/dummy/config.ru'}
rspec_options   = {:version => 2, :keep_failed => false, :all_after_pass => false, :all_on_start => false, :cli => "--drb -f Fuubar --colour --tag ~screenshots --drb-port 8910"}
spork_options   = {:rspec_env => { 'RAILS_ENV' => 'test' }, :wait => 60, :cucumber => false, :test_unit => false, :rspec_port => 8910 }

guard :spork, spork_options do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch('config/routes.rb')
  watch(%r{^Gemfile.*$})
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch(%r{^lib/(.+)\.rb$})
  watch('spec/spec_helper.rb')
end

guard 'rspec', rspec_options do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  # Capybara request specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }
end

guard :jasmine, jasmine_options do
  watch(%r{spec/javascripts/spec\.(js\.coffee|js|coffee)$}) { 'spec/javascripts' }
  watch(%r{spec/javascripts/.+_spec\.(js\.coffee|js|coffee)$})
  watch(%r{spec/javascripts/fixtures/.+$})
  watch(%r{app/assets/javascripts/(.+?)\.(js\.coffee|js|coffee)}) { 'spec/javascripts' }
end

guard :rubocop, all_on_start: false, cli: ['-D'] do
  excludes = YAML.load_file('.rubocop.yml')['AllCops']['Excludes']
  watch(%r{(.+\.rb)$}) { |m| m[0] unless excludes.find {|excluded| File.fnmatch(excluded, m[0]) } }
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

