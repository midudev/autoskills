# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    module Issuing
      class CardService < StripeService
        # Updates the shipping status of the specified Issuing Card object to delivered.
        sig {
          params(card: String, params: T.any(::Stripe::TestHelpers::Issuing::CardDeliverCardParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Card)
         }
        def deliver_card(card, params = {}, opts = {}); end

        # Updates the shipping status of the specified Issuing Card object to failure.
        sig {
          params(card: String, params: T.any(::Stripe::TestHelpers::Issuing::CardFailCardParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Card)
         }
        def fail_card(card, params = {}, opts = {}); end

        # Updates the shipping status of the specified Issuing Card object to returned.
        sig {
          params(card: String, params: T.any(::Stripe::TestHelpers::Issuing::CardReturnCardParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Card)
         }
        def return_card(card, params = {}, opts = {}); end

        # Updates the shipping status of the specified Issuing Card object to shipped.
        sig {
          params(card: String, params: T.any(::Stripe::TestHelpers::Issuing::CardShipCardParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Card)
         }
        def ship_card(card, params = {}, opts = {}); end

        # Updates the shipping status of the specified Issuing Card object to submitted. This method requires Stripe Version ‘2024-09-30.acacia' or later.
        sig {
          params(card: String, params: T.any(::Stripe::TestHelpers::Issuing::CardSubmitCardParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Card)
         }
        def submit_card(card, params = {}, opts = {}); end
      end
    end
  end
end