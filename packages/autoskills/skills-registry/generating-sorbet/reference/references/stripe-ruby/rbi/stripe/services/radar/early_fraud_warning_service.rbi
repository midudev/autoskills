# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Radar
    class EarlyFraudWarningService < StripeService
      # Returns a list of early fraud warnings.
      sig {
        params(params: T.any(::Stripe::Radar::EarlyFraudWarningListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves the details of an early fraud warning that has previously been created.
      #
      # Please refer to the [early fraud warning](https://docs.stripe.com/api#early_fraud_warning_object) object reference for more details.
      sig {
        params(early_fraud_warning: String, params: T.any(::Stripe::Radar::EarlyFraudWarningRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Radar::EarlyFraudWarning)
       }
      def retrieve(early_fraud_warning, params = {}, opts = {}); end
    end
  end
end