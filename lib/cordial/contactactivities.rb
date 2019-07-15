module Cordial
  # Pragmatic wrapper around the orders REST Api.
  #
  # @see https://api.cordial.io/docs/v1/#!/contactactivities
  class Contactactivities
    include ::HTTParty
    extend Client

    # Get Activity list
    # @example Usage
    #  Cordial::Contactactivities.find({...})
    #
    # @return [Hash]
    # @return [{"error"=>true, "message"=>"record not found"}]
    def self.find(options)
      client.get("/contactactivities", query: options)
    end

    # Add a new activity
    #
    # @example Usage.
    #   Cordial::Contactactivities.create({...})
    #
    # @return [{"success"=>true}]
    # @return [{"error"=>true, "messages"=>"..."}]
    def self.create(options)
      client.post("/contactactivities", body: options.to_json)
    end
  end
end
