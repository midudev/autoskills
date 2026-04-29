# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ApplicationFeeService < StripeService
    attr_reader :refunds
    # Returns a list of application fees you've previously collected. The application fees are returned in sorted order, with the most recent fees appearing first.
    sig {
      params(params: T.any(::Stripe::ApplicationFeeListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves the details of an application fee that your account has collected. The same information is returned when refunding the application fee.
    sig {
      params(id: String, params: T.any(::Stripe::ApplicationFeeRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ApplicationFee)
     }
    def retrieve(id, params = {}, opts = {}); end
  end
end