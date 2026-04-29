# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    # A test clock enables deterministic control over objects in testmode. With a test clock, you can create
    # objects at a frozen time in the past or future, and advance to a specific future time to observe webhooks and state changes. After the clock advances,
    # you can either validate the current state of your scenario (and test your assumptions), change the current state of your scenario (and test more complex scenarios), or keep advancing forward in time.
    class TestClock < APIResource
      class StatusDetails < ::Stripe::StripeObject
        class Advancing < ::Stripe::StripeObject
          # The `frozen_time` that the Test Clock is advancing towards.
          sig { returns(Integer) }
          def target_frozen_time; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field advancing
        sig { returns(T.nilable(Advancing)) }
        def advancing; end
        def self.inner_class_types
          @inner_class_types = {advancing: Advancing}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Time at which this clock is scheduled to auto delete.
      sig { returns(Integer) }
      def deletes_after; end
      # Time at which all objects belonging to this clock are frozen.
      sig { returns(Integer) }
      def frozen_time; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # The custom name supplied at creation.
      sig { returns(T.nilable(String)) }
      def name; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The status of the Test Clock.
      sig { returns(String) }
      def status; end
      # Attribute for field status_details
      sig { returns(StatusDetails) }
      def status_details; end
      # Always true for a deleted object
      sig { returns(T.nilable(T::Boolean)) }
      def deleted; end
      # Starts advancing a test clock to a specified time in the future. Advancement is done when status changes to Ready.
      sig {
        params(params: T.any(::Stripe::TestHelpers::TestClockAdvanceParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TestHelpers::TestClock)
       }
      def advance(params = {}, opts = {}); end

      # Starts advancing a test clock to a specified time in the future. Advancement is done when status changes to Ready.
      sig {
        params(test_clock: String, params: T.any(::Stripe::TestHelpers::TestClockAdvanceParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TestHelpers::TestClock)
       }
      def self.advance(test_clock, params = {}, opts = {}); end

      # Creates a new test clock that can be attached to new customers and quotes.
      sig {
        params(params: T.any(::Stripe::TestHelpers::TestClockCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TestHelpers::TestClock)
       }
      def self.create(params = {}, opts = {}); end

      # Deletes a test clock.
      sig {
        params(test_clock: String, params: T.any(::Stripe::TestHelpers::TestClockDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TestHelpers::TestClock)
       }
      def self.delete(test_clock, params = {}, opts = {}); end

      # Deletes a test clock.
      sig {
        params(params: T.any(::Stripe::TestHelpers::TestClockDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TestHelpers::TestClock)
       }
      def delete(params = {}, opts = {}); end

      # Returns a list of your test clocks.
      sig {
        params(params: T.any(::Stripe::TestHelpers::TestClockListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end