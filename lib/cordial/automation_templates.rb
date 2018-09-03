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
  end
end
