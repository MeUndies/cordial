module Cordial
  # https://api.cordial.io/docs/v1/#!/contacts
  class Contacts
    include ::HTTParty
    extend Client

    def self.find(email:)
      client.get("/contacts/#{email}")
    end

    def self.create(email:, attribute_list:)
      client.post('/contacts', body: {
        channels: {
          email: {
            address: email
          }
        }
      }.merge(attribute_list))
    end

    def self.unsubscribe(email:, channel: 'email')
      client.put("/contacts/#{email}/unsubscribe/#{channel}")
    end
  end
end
