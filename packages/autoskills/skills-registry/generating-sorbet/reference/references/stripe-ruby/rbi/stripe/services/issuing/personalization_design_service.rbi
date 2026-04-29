# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class PersonalizationDesignService < StripeService
      # Creates a personalization design object.
      sig {
        params(params: T.any(::Stripe::Issuing::PersonalizationDesignCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::PersonalizationDesign)
       }
      def create(params = {}, opts = {}); end

      # Returns a list of personalization design objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
      sig {
        params(params: T.any(::Stripe::Issuing::PersonalizationDesignListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves a personalization design object.
      sig {
        params(personalization_design: String, params: T.any(::Stripe::Issuing::PersonalizationDesignRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::PersonalizationDesign)
       }
      def retrieve(personalization_design, params = {}, opts = {}); end

      # Updates a card personalization object.
      sig {
        params(personalization_design: String, params: T.any(::Stripe::Issuing::PersonalizationDesignUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::PersonalizationDesign)
       }
      def update(personalization_design, params = {}, opts = {}); end
    end
  end
end