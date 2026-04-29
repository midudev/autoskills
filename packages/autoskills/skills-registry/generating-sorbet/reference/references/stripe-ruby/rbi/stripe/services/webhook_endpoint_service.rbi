# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class WebhookEndpointService < StripeService
    # A webhook endpoint must have a url and a list of enabled_events. You may optionally specify the Boolean connect parameter. If set to true, then a Connect webhook endpoint that notifies the specified url about events from all connected accounts is created; otherwise an account webhook endpoint that notifies the specified url only about events from your account is created. You can also create webhook endpoints in the [webhooks settings](https://dashboard.stripe.com/account/webhooks) section of the Dashboard.
    sig {
      params(params: T.any(::Stripe::WebhookEndpointCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::WebhookEndpoint)
     }
    def create(params = {}, opts = {}); end

    # You can also delete webhook endpoints via the [webhook endpoint management](https://dashboard.stripe.com/account/webhooks) page of the Stripe dashboard.
    sig {
      params(webhook_endpoint: String, params: T.any(::Stripe::WebhookEndpointDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::WebhookEndpoint)
     }
    def delete(webhook_endpoint, params = {}, opts = {}); end

    # Returns a list of your webhook endpoints.
    sig {
      params(params: T.any(::Stripe::WebhookEndpointListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves the webhook endpoint with the given ID.
    sig {
      params(webhook_endpoint: String, params: T.any(::Stripe::WebhookEndpointRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::WebhookEndpoint)
     }
    def retrieve(webhook_endpoint, params = {}, opts = {}); end

    # Updates the webhook endpoint. You may edit the url, the list of enabled_events, and the status of your endpoint.
    sig {
      params(webhook_endpoint: String, params: T.any(::Stripe::WebhookEndpointUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::WebhookEndpoint)
     }
    def update(webhook_endpoint, params = {}, opts = {}); end
  end
end