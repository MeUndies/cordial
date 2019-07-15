module Cordial
  class Cart < Hashie::Dash
    property :mcID
    property :customerID
    property :linkID
    property :cartID
    property :url
    property :expiration
    property :cartitems
    property :totalAmount
    property :tax
  end
end
