# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Sigma
    # If you have [scheduled a Sigma query](https://docs.stripe.com/sigma/scheduled-queries), you'll
    # receive a `sigma.scheduled_query_run.created` webhook each time the query
    # runs. The webhook contains a `ScheduledQueryRun` object, which you can use to
    # retrieve the query results.
    class ScheduledQueryRun < APIResource
      class Error < ::Stripe::StripeObject
        # Information about the run failure.
        sig { returns(String) }
        def message; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # When the query was run, Sigma contained a snapshot of your Stripe data at this time.
      sig { returns(Integer) }
      def data_load_time; end
      # Attribute for field error
      sig { returns(T.nilable(Error)) }
      def error; end
      # The file object representing the results of the query.
      sig { returns(T.nilable(::Stripe::File)) }
      def file; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Time at which the result expires and is no longer available for download.
      sig { returns(Integer) }
      def result_available_until; end
      # SQL for the query.
      sig { returns(String) }
      def sql; end
      # The query's execution status, which will be `completed` for successful runs, and `canceled`, `failed`, or `timed_out` otherwise.
      sig { returns(String) }
      def status; end
      # Title of the query.
      sig { returns(String) }
      def title; end
      # Returns a list of scheduled query runs.
      sig {
        params(params: T.any(::Stripe::Sigma::ScheduledQueryRunListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end