# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ApplePayDomainCreateParams < ::Stripe::RequestParams
    # Attribute for param field domain_name
    sig { returns(String) }
    def domain_name; end
    sig { params(_domain_name: String).returns(String) }
    def domain_name=(_domain_name); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    sig { params(domain_name: String, expand: T.nilable(T::Array[String])).void }
    def initialize(domain_name: nil, expand: nil); end
  end
end