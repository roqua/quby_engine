#!/usr/bin/env ruby

#unless ENV["CIRCLE_NODE_TOTAL"] == "3"
#  puts "Circle parallelism should be 3 (number of different Rails versions)"
#  exit 1
#end

case ENV["CIRCLE_NODE_INDEX"]
when "0"
  puts "Running #{ARGV.join(" ")} for Rails 5"
  exec({"BUNDLE_GEMFILE" => "gemfiles/rails5.gemfile"}, ARGV.join(" "))
end
