# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    class CalculationService < StripeService
      attr_reader :line_items
      # Calculates tax based on the input and returns a Tax Calculation object.
      sig {
        params(params: T.any(::Stripe::Tax::CalculationCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Tax::Calculation)
       }
      def create(params = {}, opts = {}); end

      # Retrieves a Tax Calculation object, if the calculation hasn't expired.
      sig {
        params(calculation: String, params: T.any(::Stripe::Tax::CalculationRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Tax::Calculation)
       }
      def retrieve(calculation, params = {}, opts = {}); end
    end
  end
end