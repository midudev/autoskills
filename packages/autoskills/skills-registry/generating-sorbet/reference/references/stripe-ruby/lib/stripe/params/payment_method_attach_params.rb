# File generated from our OpenAPI spec
# frozen_string_literal: true

module Stripe
  class PaymentMethodAttachParams < ::Stripe::RequestParams
    # The ID of the customer to which to attach the PaymentMethod.
    attr_accessor :customer
    # The ID of the Account representing the customer to which to attach the PaymentMethod.
    attr_accessor :customer_account
    # Specifies which fields in the response should be expanded.
    attr_accessor :expand

    def initialize(customer: nil, customer_account: nil, expand: nil)
      @customer = customer
      @customer_account = customer_account
      @expand = expand
    end
  end
end
