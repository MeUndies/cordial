module Cordial
  # Pragmatic wrapper around the products REST Api.
  #
  # @see https://api.cordial.io/docs/v1/#!/products
  class Products
    include ::HTTParty
    extend Client

    # Find a product.
    #
    # @example Usage
    #  Cordial::Products.find(id: 1)
    #
    # @return [Hash]
    # @return [{"error"=>true, "message"=>"record not found"}]
    def self.find(id:)
      client.get("/products/#{id}")
    end

    # Create a new product.
    #
    # @note If the product already exists it will be updated.
    #
    # @see https://support.cordial.com/hc/en-us/articles/203886098#postProducts
    #
    # @param id [String|Fixnum]
    # @param name [String]
    #
    # @option options [Float] :price
    # @option options [Array<Hash>] :variants
    # @option options [Boolean] :inStock
    # @option options [Boolean] :taxable
    # @option options [Boolean] :enabled
    # @option options [Array] :tags
    # @option options [String] :url
    # @option options [Hash] :properties
    #
    # @example Usage.
    #  Cordial::Products.create(
    #    id: 1,
    #    name: 'Test Product',
    #    options: {
    #      price: 99.99,
    #      variants: [{
    #        sku: '123',
    #        attr: {
    #          color: 'red',
    #          size: 'L'
    #        }
    #      }],
    #      inStock: true,
    #      taxable: true,
    #      enabled: true,
    #      properties: {test_metadata: 'my test metadata'}
    #    }
    #  )
    def self.create(id:, name:, options: {})
      body = {
        productID: id,
        productName: name
      }.merge(options).compact

      client.post('/products', body: body.to_json)
    end
  end
end
