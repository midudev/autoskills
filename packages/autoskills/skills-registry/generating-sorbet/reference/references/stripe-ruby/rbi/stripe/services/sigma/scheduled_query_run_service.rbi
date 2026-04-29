# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Sigma
    class ScheduledQueryRunService < StripeService
      # Returns a list of scheduled query runs.
      sig {
        params(params: T.any(::Stripe::Sigma::ScheduledQueryRunListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves the details of an scheduled query run.
      sig {
        params(scheduled_query_run: String, params: T.any(::Stripe::Sigma::ScheduledQueryRunRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Sigma::ScheduledQueryRun)
       }
      def retrieve(scheduled_query_run, params = {}, opts = {}); end
    end
  end
end