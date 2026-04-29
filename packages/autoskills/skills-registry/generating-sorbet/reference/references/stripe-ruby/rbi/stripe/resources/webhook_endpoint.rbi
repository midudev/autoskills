# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # You can configure [webhook endpoints](https://docs.stripe.com/webhooks/) via the API to be
  # notified about events that happen in your Stripe account or connected
  # accounts.
  #
  # Most users configure webhooks from [the dashboard](https://dashboard.stripe.com/webhooks), which provides a user interface for registering and testing your webhook endpoints.
  #
  # Related guide: [Setting up webhooks](https://docs.stripe.com/webhooks/configure)
  class WebhookEndpoint < APIResource
    # The API version events are rendered as for this webhook endpoint.
    sig { returns(T.nilable(String)) }
    def api_version; end
    # The ID of the associated Connect application.
    sig { returns(T.nilable(String)) }
    def application; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # An optional description of what the webhook is used for.
    sig { returns(T.nilable(String)) }
    def description; end
    # The list of events to enable for this endpoint. `['*']` indicates that all events are enabled, except those that require explicit selection.
    sig { returns(T::Array[String]) }
    def enabled_events; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T::Hash[String, String]) }
    def metadata; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The endpoint's secret, used to generate [webhook signatures](https://docs.stripe.com/webhooks/signatures). Only returned at creation.
    sig { returns(T.nilable(String)) }
    def secret; end
    # The status of the webhook. It can be `enabled` or `disabled`.
    sig { returns(String) }
    def status; end
    # The URL of the webhook endpoint.
    sig { returns(String) }
    def url; end
    # Always true for a deleted object
    sig { returns(T.nilable(T::Boolean)) }
    def deleted; end
    # A webhook endpoint must have a url and a list of enabled_events. You may optionally specify the Boolean connect parameter. If set to true, then a Connect webhook endpoint that notifies the specified url about events from all connected accounts is created; otherwise an account webhook endpoint that notifies the specified url only about events from your account is created. You can also create webhook endpoints in the [webhooks settings](https://dashboard.stripe.com/account/webhooks) section of the Dashboard.
    sig {
      params(params: T.any(::Stripe::WebhookEndpointCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::WebhookEndpoint)
     }
    def self.create(params = {}, opts = {}); end

    # You can also delete webhook endpoints via the [webhook endpoint management](https://dashboard.stripe.com/account/webhooks) page of the Stripe dashboard.
    sig {
      params(webhook_endpoint: String, params: T.any(::Stripe::WebhookEndpointDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::WebhookEndpoint)
     }
    def self.delete(webhook_endpoint, params = {}, opts = {}); end

    # You can also delete webhook endpoints via the [webhook endpoint management](https://dashboard.stripe.com/account/webhooks) page of the Stripe dashboard.
    sig {
      params(params: T.any(::Stripe::WebhookEndpointDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::WebhookEndpoint)
     }
    def delete(params = {}, opts = {}); end

    # Returns a list of your webhook endpoints.
    sig {
      params(params: T.any(::Stripe::WebhookEndpointListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Updates the webhook endpoint. You may edit the url, the list of enabled_events, and the status of your endpoint.
    sig {
      params(webhook_endpoint: String, params: T.any(::Stripe::WebhookEndpointUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::WebhookEndpoint)
     }
    def self.update(webhook_endpoint, params = {}, opts = {}); end
  end
end