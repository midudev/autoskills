# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CustomerPaymentSourceCreateParams < ::Stripe::RequestParams
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
     }
    def metadata=(_metadata); end
    # Please refer to full [documentation](https://api.stripe.com) instead.
    sig { returns(String) }
    def source; end
    sig { params(_source: String).returns(String) }
    def source=(_source); end
    # Attribute for param field validate
    sig { returns(T.nilable(T::Boolean)) }
    def validate; end
    sig { params(_validate: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def validate=(_validate); end
    sig {
      params(expand: T.nilable(T::Array[String]), metadata: T.nilable(T::Hash[String, String]), source: String, validate: T.nilable(T::Boolean)).void
     }
    def initialize(expand: nil, metadata: nil, source: nil, validate: nil); end
  end
end