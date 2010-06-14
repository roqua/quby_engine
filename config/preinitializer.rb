begin
  require 'rubygems'
  require 'isolate/now'

  Isolate.gems "tmp/gems", :file => "config/isolate.rb"
rescue LoadError
  puts "The gem 'isolate' is not installed. Please run:"
  puts ""
  puts "  gem install isolate"
  exit
end
