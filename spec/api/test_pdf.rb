require 'spec_helper'
require 'path'

describe 'POST /pdf' do
  include ApiTest

  HTML = <<-EOF
  <html>
    <body><h1>Hello world</h1></body>
  </html>
  EOF

  it 'works' do
    post "/", { html: HTML }, { "HTTP_ACCEPT" => "application/pdf" }
    expect(last_response).to be_ok
    expect(last_response.content_type).to match(/pdf/)
  end

  it 'allows specifying an attachment name' do
    post "/", { html: HTML, attachment: "test.pdf" }, { "HTTP_ACCEPT" => "application/pdf" }
    expect(last_response).to be_ok
    expect(last_response.content_type).to match(/pdf/)
    expect(last_response['Content-Disposition']).to eql("attachment; filename=\"test.pdf\"")
  end

end
