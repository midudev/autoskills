# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Reporting
    class ReportRunService < StripeService
      # Creates a new object and begin running the report. (Certain report types require a [live-mode API key](https://stripe.com/docs/keys#test-live-modes).)
      sig {
        params(params: T.any(::Stripe::Reporting::ReportRunCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Reporting::ReportRun)
       }
      def create(params = {}, opts = {}); end

      # Returns a list of Report Runs, with the most recent appearing first.
      sig {
        params(params: T.any(::Stripe::Reporting::ReportRunListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves the details of an existing Report Run.
      sig {
        params(report_run: String, params: T.any(::Stripe::Reporting::ReportRunRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Reporting::ReportRun)
       }
      def retrieve(report_run, params = {}, opts = {}); end
    end
  end
end