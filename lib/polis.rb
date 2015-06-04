require 'dotenv'
Dotenv.load
require 'fastenv'

require 'sinatra/base'
require 'rack/cors'
require 'json'

class Polis < Sinatra::Base
  LISTENING_PORT   =
    begin
      Fastenv.port
    rescue StandardError
      9000
    end

  STATUS_CODE      =
    begin
      Fastenv.status_code
    rescue StandardError
      200
    end

  SECONDS_TO_SLEEP =
    begin
      Fastenv.seconds_to_sleep.to_f
    rescue StandardError
      0
    end

  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: [:get, :post, :options]
    end
  end

  # Idea from http://www.recursion.org/2011/7/21/modular-sinatra-foreman
  configure do
    set :app_file, __FILE__
    set :port,     Fastenv.port
    set :logging,  true

    $stderr.puts "For a POST request, will sleep #{SECONDS_TO_SLEEP} seconds before returning #{STATUS_CODE} status code."
  end

  get '/' do
    status 200
    return <<-PAGE
    <html><head><title>Polis.rb</title></head><body><h2>polis.rb</h2><p>Up and Running!</p></body></html>
    PAGE
  end

  post '/' do
    # Note: Thanks to this SO page: http://stackoverflow.com/a/6318491/249218
    http_headers = env.select{|h| h =~ /HTTP_/}
    body_string  = request.body.read

    sleep SECONDS_TO_SLEEP

    logger.info <<-LOG
Logging POST request:
Headers:
#{http_headers}
Body:
#{body_string}

    LOG

    status STATUS_CODE
    return body_string
  end

  run! if app_file == $0
end

