require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib/transmogriffy'
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task :default => :test

task :migrate do
  require 'transmogriffy'

  Transmogriffy::Migrator.new.migrate!
end
