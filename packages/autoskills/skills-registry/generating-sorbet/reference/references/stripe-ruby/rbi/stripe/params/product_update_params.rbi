# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ProductUpdateParams < ::Stripe::RequestParams
    class MarketingFeature < ::Stripe::RequestParams
      # The marketing feature name. Up to 80 characters long.
      sig { returns(String) }
      def name; end
      sig { params(_name: String).returns(String) }
      def name=(_name); end
      sig { params(name: String).void }
      def initialize(name: nil); end
    end
    class PackageDimensions < ::Stripe::RequestParams
      # Height, in inches. Maximum precision is 2 decimal places.
      sig { returns(Float) }
      def height; end
      sig { params(_height: Float).returns(Float) }
      def height=(_height); end
      # Length, in inches. Maximum precision is 2 decimal places.
      sig { returns(Float) }
      def length; end
      sig { params(_length: Float).returns(Float) }
      def length=(_length); end
      # Weight, in ounces. Maximum precision is 2 decimal places.
      sig { returns(Float) }
      def weight; end
      sig { params(_weight: Float).returns(Float) }
      def weight=(_weight); end
      # Width, in inches. Maximum precision is 2 decimal places.
      sig { returns(Float) }
      def width; end
      sig { params(_width: Float).returns(Float) }
      def width=(_width); end
      sig { params(height: Float, length: Float, weight: Float, width: Float).void }
      def initialize(height: nil, length: nil, weight: nil, width: nil); end
    end
    # Whether the product is available for purchase.
    sig { returns(T.nilable(T::Boolean)) }
    def active; end
    sig { params(_active: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def active=(_active); end
    # The ID of the [Price](https://docs.stripe.com/api/prices) object that is the default price for this product.
    sig { returns(T.nilable(String)) }
    def default_price; end
    sig { params(_default_price: T.nilable(String)).returns(T.nilable(String)) }
    def default_price=(_default_price); end
    # The product's description, meant to be displayable to the customer. Use this field to optionally store a long form explanation of the product being sold for your own rendering purposes.
    sig { returns(T.nilable(String)) }
    def description; end
    sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
    def description=(_description); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # A list of up to 8 URLs of images for this product, meant to be displayable to the customer.
    sig { returns(T.nilable(T.any(String, T::Array[String]))) }
    def images; end
    sig {
      params(_images: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
     }
    def images=(_images); end
    # A list of up to 15 marketing features for this product. These are displayed in [pricing tables](https://docs.stripe.com/payments/checkout/pricing-table).
    sig { returns(T.nilable(T.any(String, T::Array[ProductUpdateParams::MarketingFeature]))) }
    def marketing_features; end
    sig {
      params(_marketing_features: T.nilable(T.any(String, T::Array[ProductUpdateParams::MarketingFeature]))).returns(T.nilable(T.any(String, T::Array[ProductUpdateParams::MarketingFeature])))
     }
    def marketing_features=(_marketing_features); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # The product's name, meant to be displayable to the customer.
    sig { returns(T.nilable(String)) }
    def name; end
    sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
    def name=(_name); end
    # The dimensions of this product for shipping purposes.
    sig { returns(T.nilable(T.any(String, ProductUpdateParams::PackageDimensions))) }
    def package_dimensions; end
    sig {
      params(_package_dimensions: T.nilable(T.any(String, ProductUpdateParams::PackageDimensions))).returns(T.nilable(T.any(String, ProductUpdateParams::PackageDimensions)))
     }
    def package_dimensions=(_package_dimensions); end
    # Whether this product is shipped (i.e., physical goods).
    sig { returns(T.nilable(T::Boolean)) }
    def shippable; end
    sig { params(_shippable: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def shippable=(_shippable); end
    # An arbitrary string to be displayed on your customer's credit card or bank statement. While most banks display this information consistently, some may display it incorrectly or not at all.
    #
    # This may be up to 22 characters. The statement description may not include `<`, `>`, `\`, `"`, `'` characters, and will appear on your customer's statement in capital letters. Non-ASCII characters are automatically stripped.
    #  It must contain at least one letter. May only be set if `type=service`. Only used for subscription payments.
    sig { returns(T.nilable(String)) }
    def statement_descriptor; end
    sig { params(_statement_descriptor: T.nilable(String)).returns(T.nilable(String)) }
    def statement_descriptor=(_statement_descriptor); end
    # A [tax code](https://docs.stripe.com/tax/tax-categories) ID.
    sig { returns(T.nilable(String)) }
    def tax_code; end
    sig { params(_tax_code: T.nilable(String)).returns(T.nilable(String)) }
    def tax_code=(_tax_code); end
    # A label that represents units of this product. When set, this will be included in customers' receipts, invoices, Checkout, and the customer portal. May only be set if `type=service`.
    sig { returns(T.nilable(String)) }
    def unit_label; end
    sig { params(_unit_label: T.nilable(String)).returns(T.nilable(String)) }
    def unit_label=(_unit_label); end
    # A URL of a publicly-accessible webpage for this product.
    sig { returns(T.nilable(String)) }
    def url; end
    sig { params(_url: T.nilable(String)).returns(T.nilable(String)) }
    def url=(_url); end
    sig {
      params(active: T.nilable(T::Boolean), default_price: T.nilable(String), description: T.nilable(String), expand: T.nilable(T::Array[String]), images: T.nilable(T.any(String, T::Array[String])), marketing_features: T.nilable(T.any(String, T::Array[ProductUpdateParams::MarketingFeature])), metadata: T.nilable(T.any(String, T::Hash[String, String])), name: T.nilable(String), package_dimensions: T.nilable(T.any(String, ProductUpdateParams::PackageDimensions)), shippable: T.nilable(T::Boolean), statement_descriptor: T.nilable(String), tax_code: T.nilable(String), unit_label: T.nilable(String), url: T.nilable(String)).void
     }
    def initialize(
      active: nil,
      default_price: nil,
      description: nil,
      expand: nil,
      images: nil,
      marketing_features: nil,
      metadata: nil,
      name: nil,
      package_dimensions: nil,
      shippable: nil,
      statement_descriptor: nil,
      tax_code: nil,
      unit_label: nil,
      url: nil
    ); end
  end
end