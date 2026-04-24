# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      class EventDestinationCreateParams < ::Stripe::RequestParams
        class AmazonEventbridge < ::Stripe::RequestParams
          # The AWS account ID.
          sig { returns(String) }
          def aws_account_id; end
          sig { params(_aws_account_id: String).returns(String) }
          def aws_account_id=(_aws_account_id); end
          # The region of the AWS event source.
          sig { returns(String) }
          def aws_region; end
          sig { params(_aws_region: String).returns(String) }
          def aws_region=(_aws_region); end
          sig { params(aws_account_id: String, aws_region: String).void }
          def initialize(aws_account_id: nil, aws_region: nil); end
        end
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
        sig { returns(T::Array[String]) }
        def enabled_events; end
        sig { params(_enabled_events: T::Array[String]).returns(T::Array[String]) }
        def enabled_events=(_enabled_events); end
        # Payload type of events being subscribed to.
        sig { returns(String) }
        def event_payload; end
        sig { params(_event_payload: String).returns(String) }
        def event_payload=(_event_payload); end
        # Where events should be routed from.
        sig { returns(T.nilable(T::Array[String])) }
        def events_from; end
        sig {
          params(_events_from: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
         }
        def events_from=(_events_from); end
        # Additional fields to include in the response.
        sig { returns(T.nilable(T::Array[String])) }
        def include; end
        sig { params(_include: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
        def include=(_include); end
        # Metadata.
        sig { returns(T.nilable(T::Hash[String, String])) }
        def metadata; end
        sig {
          params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
         }
        def metadata=(_metadata); end
        # Event destination name.
        sig { returns(String) }
        def name; end
        sig { params(_name: String).returns(String) }
        def name=(_name); end
        # If using the snapshot event payload, the API version events are rendered as.
        sig { returns(T.nilable(String)) }
        def snapshot_api_version; end
        sig { params(_snapshot_api_version: T.nilable(String)).returns(T.nilable(String)) }
        def snapshot_api_version=(_snapshot_api_version); end
        # Event destination type.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        # Amazon EventBridge configuration.
        sig { returns(T.nilable(V2::Core::EventDestinationCreateParams::AmazonEventbridge)) }
        def amazon_eventbridge; end
        sig {
          params(_amazon_eventbridge: T.nilable(V2::Core::EventDestinationCreateParams::AmazonEventbridge)).returns(T.nilable(V2::Core::EventDestinationCreateParams::AmazonEventbridge))
         }
        def amazon_eventbridge=(_amazon_eventbridge); end
        # Webhook endpoint configuration.
        sig { returns(T.nilable(V2::Core::EventDestinationCreateParams::WebhookEndpoint)) }
        def webhook_endpoint; end
        sig {
          params(_webhook_endpoint: T.nilable(V2::Core::EventDestinationCreateParams::WebhookEndpoint)).returns(T.nilable(V2::Core::EventDestinationCreateParams::WebhookEndpoint))
         }
        def webhook_endpoint=(_webhook_endpoint); end
        sig {
          params(description: T.nilable(String), enabled_events: T::Array[String], event_payload: String, events_from: T.nilable(T::Array[String]), include: T.nilable(T::Array[String]), metadata: T.nilable(T::Hash[String, String]), name: String, snapshot_api_version: T.nilable(String), type: String, amazon_eventbridge: T.nilable(V2::Core::EventDestinationCreateParams::AmazonEventbridge), webhook_endpoint: T.nilable(V2::Core::EventDestinationCreateParams::WebhookEndpoint)).void
         }
        def initialize(
          description: nil,
          enabled_events: nil,
          event_payload: nil,
          events_from: nil,
          include: nil,
          metadata: nil,
          name: nil,
          snapshot_api_version: nil,
          type: nil,
          amazon_eventbridge: nil,
          webhook_endpoint: nil
        ); end
      end
    end
  end
end