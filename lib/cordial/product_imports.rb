module Cordial
  # Wraps all interaction with the Product Imports resource.
  # @see https://api.cordial.io/docs/v1/#!/productimports
  class ProductImports
    include ::HTTParty
    extend Client

    # Creates an import job to batch load a file of products.
    #
    # @example Usage.
    #  Cordial::ProductImports.import(
    #    transport: "https",
    #    url: "https://example.com/product-import.csv",
    #    email: "example@email.com"
    #  )
    #
    # @example Response when the file was imported.
    # {"jobId"=>"f2f3f4u4j5h67687bhhjg78"}
    #
    # @example Response when the file was not found.
    # {"jobId"=>{"error"=>true, "message"=>"File not found"}}
    #
    def self.import(transport:, url:, email:)
      client.post('/productimports',
                  body: {
                    source: {
                      transport: transport,
                      url: url
                    },
                    hasHeader: true,
                    confirmEmail: email
                  }.to_json)
    end
  end
end
