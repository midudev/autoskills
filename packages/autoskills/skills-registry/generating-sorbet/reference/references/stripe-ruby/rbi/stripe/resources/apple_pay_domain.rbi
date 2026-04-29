# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Domains registered for Apple Pay on the Web
  class ApplePayDomain < APIResource
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Attribute for field domain_name
    sig { returns(String) }
    def domain_name; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Always true for a deleted object
    sig { returns(T.nilable(T::Boolean)) }
    def deleted; end
    # Create an apple pay domain.
    sig {
      params(params: T.any(::Stripe::ApplePayDomainCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ApplePayDomain)
     }
    def self.create(params = {}, opts = {}); end

    # Delete an apple pay domain.
    sig {
      params(domain: String, params: T.any(::Stripe::ApplePayDomainDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ApplePayDomain)
     }
    def self.delete(domain, params = {}, opts = {}); end

    # Delete an apple pay domain.
    sig {
      params(params: T.any(::Stripe::ApplePayDomainDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ApplePayDomain)
     }
    def delete(params = {}, opts = {}); end

    # List apple pay domains.
    sig {
      params(params: T.any(::Stripe::ApplePayDomainListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end
  end
end