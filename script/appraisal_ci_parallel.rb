#!/usr/bin/env ruby

unless ENV["CIRCLE_NODE_TOTAL"] == "3"
  puts "Circle parallelism should be 3 (number of different Rails versions)"
  exit 1
end

case ENV["CIRCLE_NODE_INDEX"]
when "0"
  puts "Running #{ARGV.join(" ")} for Rails 3.2"
  exec({"BUNDLE_GEMFILE" => "gemfiles/rails32.gemfile"}, ARGV.join(" "))
when "1"
  puts "Running #{ARGV.join(" ")} for Rails 4.0"
  exec({"BUNDLE_GEMFILE" => "gemfiles/rails40.gemfile"}, ARGV.join(" "))
when "2"
  puts "Running #{ARGV.join(" ")} for Rails 4.1"
  exec({"BUNDLE_GEMFILE" => "gemfiles/rails41.gemfile"}, ARGV.join(" "))
end
