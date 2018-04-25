module Cordial
  # https://api.cordial.io/docs/v1/#!/contacts
  class Contacts
    include ::HTTParty
    extend Client

    base_uri 'https://api.cordial.io/v1/contacts'

    def self.find(email:)
      client.get("/#{email}")
    end
  end
end
