# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Checkout
    class SessionLineItemService < StripeService
      # When retrieving a Checkout Session, there is an includable line_items property containing the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
      sig {
        params(session: String, params: T.any(::Stripe::Checkout::SessionLineItemListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(session, params = {}, opts = {}); end
    end
  end
end