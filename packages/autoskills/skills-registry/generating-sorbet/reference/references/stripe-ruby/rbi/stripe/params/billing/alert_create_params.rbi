# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    class AlertCreateParams < ::Stripe::RequestParams
      class UsageThreshold < ::Stripe::RequestParams
        class Filter < ::Stripe::RequestParams
          # Limit the scope to this usage alert only to this customer.
          sig { returns(T.nilable(String)) }
          def customer; end
          sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
          def customer=(_customer); end
          # What type of filter is being applied to this usage alert.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(customer: T.nilable(String), type: String).void }
          def initialize(customer: nil, type: nil); end
        end
        # The filters allows limiting the scope of this usage alert. You can only specify up to one filter at this time.
        sig { returns(T.nilable(T::Array[Billing::AlertCreateParams::UsageThreshold::Filter])) }
        def filters; end
        sig {
          params(_filters: T.nilable(T::Array[Billing::AlertCreateParams::UsageThreshold::Filter])).returns(T.nilable(T::Array[Billing::AlertCreateParams::UsageThreshold::Filter]))
         }
        def filters=(_filters); end
        # Defines at which value the alert will fire.
        sig { returns(Integer) }
        def gte; end
        sig { params(_gte: Integer).returns(Integer) }
        def gte=(_gte); end
        # The [Billing Meter](/api/billing/meter) ID whose usage is monitored.
        sig { returns(String) }
        def meter; end
        sig { params(_meter: String).returns(String) }
        def meter=(_meter); end
        # Defines how the alert will behave.
        sig { returns(String) }
        def recurrence; end
        sig { params(_recurrence: String).returns(String) }
        def recurrence=(_recurrence); end
        sig {
          params(filters: T.nilable(T::Array[Billing::AlertCreateParams::UsageThreshold::Filter]), gte: Integer, meter: String, recurrence: String).void
         }
        def initialize(filters: nil, gte: nil, meter: nil, recurrence: nil); end
      end
      # The type of alert to create.
      sig { returns(String) }
      def alert_type; end
      sig { params(_alert_type: String).returns(String) }
      def alert_type=(_alert_type); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # The title of the alert.
      sig { returns(String) }
      def title; end
      sig { params(_title: String).returns(String) }
      def title=(_title); end
      # The configuration of the usage threshold.
      sig { returns(T.nilable(Billing::AlertCreateParams::UsageThreshold)) }
      def usage_threshold; end
      sig {
        params(_usage_threshold: T.nilable(Billing::AlertCreateParams::UsageThreshold)).returns(T.nilable(Billing::AlertCreateParams::UsageThreshold))
       }
      def usage_threshold=(_usage_threshold); end
      sig {
        params(alert_type: String, expand: T.nilable(T::Array[String]), title: String, usage_threshold: T.nilable(Billing::AlertCreateParams::UsageThreshold)).void
       }
      def initialize(alert_type: nil, expand: nil, title: nil, usage_threshold: nil); end
    end
  end
end