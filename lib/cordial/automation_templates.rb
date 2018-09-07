module Cordial
  # Wraps all interaction with the Automation Templates resource.
  # @see https://api.cordial.io/docs/v1/#!/automation_templates
  class AutomationTemplates
    include ::HTTParty
    extend Client

    # Create a new message template.
    #
    # @example Usage.
    # Cordial::AutomationTemplates.create(
    #   key: "promo_01_20_2018",
    #   name: "promo_01_20_2018",
    #   channel: "email",
    #   classification: "promotional",
    #   base_aggregation: "hourly",
    #   headers:{
    #     subject_email: "One Day Only Sale",
    #     from_email: "info@example.com",
    #     reply_email: "info@example.com",
    #     from_description: "Promotions Team"
    #   },
    #   content:{
    #     text: "<div>Hello World</div>"
    #   }
    # )
    #
    # @example successful response
    # {"success"=>true, "message"=>"record created"}
    #
    # @example failed response
    # {"error"=>true, "messages"=>"KEY must be unique"}
    #
    def self.create(key:, name:, channel:, classification:, base_aggregation:, headers:, content:)
      client.post('/automationtemplates',
                  body: {
                    key: key,
                    name: name,
                    channel: channel,
                    classification: classification,
                    baseAggregation: base_aggregation,
                    message: {
                      headers: {
                          subject: headers[:subject_email],
                          fromEmail: headers[:from_email],
                          replyEmail: headers[:reply_email],
                          fromDesc: headers[:from_description]
                      },
                      content: {
                          "text/html": content[:text]
                      }
                    }
                  }.to_json)
    end

    # Sends an automation template.
    #
    # @example Usage.
    # Cordial::AutomationTemplates.send(
    #   key: "promo_01_20_2018",
    #   email: "user@example.com",
    #   order: {
    #     number: "R123456789"
    #   }
    # )
    #
    # @example successful response with unsubscribed user
    # {"success"=>true, "message"=>"messages sent", "messagecontacts"=>[
    #   {"accepted"=>false, "email"=>"user@example.com", "error"=>"not-subscribed"}
    # ]}
    #
    # @example successful response with subscribed user
    # {"success"=>true, "message"=>"messages sent", "messagecontacts"=>
    #   [{"accepted"=>true,
    #     "email"=>"user@example.com",
    #     "mcID"=>"h123456:1a1a1a1a1a1:787457457",
    #     "cID"=>"a1a1a1a1a1a1a1a1a1"}
    #   ]}
    #
    # @example failed response
    # {"error"=>"'/v1/automationtemplates//send' is not found."}
    #
    def self.send(key:, email:, **args)
      client.post("/automationtemplates/#{key}/send",
                  body: {
                    to: {
                      contact: {
                        email: email
                      },
                      extVars: {}.compact.merge(args)
                    }
                  }.to_json)
    end
  end
end
