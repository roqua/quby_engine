#!/usr/bin/env ruby

puts "Running #{ARGV.join(" ")} for Rails 5"
exec({"BUNDLE_GEMFILE" => "gemfiles/rails50.gemfile"}, ARGV.join(" "))
