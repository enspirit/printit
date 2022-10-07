require 'spec_helper'
require 'path'

describe 'GET /printit.css' do
  include ApiTest

  it 'works' do
    get 'printit.css'
    expect(last_response.content_type).to match("css")
    expect(last_response.body).not_to be_empty
  end

  it 'works with a version number too' do
    get "printit-#{Printit::VERSION}.css"
    expect(last_response.content_type).to match("css")
    expect(last_response.body).not_to be_empty
  end

end
