module Printit
  class Html2Pdf

    HANDLER = CONFIG_FILE.load['handler']

    def call(html)
      case HANDLER
      when "prince"
        convert(html, prince_cmd)
      when "weasyprint"
        convert(html, weasyprint_cmd)
      else
        raise "Unsupported handler #{HANDLER}."
      end
    end

  private

    def convert(html, cmd)
      result, status = Open3.capture2(cmd, stdin_data: html, binmode: true)
      result
    end

    def prince_cmd
      options = load_options('prince')
      "prince #{options} -"
    end

    def weasyprint_cmd
      options = load_options('weasyprint')
      "weasyprint -e utf-8 #{options} - -"
    end

    def load_options(handler)
      config = CONFIG_FILE.load[handler]
      config.map{|k,v|
        if k.size == 1
          "-#{k.gsub('_', '-')} \"#{v}\""
        else
          "--#{k.gsub('_', '-')}=\"#{v}\""
        end
      }.join(" ")
    end

  end
end
