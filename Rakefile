# frozen_string_literal: true

require 'rubocop/rake_task'

task default: %w[lint]

RuboCop::RakeTask.new(:lint) do |task|
   task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
   task.fail_on_error = false
end

task :run do
  ruby 'lib/advanced_tts.rb'
end
