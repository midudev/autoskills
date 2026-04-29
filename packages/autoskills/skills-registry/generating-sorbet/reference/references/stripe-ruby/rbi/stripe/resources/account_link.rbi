# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Account Links are the means by which a Connect platform grants a connected account permission to access
  # Stripe-hosted applications, such as Connect Onboarding.
  #
  # Related guide: [Connect Onboarding](https://docs.stripe.com/connect/custom/hosted-onboarding)
  class AccountLink < APIResource
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # The timestamp at which this account link will expire.
    sig { returns(Integer) }
    def expires_at; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The URL for the account link.
    sig { returns(String) }
    def url; end
    # Creates an AccountLink object that includes a single-use Stripe URL that the platform can redirect their user to in order to take them through the Connect Onboarding flow.
    sig {
      params(params: T.any(::Stripe::AccountLinkCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::AccountLink)
     }
    def self.create(params = {}, opts = {}); end
  end
end