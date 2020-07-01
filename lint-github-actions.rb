#!/usr/bin/env ruby
# frozen_string_literal: true

require 'yaml'
require 'shellwords'

def check(filename)
  exitstatus = 0

  puts "+yamllint #{filename}"
  system("yamllint #{Shellwords.escape(filename)}")

  puts "+shellcheck #{filename}"
  workflow = YAML.load_file(filename)
  jobs = workflow['jobs'].values
  steps = jobs.flat_map do |job|
    job['steps']
  end
  runs = steps.select { |step| step.key?('run') }.map { |step| step['run'] }
  runs.each do |run|
    IO.popen({}, ['shellcheck', '-e', 'SC2148', '-'], 'r+') do |io|
      io.puts(run)
      io.close_write
      puts io.read
    end
    exitstatus += $?.exitstatus
  end
  exitstatus
end

exitstatus = ARGV.inject(0) { |exitstatus, filename| exitstatus + check(filename) }
exit exitstatus
