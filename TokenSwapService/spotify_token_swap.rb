require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'net/http'
require 'net/https'
require 'base64'
require 'json'
require 'encrypted_strings'

AUTH_HEADER = "Basic #{Base64.strict_encode64("#{ENV['SPOTIFY_CLIENT_ID']}:#{ENV['SPOTIFY_CLIENT_SECRET']}")}"
SPOTIFY_ACCOUNTS_ENDPOINT = URI.parse('https://accounts.spotify.com')

set :port, 1234 # The port to bind to.
set :bind, '0.0.0.0' # IP address of the interface to listen on (all)

post '/swap' do
  # This call takes a single POST parameter, "code", which
  # it combines with your client ID, secret and callback
  # URL to get an OAuth token from the Spotify Auth Service,
  # which it will pass back to the caller in a JSON payload.

  auth_code = params[:code]

  http = Net::HTTP.new(SPOTIFY_ACCOUNTS_ENDPOINT.host,
                       SPOTIFY_ACCOUNTS_ENDPOINT.port)
  http.use_ssl = true

  request = Net::HTTP::Post.new('/api/token')

  request.add_field('Authorization', AUTH_HEADER)

  request.form_data = {
    'grant_type' => 'authorization_code',
    'redirect_uri' => ENV["SPOTIFY_CLIENT_CALLBACK_URL"],
    'code' => auth_code
  }

  response = http.request(request)

  # encrypt the refresh token before forwarding to the client
  if response.code.to_i == 200
    token_data = JSON.parse(response.body)
    refresh_token = token_data['refresh_token']
    encrypted_token = refresh_token.encrypt(:symmetric,
                                            :password => ENV["SPOTIFY_ENCRYPTION_SECRET"])
    token_data['refresh_token'] = encrypted_token
    response.body = JSON.dump(token_data)
  end

  status response.code.to_i
  return response.body
end

post '/refresh' do
  # Request a new access token using the POST:ed refresh token

  http = Net::HTTP.new(SPOTIFY_ACCOUNTS_ENDPOINT.host,
                       SPOTIFY_ACCOUNTS_ENDPOINT.port)
  http.use_ssl = true

  request = Net::HTTP::Post.new('/api/token')

  request.add_field('Authorization', AUTH_HEADER)

  encrypted_token = params[:refresh_token]
  refresh_token = encrypted_token.decrypt(:symmetric,
                                          :password => ENV["SPOTIFY_ENCRYPTION_SECRET"])

  request.form_data = {
    'grant_type' => 'refresh_token',
    'refresh_token' => refresh_token
  }

  response = http.request(request)

  status response.code.to_i
  return response.body
end
