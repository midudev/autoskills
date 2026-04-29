# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    class SettingsUpdateParams < ::Stripe::RequestParams
      class Defaults < ::Stripe::RequestParams
        # Specifies the default [tax behavior](https://stripe.com/docs/tax/products-prices-tax-categories-tax-behavior#tax-behavior) to be used when the item's price has unspecified tax behavior. One of inclusive, exclusive, or inferred_by_currency. Once specified, it cannot be changed back to null.
        sig { returns(T.nilable(String)) }
        def tax_behavior; end
        sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
        def tax_behavior=(_tax_behavior); end
        # A [tax code](https://docs.stripe.com/tax/tax-categories) ID.
        sig { returns(T.nilable(String)) }
        def tax_code; end
        sig { params(_tax_code: T.nilable(String)).returns(T.nilable(String)) }
        def tax_code=(_tax_code); end
        sig { params(tax_behavior: T.nilable(String), tax_code: T.nilable(String)).void }
        def initialize(tax_behavior: nil, tax_code: nil); end
      end
      class HeadOffice < ::Stripe::RequestParams
        class Address < ::Stripe::RequestParams
          # City, district, suburb, town, or village.
          sig { returns(T.nilable(String)) }
          def city; end
          sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
          def city=(_city); end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(T.nilable(String)) }
          def country; end
          sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
          def country=(_country); end
          # Address line 1, such as the street, PO Box, or company name.
          sig { returns(T.nilable(String)) }
          def line1; end
          sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
          def line1=(_line1); end
          # Address line 2, such as the apartment, suite, unit, or building.
          sig { returns(T.nilable(String)) }
          def line2; end
          sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
          def line2=(_line2); end
          # ZIP or postal code.
          sig { returns(T.nilable(String)) }
          def postal_code; end
          sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
          def postal_code=(_postal_code); end
          # State/province as an [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2) subdivision code, without country prefix, such as "NY" or "TX".
          sig { returns(T.nilable(String)) }
          def state; end
          sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
          def state=(_state); end
          sig {
            params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String)).void
           }
          def initialize(
            city: nil,
            country: nil,
            line1: nil,
            line2: nil,
            postal_code: nil,
            state: nil
          ); end
        end
        # The location of the business for tax purposes.
        sig { returns(Tax::SettingsUpdateParams::HeadOffice::Address) }
        def address; end
        sig {
          params(_address: Tax::SettingsUpdateParams::HeadOffice::Address).returns(Tax::SettingsUpdateParams::HeadOffice::Address)
         }
        def address=(_address); end
        sig { params(address: Tax::SettingsUpdateParams::HeadOffice::Address).void }
        def initialize(address: nil); end
      end
      # Default configuration to be used on Stripe Tax calculations.
      sig { returns(T.nilable(Tax::SettingsUpdateParams::Defaults)) }
      def defaults; end
      sig {
        params(_defaults: T.nilable(Tax::SettingsUpdateParams::Defaults)).returns(T.nilable(Tax::SettingsUpdateParams::Defaults))
       }
      def defaults=(_defaults); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # The place where your business is located.
      sig { returns(T.nilable(Tax::SettingsUpdateParams::HeadOffice)) }
      def head_office; end
      sig {
        params(_head_office: T.nilable(Tax::SettingsUpdateParams::HeadOffice)).returns(T.nilable(Tax::SettingsUpdateParams::HeadOffice))
       }
      def head_office=(_head_office); end
      sig {
        params(defaults: T.nilable(Tax::SettingsUpdateParams::Defaults), expand: T.nilable(T::Array[String]), head_office: T.nilable(Tax::SettingsUpdateParams::HeadOffice)).void
       }
      def initialize(defaults: nil, expand: nil, head_office: nil); end
    end
  end
end