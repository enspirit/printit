require 'spec_helper'
require 'path'

describe 'GET /printit.js' do
  include ApiTest

  it 'works' do
    get 'printit.js'
    expect(last_response.content_type).to match("javascript")
    expect(last_response.body).not_to be_empty
  end

  it 'works with a version number too' do
    get "printit-#{Printit::VERSION}.js"
    expect(last_response.content_type).to match("javascript")
    expect(last_response.body).not_to be_empty
  end

end
