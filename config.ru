require "rack/jekyll"

ENV['ECS_ASSOCIATE_TAG'] = 'tokzk-22'
ENV['JEKYLL_ENV'] = "production"
# run Rack::Jekyll.new(auto: true)
run Rack::Jekyll.new
