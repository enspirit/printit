require 'spec_helper'
require 'path'

describe 'POST /csv' do
  include ApiTest

HTML = <<-HTML
  <body>
    <table>
      <thead>
        <tr>
          <th>Foo</th>
          <th>Bar</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td>
          <td>Bernard</td>
        </tr>
        <tr>
          <td>2</td>
          <td>Yoann</td>
        </tr>
      </tbody>
    </table>
  </body>
HTML

  it 'works with a header' do
    post "/", { html: HTML }, { "HTTP_ACCEPT" => "text/csv" }
    expect(last_response).to be_ok
    expect(last_response.content_type).to match(/csv/)
  end

  it 'works with a param' do
    post "/", { html: HTML, accept: "text/csv" }
    expect(last_response).to be_ok
    expect(last_response.content_type).to match(/csv/)
  end

end
