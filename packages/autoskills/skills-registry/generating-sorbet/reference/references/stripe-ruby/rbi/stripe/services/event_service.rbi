# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class EventService < StripeService
    # List events, going back up to 30 days. Each event data is rendered according to Stripe API version at its creation time, specified in [event object](https://docs.stripe.com/api/events/object) api_version attribute (not according to your current Stripe API version or Stripe-Version header).
    sig {
      params(params: T.any(::Stripe::EventListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves the details of an event if it was created in the last 30 days. Supply the unique identifier of the event, which you might have received in a webhook.
    sig {
      params(id: String, params: T.any(::Stripe::EventRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Event)
     }
    def retrieve(id, params = {}, opts = {}); end
  end
end