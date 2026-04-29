# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # [Tax codes](https://stripe.com/docs/tax/tax-categories) classify goods and services for tax purposes.
  class TaxCode < APIResource
    # A detailed description of which types of products the tax code represents.
    sig { returns(String) }
    def description; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # A short name for the tax code.
    sig { returns(String) }
    def name; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # A list of [all tax codes available](https://stripe.com/docs/tax/tax-categories) to add to Products in order to allow specific tax calculations.
    sig {
      params(params: T.any(::Stripe::TaxCodeListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end
  end
end