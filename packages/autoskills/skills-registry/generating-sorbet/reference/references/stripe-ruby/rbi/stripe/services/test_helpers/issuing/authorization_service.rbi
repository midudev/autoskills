# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    module Issuing
      class AuthorizationService < StripeService
        # Capture a test-mode authorization.
        sig {
          params(authorization: String, params: T.any(::Stripe::TestHelpers::Issuing::AuthorizationCaptureParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Authorization)
         }
        def capture(authorization, params = {}, opts = {}); end

        # Create a test-mode authorization.
        sig {
          params(params: T.any(::Stripe::TestHelpers::Issuing::AuthorizationCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Authorization)
         }
        def create(params = {}, opts = {}); end

        # Expire a test-mode Authorization.
        sig {
          params(authorization: String, params: T.any(::Stripe::TestHelpers::Issuing::AuthorizationExpireParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Authorization)
         }
        def expire(authorization, params = {}, opts = {}); end

        # Finalize the amount on an Authorization prior to capture, when the initial authorization was for an estimated amount.
        sig {
          params(authorization: String, params: T.any(::Stripe::TestHelpers::Issuing::AuthorizationFinalizeAmountParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Authorization)
         }
        def finalize_amount(authorization, params = {}, opts = {}); end

        # Increment a test-mode Authorization.
        sig {
          params(authorization: String, params: T.any(::Stripe::TestHelpers::Issuing::AuthorizationIncrementParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Authorization)
         }
        def increment(authorization, params = {}, opts = {}); end

        # Respond to a fraud challenge on a testmode Issuing authorization, simulating either a confirmation of fraud or a correction of legitimacy.
        sig {
          params(authorization: String, params: T.any(::Stripe::TestHelpers::Issuing::AuthorizationRespondParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Authorization)
         }
        def respond(authorization, params = {}, opts = {}); end

        # Reverse a test-mode Authorization.
        sig {
          params(authorization: String, params: T.any(::Stripe::TestHelpers::Issuing::AuthorizationReverseParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Authorization)
         }
        def reverse(authorization, params = {}, opts = {}); end
      end
    end
  end
end