#!/usr/bin/env ruby
# frozen_string_literal: true

puts "Running #{ARGV.join(" ")} for Rails 5"
exec({"BUNDLE_GEMFILE" => "gemfiles/rails52.gemfile"}, ARGV.join(" "))
