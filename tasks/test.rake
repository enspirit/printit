namespace :test do

  require "rspec/core/rake_task"

  desc "Run RSpec code examples"
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = "spec/**/test_*.rb"
    t.rspec_opts = ["-Ilib", "-Ispec", "--color", "--backtrace"]
  end

  desc "Runs webspicy functional tests"
  task :webspicy do
    require "webspicy"
    res = Webspicy::Tester.new(Path.dir.parent/"webspicy/rack.rb").call
    abort('Webspicy tests failed') unless res == 0
  end

end
task :test => [:'test:unit', :'test:webspicy']
