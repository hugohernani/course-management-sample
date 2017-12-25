class Rack::Attack
  # Allow all local traffic
  safelist('allow-localhost') do |req|
  '127.0.0.1' == req.ip || '::1' == req.ip
  end

  # Allow an IP address to make 5 requests every 5 seconds
  throttle('req/ip', limit: 3600, period: 3600) do |req|
    req.ip
  end

  # Send the following response to throttled clients
  self.throttled_response = ->(env) {
    now = Time.now
    match_data = env['rack.attack.match_data']

    headers = {
      'Content-Type' => 'application/json',
      'X-RateLimit-Limit' => match_data[:limit].to_s,
      'X-RateLimit-Remaining' => (match_data[:limit] - match_data[:count]).to_s,
      'X-RateLimit-Reset' => (now + (match_data[:period] - now.to_i % match_data[:period])).to_s
    }

    [ 429, headers, ["Throttled\n"]]
  }
end
