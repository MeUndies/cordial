module Cordial
  # Wraps all interaction with the Contact resource.
  # @see https://api.cordial.io/docs/v1/#!/contacts
  class Contacts
    include ::HTTParty
    extend Client

    # Find a contact.
    # @example Usage
    #  Cordial::Contacts.find(email: 'hello@world.earth')
    # @example Response when the contact was found.
    #   {
    #     "_id" => "111122223334444",
    #     "channels" => {
    #       "email" => {
    #         "address" => "hello@world.earth",
    #         "subscribeStatus" => "unsubscribed",
    #         "unsubscribedAt" => "2018-05-02T23:35:38+0000"
    #       }
    #     },
    #     "lastModified" => "2018-05-16T22:57:16+0000",
    #     "createdAt" => "2018-04-25T19:55:45+0000",
    #     "lists" => ["test-list"],
    #     "lj" => {
    #       "14854" => {
    #         "sec" => 1524897139,
    #         "usec" => 0
    #        }
    #      },
    #      "listJoinDate" => {
    #        "test-list" => "2018-04-28T06:32:19+0000"
    #      }
    #    }
    #
    # @example Response when the contact was not found.
    #  {"error"=>true, "message"=>"record not found"}
    def self.find(email:)
      client.get("/contacts/#{email}")
    end

    # Create a new contact.
    #
    # If the contact already exists it will be updated.
    # @example Usage.
    #  Cordial::Contacts.create(
    #    email: 'hello@world.earth',
    #    attribute_list: {
    #      some_attribute: 'your-custom-value'
    #    },
    #    subscribe_status: 'subscribed'
    #  )
    def self.create(email:, attribute_list: {}, subscribe_status: nil)
      client.post('/contacts', body: {
        channels: {
          email: {
            address: email,
            subscribeStatus: subscribe_status
          }.compact
        },
        forceSubscribe: subscribe_status == 'subscribed' || nil
      }.compact.merge(attribute_list))
    end

    # Unsubscribe a contact.
    #
    # @param channel [String] The channel to unsubscribe, defaults to `email`
    # @see https://support.cordial.com/hc/en-us/articles/115001319432-Channels-Overview
    # @example Usage. Default channel.
    #  Cordial::Contacts.unsubscribe(
    #    email: 'hello@world.earth'
    #  )
    def self.unsubscribe(email:, channel: 'email')
      client.put("/contacts/#{email}/unsubscribe/#{channel}")
    end
  end
end
