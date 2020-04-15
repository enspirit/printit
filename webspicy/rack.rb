$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'printit'
require_relative 'config'
webspicy_config do |c|
  c.client = Webspicy::RackTestClient.for(::Printit::Api)
end
