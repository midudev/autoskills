# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    class AlertService < StripeService
      # Reactivates this alert, allowing it to trigger again.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::AlertActivateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Alert)
       }
      def activate(id, params = {}, opts = {}); end

      # Archives this alert, removing it from the list view and APIs. This is non-reversible.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::AlertArchiveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Alert)
       }
      def archive(id, params = {}, opts = {}); end

      # Creates a billing alert
      sig {
        params(params: T.any(::Stripe::Billing::AlertCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Alert)
       }
      def create(params = {}, opts = {}); end

      # Deactivates this alert, preventing it from triggering.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::AlertDeactivateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Alert)
       }
      def deactivate(id, params = {}, opts = {}); end

      # Lists billing active and inactive alerts
      sig {
        params(params: T.any(::Stripe::Billing::AlertListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves a billing alert given an ID
      sig {
        params(id: String, params: T.any(::Stripe::Billing::AlertRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Alert)
       }
      def retrieve(id, params = {}, opts = {}); end
    end
  end
end