# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      # Set up an event destination to receive events from Stripe across multiple destination types, including [webhook endpoints](https://docs.stripe.com/webhooks) and [Amazon EventBridge](https://docs.stripe.com/event-destinations/eventbridge). Event destinations support receiving [thin events](https://docs.stripe.com/api/v2/events) and [snapshot events](https://docs.stripe.com/api/events).
      class EventDestination < APIResource
        class StatusDetails < ::Stripe::StripeObject
          class Disabled < ::Stripe::StripeObject
            # Reason event destination has been disabled.
            sig { returns(String) }
            def reason; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Details about why the event destination has been disabled.
          sig { returns(T.nilable(Disabled)) }
          def disabled; end
          def self.inner_class_types
            @inner_class_types = {disabled: Disabled}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class AmazonEventbridge < ::Stripe::StripeObject
          # The AWS account ID.
          sig { returns(String) }
          def aws_account_id; end
          # The ARN of the AWS event source.
          sig { returns(String) }
          def aws_event_source_arn; end
          # The state of the AWS event source.
          sig { returns(String) }
          def aws_event_source_status; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class WebhookEndpoint < ::Stripe::StripeObject
          # The signing secret of the webhook endpoint, only includable on creation.
          sig { returns(T.nilable(String)) }
          def signing_secret; end
          # The URL of the webhook endpoint, includable.
          sig { returns(T.nilable(String)) }
          def url; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Time at which the object was created.
        sig { returns(String) }
        def created; end
        # An optional description of what the event destination is used for.
        sig { returns(String) }
        def description; end
        # The list of events to enable for this endpoint.
        sig { returns(T::Array[String]) }
        def enabled_events; end
        # Payload type of events being subscribed to.
        sig { returns(String) }
        def event_payload; end
        # Where events should be routed from.
        sig { returns(T.nilable(T::Array[String])) }
        def events_from; end
        # Unique identifier for the object.
        sig { returns(String) }
        def id; end
        # Metadata.
        sig { returns(T.nilable(T::Hash[String, String])) }
        def metadata; end
        # Event destination name.
        sig { returns(String) }
        def name; end
        # String representing the object's type. Objects of the same type share the same value of the object field.
        sig { returns(String) }
        def object; end
        # If using the snapshot event payload, the API version events are rendered as.
        sig { returns(T.nilable(String)) }
        def snapshot_api_version; end
        # Status. It can be set to either enabled or disabled.
        sig { returns(String) }
        def status; end
        # Additional information about event destination status.
        sig { returns(T.nilable(StatusDetails)) }
        def status_details; end
        # Event destination type.
        sig { returns(String) }
        def type; end
        # Time at which the object was last updated.
        sig { returns(String) }
        def updated; end
        # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        sig { returns(T::Boolean) }
        def livemode; end
        # Amazon EventBridge configuration.
        sig { returns(T.nilable(AmazonEventbridge)) }
        def amazon_eventbridge; end
        # Webhook endpoint configuration.
        sig { returns(T.nilable(WebhookEndpoint)) }
        def webhook_endpoint; end
      end
    end
  end
end