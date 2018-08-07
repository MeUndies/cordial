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
    # Posting more than one time the same "orderID" name will generate an error.
    #
    # @example Usage.
    # Cordial::Orders.create(
    #   id: 1,
    #   email: 'cordial@example.com',
    #   link_id: '123456',
    #   mc_id: '645:5b6a1f26e1b829b63c2a7946:ot:5aea409bbb3dc2f9bc27158f:1',
    #   purchase_date: '2015-01-09 17:47:43',
    #   items: [{productID: '1',
    #            sku: '123',
    #            name: 'Test product',
    #            attr: { color: 'blue', size: 'L' }}])
    # @example response whe the orderID is not on cordial
    # {"success"=>true}
    #
    # @example Response when orderID already exist on cordial.
    # {"error"=>true, "messages"=>"ID must be unique"}
    def self.create(id:, email:, purchase_date:, items:, link_id: '', mc_id: '')
      body = {
        orderID: id,
        email: email,
        purchaseDate: purchase_date,
        items: items
      }

      body[:linkID] = link_id unless link_id.empty?
      body[:mcID] = mc_id unless mc_id.empty?

      client.post('/orders', body: body.to_json)
    end
  end
end
