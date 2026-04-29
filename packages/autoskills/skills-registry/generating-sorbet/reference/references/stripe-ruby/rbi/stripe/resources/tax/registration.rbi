# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    # A Tax `Registration` lets us know that your business is registered to collect tax on payments within a region, enabling you to [automatically collect tax](https://docs.stripe.com/tax).
    #
    # Stripe doesn't register on your behalf with the relevant authorities when you create a Tax `Registration` object. For more information on how to register to collect tax, see [our guide](https://docs.stripe.com/tax/registering).
    #
    # Related guide: [Using the Registrations API](https://docs.stripe.com/tax/registrations-api)
    class Registration < APIResource
      class CountryOptions < ::Stripe::StripeObject
        class Ae < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an Default standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Al < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Am < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ao < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class At < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Au < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an Default standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Aw < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Az < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ba < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Bb < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Bd < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Be < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Bf < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Bg < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Bh < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Bj < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Bs < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class By < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ca < ::Stripe::StripeObject
          class ProvinceStandard < ::Stripe::StripeObject
            # Two-letter CA province code ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
            sig { returns(String) }
            def province; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field province_standard
          sig { returns(T.nilable(ProvinceStandard)) }
          def province_standard; end
          # Type of registration in Canada.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {province_standard: ProvinceStandard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Cd < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ch < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an Default standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Cl < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Cm < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Co < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Cr < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Cv < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Cy < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Cz < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class De < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Dk < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ec < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ee < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Eg < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Es < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Et < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Fi < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Fr < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Gb < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an Default standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ge < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Gn < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Gr < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Hr < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Hu < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Id < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ie < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class In < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Is < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class It < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Jp < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an Default standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ke < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Kg < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Kh < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Kr < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Kz < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class La < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Lt < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Lu < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Lv < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ma < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Md < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Me < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Mk < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Mr < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Mt < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Mx < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class My < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ng < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Nl < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class No < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an Default standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Np < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Nz < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an Default standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Om < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Pe < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ph < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Pl < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Pt < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ro < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Rs < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ru < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Sa < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Se < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Sg < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an Default standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Si < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Sk < ::Stripe::StripeObject
          class Standard < ::Stripe::StripeObject
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field standard
          sig { returns(T.nilable(Standard)) }
          def standard; end
          # Type of registration in an EU country.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {standard: Standard}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Sn < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Sr < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Th < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Tj < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Tr < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Tw < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Tz < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ua < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ug < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Us < ::Stripe::StripeObject
          class LocalAmusementTax < ::Stripe::StripeObject
            # A [FIPS code](https://www.census.gov/library/reference/code-lists/ansi.html) representing the local jurisdiction.
            sig { returns(String) }
            def jurisdiction; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class LocalLeaseTax < ::Stripe::StripeObject
            # A [FIPS code](https://www.census.gov/library/reference/code-lists/ansi.html) representing the local jurisdiction.
            sig { returns(String) }
            def jurisdiction; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class StateSalesTax < ::Stripe::StripeObject
            class Election < ::Stripe::StripeObject
              # A [FIPS code](https://www.census.gov/library/reference/code-lists/ansi.html) representing the local jurisdiction.
              sig { returns(T.nilable(String)) }
              def jurisdiction; end
              # The type of the election for the state sales tax registration.
              sig { returns(String) }
              def type; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Elections for the state sales tax registration.
            sig { returns(T.nilable(T::Array[Election])) }
            def elections; end
            def self.inner_class_types
              @inner_class_types = {elections: Election}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field local_amusement_tax
          sig { returns(T.nilable(LocalAmusementTax)) }
          def local_amusement_tax; end
          # Attribute for field local_lease_tax
          sig { returns(T.nilable(LocalLeaseTax)) }
          def local_lease_tax; end
          # Two-letter US state code ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
          sig { returns(String) }
          def state; end
          # Attribute for field state_sales_tax
          sig { returns(T.nilable(StateSalesTax)) }
          def state_sales_tax; end
          # Type of registration in the US.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {
              local_amusement_tax: LocalAmusementTax,
              local_lease_tax: LocalLeaseTax,
              state_sales_tax: StateSalesTax,
            }
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Uy < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Uz < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Vn < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Za < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Zm < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Zw < ::Stripe::StripeObject
          # Type of registration in `country`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field ae
        sig { returns(T.nilable(Ae)) }
        def ae; end
        # Attribute for field al
        sig { returns(T.nilable(Al)) }
        def al; end
        # Attribute for field am
        sig { returns(T.nilable(Am)) }
        def am; end
        # Attribute for field ao
        sig { returns(T.nilable(Ao)) }
        def ao; end
        # Attribute for field at
        sig { returns(T.nilable(At)) }
        def at; end
        # Attribute for field au
        sig { returns(T.nilable(Au)) }
        def au; end
        # Attribute for field aw
        sig { returns(T.nilable(Aw)) }
        def aw; end
        # Attribute for field az
        sig { returns(T.nilable(Az)) }
        def az; end
        # Attribute for field ba
        sig { returns(T.nilable(Ba)) }
        def ba; end
        # Attribute for field bb
        sig { returns(T.nilable(Bb)) }
        def bb; end
        # Attribute for field bd
        sig { returns(T.nilable(Bd)) }
        def bd; end
        # Attribute for field be
        sig { returns(T.nilable(Be)) }
        def be; end
        # Attribute for field bf
        sig { returns(T.nilable(Bf)) }
        def bf; end
        # Attribute for field bg
        sig { returns(T.nilable(Bg)) }
        def bg; end
        # Attribute for field bh
        sig { returns(T.nilable(Bh)) }
        def bh; end
        # Attribute for field bj
        sig { returns(T.nilable(Bj)) }
        def bj; end
        # Attribute for field bs
        sig { returns(T.nilable(Bs)) }
        def bs; end
        # Attribute for field by
        sig { returns(T.nilable(By)) }
        def by; end
        # Attribute for field ca
        sig { returns(T.nilable(Ca)) }
        def ca; end
        # Attribute for field cd
        sig { returns(T.nilable(Cd)) }
        def cd; end
        # Attribute for field ch
        sig { returns(T.nilable(Ch)) }
        def ch; end
        # Attribute for field cl
        sig { returns(T.nilable(Cl)) }
        def cl; end
        # Attribute for field cm
        sig { returns(T.nilable(Cm)) }
        def cm; end
        # Attribute for field co
        sig { returns(T.nilable(Co)) }
        def co; end
        # Attribute for field cr
        sig { returns(T.nilable(Cr)) }
        def cr; end
        # Attribute for field cv
        sig { returns(T.nilable(Cv)) }
        def cv; end
        # Attribute for field cy
        sig { returns(T.nilable(Cy)) }
        def cy; end
        # Attribute for field cz
        sig { returns(T.nilable(Cz)) }
        def cz; end
        # Attribute for field de
        sig { returns(T.nilable(De)) }
        def de; end
        # Attribute for field dk
        sig { returns(T.nilable(Dk)) }
        def dk; end
        # Attribute for field ec
        sig { returns(T.nilable(Ec)) }
        def ec; end
        # Attribute for field ee
        sig { returns(T.nilable(Ee)) }
        def ee; end
        # Attribute for field eg
        sig { returns(T.nilable(Eg)) }
        def eg; end
        # Attribute for field es
        sig { returns(T.nilable(Es)) }
        def es; end
        # Attribute for field et
        sig { returns(T.nilable(Et)) }
        def et; end
        # Attribute for field fi
        sig { returns(T.nilable(Fi)) }
        def fi; end
        # Attribute for field fr
        sig { returns(T.nilable(Fr)) }
        def fr; end
        # Attribute for field gb
        sig { returns(T.nilable(Gb)) }
        def gb; end
        # Attribute for field ge
        sig { returns(T.nilable(Ge)) }
        def ge; end
        # Attribute for field gn
        sig { returns(T.nilable(Gn)) }
        def gn; end
        # Attribute for field gr
        sig { returns(T.nilable(Gr)) }
        def gr; end
        # Attribute for field hr
        sig { returns(T.nilable(Hr)) }
        def hr; end
        # Attribute for field hu
        sig { returns(T.nilable(Hu)) }
        def hu; end
        # Attribute for field id
        sig { returns(T.nilable(Id)) }
        def id; end
        # Attribute for field ie
        sig { returns(T.nilable(Ie)) }
        def ie; end
        # Attribute for field in
        sig { returns(T.nilable(In)) }
        def in; end
        # Attribute for field is
        sig { returns(T.nilable(Is)) }
        def is; end
        # Attribute for field it
        sig { returns(T.nilable(It)) }
        def it; end
        # Attribute for field jp
        sig { returns(T.nilable(Jp)) }
        def jp; end
        # Attribute for field ke
        sig { returns(T.nilable(Ke)) }
        def ke; end
        # Attribute for field kg
        sig { returns(T.nilable(Kg)) }
        def kg; end
        # Attribute for field kh
        sig { returns(T.nilable(Kh)) }
        def kh; end
        # Attribute for field kr
        sig { returns(T.nilable(Kr)) }
        def kr; end
        # Attribute for field kz
        sig { returns(T.nilable(Kz)) }
        def kz; end
        # Attribute for field la
        sig { returns(T.nilable(La)) }
        def la; end
        # Attribute for field lt
        sig { returns(T.nilable(Lt)) }
        def lt; end
        # Attribute for field lu
        sig { returns(T.nilable(Lu)) }
        def lu; end
        # Attribute for field lv
        sig { returns(T.nilable(Lv)) }
        def lv; end
        # Attribute for field ma
        sig { returns(T.nilable(Ma)) }
        def ma; end
        # Attribute for field md
        sig { returns(T.nilable(Md)) }
        def md; end
        # Attribute for field me
        sig { returns(T.nilable(Me)) }
        def me; end
        # Attribute for field mk
        sig { returns(T.nilable(Mk)) }
        def mk; end
        # Attribute for field mr
        sig { returns(T.nilable(Mr)) }
        def mr; end
        # Attribute for field mt
        sig { returns(T.nilable(Mt)) }
        def mt; end
        # Attribute for field mx
        sig { returns(T.nilable(Mx)) }
        def mx; end
        # Attribute for field my
        sig { returns(T.nilable(My)) }
        def my; end
        # Attribute for field ng
        sig { returns(T.nilable(Ng)) }
        def ng; end
        # Attribute for field nl
        sig { returns(T.nilable(Nl)) }
        def nl; end
        # Attribute for field no
        sig { returns(T.nilable(No)) }
        def no; end
        # Attribute for field np
        sig { returns(T.nilable(Np)) }
        def np; end
        # Attribute for field nz
        sig { returns(T.nilable(Nz)) }
        def nz; end
        # Attribute for field om
        sig { returns(T.nilable(Om)) }
        def om; end
        # Attribute for field pe
        sig { returns(T.nilable(Pe)) }
        def pe; end
        # Attribute for field ph
        sig { returns(T.nilable(Ph)) }
        def ph; end
        # Attribute for field pl
        sig { returns(T.nilable(Pl)) }
        def pl; end
        # Attribute for field pt
        sig { returns(T.nilable(Pt)) }
        def pt; end
        # Attribute for field ro
        sig { returns(T.nilable(Ro)) }
        def ro; end
        # Attribute for field rs
        sig { returns(T.nilable(Rs)) }
        def rs; end
        # Attribute for field ru
        sig { returns(T.nilable(Ru)) }
        def ru; end
        # Attribute for field sa
        sig { returns(T.nilable(Sa)) }
        def sa; end
        # Attribute for field se
        sig { returns(T.nilable(Se)) }
        def se; end
        # Attribute for field sg
        sig { returns(T.nilable(Sg)) }
        def sg; end
        # Attribute for field si
        sig { returns(T.nilable(Si)) }
        def si; end
        # Attribute for field sk
        sig { returns(T.nilable(Sk)) }
        def sk; end
        # Attribute for field sn
        sig { returns(T.nilable(Sn)) }
        def sn; end
        # Attribute for field sr
        sig { returns(T.nilable(Sr)) }
        def sr; end
        # Attribute for field th
        sig { returns(T.nilable(Th)) }
        def th; end
        # Attribute for field tj
        sig { returns(T.nilable(Tj)) }
        def tj; end
        # Attribute for field tr
        sig { returns(T.nilable(Tr)) }
        def tr; end
        # Attribute for field tw
        sig { returns(T.nilable(Tw)) }
        def tw; end
        # Attribute for field tz
        sig { returns(T.nilable(Tz)) }
        def tz; end
        # Attribute for field ua
        sig { returns(T.nilable(Ua)) }
        def ua; end
        # Attribute for field ug
        sig { returns(T.nilable(Ug)) }
        def ug; end
        # Attribute for field us
        sig { returns(T.nilable(Us)) }
        def us; end
        # Attribute for field uy
        sig { returns(T.nilable(Uy)) }
        def uy; end
        # Attribute for field uz
        sig { returns(T.nilable(Uz)) }
        def uz; end
        # Attribute for field vn
        sig { returns(T.nilable(Vn)) }
        def vn; end
        # Attribute for field za
        sig { returns(T.nilable(Za)) }
        def za; end
        # Attribute for field zm
        sig { returns(T.nilable(Zm)) }
        def zm; end
        # Attribute for field zw
        sig { returns(T.nilable(Zw)) }
        def zw; end
        def self.inner_class_types
          @inner_class_types = {
            ae: Ae,
            al: Al,
            am: Am,
            ao: Ao,
            at: At,
            au: Au,
            aw: Aw,
            az: Az,
            ba: Ba,
            bb: Bb,
            bd: Bd,
            be: Be,
            bf: Bf,
            bg: Bg,
            bh: Bh,
            bj: Bj,
            bs: Bs,
            by: By,
            ca: Ca,
            cd: Cd,
            ch: Ch,
            cl: Cl,
            cm: Cm,
            co: Co,
            cr: Cr,
            cv: Cv,
            cy: Cy,
            cz: Cz,
            de: De,
            dk: Dk,
            ec: Ec,
            ee: Ee,
            eg: Eg,
            es: Es,
            et: Et,
            fi: Fi,
            fr: Fr,
            gb: Gb,
            ge: Ge,
            gn: Gn,
            gr: Gr,
            hr: Hr,
            hu: Hu,
            id: Id,
            ie: Ie,
            in: In,
            is: Is,
            it: It,
            jp: Jp,
            ke: Ke,
            kg: Kg,
            kh: Kh,
            kr: Kr,
            kz: Kz,
            la: La,
            lt: Lt,
            lu: Lu,
            lv: Lv,
            ma: Ma,
            md: Md,
            me: Me,
            mk: Mk,
            mr: Mr,
            mt: Mt,
            mx: Mx,
            my: My,
            ng: Ng,
            nl: Nl,
            no: No,
            np: Np,
            nz: Nz,
            om: Om,
            pe: Pe,
            ph: Ph,
            pl: Pl,
            pt: Pt,
            ro: Ro,
            rs: Rs,
            ru: Ru,
            sa: Sa,
            se: Se,
            sg: Sg,
            si: Si,
            sk: Sk,
            sn: Sn,
            sr: Sr,
            th: Th,
            tj: Tj,
            tr: Tr,
            tw: Tw,
            tz: Tz,
            ua: Ua,
            ug: Ug,
            us: Us,
            uy: Uy,
            uz: Uz,
            vn: Vn,
            za: Za,
            zm: Zm,
            zw: Zw,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Time at which the registration becomes active. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def active_from; end
      # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
      sig { returns(String) }
      def country; end
      # Attribute for field country_options
      sig { returns(CountryOptions) }
      def country_options; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # If set, the registration stops being active at this time. If not set, the registration will be active indefinitely. Measured in seconds since the Unix epoch.
      sig { returns(T.nilable(Integer)) }
      def expires_at; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The status of the registration. This field is present for convenience and can be deduced from `active_from` and `expires_at`.
      sig { returns(String) }
      def status; end
      # Creates a new Tax Registration object.
      sig {
        params(params: T.any(::Stripe::Tax::RegistrationCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Tax::Registration)
       }
      def self.create(params = {}, opts = {}); end

      # Returns a list of Tax Registration objects.
      sig {
        params(params: T.any(::Stripe::Tax::RegistrationListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Updates an existing Tax Registration object.
      #
      # A registration cannot be deleted after it has been created. If you wish to end a registration you may do so by setting expires_at.
      sig {
        params(id: String, params: T.any(::Stripe::Tax::RegistrationUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Tax::Registration)
       }
      def self.update(id, params = {}, opts = {}); end
    end
  end
end