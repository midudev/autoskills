# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Reporting
    class ReportTypeService < StripeService
      # Returns a full list of Report Types.
      sig {
        params(params: T.any(::Stripe::Reporting::ReportTypeListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves the details of a Report Type. (Certain report types require a [live-mode API key](https://stripe.com/docs/keys#test-live-modes).)
      sig {
        params(report_type: String, params: T.any(::Stripe::Reporting::ReportTypeRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Reporting::ReportType)
       }
      def retrieve(report_type, params = {}, opts = {}); end
    end
  end
end