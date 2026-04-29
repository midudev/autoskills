# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    class CalculationLineItemService < StripeService
      # Retrieves the line items of a tax calculation as a collection, if the calculation hasn't expired.
      sig {
        params(calculation: String, params: T.any(::Stripe::Tax::CalculationLineItemListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(calculation, params = {}, opts = {}); end
    end
  end
end