# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    # You can use Tax `Settings` to manage configurations used by Stripe Tax calculations.
    #
    # Related guide: [Using the Settings API](https://docs.stripe.com/tax/settings-api)
    class Settings < SingletonAPIResource
      class Defaults < ::Stripe::StripeObject
        # The tax calculation provider this account uses. Defaults to `stripe` when not using a [third-party provider](/tax/third-party-apps).
        sig { returns(String) }
        def provider; end
        # Default [tax behavior](https://stripe.com/docs/tax/products-prices-tax-categories-tax-behavior#tax-behavior) used to specify whether the price is considered inclusive of taxes or exclusive of taxes. If the item's price has a tax behavior set, it will take precedence over the default tax behavior.
        sig { returns(T.nilable(String)) }
        def tax_behavior; end
        # Default [tax code](https://stripe.com/docs/tax/tax-categories) used to classify your products and prices.
        sig { returns(T.nilable(String)) }
        def tax_code; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class HeadOffice < ::Stripe::StripeObject
        class Address < ::Stripe::StripeObject
          # City, district, suburb, town, or village.
          sig { returns(T.nilable(String)) }
          def city; end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(T.nilable(String)) }
          def country; end
          # Address line 1, such as the street, PO Box, or company name.
          sig { returns(T.nilable(String)) }
          def line1; end
          # Address line 2, such as the apartment, suite, unit, or building.
          sig { returns(T.nilable(String)) }
          def line2; end
          # ZIP or postal code.
          sig { returns(T.nilable(String)) }
          def postal_code; end
          # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
          sig { returns(T.nilable(String)) }
          def state; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field address
        sig { returns(Address) }
        def address; end
        def self.inner_class_types
          @inner_class_types = {address: Address}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class StatusDetails < ::Stripe::StripeObject
        class Active < ::Stripe::StripeObject
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Pending < ::Stripe::StripeObject
          # The list of missing fields that are required to perform calculations. It includes the entry `head_office` when the status is `pending`. It is recommended to set the optional values even if they aren't listed as required for calculating taxes. Calculations can fail if missing fields aren't explicitly provided on every call.
          sig { returns(T.nilable(T::Array[String])) }
          def missing_fields; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field active
        sig { returns(T.nilable(Active)) }
        def active; end
        # Attribute for field pending
        sig { returns(T.nilable(Pending)) }
        def pending; end
        def self.inner_class_types
          @inner_class_types = {active: Active, pending: Pending}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field defaults
      sig { returns(Defaults) }
      def defaults; end
      # The place where your business is located.
      sig { returns(T.nilable(HeadOffice)) }
      def head_office; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The status of the Tax `Settings`.
      sig { returns(String) }
      def status; end
      # Attribute for field status_details
      sig { returns(StatusDetails) }
      def status_details; end
    end
  end
end