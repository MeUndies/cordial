module Cordial
  # Pragmatic wrapper around the orders REST Api.
  #
  # @see https://api.cordial.io/docs/v1/#!/orders
  class Orders
    include ::HTTParty
    extend Client

    # Find an order
    # @example Usage
    #  Cordial::Orders.find(id: 1)
    #
    # @param id [String|Fixnum] The order's id.
    #
    # @return [Hash]
    # @return [{"error"=>true, "message"=>"record not found"}]
    def self.find(id:)
      client.get("/orders/#{id}")
    end

    # Create a new order.
    #
    # @note This endpoint does not support upsert.
    #
    # @example Usage.
    #   Cordial::Orders.create({...})
    #
    # @return [{"success"=>true}]
    # @return [{"error"=>true, "messages"=>"ID must be unique"}]
    def self.create(options)
      order = Cordial::Order.new(options)
      client.post('/orders', body: order.to_json)
    end

    # List Orders matching criteria.
    #
    # @example
    #   Cordial::Orders.index(
    #     fields: 'orderID,purchaseDate',
    #     purchaseDate: { 'lt': '2018-10-21 11:11:11' },
    #     per_page: 5
    #   )
    #
    # @option options [String] :fields Comma delimited string of fields to be returned.
    # @option options [String] :cID Where Customer ID is..
    # @option options [String] :email Where email is..
    # @option options [Hash] :purchaseDate When purchased on, before, and after (YYYY-MM-DD HH:ii:ss)
    #   {
    #     'eq': '2018-10-31 11:59:59',
    #     'lt': '2018-10-31 11:59:59',
    #     'gt': '2018-10-31 11:59:59'
    #     }
    # @option options [Fixnum] :page Which page of results
    # @option options [Fixnum] :per_page How many results to return on a page (max: 10,000)
    #
    # @return [Array<Hash>]
    def self.index(options = {})
      client.get(
        '/orders',
        query: {
          'fields': options[:fields],
          'cID': options[:cID],
          'email': options[:email],
          'purchaseDate': options[:purchaseDate],
          'page': options[:page],
          'per_page': options[:per_page]
        }.compact
      )
    end
  end
end
