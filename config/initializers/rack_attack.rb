module Rack
  class Attack

    throttle('req/ip', limit: 300, period: 5.minutes, &:ip)

    self.blocklisted_responder = lambda do |request|
      # Using 503 because it may make attacker think that they have successfully
      # DOSed the site. Rack::Attack returns 403 for blocklists by default
      [ 503, {}, ['Blocked']]
    end
    
    
    self.throttled_responder = lambda do |request|
      # Using 503 because it may make attacker think that they have successfully
      # DOSed the site. Rack::Attack returns 429 for throttling by default  
      [ 503, {}, ["Server Error\n"]]
    end

  end
end

