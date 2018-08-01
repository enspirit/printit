require 'sinatra'
require 'json'
require 'open3'
require 'path'
require 'yaml'

# Simply checks that a path exists of raise an error
def self._!(path)
  Path(path).tap do |p|
    raise "Missing #{p.basename}." unless p.exists?
  end
end

ROOT_FOLDER = Path.backfind('.[Gemfile]') or raise("Missing Gemfile")

CONFIG_FILE = _!(ROOT_FOLDER/'config/printit.yml')

CONFIG = CONFIG_FILE.load['prince']

set :bind, '0.0.0.0'
set :raise_errors, true
set :show_exceptions, false
set :dump_errors, true

post '/' do
  content_type 'application/pdf'
  if (filename = request.params['attachment'])
    attachment filename.strip
  end
  print_pdf
end

private

  def print_pdf
    cmd  = "prince #{prince_options} -"
    html = request.params['html']
    result, status = Open3.capture2(cmd, stdin_data: html)
    result
  end

  def prince_options
    CONFIG.map{|k,v| "--#{k.gsub('_', '-')}=\"#{v}\"" }.join(" ")
  end
