# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    class RegistrationCreateParams < ::Stripe::RequestParams
      class CountryOptions < ::Stripe::RequestParams
        class Ae < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ae::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ae::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ae::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ae::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Al < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Al::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Al::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Al::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Al::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Am < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Ao < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ao::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ao::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ao::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ao::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class At < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::At::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::At::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::At::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::At::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Au < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Au::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Au::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Au::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Au::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Aw < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Aw::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Aw::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Aw::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Aw::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Az < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Ba < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ba::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ba::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ba::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ba::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Bb < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bb::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bb::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bb::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bb::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Bd < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bd::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bd::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bd::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bd::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Be < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Be::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Be::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Be::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Be::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Bf < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bf::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bf::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bf::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bf::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Bg < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bg::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bg::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bg::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bg::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Bh < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bh::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bh::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bh::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bh::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Bj < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Bs < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bs::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bs::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bs::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bs::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class By < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Ca < ::Stripe::RequestParams
          class ProvinceStandard < ::Stripe::RequestParams
            # Two-letter CA province code ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
            sig { returns(String) }
            def province; end
            sig { params(_province: String).returns(String) }
            def province=(_province); end
            sig { params(province: String).void }
            def initialize(province: nil); end
          end
          # Options for the provincial tax registration.
          sig {
            returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ca::ProvinceStandard))
           }
          def province_standard; end
          sig {
            params(_province_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ca::ProvinceStandard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ca::ProvinceStandard))
           }
          def province_standard=(_province_standard); end
          # Type of registration to be created in Canada.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(province_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ca::ProvinceStandard), type: String).void
           }
          def initialize(province_standard: nil, type: nil); end
        end
        class Cd < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cd::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cd::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cd::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cd::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Ch < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ch::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ch::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ch::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ch::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Cl < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Cm < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Co < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Cr < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Cv < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Cy < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cy::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cy::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cy::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cy::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Cz < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cz::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cz::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cz::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cz::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class De < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::De::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::De::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::De::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::De::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Dk < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Dk::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Dk::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Dk::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Dk::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Ec < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Ee < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ee::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ee::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ee::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ee::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Eg < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Es < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Es::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Es::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Es::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Es::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Et < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Et::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Et::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Et::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Et::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Fi < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Fi::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Fi::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Fi::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Fi::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Fr < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Fr::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Fr::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Fr::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Fr::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Gb < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gb::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gb::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gb::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gb::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Ge < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Gn < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gn::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gn::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gn::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gn::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Gr < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gr::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gr::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gr::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gr::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Hr < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Hr::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Hr::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Hr::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Hr::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Hu < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Hu::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Hu::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Hu::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Hu::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Id < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Ie < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ie::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ie::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ie::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ie::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class In < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Is < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Is::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Is::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Is::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Is::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class It < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::It::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::It::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::It::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::It::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Jp < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Jp::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Jp::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Jp::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Jp::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Ke < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Kg < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Kh < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Kr < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Kz < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class La < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Lt < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lt::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lt::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lt::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lt::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Lu < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lu::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lu::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lu::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lu::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Lv < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lv::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lv::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lv::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lv::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Ma < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Md < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Me < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Me::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Me::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Me::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Me::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Mk < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mk::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mk::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mk::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mk::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Mr < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mr::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mr::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mr::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mr::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Mt < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mt::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mt::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mt::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mt::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Mx < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class My < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Ng < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Nl < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Nl::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Nl::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Nl::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Nl::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class No < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::No::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::No::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::No::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::No::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Np < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Nz < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Nz::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Nz::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Nz::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Nz::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Om < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Om::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Om::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Om::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Om::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Pe < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Ph < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Pl < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pl::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pl::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pl::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pl::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Pt < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pt::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pt::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pt::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pt::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Ro < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ro::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ro::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ro::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ro::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Rs < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Rs::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Rs::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Rs::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Rs::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Ru < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Sa < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Se < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Se::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Se::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Se::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Se::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Sg < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sg::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sg::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sg::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sg::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Si < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Si::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Si::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Si::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Si::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Sk < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an EU standard registration.
            sig { returns(String) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: String).returns(String) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: String).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sk::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sk::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sk::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in an EU country.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sk::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Sn < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Sr < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sr::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sr::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sr::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sr::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Th < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Tj < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Tr < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Tw < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Tz < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Ua < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Ug < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Us < ::Stripe::RequestParams
          class LocalAmusementTax < ::Stripe::RequestParams
            # A [FIPS code](https://www.census.gov/library/reference/code-lists/ansi.html) representing the local jurisdiction. Supported FIPS codes are: `14000` (Chicago), `02154` (Arlington Heights), `06613` (Bloomington), `10906` (Campton Hills), `21696` (East Dundee), `24582` (Evanston), `45421` (Lynwood), `48892` (Midlothian), `64343` (River Grove), and `68081` (Schiller Park).
            sig { returns(String) }
            def jurisdiction; end
            sig { params(_jurisdiction: String).returns(String) }
            def jurisdiction=(_jurisdiction); end
            sig { params(jurisdiction: String).void }
            def initialize(jurisdiction: nil); end
          end
          class LocalLeaseTax < ::Stripe::RequestParams
            # A [FIPS code](https://www.census.gov/library/reference/code-lists/ansi.html) representing the local jurisdiction. Supported FIPS codes are: `14000` (Chicago).
            sig { returns(String) }
            def jurisdiction; end
            sig { params(_jurisdiction: String).returns(String) }
            def jurisdiction=(_jurisdiction); end
            sig { params(jurisdiction: String).void }
            def initialize(jurisdiction: nil); end
          end
          class StateSalesTax < ::Stripe::RequestParams
            class Election < ::Stripe::RequestParams
              # A [FIPS code](https://www.census.gov/library/reference/code-lists/ansi.html) representing the local jurisdiction. Supported FIPS codes are: `003` (Allegheny County) and `60000` (Philadelphia City).
              sig { returns(T.nilable(String)) }
              def jurisdiction; end
              sig { params(_jurisdiction: T.nilable(String)).returns(T.nilable(String)) }
              def jurisdiction=(_jurisdiction); end
              # The type of the election for the state sales tax registration.
              sig { returns(String) }
              def type; end
              sig { params(_type: String).returns(String) }
              def type=(_type); end
              sig { params(jurisdiction: T.nilable(String), type: String).void }
              def initialize(jurisdiction: nil, type: nil); end
            end
            # Elections for the state sales tax registration.
            sig {
              returns(T::Array[Tax::RegistrationCreateParams::CountryOptions::Us::StateSalesTax::Election])
             }
            def elections; end
            sig {
              params(_elections: T::Array[Tax::RegistrationCreateParams::CountryOptions::Us::StateSalesTax::Election]).returns(T::Array[Tax::RegistrationCreateParams::CountryOptions::Us::StateSalesTax::Election])
             }
            def elections=(_elections); end
            sig {
              params(elections: T::Array[Tax::RegistrationCreateParams::CountryOptions::Us::StateSalesTax::Election]).void
             }
            def initialize(elections: nil); end
          end
          # Options for the local amusement tax registration.
          sig {
            returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Us::LocalAmusementTax))
           }
          def local_amusement_tax; end
          sig {
            params(_local_amusement_tax: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Us::LocalAmusementTax)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Us::LocalAmusementTax))
           }
          def local_amusement_tax=(_local_amusement_tax); end
          # Options for the local lease tax registration.
          sig {
            returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Us::LocalLeaseTax))
           }
          def local_lease_tax; end
          sig {
            params(_local_lease_tax: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Us::LocalLeaseTax)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Us::LocalLeaseTax))
           }
          def local_lease_tax=(_local_lease_tax); end
          # Two-letter US state code ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
          sig { returns(String) }
          def state; end
          sig { params(_state: String).returns(String) }
          def state=(_state); end
          # Options for the state sales tax registration.
          sig {
            returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Us::StateSalesTax))
           }
          def state_sales_tax; end
          sig {
            params(_state_sales_tax: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Us::StateSalesTax)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Us::StateSalesTax))
           }
          def state_sales_tax=(_state_sales_tax); end
          # Type of registration to be created in the US.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(local_amusement_tax: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Us::LocalAmusementTax), local_lease_tax: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Us::LocalLeaseTax), state: String, state_sales_tax: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Us::StateSalesTax), type: String).void
           }
          def initialize(
            local_amusement_tax: nil,
            local_lease_tax: nil,
            state: nil,
            state_sales_tax: nil,
            type: nil
          ); end
        end
        class Uy < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Uy::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Uy::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Uy::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Uy::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Uz < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Vn < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Za < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Za::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Za::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Za::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Za::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        class Zm < ::Stripe::RequestParams
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(type: String).void }
          def initialize(type: nil); end
        end
        class Zw < ::Stripe::RequestParams
          class Standard < ::Stripe::RequestParams
            # Place of supply scheme used in an standard registration.
            sig { returns(T.nilable(String)) }
            def place_of_supply_scheme; end
            sig { params(_place_of_supply_scheme: T.nilable(String)).returns(T.nilable(String)) }
            def place_of_supply_scheme=(_place_of_supply_scheme); end
            sig { params(place_of_supply_scheme: T.nilable(String)).void }
            def initialize(place_of_supply_scheme: nil); end
          end
          # Options for the standard registration.
          sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Zw::Standard)) }
          def standard; end
          sig {
            params(_standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Zw::Standard)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Zw::Standard))
           }
          def standard=(_standard); end
          # Type of registration to be created in `country`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(standard: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Zw::Standard), type: String).void
           }
          def initialize(standard: nil, type: nil); end
        end
        # Options for the registration in AE.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ae)) }
        def ae; end
        sig {
          params(_ae: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ae)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ae))
         }
        def ae=(_ae); end
        # Options for the registration in AL.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Al)) }
        def al; end
        sig {
          params(_al: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Al)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Al))
         }
        def al=(_al); end
        # Options for the registration in AM.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Am)) }
        def am; end
        sig {
          params(_am: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Am)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Am))
         }
        def am=(_am); end
        # Options for the registration in AO.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ao)) }
        def ao; end
        sig {
          params(_ao: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ao)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ao))
         }
        def ao=(_ao); end
        # Options for the registration in AT.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::At)) }
        def at; end
        sig {
          params(_at: T.nilable(Tax::RegistrationCreateParams::CountryOptions::At)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::At))
         }
        def at=(_at); end
        # Options for the registration in AU.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Au)) }
        def au; end
        sig {
          params(_au: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Au)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Au))
         }
        def au=(_au); end
        # Options for the registration in AW.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Aw)) }
        def aw; end
        sig {
          params(_aw: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Aw)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Aw))
         }
        def aw=(_aw); end
        # Options for the registration in AZ.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Az)) }
        def az; end
        sig {
          params(_az: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Az)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Az))
         }
        def az=(_az); end
        # Options for the registration in BA.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ba)) }
        def ba; end
        sig {
          params(_ba: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ba)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ba))
         }
        def ba=(_ba); end
        # Options for the registration in BB.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bb)) }
        def bb; end
        sig {
          params(_bb: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bb)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bb))
         }
        def bb=(_bb); end
        # Options for the registration in BD.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bd)) }
        def bd; end
        sig {
          params(_bd: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bd)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bd))
         }
        def bd=(_bd); end
        # Options for the registration in BE.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Be)) }
        def be; end
        sig {
          params(_be: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Be)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Be))
         }
        def be=(_be); end
        # Options for the registration in BF.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bf)) }
        def bf; end
        sig {
          params(_bf: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bf)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bf))
         }
        def bf=(_bf); end
        # Options for the registration in BG.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bg)) }
        def bg; end
        sig {
          params(_bg: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bg)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bg))
         }
        def bg=(_bg); end
        # Options for the registration in BH.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bh)) }
        def bh; end
        sig {
          params(_bh: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bh)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bh))
         }
        def bh=(_bh); end
        # Options for the registration in BJ.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bj)) }
        def bj; end
        sig {
          params(_bj: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bj)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bj))
         }
        def bj=(_bj); end
        # Options for the registration in BS.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bs)) }
        def bs; end
        sig {
          params(_bs: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bs)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bs))
         }
        def bs=(_bs); end
        # Options for the registration in BY.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::By)) }
        def by; end
        sig {
          params(_by: T.nilable(Tax::RegistrationCreateParams::CountryOptions::By)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::By))
         }
        def by=(_by); end
        # Options for the registration in CA.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ca)) }
        def ca; end
        sig {
          params(_ca: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ca)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ca))
         }
        def ca=(_ca); end
        # Options for the registration in CD.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cd)) }
        def cd; end
        sig {
          params(_cd: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cd)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cd))
         }
        def cd=(_cd); end
        # Options for the registration in CH.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ch)) }
        def ch; end
        sig {
          params(_ch: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ch)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ch))
         }
        def ch=(_ch); end
        # Options for the registration in CL.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cl)) }
        def cl; end
        sig {
          params(_cl: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cl)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cl))
         }
        def cl=(_cl); end
        # Options for the registration in CM.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cm)) }
        def cm; end
        sig {
          params(_cm: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cm)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cm))
         }
        def cm=(_cm); end
        # Options for the registration in CO.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Co)) }
        def co; end
        sig {
          params(_co: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Co)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Co))
         }
        def co=(_co); end
        # Options for the registration in CR.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cr)) }
        def cr; end
        sig {
          params(_cr: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cr)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cr))
         }
        def cr=(_cr); end
        # Options for the registration in CV.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cv)) }
        def cv; end
        sig {
          params(_cv: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cv)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cv))
         }
        def cv=(_cv); end
        # Options for the registration in CY.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cy)) }
        def cy; end
        sig {
          params(_cy: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cy)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cy))
         }
        def cy=(_cy); end
        # Options for the registration in CZ.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cz)) }
        def cz; end
        sig {
          params(_cz: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cz)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cz))
         }
        def cz=(_cz); end
        # Options for the registration in DE.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::De)) }
        def de; end
        sig {
          params(_de: T.nilable(Tax::RegistrationCreateParams::CountryOptions::De)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::De))
         }
        def de=(_de); end
        # Options for the registration in DK.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Dk)) }
        def dk; end
        sig {
          params(_dk: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Dk)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Dk))
         }
        def dk=(_dk); end
        # Options for the registration in EC.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ec)) }
        def ec; end
        sig {
          params(_ec: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ec)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ec))
         }
        def ec=(_ec); end
        # Options for the registration in EE.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ee)) }
        def ee; end
        sig {
          params(_ee: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ee)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ee))
         }
        def ee=(_ee); end
        # Options for the registration in EG.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Eg)) }
        def eg; end
        sig {
          params(_eg: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Eg)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Eg))
         }
        def eg=(_eg); end
        # Options for the registration in ES.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Es)) }
        def es; end
        sig {
          params(_es: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Es)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Es))
         }
        def es=(_es); end
        # Options for the registration in ET.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Et)) }
        def et; end
        sig {
          params(_et: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Et)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Et))
         }
        def et=(_et); end
        # Options for the registration in FI.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Fi)) }
        def fi; end
        sig {
          params(_fi: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Fi)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Fi))
         }
        def fi=(_fi); end
        # Options for the registration in FR.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Fr)) }
        def fr; end
        sig {
          params(_fr: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Fr)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Fr))
         }
        def fr=(_fr); end
        # Options for the registration in GB.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gb)) }
        def gb; end
        sig {
          params(_gb: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gb)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gb))
         }
        def gb=(_gb); end
        # Options for the registration in GE.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ge)) }
        def ge; end
        sig {
          params(_ge: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ge)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ge))
         }
        def ge=(_ge); end
        # Options for the registration in GN.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gn)) }
        def gn; end
        sig {
          params(_gn: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gn)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gn))
         }
        def gn=(_gn); end
        # Options for the registration in GR.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gr)) }
        def gr; end
        sig {
          params(_gr: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gr)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gr))
         }
        def gr=(_gr); end
        # Options for the registration in HR.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Hr)) }
        def hr; end
        sig {
          params(_hr: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Hr)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Hr))
         }
        def hr=(_hr); end
        # Options for the registration in HU.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Hu)) }
        def hu; end
        sig {
          params(_hu: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Hu)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Hu))
         }
        def hu=(_hu); end
        # Options for the registration in ID.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Id)) }
        def id; end
        sig {
          params(_id: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Id)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Id))
         }
        def id=(_id); end
        # Options for the registration in IE.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ie)) }
        def ie; end
        sig {
          params(_ie: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ie)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ie))
         }
        def ie=(_ie); end
        # Options for the registration in IN.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::In)) }
        def in; end
        sig {
          params(_in: T.nilable(Tax::RegistrationCreateParams::CountryOptions::In)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::In))
         }
        def in=(_in); end
        # Options for the registration in IS.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Is)) }
        def is; end
        sig {
          params(_is: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Is)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Is))
         }
        def is=(_is); end
        # Options for the registration in IT.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::It)) }
        def it; end
        sig {
          params(_it: T.nilable(Tax::RegistrationCreateParams::CountryOptions::It)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::It))
         }
        def it=(_it); end
        # Options for the registration in JP.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Jp)) }
        def jp; end
        sig {
          params(_jp: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Jp)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Jp))
         }
        def jp=(_jp); end
        # Options for the registration in KE.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ke)) }
        def ke; end
        sig {
          params(_ke: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ke)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ke))
         }
        def ke=(_ke); end
        # Options for the registration in KG.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Kg)) }
        def kg; end
        sig {
          params(_kg: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Kg)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Kg))
         }
        def kg=(_kg); end
        # Options for the registration in KH.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Kh)) }
        def kh; end
        sig {
          params(_kh: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Kh)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Kh))
         }
        def kh=(_kh); end
        # Options for the registration in KR.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Kr)) }
        def kr; end
        sig {
          params(_kr: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Kr)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Kr))
         }
        def kr=(_kr); end
        # Options for the registration in KZ.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Kz)) }
        def kz; end
        sig {
          params(_kz: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Kz)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Kz))
         }
        def kz=(_kz); end
        # Options for the registration in LA.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::La)) }
        def la; end
        sig {
          params(_la: T.nilable(Tax::RegistrationCreateParams::CountryOptions::La)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::La))
         }
        def la=(_la); end
        # Options for the registration in LT.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lt)) }
        def lt; end
        sig {
          params(_lt: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lt)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lt))
         }
        def lt=(_lt); end
        # Options for the registration in LU.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lu)) }
        def lu; end
        sig {
          params(_lu: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lu)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lu))
         }
        def lu=(_lu); end
        # Options for the registration in LV.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lv)) }
        def lv; end
        sig {
          params(_lv: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lv)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lv))
         }
        def lv=(_lv); end
        # Options for the registration in MA.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ma)) }
        def ma; end
        sig {
          params(_ma: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ma)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ma))
         }
        def ma=(_ma); end
        # Options for the registration in MD.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Md)) }
        def md; end
        sig {
          params(_md: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Md)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Md))
         }
        def md=(_md); end
        # Options for the registration in ME.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Me)) }
        def me; end
        sig {
          params(_me: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Me)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Me))
         }
        def me=(_me); end
        # Options for the registration in MK.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mk)) }
        def mk; end
        sig {
          params(_mk: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mk)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mk))
         }
        def mk=(_mk); end
        # Options for the registration in MR.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mr)) }
        def mr; end
        sig {
          params(_mr: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mr)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mr))
         }
        def mr=(_mr); end
        # Options for the registration in MT.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mt)) }
        def mt; end
        sig {
          params(_mt: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mt)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mt))
         }
        def mt=(_mt); end
        # Options for the registration in MX.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mx)) }
        def mx; end
        sig {
          params(_mx: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mx)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mx))
         }
        def mx=(_mx); end
        # Options for the registration in MY.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::My)) }
        def my; end
        sig {
          params(_my: T.nilable(Tax::RegistrationCreateParams::CountryOptions::My)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::My))
         }
        def my=(_my); end
        # Options for the registration in NG.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ng)) }
        def ng; end
        sig {
          params(_ng: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ng)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ng))
         }
        def ng=(_ng); end
        # Options for the registration in NL.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Nl)) }
        def nl; end
        sig {
          params(_nl: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Nl)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Nl))
         }
        def nl=(_nl); end
        # Options for the registration in NO.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::No)) }
        def no; end
        sig {
          params(_no: T.nilable(Tax::RegistrationCreateParams::CountryOptions::No)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::No))
         }
        def no=(_no); end
        # Options for the registration in NP.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Np)) }
        def np; end
        sig {
          params(_np: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Np)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Np))
         }
        def np=(_np); end
        # Options for the registration in NZ.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Nz)) }
        def nz; end
        sig {
          params(_nz: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Nz)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Nz))
         }
        def nz=(_nz); end
        # Options for the registration in OM.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Om)) }
        def om; end
        sig {
          params(_om: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Om)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Om))
         }
        def om=(_om); end
        # Options for the registration in PE.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pe)) }
        def pe; end
        sig {
          params(_pe: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pe)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pe))
         }
        def pe=(_pe); end
        # Options for the registration in PH.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ph)) }
        def ph; end
        sig {
          params(_ph: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ph)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ph))
         }
        def ph=(_ph); end
        # Options for the registration in PL.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pl)) }
        def pl; end
        sig {
          params(_pl: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pl)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pl))
         }
        def pl=(_pl); end
        # Options for the registration in PT.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pt)) }
        def pt; end
        sig {
          params(_pt: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pt)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pt))
         }
        def pt=(_pt); end
        # Options for the registration in RO.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ro)) }
        def ro; end
        sig {
          params(_ro: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ro)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ro))
         }
        def ro=(_ro); end
        # Options for the registration in RS.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Rs)) }
        def rs; end
        sig {
          params(_rs: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Rs)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Rs))
         }
        def rs=(_rs); end
        # Options for the registration in RU.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ru)) }
        def ru; end
        sig {
          params(_ru: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ru)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ru))
         }
        def ru=(_ru); end
        # Options for the registration in SA.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sa)) }
        def sa; end
        sig {
          params(_sa: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sa)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sa))
         }
        def sa=(_sa); end
        # Options for the registration in SE.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Se)) }
        def se; end
        sig {
          params(_se: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Se)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Se))
         }
        def se=(_se); end
        # Options for the registration in SG.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sg)) }
        def sg; end
        sig {
          params(_sg: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sg)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sg))
         }
        def sg=(_sg); end
        # Options for the registration in SI.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Si)) }
        def si; end
        sig {
          params(_si: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Si)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Si))
         }
        def si=(_si); end
        # Options for the registration in SK.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sk)) }
        def sk; end
        sig {
          params(_sk: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sk)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sk))
         }
        def sk=(_sk); end
        # Options for the registration in SN.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sn)) }
        def sn; end
        sig {
          params(_sn: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sn)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sn))
         }
        def sn=(_sn); end
        # Options for the registration in SR.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sr)) }
        def sr; end
        sig {
          params(_sr: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sr)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sr))
         }
        def sr=(_sr); end
        # Options for the registration in TH.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Th)) }
        def th; end
        sig {
          params(_th: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Th)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Th))
         }
        def th=(_th); end
        # Options for the registration in TJ.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Tj)) }
        def tj; end
        sig {
          params(_tj: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Tj)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Tj))
         }
        def tj=(_tj); end
        # Options for the registration in TR.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Tr)) }
        def tr; end
        sig {
          params(_tr: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Tr)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Tr))
         }
        def tr=(_tr); end
        # Options for the registration in TW.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Tw)) }
        def tw; end
        sig {
          params(_tw: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Tw)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Tw))
         }
        def tw=(_tw); end
        # Options for the registration in TZ.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Tz)) }
        def tz; end
        sig {
          params(_tz: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Tz)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Tz))
         }
        def tz=(_tz); end
        # Options for the registration in UA.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ua)) }
        def ua; end
        sig {
          params(_ua: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ua)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ua))
         }
        def ua=(_ua); end
        # Options for the registration in UG.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ug)) }
        def ug; end
        sig {
          params(_ug: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ug)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ug))
         }
        def ug=(_ug); end
        # Options for the registration in US.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Us)) }
        def us; end
        sig {
          params(_us: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Us)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Us))
         }
        def us=(_us); end
        # Options for the registration in UY.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Uy)) }
        def uy; end
        sig {
          params(_uy: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Uy)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Uy))
         }
        def uy=(_uy); end
        # Options for the registration in UZ.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Uz)) }
        def uz; end
        sig {
          params(_uz: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Uz)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Uz))
         }
        def uz=(_uz); end
        # Options for the registration in VN.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Vn)) }
        def vn; end
        sig {
          params(_vn: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Vn)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Vn))
         }
        def vn=(_vn); end
        # Options for the registration in ZA.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Za)) }
        def za; end
        sig {
          params(_za: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Za)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Za))
         }
        def za=(_za); end
        # Options for the registration in ZM.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Zm)) }
        def zm; end
        sig {
          params(_zm: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Zm)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Zm))
         }
        def zm=(_zm); end
        # Options for the registration in ZW.
        sig { returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Zw)) }
        def zw; end
        sig {
          params(_zw: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Zw)).returns(T.nilable(Tax::RegistrationCreateParams::CountryOptions::Zw))
         }
        def zw=(_zw); end
        sig {
          params(ae: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ae), al: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Al), am: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Am), ao: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ao), at: T.nilable(Tax::RegistrationCreateParams::CountryOptions::At), au: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Au), aw: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Aw), az: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Az), ba: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ba), bb: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bb), bd: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bd), be: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Be), bf: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bf), bg: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bg), bh: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bh), bj: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bj), bs: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Bs), by: T.nilable(Tax::RegistrationCreateParams::CountryOptions::By), ca: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ca), cd: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cd), ch: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ch), cl: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cl), cm: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cm), co: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Co), cr: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cr), cv: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cv), cy: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cy), cz: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Cz), de: T.nilable(Tax::RegistrationCreateParams::CountryOptions::De), dk: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Dk), ec: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ec), ee: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ee), eg: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Eg), es: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Es), et: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Et), fi: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Fi), fr: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Fr), gb: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gb), ge: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ge), gn: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gn), gr: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Gr), hr: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Hr), hu: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Hu), id: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Id), ie: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ie), in_: T.nilable(Tax::RegistrationCreateParams::CountryOptions::In), is: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Is), it: T.nilable(Tax::RegistrationCreateParams::CountryOptions::It), jp: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Jp), ke: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ke), kg: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Kg), kh: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Kh), kr: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Kr), kz: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Kz), la: T.nilable(Tax::RegistrationCreateParams::CountryOptions::La), lt: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lt), lu: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lu), lv: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Lv), ma: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ma), md: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Md), me: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Me), mk: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mk), mr: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mr), mt: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mt), mx: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Mx), my: T.nilable(Tax::RegistrationCreateParams::CountryOptions::My), ng: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ng), nl: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Nl), no: T.nilable(Tax::RegistrationCreateParams::CountryOptions::No), np: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Np), nz: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Nz), om: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Om), pe: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pe), ph: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ph), pl: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pl), pt: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Pt), ro: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ro), rs: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Rs), ru: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ru), sa: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sa), se: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Se), sg: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sg), si: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Si), sk: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sk), sn: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sn), sr: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Sr), th: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Th), tj: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Tj), tr: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Tr), tw: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Tw), tz: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Tz), ua: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ua), ug: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Ug), us: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Us), uy: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Uy), uz: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Uz), vn: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Vn), za: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Za), zm: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Zm), zw: T.nilable(Tax::RegistrationCreateParams::CountryOptions::Zw)).void
         }
        def initialize(
          ae: nil,
          al: nil,
          am: nil,
          ao: nil,
          at: nil,
          au: nil,
          aw: nil,
          az: nil,
          ba: nil,
          bb: nil,
          bd: nil,
          be: nil,
          bf: nil,
          bg: nil,
          bh: nil,
          bj: nil,
          bs: nil,
          by: nil,
          ca: nil,
          cd: nil,
          ch: nil,
          cl: nil,
          cm: nil,
          co: nil,
          cr: nil,
          cv: nil,
          cy: nil,
          cz: nil,
          de: nil,
          dk: nil,
          ec: nil,
          ee: nil,
          eg: nil,
          es: nil,
          et: nil,
          fi: nil,
          fr: nil,
          gb: nil,
          ge: nil,
          gn: nil,
          gr: nil,
          hr: nil,
          hu: nil,
          id: nil,
          ie: nil,
          in_: nil,
          is: nil,
          it: nil,
          jp: nil,
          ke: nil,
          kg: nil,
          kh: nil,
          kr: nil,
          kz: nil,
          la: nil,
          lt: nil,
          lu: nil,
          lv: nil,
          ma: nil,
          md: nil,
          me: nil,
          mk: nil,
          mr: nil,
          mt: nil,
          mx: nil,
          my: nil,
          ng: nil,
          nl: nil,
          no: nil,
          np: nil,
          nz: nil,
          om: nil,
          pe: nil,
          ph: nil,
          pl: nil,
          pt: nil,
          ro: nil,
          rs: nil,
          ru: nil,
          sa: nil,
          se: nil,
          sg: nil,
          si: nil,
          sk: nil,
          sn: nil,
          sr: nil,
          th: nil,
          tj: nil,
          tr: nil,
          tw: nil,
          tz: nil,
          ua: nil,
          ug: nil,
          us: nil,
          uy: nil,
          uz: nil,
          vn: nil,
          za: nil,
          zm: nil,
          zw: nil
        ); end
      end
      # Time at which the Tax Registration becomes active. It can be either `now` to indicate the current time, or a future timestamp measured in seconds since the Unix epoch.
      sig { returns(T.any(String, Integer)) }
      def active_from; end
      sig { params(_active_from: T.any(String, Integer)).returns(T.any(String, Integer)) }
      def active_from=(_active_from); end
      # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
      sig { returns(String) }
      def country; end
      sig { params(_country: String).returns(String) }
      def country=(_country); end
      # Specific options for a registration in the specified `country`.
      sig { returns(Tax::RegistrationCreateParams::CountryOptions) }
      def country_options; end
      sig {
        params(_country_options: Tax::RegistrationCreateParams::CountryOptions).returns(Tax::RegistrationCreateParams::CountryOptions)
       }
      def country_options=(_country_options); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # If set, the Tax Registration stops being active at this time. If not set, the Tax Registration will be active indefinitely. Timestamp measured in seconds since the Unix epoch.
      sig { returns(T.nilable(Integer)) }
      def expires_at; end
      sig { params(_expires_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def expires_at=(_expires_at); end
      sig {
        params(active_from: T.any(String, Integer), country: String, country_options: Tax::RegistrationCreateParams::CountryOptions, expand: T.nilable(T::Array[String]), expires_at: T.nilable(Integer)).void
       }
      def initialize(
        active_from: nil,
        country: nil,
        country_options: nil,
        expand: nil,
        expires_at: nil
      ); end
    end
  end
end