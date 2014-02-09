class Config < Thor
  desc "heroku", "setup heroku from .heroku_config"

  def heroku
    puts "running Heroku config . . ."
    config = ".heroku_config"
    if File.exists?(config)
      settings = File.open(config).read
      settings.gsub!(/\r\n?/, "\n")
      settings.each_line do |line|
        if line.length > 2 && line.start_with?('#') == false
          IO.popen("heroku config:set #{line.split("\n")[0]}") { |f| puts f.gets }
        end
      end
    end
  end
end