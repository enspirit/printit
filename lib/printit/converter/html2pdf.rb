module Printit
  class Html2Pdf

    PRINCE_CONFIG = CONFIG_FILE.load['prince']

    def call(html)
      cmd = "prince #{prince_options} -"
      result, status = Open3.capture2(cmd, stdin_data: html)
      result
    end

  private

    def prince_options
      PRINCE_CONFIG.map{|k,v| "--#{k.gsub('_', '-')}=\"#{v}\"" }.join(" ")
    end

  end
end
