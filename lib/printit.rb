require 'sinatra'
require 'json'
require 'open3'
require 'path'
require 'yaml'
require 'nokogiri'
require 'csv'
require 'rack/accept'

module Printit

  # Simply checks that a path exists of raise an error
  def self._!(path)
    Path(path).tap do |p|
      raise "Missing #{p.basename}." unless p.exists?
    end
  end

  ROOT_FOLDER = Path.backfind('.[Gemfile]') or raise("Missing Gemfile")

  HANDLER = ENV["HANDLER"]
  CONFIG_FILE = _!(ROOT_FOLDER/'config/printit.yml')

end
require 'printit/version'
require 'printit/api'
require 'printit/converter'
