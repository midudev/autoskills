# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Climate
    class OrderCreateParams < ::Stripe::RequestParams
      class Beneficiary < ::Stripe::RequestParams
        # Publicly displayable name for the end beneficiary of carbon removal.
        sig { returns(String) }
        def public_name; end
        sig { params(_public_name: String).returns(String) }
        def public_name=(_public_name); end
        sig { params(public_name: String).void }
        def initialize(public_name: nil); end
      end
      # Requested amount of carbon removal units. Either this or `metric_tons` must be specified.
      sig { returns(T.nilable(Integer)) }
      def amount; end
      sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def amount=(_amount); end
      # Publicly sharable reference for the end beneficiary of carbon removal. Assumed to be the Stripe account if not set.
      sig { returns(T.nilable(Climate::OrderCreateParams::Beneficiary)) }
      def beneficiary; end
      sig {
        params(_beneficiary: T.nilable(Climate::OrderCreateParams::Beneficiary)).returns(T.nilable(Climate::OrderCreateParams::Beneficiary))
       }
      def beneficiary=(_beneficiary); end
      # Request currency for the order as a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a supported [settlement currency for your account](https://stripe.com/docs/currencies). If omitted, the account's default currency will be used.
      sig { returns(T.nilable(String)) }
      def currency; end
      sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
      def currency=(_currency); end
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
      # Requested number of tons for the order. Either this or `amount` must be specified.
      sig { returns(T.nilable(String)) }
      def metric_tons; end
      sig { params(_metric_tons: T.nilable(String)).returns(T.nilable(String)) }
      def metric_tons=(_metric_tons); end
      # Unique identifier of the Climate product.
      sig { returns(String) }
      def product; end
      sig { params(_product: String).returns(String) }
      def product=(_product); end
      sig {
        params(amount: T.nilable(Integer), beneficiary: T.nilable(Climate::OrderCreateParams::Beneficiary), currency: T.nilable(String), expand: T.nilable(T::Array[String]), metadata: T.nilable(T::Hash[String, String]), metric_tons: T.nilable(String), product: String).void
       }
      def initialize(
        amount: nil,
        beneficiary: nil,
        currency: nil,
        expand: nil,
        metadata: nil,
        metric_tons: nil,
        product: nil
      ); end
    end
  end
end