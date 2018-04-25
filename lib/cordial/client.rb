module Cordial
  # Encapsulates the configuration of each client before JIT before requests
  # are made. This allows us to use our configuration which won't have been
  # available until runtime, not load time.
  module Client
    def client
      basic_auth(Cordial.config.api_key, '')
      self
    end
  end
end
