# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    class SettingsService < StripeService
      # Retrieves Tax Settings for a merchant.
      sig {
        params(params: T.any(::Stripe::Tax::SettingsRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Tax::Settings)
       }
      def retrieve(params = {}, opts = {}); end

      # Updates Tax Settings parameters used in tax calculations. All parameters are editable but none can be removed once set.
      sig {
        params(params: T.any(::Stripe::Tax::SettingsUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Tax::Settings)
       }
      def update(params = {}, opts = {}); end
    end
  end
end