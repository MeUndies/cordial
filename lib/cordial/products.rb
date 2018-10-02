module Cordial
  # Wraps all interaction with the Product resource.
  # @see https://api.cordial.io/docs/v1/#!/products
  class Products
    include ::HTTParty
    extend Client

    # Delete a product
    # @example Usage
    #  Cordial::Products.destroy(id: 1)
    # @example Response when the product was found.
    # {"success"=>true}
    #
    # @example Response when the product was not found.
    # {"error"=>true, "message"=>"Product not found"}
    def self.destroy(id:)
      client.delete("/products/#{id}")
    end

    # Find a product.
    # @example Usage
    #  Cordial::Products.find(id: 1)
    # @example Response when the product was found.
    # {
    #   "_id"=>"5b28275fe1dc0fa0c872abec",
    #   "productID"=>"1",
    #   "productName"=>"Test Product",
    #   "price"=>10,
    #   "variants"=>[
    #     {
    #       "sku"=>"123456789",
    #       "attr"=>{"color"=>"blue", "size"=>"Large"},
    #       "qty"=>"10"}
    #   ],
    #   "accountID"=>645,
    #   "totalQty"=>10,
    #   "lm"=>"2018-06-18T21:42:55+0000",
    #   "ct"=>"2018-06-18T21:42:55+0000"
    # }
    #
    # @example Response when the product was not found.
    #  {"error"=>true, "message"=>"record not found"}
    def self.find(id:)
      client.get("/products/#{id}")
    end

    # Create a new product.
    # options keyword argument is for optional parameters
    # https://support.cordial.com/hc/en-us/articles/203886098#postProducts
    # If the product already exists it will be updated.
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
