module Printit
  class Html2Csv

    CSV_OPTIONS = {
      :col_sep => ",",
      :quote_char => '"',
      :force_quotes => false
    }

    def call(html)
      doc = Nokogiri::HTML(html)
      io = StringIO.new
      csv = ::CSV.new(io, CSV_OPTIONS)

      thead = []
      doc.xpath('//table/thead/tr/th').each do |cell|
        thead << cell2str(cell)
      end
      csv << thead

      doc.xpath('//table/tbody/tr').each do |row|
        tarray = [] 
        row.xpath('td').each do |cell|
          tarray << cell2str(cell)
        end
        csv << tarray
      end
      io.string
    end

  private

    def cell2str(cell)
      cell.text.to_s.strip.gsub(/\s*\n\s*/, "\n")
    end

  end
end
