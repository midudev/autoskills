# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Snapshot events allow you to track and react to activity in your Stripe integration. When
  # the state of another API resource changes, Stripe creates an `Event` object that contains
  # all the relevant information associated with that action, including the affected API
  # resource. For example, a successful payment triggers a `charge.succeeded` event, which
  # contains the `Charge` in the event's data property. Some actions trigger multiple events.
  # For example, if you create a new subscription for a customer, it triggers both a
  # `customer.subscription.created` event and a `charge.succeeded` event.
  #
  # Configure an event destination in your account to listen for events that represent actions
  # your integration needs to respond to. Additionally, you can retrieve an individual event or
  # a list of events from the API.
  #
  # [Connect](https://docs.stripe.com/connect) platforms can also receive event notifications
  # that occur in their connected accounts. These events include an account attribute that
  # identifies the relevant connected account.
  #
  # You can access events through the [Retrieve Event API](https://docs.stripe.com/api/events#retrieve_event)
  # for 30 days.
  class Event < APIResource
    class Data < ::Stripe::StripeObject
      # Object containing the API resource relevant to the event. For example, an `invoice.created` event will have a full [invoice object](https://api.stripe.com#invoice_object) as the value of the object key.
      sig { returns(T::Hash[String, T.untyped]) }
      def object; end
      # Object containing the names of the updated attributes and their values prior to the event (only included in events of type `*.updated`). If an array attribute has any updated elements, this object contains the entire array. In Stripe API versions 2017-04-06 or earlier, an updated array attribute in this object includes only the updated array elements.
      sig { returns(T.nilable(T::Hash[String, T.untyped])) }
      def previous_attributes; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Request < ::Stripe::StripeObject
      # ID of the API request that caused the event. If null, the event was automatic (e.g., Stripe's automatic subscription handling). Request logs are available in the [dashboard](https://dashboard.stripe.com/logs), but currently not in the API.
      sig { returns(T.nilable(String)) }
      def id; end
      # The idempotency key transmitted during the request, if any. *Note: This property is populated only for events on or after May 23, 2017*.
      sig { returns(T.nilable(String)) }
      def idempotency_key; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # The connected account that originates the event.
    sig { returns(T.nilable(String)) }
    def account; end
    # The Stripe API version used to render `data` when the event was created. The contents of `data` never change, so this value remains static regardless of the API version currently in use. This property is populated only for events created on or after October 31, 2014.
    sig { returns(T.nilable(String)) }
    def api_version; end
    # Authentication context needed to fetch the event or related object.
    sig { returns(T.nilable(String)) }
    def context; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Attribute for field data
    sig { returns(Data) }
    def data; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Number of webhooks that haven't been successfully delivered (for example, to return a 20x response) to the URLs you specify.
    sig { returns(Integer) }
    def pending_webhooks; end
    # Information on the API request that triggers the event.
    sig { returns(T.nilable(Request)) }
    def request; end
    # Description of the event (for example, `invoice.created` or `charge.refunded`).
    sig { returns(String) }
    def type; end
    # List events, going back up to 30 days. Each event data is rendered according to Stripe API version at its creation time, specified in [event object](https://docs.stripe.com/api/events/object) api_version attribute (not according to your current Stripe API version or Stripe-Version header).
    sig {
      params(params: T.any(::Stripe::EventListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end
  end
end