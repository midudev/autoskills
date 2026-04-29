# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      class EventDestinationUpdateParams < ::Stripe::RequestParams
        class WebhookEndpoint < ::Stripe::RequestParams
          # The URL of the webhook endpoint.
          sig { returns(String) }
          def url; end
          sig { params(_url: String).returns(String) }
          def url=(_url); end
          sig { params(url: String).void }
          def initialize(url: nil); end
        end
        # An optional description of what the event destination is used for.
        sig { returns(T.nilable(String)) }
        def description; end
        sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
        def description=(_description); end
        # The list of events to enable for this endpoint.
        sig { returns(T.nilable(T::Array[String])) }
        def enabled_events; end
        sig {
          params(_enabled_events: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
         }
        def enabled_events=(_enabled_events); end
        # Additional fields to include in the response. Currently supports `webhook_endpoint.url`.
        sig { returns(T.nilable(T::Array[String])) }
        def include; end
        sig { params(_include: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
        def include=(_include); end
        # Metadata.
        sig { returns(T.nilable(T::Hash[String, T.nilable(String)])) }
        def metadata; end
        sig {
          params(_metadata: T.nilable(T::Hash[String, T.nilable(String)])).returns(T.nilable(T::Hash[String, T.nilable(String)]))
         }
        def metadata=(_metadata); end
        # Event destination name.
        sig { returns(T.nilable(String)) }
        def name; end
        sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
        def name=(_name); end
        # Webhook endpoint configuration.
        sig { returns(T.nilable(V2::Core::EventDestinationUpdateParams::WebhookEndpoint)) }
        def webhook_endpoint; end
        sig {
          params(_webhook_endpoint: T.nilable(V2::Core::EventDestinationUpdateParams::WebhookEndpoint)).returns(T.nilable(V2::Core::EventDestinationUpdateParams::WebhookEndpoint))
         }
        def webhook_endpoint=(_webhook_endpoint); end
        sig {
          params(description: T.nilable(String), enabled_events: T.nilable(T::Array[String]), include: T.nilable(T::Array[String]), metadata: T.nilable(T::Hash[String, T.nilable(String)]), name: T.nilable(String), webhook_endpoint: T.nilable(V2::Core::EventDestinationUpdateParams::WebhookEndpoint)).void
         }
        def initialize(
          description: nil,
          enabled_events: nil,
          include: nil,
          metadata: nil,
          name: nil,
          webhook_endpoint: nil
        ); end
      end
    end
  end
end