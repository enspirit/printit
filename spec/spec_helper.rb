require 'printit'
require 'rspec'
require "rack/test"

module SpecHelper
end

module ApiTest
  include Rack::Test::Methods

  def app
    Printit::Api
  end
end

RSpec.configure do |c|
  c.include SpecHelper
end
