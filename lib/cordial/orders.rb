module Cordial
  # Wraps all interaction with the Order resource.
  # @see https://api.cordial.io/docs/v1/#!/orders
  class Orders
    include ::HTTParty
    extend Client

    # Find an order
    # @example Usage
    #  Cordial::Orders.find(id: 1)
    # @example Response when the order was found
    # {
    #   "_id"=>"5b3a774a2cab4e1a59d0cc6d",
    #   "orderID"=>"1",
    #   "purchaseDate"=>"2015-01-10T01:47:43+0000",
    #   "items"=>[
    #     {
    #       "productID"=>"1",
    #       "sku"=>"123",
    #       "name"=>"Test product",
    #       "attr"=>{
    #         "color"=>"blue",
    #         "size"=>"L"
    #        },
    #       "amount"=>0
    #     }
    #   ],
    #   "cID"=>"5aea409bbb3dc2f9bc27158f",
    #   "totalAmount"=>0
    # }
    #
    # @example Response when the order was not found.
    #  {"error"=>true, "message"=>"record not found"}
    def self.find(id:)
      client.get("/orders/#{id}")
    end

    # Create a new order.
    #
    # This endpoint does not support the idea of an upsert like others do.
    # Subsequent calls will fail.
    #
    # @example Usage.
    # Cordial::Orders.create({...})
    #
    # @example response when the orderID is not on cordial
    # {"success"=>true}
    #
    # @example Response when orderID already exist on cordial.
    # {"error"=>true, "messages"=>"ID must be unique"}
    def self.create(options)
      order = Cordial::Order.new(options)
      client.post('/orders', body: order.to_json)
    end

    # List orders in Cordial
    def self.index
      client.get('/orders')
    end

    # Delete an order
    # @example Usage
    #  Cordial::Orders.destroy(id: 1)
    # @example Response when the order was found.
    # {"success"=>true}
    #
    # @example Response when the order was not found.
    # {"error"=>true, "message"=>"Product not found"}
    def self.destroy(id:)
      client.delete("/orders/#{id}")
    end
  end
end
