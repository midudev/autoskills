# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    class OnboardingLinkService < StripeService
      # Creates a new OnboardingLink object that contains a redirect_url used for onboarding onto Tap to Pay on iPhone.
      sig {
        params(params: T.any(::Stripe::Terminal::OnboardingLinkCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::OnboardingLink)
       }
      def create(params = {}, opts = {}); end
    end
  end
end