require 'spec_helper'

module Printit
  describe Html2Csv do

HTML = <<-HTML
  <body>
    <table>
      <thead>
        <tr>
          <th>  Foo</th>
          <th>Bar  </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td>
          <td>  Bernard  \n\t  Hello</td>
        </tr>
        <tr>
          <td>2</td>
          <td>Yoann</td>
        </tr>
      </tbody>
    </table>
  </body>
HTML

CSV = <<-CSV
Foo,Bar
1,"Bernard\nHello"
2,Yoann
CSV

    it 'works' do
      got = Html2Csv.new.call(HTML)
      expect(got).to eql(CSV)
    end

  end
end
