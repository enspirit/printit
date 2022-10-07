module Printit
  class Api < Sinatra::Base

    set :bind, '0.0.0.0'
    set :raise_errors, true
    set :show_exceptions, false
    set :dump_errors, true

    use Rack::Accept

    get "/printit.js" do
      send_file ROOT_FOLDER/"public/printit.js"
    end

    get %r{/printit-(.*?).js} do |version|
      send_file ROOT_FOLDER/"public/printit.js"
    end

    get %r{/([a-z]+).css} do |name|
      send_file ROOT_FOLDER/"public/#{name}.css"
    end

    get %r{/([a-z]+)-(.*?).css} do |name,version|
      send_file ROOT_FOLDER/"public/#{name}.css"
    end

    before do
      unless (accept = request.params['accept']).nil?
        env['HTTP_ACCEPT'] = accept
      end
    end

    post '/' do
      if (filename = request.params['attachment'])
        attachment filename.strip
      end

      accept = env['rack-accept.request']
      if accept.media_type?('application/pdf')
        content_type 'application/pdf'
        status 200
        Html2Pdf.new.call(request.params['html'])
      elsif accept.media_type?('text/csv')
        content_type 'text/csv'
        status 200
        Html2Csv.new.call(request.params['html'])
      else
        content_type 'text/plain'
        status 415
        "Unsupported media type"
      end
    end

  end
end
