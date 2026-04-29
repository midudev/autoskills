# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class InvoiceRenderingTemplateRetrieveParams < ::Stripe::RequestParams
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Attribute for param field version
    sig { returns(T.nilable(Integer)) }
    def version; end
    sig { params(_version: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def version=(_version); end
    sig { params(expand: T.nilable(T::Array[String]), version: T.nilable(Integer)).void }
    def initialize(expand: nil, version: nil); end
  end
end