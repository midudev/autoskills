# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SourceRetrieveParams < ::Stripe::RequestParams
    # The client secret of the source. Required if a publishable key is used to retrieve the source.
    sig { returns(T.nilable(String)) }
    def client_secret; end
    sig { params(_client_secret: T.nilable(String)).returns(T.nilable(String)) }
    def client_secret=(_client_secret); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    sig { params(client_secret: T.nilable(String), expand: T.nilable(T::Array[String])).void }
    def initialize(client_secret: nil, expand: nil); end
  end
end