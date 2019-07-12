#!/usr/bin/env ruby
# typed: false
# frozen_string_literal: true

puts "Running #{ARGV.join(" ")} for Rails 5"
exec({"BUNDLE_GEMFILE" => "gemfiles/rails50.gemfile"}, ARGV.join(" "))
