require File.expand_path('../config/application',  __FILE__)

# Sprockets
map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'app/assets/javascripts'
  environment.append_path 'app/assets/stylesheets'
  Stylus.setup environment

  run environment
end

map '/' do
  run GitHubNewsFeed::App
end
