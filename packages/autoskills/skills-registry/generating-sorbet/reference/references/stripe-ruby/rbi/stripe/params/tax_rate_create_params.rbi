# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class TaxRateCreateParams < ::Stripe::RequestParams
    # Flag determining whether the tax rate is active or inactive (archived). Inactive tax rates cannot be used with new applications or Checkout Sessions, but will still work for subscriptions and invoices that already have it set.
    sig { returns(T.nilable(T::Boolean)) }
    def active; end
    sig { params(_active: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def active=(_active); end
    # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
    sig { returns(T.nilable(String)) }
    def country; end
    sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
    def country=(_country); end
    # An arbitrary string attached to the tax rate for your internal use only. It will not be visible to your customers.
    sig { returns(T.nilable(String)) }
    def description; end
    sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
    def description=(_description); end
    # The display name of the tax rate, which will be shown to users.
    sig { returns(String) }
    def display_name; end
    sig { params(_display_name: String).returns(String) }
    def display_name=(_display_name); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # This specifies if the tax rate is inclusive or exclusive.
    sig { returns(T::Boolean) }
    def inclusive; end
    sig { params(_inclusive: T::Boolean).returns(T::Boolean) }
    def inclusive=(_inclusive); end
    # The jurisdiction for the tax rate. You can use this label field for tax reporting purposes. It also appears on your customer’s invoice.
    sig { returns(T.nilable(String)) }
    def jurisdiction; end
    sig { params(_jurisdiction: T.nilable(String)).returns(T.nilable(String)) }
    def jurisdiction=(_jurisdiction); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
     }
    def metadata=(_metadata); end
    # This represents the tax rate percent out of 100.
    sig { returns(Float) }
    def percentage; end
    sig { params(_percentage: Float).returns(Float) }
    def percentage=(_percentage); end
    # [ISO 3166-2 subdivision code](https://en.wikipedia.org/wiki/ISO_3166-2), without country prefix. For example, "NY" for New York, United States.
    sig { returns(T.nilable(String)) }
    def state; end
    sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
    def state=(_state); end
    # The high-level tax type, such as `vat` or `sales_tax`.
    sig { returns(T.nilable(String)) }
    def tax_type; end
    sig { params(_tax_type: T.nilable(String)).returns(T.nilable(String)) }
    def tax_type=(_tax_type); end
    sig {
      params(active: T.nilable(T::Boolean), country: T.nilable(String), description: T.nilable(String), display_name: String, expand: T.nilable(T::Array[String]), inclusive: T::Boolean, jurisdiction: T.nilable(String), metadata: T.nilable(T::Hash[String, String]), percentage: Float, state: T.nilable(String), tax_type: T.nilable(String)).void
     }
    def initialize(
      active: nil,
      country: nil,
      description: nil,
      display_name: nil,
      expand: nil,
      inclusive: nil,
      jurisdiction: nil,
      metadata: nil,
      percentage: nil,
      state: nil,
      tax_type: nil
    ); end
  end
end