# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class DisputeService < StripeService
      # Creates an Issuing Dispute object. Individual pieces of evidence within the evidence object are optional at this point. Stripe only validates that required evidence is present during submission. Refer to [Dispute reasons and evidence](https://docs.stripe.com/docs/issuing/purchases/disputes#dispute-reasons-and-evidence) for more details about evidence requirements.
      sig {
        params(params: T.any(::Stripe::Issuing::DisputeCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Dispute)
       }
      def create(params = {}, opts = {}); end

      # Returns a list of Issuing Dispute objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
      sig {
        params(params: T.any(::Stripe::Issuing::DisputeListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves an Issuing Dispute object.
      sig {
        params(dispute: String, params: T.any(::Stripe::Issuing::DisputeRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Dispute)
       }
      def retrieve(dispute, params = {}, opts = {}); end

      # Submits an Issuing Dispute to the card network. Stripe validates that all evidence fields required for the dispute's reason are present. For more details, see [Dispute reasons and evidence](https://docs.stripe.com/docs/issuing/purchases/disputes#dispute-reasons-and-evidence).
      sig {
        params(dispute: String, params: T.any(::Stripe::Issuing::DisputeSubmitParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Dispute)
       }
      def submit(dispute, params = {}, opts = {}); end

      # Updates the specified Issuing Dispute object by setting the values of the parameters passed. Any parameters not provided will be left unchanged. Properties on the evidence object can be unset by passing in an empty string.
      sig {
        params(dispute: String, params: T.any(::Stripe::Issuing::DisputeUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Dispute)
       }
      def update(dispute, params = {}, opts = {}); end
    end
  end
end