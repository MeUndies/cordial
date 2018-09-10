module Cordial
  class Order < Hashie::Dash
    property :orderID
    property :email, required: -> { cID.nil? }, message: 'email is required if cID is not set.'
    property :cID, required: -> { email.nil? }, message: 'cID is required if email is not set.'
    property :linkID
    property :status
    property :mcID
    property :storeID
    property :customerID
    property :purchaseDate
    property :shippingAddress
    property :billingAddress
    property :items
    property :tax
    property :shippingAndHandling
    property :properties
  end
end
