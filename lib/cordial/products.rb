module Cordial
  # Wraps all interaction with the Product resource.
  # @see https://api.cordial.io/docs/v1/#!/products
  class Products
    include ::HTTParty
    extend Client

    # Find a product.
    # @example Usage
    #  Cordial::products.find(product_id: 1)
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
  end
end
