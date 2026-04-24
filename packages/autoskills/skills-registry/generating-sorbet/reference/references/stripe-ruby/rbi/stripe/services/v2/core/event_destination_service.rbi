# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      class EventDestinationService < StripeService
        # Create a new event destination.
        sig {
          params(params: T.any(::Stripe::V2::Core::EventDestinationCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Core::EventDestination)
         }
        def create(params = {}, opts = {}); end

        # Delete an event destination.
        sig {
          params(id: String, params: T.any(::Stripe::V2::Core::EventDestinationDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::DeletedObject)
         }
        def delete(id, params = {}, opts = {}); end

        # Disable an event destination.
        sig {
          params(id: String, params: T.any(::Stripe::V2::Core::EventDestinationDisableParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Core::EventDestination)
         }
        def disable(id, params = {}, opts = {}); end

        # Enable an event destination.
        sig {
          params(id: String, params: T.any(::Stripe::V2::Core::EventDestinationEnableParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Core::EventDestination)
         }
        def enable(id, params = {}, opts = {}); end

        # Lists all event destinations.
        sig {
          params(params: T.any(::Stripe::V2::Core::EventDestinationListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::ListObject)
         }
        def list(params = {}, opts = {}); end

        # Send a `ping` event to an event destination.
        sig {
          params(id: String, params: T.any(::Stripe::V2::Core::EventDestinationPingParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Core::Event)
         }
        def ping(id, params = {}, opts = {}); end

        # Retrieves the details of an event destination.
        sig {
          params(id: String, params: T.any(::Stripe::V2::Core::EventDestinationRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Core::EventDestination)
         }
        def retrieve(id, params = {}, opts = {}); end

        # Update the details of an event destination.
        sig {
          params(id: String, params: T.any(::Stripe::V2::Core::EventDestinationUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Core::EventDestination)
         }
        def update(id, params = {}, opts = {}); end
      end
    end
  end
end