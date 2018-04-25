module Cordial
  # https://api.cordial.io/docs/v1/#!/contacts
  class Contacts
    include ::HTTParty
    extend Client

    def self.find(email:)
      client.get("/contacts/#{email}")
    end
  end
end
