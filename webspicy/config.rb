def webspicy_config(&bl)
  Webspicy::Configuration.new(Path.dir) do |c|
    bl.call(c) if bl
  end
end
webspicy_config
