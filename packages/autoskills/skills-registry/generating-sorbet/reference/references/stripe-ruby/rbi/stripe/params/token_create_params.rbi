# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class TokenCreateParams < ::Stripe::RequestParams
    class Account < ::Stripe::RequestParams
      class Company < ::Stripe::RequestParams
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
          # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
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
        class AddressKana < ::Stripe::RequestParams
          # City or ward.
          sig { returns(T.nilable(String)) }
          def city; end
          sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
          def city=(_city); end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(T.nilable(String)) }
          def country; end
          sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
          def country=(_country); end
          # Block or building number.
          sig { returns(T.nilable(String)) }
          def line1; end
          sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
          def line1=(_line1); end
          # Building details.
          sig { returns(T.nilable(String)) }
          def line2; end
          sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
          def line2=(_line2); end
          # Postal code.
          sig { returns(T.nilable(String)) }
          def postal_code; end
          sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
          def postal_code=(_postal_code); end
          # Prefecture.
          sig { returns(T.nilable(String)) }
          def state; end
          sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
          def state=(_state); end
          # Town or cho-me.
          sig { returns(T.nilable(String)) }
          def town; end
          sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
          def town=(_town); end
          sig {
            params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
           }
          def initialize(
            city: nil,
            country: nil,
            line1: nil,
            line2: nil,
            postal_code: nil,
            state: nil,
            town: nil
          ); end
        end
        class AddressKanji < ::Stripe::RequestParams
          # City or ward.
          sig { returns(T.nilable(String)) }
          def city; end
          sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
          def city=(_city); end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(T.nilable(String)) }
          def country; end
          sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
          def country=(_country); end
          # Block or building number.
          sig { returns(T.nilable(String)) }
          def line1; end
          sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
          def line1=(_line1); end
          # Building details.
          sig { returns(T.nilable(String)) }
          def line2; end
          sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
          def line2=(_line2); end
          # Postal code.
          sig { returns(T.nilable(String)) }
          def postal_code; end
          sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
          def postal_code=(_postal_code); end
          # Prefecture.
          sig { returns(T.nilable(String)) }
          def state; end
          sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
          def state=(_state); end
          # Town or cho-me.
          sig { returns(T.nilable(String)) }
          def town; end
          sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
          def town=(_town); end
          sig {
            params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
           }
          def initialize(
            city: nil,
            country: nil,
            line1: nil,
            line2: nil,
            postal_code: nil,
            state: nil,
            town: nil
          ); end
        end
        class DirectorshipDeclaration < ::Stripe::RequestParams
          # The Unix timestamp marking when the directorship declaration attestation was made.
          sig { returns(T.nilable(Integer)) }
          def date; end
          sig { params(_date: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def date=(_date); end
          # The IP address from which the directorship declaration attestation was made.
          sig { returns(T.nilable(String)) }
          def ip; end
          sig { params(_ip: T.nilable(String)).returns(T.nilable(String)) }
          def ip=(_ip); end
          # The user agent of the browser from which the directorship declaration attestation was made.
          sig { returns(T.nilable(String)) }
          def user_agent; end
          sig { params(_user_agent: T.nilable(String)).returns(T.nilable(String)) }
          def user_agent=(_user_agent); end
          sig {
            params(date: T.nilable(Integer), ip: T.nilable(String), user_agent: T.nilable(String)).void
           }
          def initialize(date: nil, ip: nil, user_agent: nil); end
        end
        class OwnershipDeclaration < ::Stripe::RequestParams
          # The Unix timestamp marking when the beneficial owner attestation was made.
          sig { returns(T.nilable(Integer)) }
          def date; end
          sig { params(_date: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def date=(_date); end
          # The IP address from which the beneficial owner attestation was made.
          sig { returns(T.nilable(String)) }
          def ip; end
          sig { params(_ip: T.nilable(String)).returns(T.nilable(String)) }
          def ip=(_ip); end
          # The user agent of the browser from which the beneficial owner attestation was made.
          sig { returns(T.nilable(String)) }
          def user_agent; end
          sig { params(_user_agent: T.nilable(String)).returns(T.nilable(String)) }
          def user_agent=(_user_agent); end
          sig {
            params(date: T.nilable(Integer), ip: T.nilable(String), user_agent: T.nilable(String)).void
           }
          def initialize(date: nil, ip: nil, user_agent: nil); end
        end
        class RegistrationDate < ::Stripe::RequestParams
          # The day of registration, between 1 and 31.
          sig { returns(Integer) }
          def day; end
          sig { params(_day: Integer).returns(Integer) }
          def day=(_day); end
          # The month of registration, between 1 and 12.
          sig { returns(Integer) }
          def month; end
          sig { params(_month: Integer).returns(Integer) }
          def month=(_month); end
          # The four-digit year of registration.
          sig { returns(Integer) }
          def year; end
          sig { params(_year: Integer).returns(Integer) }
          def year=(_year); end
          sig { params(day: Integer, month: Integer, year: Integer).void }
          def initialize(day: nil, month: nil, year: nil); end
        end
        class RepresentativeDeclaration < ::Stripe::RequestParams
          # The Unix timestamp marking when the representative declaration attestation was made.
          sig { returns(T.nilable(Integer)) }
          def date; end
          sig { params(_date: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def date=(_date); end
          # The IP address from which the representative declaration attestation was made.
          sig { returns(T.nilable(String)) }
          def ip; end
          sig { params(_ip: T.nilable(String)).returns(T.nilable(String)) }
          def ip=(_ip); end
          # The user agent of the browser from which the representative declaration attestation was made.
          sig { returns(T.nilable(String)) }
          def user_agent; end
          sig { params(_user_agent: T.nilable(String)).returns(T.nilable(String)) }
          def user_agent=(_user_agent); end
          sig {
            params(date: T.nilable(Integer), ip: T.nilable(String), user_agent: T.nilable(String)).void
           }
          def initialize(date: nil, ip: nil, user_agent: nil); end
        end
        class Verification < ::Stripe::RequestParams
          class Document < ::Stripe::RequestParams
            # The back of a document returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `additional_verification`. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
            sig { returns(T.nilable(String)) }
            def back; end
            sig { params(_back: T.nilable(String)).returns(T.nilable(String)) }
            def back=(_back); end
            # The front of a document returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `additional_verification`. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
            sig { returns(T.nilable(String)) }
            def front; end
            sig { params(_front: T.nilable(String)).returns(T.nilable(String)) }
            def front=(_front); end
            sig { params(back: T.nilable(String), front: T.nilable(String)).void }
            def initialize(back: nil, front: nil); end
          end
          # A document verifying the business.
          sig { returns(T.nilable(TokenCreateParams::Account::Company::Verification::Document)) }
          def document; end
          sig {
            params(_document: T.nilable(TokenCreateParams::Account::Company::Verification::Document)).returns(T.nilable(TokenCreateParams::Account::Company::Verification::Document))
           }
          def document=(_document); end
          sig {
            params(document: T.nilable(TokenCreateParams::Account::Company::Verification::Document)).void
           }
          def initialize(document: nil); end
        end
        # The company's primary address.
        sig { returns(T.nilable(TokenCreateParams::Account::Company::Address)) }
        def address; end
        sig {
          params(_address: T.nilable(TokenCreateParams::Account::Company::Address)).returns(T.nilable(TokenCreateParams::Account::Company::Address))
         }
        def address=(_address); end
        # The Kana variation of the company's primary address (Japan only).
        sig { returns(T.nilable(TokenCreateParams::Account::Company::AddressKana)) }
        def address_kana; end
        sig {
          params(_address_kana: T.nilable(TokenCreateParams::Account::Company::AddressKana)).returns(T.nilable(TokenCreateParams::Account::Company::AddressKana))
         }
        def address_kana=(_address_kana); end
        # The Kanji variation of the company's primary address (Japan only).
        sig { returns(T.nilable(TokenCreateParams::Account::Company::AddressKanji)) }
        def address_kanji; end
        sig {
          params(_address_kanji: T.nilable(TokenCreateParams::Account::Company::AddressKanji)).returns(T.nilable(TokenCreateParams::Account::Company::AddressKanji))
         }
        def address_kanji=(_address_kanji); end
        # Whether the company's directors have been provided. Set this Boolean to `true` after creating all the company's directors with [the Persons API](/api/persons) for accounts with a `relationship.director` requirement. This value is not automatically set to `true` after creating directors, so it needs to be updated to indicate all directors have been provided.
        sig { returns(T.nilable(T::Boolean)) }
        def directors_provided; end
        sig { params(_directors_provided: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def directors_provided=(_directors_provided); end
        # This hash is used to attest that the directors information provided to Stripe is both current and correct.
        sig { returns(T.nilable(TokenCreateParams::Account::Company::DirectorshipDeclaration)) }
        def directorship_declaration; end
        sig {
          params(_directorship_declaration: T.nilable(TokenCreateParams::Account::Company::DirectorshipDeclaration)).returns(T.nilable(TokenCreateParams::Account::Company::DirectorshipDeclaration))
         }
        def directorship_declaration=(_directorship_declaration); end
        # Whether the company's executives have been provided. Set this Boolean to `true` after creating all the company's executives with [the Persons API](/api/persons) for accounts with a `relationship.executive` requirement.
        sig { returns(T.nilable(T::Boolean)) }
        def executives_provided; end
        sig { params(_executives_provided: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def executives_provided=(_executives_provided); end
        # The export license ID number of the company, also referred as Import Export Code (India only).
        sig { returns(T.nilable(String)) }
        def export_license_id; end
        sig { params(_export_license_id: T.nilable(String)).returns(T.nilable(String)) }
        def export_license_id=(_export_license_id); end
        # The purpose code to use for export transactions (India only).
        sig { returns(T.nilable(String)) }
        def export_purpose_code; end
        sig { params(_export_purpose_code: T.nilable(String)).returns(T.nilable(String)) }
        def export_purpose_code=(_export_purpose_code); end
        # The company's legal name.
        sig { returns(T.nilable(String)) }
        def name; end
        sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
        def name=(_name); end
        # The Kana variation of the company's legal name (Japan only).
        sig { returns(T.nilable(String)) }
        def name_kana; end
        sig { params(_name_kana: T.nilable(String)).returns(T.nilable(String)) }
        def name_kana=(_name_kana); end
        # The Kanji variation of the company's legal name (Japan only).
        sig { returns(T.nilable(String)) }
        def name_kanji; end
        sig { params(_name_kanji: T.nilable(String)).returns(T.nilable(String)) }
        def name_kanji=(_name_kanji); end
        # Whether the company's owners have been provided. Set this Boolean to `true` after creating all the company's owners with [the Persons API](/api/persons) for accounts with a `relationship.owner` requirement.
        sig { returns(T.nilable(T::Boolean)) }
        def owners_provided; end
        sig { params(_owners_provided: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def owners_provided=(_owners_provided); end
        # This hash is used to attest that the beneficial owner information provided to Stripe is both current and correct.
        sig { returns(T.nilable(TokenCreateParams::Account::Company::OwnershipDeclaration)) }
        def ownership_declaration; end
        sig {
          params(_ownership_declaration: T.nilable(TokenCreateParams::Account::Company::OwnershipDeclaration)).returns(T.nilable(TokenCreateParams::Account::Company::OwnershipDeclaration))
         }
        def ownership_declaration=(_ownership_declaration); end
        # Whether the user described by the data in the token has been shown the Ownership Declaration and indicated that it is correct.
        sig { returns(T.nilable(T::Boolean)) }
        def ownership_declaration_shown_and_signed; end
        sig {
          params(_ownership_declaration_shown_and_signed: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean))
         }
        def ownership_declaration_shown_and_signed=(_ownership_declaration_shown_and_signed); end
        # This value is used to determine if a business is exempt from providing ultimate beneficial owners. See [this support article](https://support.stripe.com/questions/exemption-from-providing-ownership-details) and [changelog](https://docs.stripe.com/changelog/acacia/2025-01-27/ownership-exemption-reason-accounts-api) for more details.
        sig { returns(T.nilable(T.any(String, String))) }
        def ownership_exemption_reason; end
        sig {
          params(_ownership_exemption_reason: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def ownership_exemption_reason=(_ownership_exemption_reason); end
        # The company's phone number (used for verification).
        sig { returns(T.nilable(String)) }
        def phone; end
        sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
        def phone=(_phone); end
        # When the business was incorporated or registered.
        sig {
          returns(T.nilable(T.any(String, TokenCreateParams::Account::Company::RegistrationDate)))
         }
        def registration_date; end
        sig {
          params(_registration_date: T.nilable(T.any(String, TokenCreateParams::Account::Company::RegistrationDate))).returns(T.nilable(T.any(String, TokenCreateParams::Account::Company::RegistrationDate)))
         }
        def registration_date=(_registration_date); end
        # The identification number given to a company when it is registered or incorporated, if distinct from the identification number used for filing taxes. (Examples are the CIN for companies and LLP IN for partnerships in India, and the Company Registration Number in Hong Kong).
        sig { returns(T.nilable(String)) }
        def registration_number; end
        sig { params(_registration_number: T.nilable(String)).returns(T.nilable(String)) }
        def registration_number=(_registration_number); end
        # This hash is used to attest that the representative is authorized to act as the representative of their legal entity.
        sig { returns(T.nilable(TokenCreateParams::Account::Company::RepresentativeDeclaration)) }
        def representative_declaration; end
        sig {
          params(_representative_declaration: T.nilable(TokenCreateParams::Account::Company::RepresentativeDeclaration)).returns(T.nilable(TokenCreateParams::Account::Company::RepresentativeDeclaration))
         }
        def representative_declaration=(_representative_declaration); end
        # The category identifying the legal structure of the company or legal entity. See [Business structure](/connect/identity-verification#business-structure) for more details. Pass an empty string to unset this value.
        sig { returns(T.nilable(T.any(String, String))) }
        def structure; end
        sig {
          params(_structure: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def structure=(_structure); end
        # The business ID number of the company, as appropriate for the company’s country. (Examples are an Employer ID Number in the U.S., a Business Number in Canada, or a Company Number in the UK.)
        sig { returns(T.nilable(String)) }
        def tax_id; end
        sig { params(_tax_id: T.nilable(String)).returns(T.nilable(String)) }
        def tax_id=(_tax_id); end
        # The jurisdiction in which the `tax_id` is registered (Germany-based companies only).
        sig { returns(T.nilable(String)) }
        def tax_id_registrar; end
        sig { params(_tax_id_registrar: T.nilable(String)).returns(T.nilable(String)) }
        def tax_id_registrar=(_tax_id_registrar); end
        # The VAT number of the company.
        sig { returns(T.nilable(String)) }
        def vat_id; end
        sig { params(_vat_id: T.nilable(String)).returns(T.nilable(String)) }
        def vat_id=(_vat_id); end
        # Information on the verification state of the company.
        sig { returns(T.nilable(TokenCreateParams::Account::Company::Verification)) }
        def verification; end
        sig {
          params(_verification: T.nilable(TokenCreateParams::Account::Company::Verification)).returns(T.nilable(TokenCreateParams::Account::Company::Verification))
         }
        def verification=(_verification); end
        sig {
          params(address: T.nilable(TokenCreateParams::Account::Company::Address), address_kana: T.nilable(TokenCreateParams::Account::Company::AddressKana), address_kanji: T.nilable(TokenCreateParams::Account::Company::AddressKanji), directors_provided: T.nilable(T::Boolean), directorship_declaration: T.nilable(TokenCreateParams::Account::Company::DirectorshipDeclaration), executives_provided: T.nilable(T::Boolean), export_license_id: T.nilable(String), export_purpose_code: T.nilable(String), name: T.nilable(String), name_kana: T.nilable(String), name_kanji: T.nilable(String), owners_provided: T.nilable(T::Boolean), ownership_declaration: T.nilable(TokenCreateParams::Account::Company::OwnershipDeclaration), ownership_declaration_shown_and_signed: T.nilable(T::Boolean), ownership_exemption_reason: T.nilable(T.any(String, String)), phone: T.nilable(String), registration_date: T.nilable(T.any(String, TokenCreateParams::Account::Company::RegistrationDate)), registration_number: T.nilable(String), representative_declaration: T.nilable(TokenCreateParams::Account::Company::RepresentativeDeclaration), structure: T.nilable(T.any(String, String)), tax_id: T.nilable(String), tax_id_registrar: T.nilable(String), vat_id: T.nilable(String), verification: T.nilable(TokenCreateParams::Account::Company::Verification)).void
         }
        def initialize(
          address: nil,
          address_kana: nil,
          address_kanji: nil,
          directors_provided: nil,
          directorship_declaration: nil,
          executives_provided: nil,
          export_license_id: nil,
          export_purpose_code: nil,
          name: nil,
          name_kana: nil,
          name_kanji: nil,
          owners_provided: nil,
          ownership_declaration: nil,
          ownership_declaration_shown_and_signed: nil,
          ownership_exemption_reason: nil,
          phone: nil,
          registration_date: nil,
          registration_number: nil,
          representative_declaration: nil,
          structure: nil,
          tax_id: nil,
          tax_id_registrar: nil,
          vat_id: nil,
          verification: nil
        ); end
      end
      class Individual < ::Stripe::RequestParams
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
          # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
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
        class AddressKana < ::Stripe::RequestParams
          # City or ward.
          sig { returns(T.nilable(String)) }
          def city; end
          sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
          def city=(_city); end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(T.nilable(String)) }
          def country; end
          sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
          def country=(_country); end
          # Block or building number.
          sig { returns(T.nilable(String)) }
          def line1; end
          sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
          def line1=(_line1); end
          # Building details.
          sig { returns(T.nilable(String)) }
          def line2; end
          sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
          def line2=(_line2); end
          # Postal code.
          sig { returns(T.nilable(String)) }
          def postal_code; end
          sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
          def postal_code=(_postal_code); end
          # Prefecture.
          sig { returns(T.nilable(String)) }
          def state; end
          sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
          def state=(_state); end
          # Town or cho-me.
          sig { returns(T.nilable(String)) }
          def town; end
          sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
          def town=(_town); end
          sig {
            params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
           }
          def initialize(
            city: nil,
            country: nil,
            line1: nil,
            line2: nil,
            postal_code: nil,
            state: nil,
            town: nil
          ); end
        end
        class AddressKanji < ::Stripe::RequestParams
          # City or ward.
          sig { returns(T.nilable(String)) }
          def city; end
          sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
          def city=(_city); end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(T.nilable(String)) }
          def country; end
          sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
          def country=(_country); end
          # Block or building number.
          sig { returns(T.nilable(String)) }
          def line1; end
          sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
          def line1=(_line1); end
          # Building details.
          sig { returns(T.nilable(String)) }
          def line2; end
          sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
          def line2=(_line2); end
          # Postal code.
          sig { returns(T.nilable(String)) }
          def postal_code; end
          sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
          def postal_code=(_postal_code); end
          # Prefecture.
          sig { returns(T.nilable(String)) }
          def state; end
          sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
          def state=(_state); end
          # Town or cho-me.
          sig { returns(T.nilable(String)) }
          def town; end
          sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
          def town=(_town); end
          sig {
            params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
           }
          def initialize(
            city: nil,
            country: nil,
            line1: nil,
            line2: nil,
            postal_code: nil,
            state: nil,
            town: nil
          ); end
        end
        class Dob < ::Stripe::RequestParams
          # The day of birth, between 1 and 31.
          sig { returns(Integer) }
          def day; end
          sig { params(_day: Integer).returns(Integer) }
          def day=(_day); end
          # The month of birth, between 1 and 12.
          sig { returns(Integer) }
          def month; end
          sig { params(_month: Integer).returns(Integer) }
          def month=(_month); end
          # The four-digit year of birth.
          sig { returns(Integer) }
          def year; end
          sig { params(_year: Integer).returns(Integer) }
          def year=(_year); end
          sig { params(day: Integer, month: Integer, year: Integer).void }
          def initialize(day: nil, month: nil, year: nil); end
        end
        class RegisteredAddress < ::Stripe::RequestParams
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
          # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
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
        class Relationship < ::Stripe::RequestParams
          # Whether the person is a director of the account's legal entity. Directors are typically members of the governing board of the company, or responsible for ensuring the company meets its regulatory obligations.
          sig { returns(T.nilable(T::Boolean)) }
          def director; end
          sig { params(_director: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
          def director=(_director); end
          # Whether the person has significant responsibility to control, manage, or direct the organization.
          sig { returns(T.nilable(T::Boolean)) }
          def executive; end
          sig { params(_executive: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
          def executive=(_executive); end
          # Whether the person is an owner of the account’s legal entity.
          sig { returns(T.nilable(T::Boolean)) }
          def owner; end
          sig { params(_owner: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
          def owner=(_owner); end
          # The percent owned by the person of the account's legal entity.
          sig { returns(T.nilable(T.any(String, Float))) }
          def percent_ownership; end
          sig {
            params(_percent_ownership: T.nilable(T.any(String, Float))).returns(T.nilable(T.any(String, Float)))
           }
          def percent_ownership=(_percent_ownership); end
          # The person's title (e.g., CEO, Support Engineer).
          sig { returns(T.nilable(String)) }
          def title; end
          sig { params(_title: T.nilable(String)).returns(T.nilable(String)) }
          def title=(_title); end
          sig {
            params(director: T.nilable(T::Boolean), executive: T.nilable(T::Boolean), owner: T.nilable(T::Boolean), percent_ownership: T.nilable(T.any(String, Float)), title: T.nilable(String)).void
           }
          def initialize(
            director: nil,
            executive: nil,
            owner: nil,
            percent_ownership: nil,
            title: nil
          ); end
        end
        class Verification < ::Stripe::RequestParams
          class AdditionalDocument < ::Stripe::RequestParams
            # The back of an ID returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `identity_document`. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
            sig { returns(T.nilable(String)) }
            def back; end
            sig { params(_back: T.nilable(String)).returns(T.nilable(String)) }
            def back=(_back); end
            # The front of an ID returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `identity_document`. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
            sig { returns(T.nilable(String)) }
            def front; end
            sig { params(_front: T.nilable(String)).returns(T.nilable(String)) }
            def front=(_front); end
            sig { params(back: T.nilable(String), front: T.nilable(String)).void }
            def initialize(back: nil, front: nil); end
          end
          class Document < ::Stripe::RequestParams
            # The back of an ID returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `identity_document`. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
            sig { returns(T.nilable(String)) }
            def back; end
            sig { params(_back: T.nilable(String)).returns(T.nilable(String)) }
            def back=(_back); end
            # The front of an ID returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `identity_document`. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
            sig { returns(T.nilable(String)) }
            def front; end
            sig { params(_front: T.nilable(String)).returns(T.nilable(String)) }
            def front=(_front); end
            sig { params(back: T.nilable(String), front: T.nilable(String)).void }
            def initialize(back: nil, front: nil); end
          end
          # A document showing address, either a passport, local ID card, or utility bill from a well-known utility company.
          sig {
            returns(T.nilable(TokenCreateParams::Account::Individual::Verification::AdditionalDocument))
           }
          def additional_document; end
          sig {
            params(_additional_document: T.nilable(TokenCreateParams::Account::Individual::Verification::AdditionalDocument)).returns(T.nilable(TokenCreateParams::Account::Individual::Verification::AdditionalDocument))
           }
          def additional_document=(_additional_document); end
          # An identifying document, either a passport or local ID card.
          sig { returns(T.nilable(TokenCreateParams::Account::Individual::Verification::Document)) }
          def document; end
          sig {
            params(_document: T.nilable(TokenCreateParams::Account::Individual::Verification::Document)).returns(T.nilable(TokenCreateParams::Account::Individual::Verification::Document))
           }
          def document=(_document); end
          sig {
            params(additional_document: T.nilable(TokenCreateParams::Account::Individual::Verification::AdditionalDocument), document: T.nilable(TokenCreateParams::Account::Individual::Verification::Document)).void
           }
          def initialize(additional_document: nil, document: nil); end
        end
        # The individual's primary address.
        sig { returns(T.nilable(TokenCreateParams::Account::Individual::Address)) }
        def address; end
        sig {
          params(_address: T.nilable(TokenCreateParams::Account::Individual::Address)).returns(T.nilable(TokenCreateParams::Account::Individual::Address))
         }
        def address=(_address); end
        # The Kana variation of the individual's primary address (Japan only).
        sig { returns(T.nilable(TokenCreateParams::Account::Individual::AddressKana)) }
        def address_kana; end
        sig {
          params(_address_kana: T.nilable(TokenCreateParams::Account::Individual::AddressKana)).returns(T.nilable(TokenCreateParams::Account::Individual::AddressKana))
         }
        def address_kana=(_address_kana); end
        # The Kanji variation of the individual's primary address (Japan only).
        sig { returns(T.nilable(TokenCreateParams::Account::Individual::AddressKanji)) }
        def address_kanji; end
        sig {
          params(_address_kanji: T.nilable(TokenCreateParams::Account::Individual::AddressKanji)).returns(T.nilable(TokenCreateParams::Account::Individual::AddressKanji))
         }
        def address_kanji=(_address_kanji); end
        # The individual's date of birth.
        sig { returns(T.nilable(T.any(String, TokenCreateParams::Account::Individual::Dob))) }
        def dob; end
        sig {
          params(_dob: T.nilable(T.any(String, TokenCreateParams::Account::Individual::Dob))).returns(T.nilable(T.any(String, TokenCreateParams::Account::Individual::Dob)))
         }
        def dob=(_dob); end
        # The individual's email address.
        sig { returns(T.nilable(String)) }
        def email; end
        sig { params(_email: T.nilable(String)).returns(T.nilable(String)) }
        def email=(_email); end
        # The individual's first name.
        sig { returns(T.nilable(String)) }
        def first_name; end
        sig { params(_first_name: T.nilable(String)).returns(T.nilable(String)) }
        def first_name=(_first_name); end
        # The Kana variation of the individual's first name (Japan only).
        sig { returns(T.nilable(String)) }
        def first_name_kana; end
        sig { params(_first_name_kana: T.nilable(String)).returns(T.nilable(String)) }
        def first_name_kana=(_first_name_kana); end
        # The Kanji variation of the individual's first name (Japan only).
        sig { returns(T.nilable(String)) }
        def first_name_kanji; end
        sig { params(_first_name_kanji: T.nilable(String)).returns(T.nilable(String)) }
        def first_name_kanji=(_first_name_kanji); end
        # A list of alternate names or aliases that the individual is known by.
        sig { returns(T.nilable(T.any(String, T::Array[String]))) }
        def full_name_aliases; end
        sig {
          params(_full_name_aliases: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
         }
        def full_name_aliases=(_full_name_aliases); end
        # The individual's gender
        sig { returns(T.nilable(String)) }
        def gender; end
        sig { params(_gender: T.nilable(String)).returns(T.nilable(String)) }
        def gender=(_gender); end
        # The government-issued ID number of the individual, as appropriate for the representative's country. (Examples are a Social Security Number in the U.S., or a Social Insurance Number in Canada). Instead of the number itself, you can also provide a [PII token created with Stripe.js](/js/tokens/create_token?type=pii).
        sig { returns(T.nilable(String)) }
        def id_number; end
        sig { params(_id_number: T.nilable(String)).returns(T.nilable(String)) }
        def id_number=(_id_number); end
        # The government-issued secondary ID number of the individual, as appropriate for the representative's country, will be used for enhanced verification checks. In Thailand, this would be the laser code found on the back of an ID card. Instead of the number itself, you can also provide a [PII token created with Stripe.js](/js/tokens/create_token?type=pii).
        sig { returns(T.nilable(String)) }
        def id_number_secondary; end
        sig { params(_id_number_secondary: T.nilable(String)).returns(T.nilable(String)) }
        def id_number_secondary=(_id_number_secondary); end
        # The individual's last name.
        sig { returns(T.nilable(String)) }
        def last_name; end
        sig { params(_last_name: T.nilable(String)).returns(T.nilable(String)) }
        def last_name=(_last_name); end
        # The Kana variation of the individual's last name (Japan only).
        sig { returns(T.nilable(String)) }
        def last_name_kana; end
        sig { params(_last_name_kana: T.nilable(String)).returns(T.nilable(String)) }
        def last_name_kana=(_last_name_kana); end
        # The Kanji variation of the individual's last name (Japan only).
        sig { returns(T.nilable(String)) }
        def last_name_kanji; end
        sig { params(_last_name_kanji: T.nilable(String)).returns(T.nilable(String)) }
        def last_name_kanji=(_last_name_kanji); end
        # The individual's maiden name.
        sig { returns(T.nilable(String)) }
        def maiden_name; end
        sig { params(_maiden_name: T.nilable(String)).returns(T.nilable(String)) }
        def maiden_name=(_maiden_name); end
        # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
        sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
        def metadata; end
        sig {
          params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
         }
        def metadata=(_metadata); end
        # The individual's phone number.
        sig { returns(T.nilable(String)) }
        def phone; end
        sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
        def phone=(_phone); end
        # Indicates if the person or any of their representatives, family members, or other closely related persons, declares that they hold or have held an important public job or function, in any jurisdiction.
        sig { returns(T.nilable(String)) }
        def political_exposure; end
        sig { params(_political_exposure: T.nilable(String)).returns(T.nilable(String)) }
        def political_exposure=(_political_exposure); end
        # The individual's registered address.
        sig { returns(T.nilable(TokenCreateParams::Account::Individual::RegisteredAddress)) }
        def registered_address; end
        sig {
          params(_registered_address: T.nilable(TokenCreateParams::Account::Individual::RegisteredAddress)).returns(T.nilable(TokenCreateParams::Account::Individual::RegisteredAddress))
         }
        def registered_address=(_registered_address); end
        # Describes the person’s relationship to the account.
        sig { returns(T.nilable(TokenCreateParams::Account::Individual::Relationship)) }
        def relationship; end
        sig {
          params(_relationship: T.nilable(TokenCreateParams::Account::Individual::Relationship)).returns(T.nilable(TokenCreateParams::Account::Individual::Relationship))
         }
        def relationship=(_relationship); end
        # The last four digits of the individual's Social Security Number (U.S. only).
        sig { returns(T.nilable(String)) }
        def ssn_last_4; end
        sig { params(_ssn_last_4: T.nilable(String)).returns(T.nilable(String)) }
        def ssn_last_4=(_ssn_last_4); end
        # The individual's verification document information.
        sig { returns(T.nilable(TokenCreateParams::Account::Individual::Verification)) }
        def verification; end
        sig {
          params(_verification: T.nilable(TokenCreateParams::Account::Individual::Verification)).returns(T.nilable(TokenCreateParams::Account::Individual::Verification))
         }
        def verification=(_verification); end
        sig {
          params(address: T.nilable(TokenCreateParams::Account::Individual::Address), address_kana: T.nilable(TokenCreateParams::Account::Individual::AddressKana), address_kanji: T.nilable(TokenCreateParams::Account::Individual::AddressKanji), dob: T.nilable(T.any(String, TokenCreateParams::Account::Individual::Dob)), email: T.nilable(String), first_name: T.nilable(String), first_name_kana: T.nilable(String), first_name_kanji: T.nilable(String), full_name_aliases: T.nilable(T.any(String, T::Array[String])), gender: T.nilable(String), id_number: T.nilable(String), id_number_secondary: T.nilable(String), last_name: T.nilable(String), last_name_kana: T.nilable(String), last_name_kanji: T.nilable(String), maiden_name: T.nilable(String), metadata: T.nilable(T.any(String, T::Hash[String, String])), phone: T.nilable(String), political_exposure: T.nilable(String), registered_address: T.nilable(TokenCreateParams::Account::Individual::RegisteredAddress), relationship: T.nilable(TokenCreateParams::Account::Individual::Relationship), ssn_last_4: T.nilable(String), verification: T.nilable(TokenCreateParams::Account::Individual::Verification)).void
         }
        def initialize(
          address: nil,
          address_kana: nil,
          address_kanji: nil,
          dob: nil,
          email: nil,
          first_name: nil,
          first_name_kana: nil,
          first_name_kanji: nil,
          full_name_aliases: nil,
          gender: nil,
          id_number: nil,
          id_number_secondary: nil,
          last_name: nil,
          last_name_kana: nil,
          last_name_kanji: nil,
          maiden_name: nil,
          metadata: nil,
          phone: nil,
          political_exposure: nil,
          registered_address: nil,
          relationship: nil,
          ssn_last_4: nil,
          verification: nil
        ); end
      end
      # The business type.
      sig { returns(T.nilable(String)) }
      def business_type; end
      sig { params(_business_type: T.nilable(String)).returns(T.nilable(String)) }
      def business_type=(_business_type); end
      # Information about the company or business.
      sig { returns(T.nilable(TokenCreateParams::Account::Company)) }
      def company; end
      sig {
        params(_company: T.nilable(TokenCreateParams::Account::Company)).returns(T.nilable(TokenCreateParams::Account::Company))
       }
      def company=(_company); end
      # Information about the person represented by the account.
      sig { returns(T.nilable(TokenCreateParams::Account::Individual)) }
      def individual; end
      sig {
        params(_individual: T.nilable(TokenCreateParams::Account::Individual)).returns(T.nilable(TokenCreateParams::Account::Individual))
       }
      def individual=(_individual); end
      # Whether the user described by the data in the token has been shown [the Stripe Connected Account Agreement](/connect/account-tokens#stripe-connected-account-agreement). When creating an account token to create a new Connect account, this value must be `true`.
      sig { returns(T.nilable(T::Boolean)) }
      def tos_shown_and_accepted; end
      sig { params(_tos_shown_and_accepted: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def tos_shown_and_accepted=(_tos_shown_and_accepted); end
      sig {
        params(business_type: T.nilable(String), company: T.nilable(TokenCreateParams::Account::Company), individual: T.nilable(TokenCreateParams::Account::Individual), tos_shown_and_accepted: T.nilable(T::Boolean)).void
       }
      def initialize(
        business_type: nil,
        company: nil,
        individual: nil,
        tos_shown_and_accepted: nil
      ); end
    end
    class BankAccount < ::Stripe::RequestParams
      # The name of the person or business that owns the bank account. This field is required when attaching the bank account to a `Customer` object.
      sig { returns(T.nilable(String)) }
      def account_holder_name; end
      sig { params(_account_holder_name: T.nilable(String)).returns(T.nilable(String)) }
      def account_holder_name=(_account_holder_name); end
      # The type of entity that holds the account. It can be `company` or `individual`. This field is required when attaching the bank account to a `Customer` object.
      sig { returns(T.nilable(String)) }
      def account_holder_type; end
      sig { params(_account_holder_type: T.nilable(String)).returns(T.nilable(String)) }
      def account_holder_type=(_account_holder_type); end
      # The account number for the bank account, in string form. Must be a checking account.
      sig { returns(String) }
      def account_number; end
      sig { params(_account_number: String).returns(String) }
      def account_number=(_account_number); end
      # The bank account type. This can only be `checking` or `savings` in most countries. In Japan, this can only be `futsu` or `toza`.
      sig { returns(T.nilable(String)) }
      def account_type; end
      sig { params(_account_type: T.nilable(String)).returns(T.nilable(String)) }
      def account_type=(_account_type); end
      # The country in which the bank account is located.
      sig { returns(String) }
      def country; end
      sig { params(_country: String).returns(String) }
      def country=(_country); end
      # The currency the bank account is in. This must be a country/currency pairing that [Stripe supports.](https://docs.stripe.com/payouts)
      sig { returns(T.nilable(String)) }
      def currency; end
      sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
      def currency=(_currency); end
      # The ID of a Payment Method with a `type` of `us_bank_account`. The Payment Method's bank account information will be copied and returned as a Bank Account Token. This parameter is exclusive with respect to all other parameters in the `bank_account` hash. You must include the top-level `customer` parameter if the Payment Method is attached to a `Customer` object. If the Payment Method is not attached to a `Customer` object, it will be consumed and cannot be used again. You may not use Payment Methods which were created by a Setup Intent with `attach_to_self=true`.
      sig { returns(T.nilable(String)) }
      def payment_method; end
      sig { params(_payment_method: T.nilable(String)).returns(T.nilable(String)) }
      def payment_method=(_payment_method); end
      # The routing number, sort code, or other country-appropriate institution number for the bank account. For US bank accounts, this is required and should be the ACH routing number, not the wire routing number. If you are providing an IBAN for `account_number`, this field is not required.
      sig { returns(T.nilable(String)) }
      def routing_number; end
      sig { params(_routing_number: T.nilable(String)).returns(T.nilable(String)) }
      def routing_number=(_routing_number); end
      sig {
        params(account_holder_name: T.nilable(String), account_holder_type: T.nilable(String), account_number: String, account_type: T.nilable(String), country: String, currency: T.nilable(String), payment_method: T.nilable(String), routing_number: T.nilable(String)).void
       }
      def initialize(
        account_holder_name: nil,
        account_holder_type: nil,
        account_number: nil,
        account_type: nil,
        country: nil,
        currency: nil,
        payment_method: nil,
        routing_number: nil
      ); end
    end
    class Card < ::Stripe::RequestParams
      class Networks < ::Stripe::RequestParams
        # The customer's preferred card network for co-branded cards. Supports `cartes_bancaires`, `mastercard`, or `visa`. Selection of a network that does not apply to the card will be stored as `invalid_preference` on the card.
        sig { returns(T.nilable(String)) }
        def preferred; end
        sig { params(_preferred: T.nilable(String)).returns(T.nilable(String)) }
        def preferred=(_preferred); end
        sig { params(preferred: T.nilable(String)).void }
        def initialize(preferred: nil); end
      end
      # City / District / Suburb / Town / Village.
      sig { returns(T.nilable(String)) }
      def address_city; end
      sig { params(_address_city: T.nilable(String)).returns(T.nilable(String)) }
      def address_city=(_address_city); end
      # Billing address country, if provided.
      sig { returns(T.nilable(String)) }
      def address_country; end
      sig { params(_address_country: T.nilable(String)).returns(T.nilable(String)) }
      def address_country=(_address_country); end
      # Address line 1 (Street address / PO Box / Company name).
      sig { returns(T.nilable(String)) }
      def address_line1; end
      sig { params(_address_line1: T.nilable(String)).returns(T.nilable(String)) }
      def address_line1=(_address_line1); end
      # Address line 2 (Apartment / Suite / Unit / Building).
      sig { returns(T.nilable(String)) }
      def address_line2; end
      sig { params(_address_line2: T.nilable(String)).returns(T.nilable(String)) }
      def address_line2=(_address_line2); end
      # State / County / Province / Region.
      sig { returns(T.nilable(String)) }
      def address_state; end
      sig { params(_address_state: T.nilable(String)).returns(T.nilable(String)) }
      def address_state=(_address_state); end
      # ZIP or postal code.
      sig { returns(T.nilable(String)) }
      def address_zip; end
      sig { params(_address_zip: T.nilable(String)).returns(T.nilable(String)) }
      def address_zip=(_address_zip); end
      # Required in order to add the card to an account; in all other cases, this parameter is not used. When added to an account, the card (which must be a debit card) can be used as a transfer destination for funds in this currency.
      sig { returns(T.nilable(String)) }
      def currency; end
      sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
      def currency=(_currency); end
      # Card security code. Highly recommended to always include this value.
      sig { returns(T.nilable(String)) }
      def cvc; end
      sig { params(_cvc: T.nilable(String)).returns(T.nilable(String)) }
      def cvc=(_cvc); end
      # Two-digit number representing the card's expiration month.
      sig { returns(String) }
      def exp_month; end
      sig { params(_exp_month: String).returns(String) }
      def exp_month=(_exp_month); end
      # Two- or four-digit number representing the card's expiration year.
      sig { returns(String) }
      def exp_year; end
      sig { params(_exp_year: String).returns(String) }
      def exp_year=(_exp_year); end
      # Cardholder's full name.
      sig { returns(T.nilable(String)) }
      def name; end
      sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
      def name=(_name); end
      # Contains information about card networks used to process the payment.
      sig { returns(T.nilable(TokenCreateParams::Card::Networks)) }
      def networks; end
      sig {
        params(_networks: T.nilable(TokenCreateParams::Card::Networks)).returns(T.nilable(TokenCreateParams::Card::Networks))
       }
      def networks=(_networks); end
      # The card number, as a string without any separators.
      sig { returns(String) }
      def number; end
      sig { params(_number: String).returns(String) }
      def number=(_number); end
      sig {
        params(address_city: T.nilable(String), address_country: T.nilable(String), address_line1: T.nilable(String), address_line2: T.nilable(String), address_state: T.nilable(String), address_zip: T.nilable(String), currency: T.nilable(String), cvc: T.nilable(String), exp_month: String, exp_year: String, name: T.nilable(String), networks: T.nilable(TokenCreateParams::Card::Networks), number: String).void
       }
      def initialize(
        address_city: nil,
        address_country: nil,
        address_line1: nil,
        address_line2: nil,
        address_state: nil,
        address_zip: nil,
        currency: nil,
        cvc: nil,
        exp_month: nil,
        exp_year: nil,
        name: nil,
        networks: nil,
        number: nil
      ); end
    end
    class CvcUpdate < ::Stripe::RequestParams
      # The CVC value, in string form.
      sig { returns(String) }
      def cvc; end
      sig { params(_cvc: String).returns(String) }
      def cvc=(_cvc); end
      sig { params(cvc: String).void }
      def initialize(cvc: nil); end
    end
    class Person < ::Stripe::RequestParams
      class AdditionalTosAcceptances < ::Stripe::RequestParams
        class Account < ::Stripe::RequestParams
          # The Unix timestamp marking when the account representative accepted the service agreement.
          sig { returns(T.nilable(Integer)) }
          def date; end
          sig { params(_date: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def date=(_date); end
          # The IP address from which the account representative accepted the service agreement.
          sig { returns(T.nilable(String)) }
          def ip; end
          sig { params(_ip: T.nilable(String)).returns(T.nilable(String)) }
          def ip=(_ip); end
          # The user agent of the browser from which the account representative accepted the service agreement.
          sig { returns(T.nilable(String)) }
          def user_agent; end
          sig { params(_user_agent: T.nilable(String)).returns(T.nilable(String)) }
          def user_agent=(_user_agent); end
          sig {
            params(date: T.nilable(Integer), ip: T.nilable(String), user_agent: T.nilable(String)).void
           }
          def initialize(date: nil, ip: nil, user_agent: nil); end
        end
        # Details on the legal guardian's acceptance of the main Stripe service agreement.
        sig { returns(T.nilable(TokenCreateParams::Person::AdditionalTosAcceptances::Account)) }
        def account; end
        sig {
          params(_account: T.nilable(TokenCreateParams::Person::AdditionalTosAcceptances::Account)).returns(T.nilable(TokenCreateParams::Person::AdditionalTosAcceptances::Account))
         }
        def account=(_account); end
        sig {
          params(account: T.nilable(TokenCreateParams::Person::AdditionalTosAcceptances::Account)).void
         }
        def initialize(account: nil); end
      end
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
        # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
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
      class AddressKana < ::Stripe::RequestParams
        # City or ward.
        sig { returns(T.nilable(String)) }
        def city; end
        sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
        def city=(_city); end
        # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        sig { returns(T.nilable(String)) }
        def country; end
        sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
        def country=(_country); end
        # Block or building number.
        sig { returns(T.nilable(String)) }
        def line1; end
        sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
        def line1=(_line1); end
        # Building details.
        sig { returns(T.nilable(String)) }
        def line2; end
        sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
        def line2=(_line2); end
        # Postal code.
        sig { returns(T.nilable(String)) }
        def postal_code; end
        sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
        def postal_code=(_postal_code); end
        # Prefecture.
        sig { returns(T.nilable(String)) }
        def state; end
        sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
        def state=(_state); end
        # Town or cho-me.
        sig { returns(T.nilable(String)) }
        def town; end
        sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
        def town=(_town); end
        sig {
          params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
         }
        def initialize(
          city: nil,
          country: nil,
          line1: nil,
          line2: nil,
          postal_code: nil,
          state: nil,
          town: nil
        ); end
      end
      class AddressKanji < ::Stripe::RequestParams
        # City or ward.
        sig { returns(T.nilable(String)) }
        def city; end
        sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
        def city=(_city); end
        # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        sig { returns(T.nilable(String)) }
        def country; end
        sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
        def country=(_country); end
        # Block or building number.
        sig { returns(T.nilable(String)) }
        def line1; end
        sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
        def line1=(_line1); end
        # Building details.
        sig { returns(T.nilable(String)) }
        def line2; end
        sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
        def line2=(_line2); end
        # Postal code.
        sig { returns(T.nilable(String)) }
        def postal_code; end
        sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
        def postal_code=(_postal_code); end
        # Prefecture.
        sig { returns(T.nilable(String)) }
        def state; end
        sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
        def state=(_state); end
        # Town or cho-me.
        sig { returns(T.nilable(String)) }
        def town; end
        sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
        def town=(_town); end
        sig {
          params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
         }
        def initialize(
          city: nil,
          country: nil,
          line1: nil,
          line2: nil,
          postal_code: nil,
          state: nil,
          town: nil
        ); end
      end
      class Dob < ::Stripe::RequestParams
        # The day of birth, between 1 and 31.
        sig { returns(Integer) }
        def day; end
        sig { params(_day: Integer).returns(Integer) }
        def day=(_day); end
        # The month of birth, between 1 and 12.
        sig { returns(Integer) }
        def month; end
        sig { params(_month: Integer).returns(Integer) }
        def month=(_month); end
        # The four-digit year of birth.
        sig { returns(Integer) }
        def year; end
        sig { params(_year: Integer).returns(Integer) }
        def year=(_year); end
        sig { params(day: Integer, month: Integer, year: Integer).void }
        def initialize(day: nil, month: nil, year: nil); end
      end
      class Documents < ::Stripe::RequestParams
        class CompanyAuthorization < ::Stripe::RequestParams
          # One or more document ids returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `account_requirement`.
          sig { returns(T.nilable(T::Array[String])) }
          def files; end
          sig { params(_files: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
          def files=(_files); end
          sig { params(files: T.nilable(T::Array[String])).void }
          def initialize(files: nil); end
        end
        class Passport < ::Stripe::RequestParams
          # One or more document ids returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `account_requirement`.
          sig { returns(T.nilable(T::Array[String])) }
          def files; end
          sig { params(_files: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
          def files=(_files); end
          sig { params(files: T.nilable(T::Array[String])).void }
          def initialize(files: nil); end
        end
        class Visa < ::Stripe::RequestParams
          # One or more document ids returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `account_requirement`.
          sig { returns(T.nilable(T::Array[String])) }
          def files; end
          sig { params(_files: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
          def files=(_files); end
          sig { params(files: T.nilable(T::Array[String])).void }
          def initialize(files: nil); end
        end
        # One or more documents that demonstrate proof that this person is authorized to represent the company.
        sig { returns(T.nilable(TokenCreateParams::Person::Documents::CompanyAuthorization)) }
        def company_authorization; end
        sig {
          params(_company_authorization: T.nilable(TokenCreateParams::Person::Documents::CompanyAuthorization)).returns(T.nilable(TokenCreateParams::Person::Documents::CompanyAuthorization))
         }
        def company_authorization=(_company_authorization); end
        # One or more documents showing the person's passport page with photo and personal data.
        sig { returns(T.nilable(TokenCreateParams::Person::Documents::Passport)) }
        def passport; end
        sig {
          params(_passport: T.nilable(TokenCreateParams::Person::Documents::Passport)).returns(T.nilable(TokenCreateParams::Person::Documents::Passport))
         }
        def passport=(_passport); end
        # One or more documents showing the person's visa required for living in the country where they are residing.
        sig { returns(T.nilable(TokenCreateParams::Person::Documents::Visa)) }
        def visa; end
        sig {
          params(_visa: T.nilable(TokenCreateParams::Person::Documents::Visa)).returns(T.nilable(TokenCreateParams::Person::Documents::Visa))
         }
        def visa=(_visa); end
        sig {
          params(company_authorization: T.nilable(TokenCreateParams::Person::Documents::CompanyAuthorization), passport: T.nilable(TokenCreateParams::Person::Documents::Passport), visa: T.nilable(TokenCreateParams::Person::Documents::Visa)).void
         }
        def initialize(company_authorization: nil, passport: nil, visa: nil); end
      end
      class RegisteredAddress < ::Stripe::RequestParams
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
        # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
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
      class Relationship < ::Stripe::RequestParams
        # Whether the person is the authorizer of the account's representative.
        sig { returns(T.nilable(T::Boolean)) }
        def authorizer; end
        sig { params(_authorizer: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def authorizer=(_authorizer); end
        # Whether the person is a director of the account's legal entity. Directors are typically members of the governing board of the company, or responsible for ensuring the company meets its regulatory obligations.
        sig { returns(T.nilable(T::Boolean)) }
        def director; end
        sig { params(_director: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def director=(_director); end
        # Whether the person has significant responsibility to control, manage, or direct the organization.
        sig { returns(T.nilable(T::Boolean)) }
        def executive; end
        sig { params(_executive: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def executive=(_executive); end
        # Whether the person is the legal guardian of the account's representative.
        sig { returns(T.nilable(T::Boolean)) }
        def legal_guardian; end
        sig { params(_legal_guardian: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def legal_guardian=(_legal_guardian); end
        # Whether the person is an owner of the account’s legal entity.
        sig { returns(T.nilable(T::Boolean)) }
        def owner; end
        sig { params(_owner: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def owner=(_owner); end
        # The percent owned by the person of the account's legal entity.
        sig { returns(T.nilable(T.any(String, Float))) }
        def percent_ownership; end
        sig {
          params(_percent_ownership: T.nilable(T.any(String, Float))).returns(T.nilable(T.any(String, Float)))
         }
        def percent_ownership=(_percent_ownership); end
        # Whether the person is authorized as the primary representative of the account. This is the person nominated by the business to provide information about themselves, and general information about the account. There can only be one representative at any given time. At the time the account is created, this person should be set to the person responsible for opening the account.
        sig { returns(T.nilable(T::Boolean)) }
        def representative; end
        sig { params(_representative: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def representative=(_representative); end
        # The person's title (e.g., CEO, Support Engineer).
        sig { returns(T.nilable(String)) }
        def title; end
        sig { params(_title: T.nilable(String)).returns(T.nilable(String)) }
        def title=(_title); end
        sig {
          params(authorizer: T.nilable(T::Boolean), director: T.nilable(T::Boolean), executive: T.nilable(T::Boolean), legal_guardian: T.nilable(T::Boolean), owner: T.nilable(T::Boolean), percent_ownership: T.nilable(T.any(String, Float)), representative: T.nilable(T::Boolean), title: T.nilable(String)).void
         }
        def initialize(
          authorizer: nil,
          director: nil,
          executive: nil,
          legal_guardian: nil,
          owner: nil,
          percent_ownership: nil,
          representative: nil,
          title: nil
        ); end
      end
      class UsCfpbData < ::Stripe::RequestParams
        class EthnicityDetails < ::Stripe::RequestParams
          # The persons ethnicity
          sig { returns(T.nilable(T::Array[String])) }
          def ethnicity; end
          sig {
            params(_ethnicity: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
           }
          def ethnicity=(_ethnicity); end
          # Please specify your origin, when other is selected.
          sig { returns(T.nilable(String)) }
          def ethnicity_other; end
          sig { params(_ethnicity_other: T.nilable(String)).returns(T.nilable(String)) }
          def ethnicity_other=(_ethnicity_other); end
          sig {
            params(ethnicity: T.nilable(T::Array[String]), ethnicity_other: T.nilable(String)).void
           }
          def initialize(ethnicity: nil, ethnicity_other: nil); end
        end
        class RaceDetails < ::Stripe::RequestParams
          # The persons race.
          sig { returns(T.nilable(T::Array[String])) }
          def race; end
          sig { params(_race: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
          def race=(_race); end
          # Please specify your race, when other is selected.
          sig { returns(T.nilable(String)) }
          def race_other; end
          sig { params(_race_other: T.nilable(String)).returns(T.nilable(String)) }
          def race_other=(_race_other); end
          sig { params(race: T.nilable(T::Array[String]), race_other: T.nilable(String)).void }
          def initialize(race: nil, race_other: nil); end
        end
        # The persons ethnicity details
        sig { returns(T.nilable(TokenCreateParams::Person::UsCfpbData::EthnicityDetails)) }
        def ethnicity_details; end
        sig {
          params(_ethnicity_details: T.nilable(TokenCreateParams::Person::UsCfpbData::EthnicityDetails)).returns(T.nilable(TokenCreateParams::Person::UsCfpbData::EthnicityDetails))
         }
        def ethnicity_details=(_ethnicity_details); end
        # The persons race details
        sig { returns(T.nilable(TokenCreateParams::Person::UsCfpbData::RaceDetails)) }
        def race_details; end
        sig {
          params(_race_details: T.nilable(TokenCreateParams::Person::UsCfpbData::RaceDetails)).returns(T.nilable(TokenCreateParams::Person::UsCfpbData::RaceDetails))
         }
        def race_details=(_race_details); end
        # The persons self-identified gender
        sig { returns(T.nilable(String)) }
        def self_identified_gender; end
        sig { params(_self_identified_gender: T.nilable(String)).returns(T.nilable(String)) }
        def self_identified_gender=(_self_identified_gender); end
        sig {
          params(ethnicity_details: T.nilable(TokenCreateParams::Person::UsCfpbData::EthnicityDetails), race_details: T.nilable(TokenCreateParams::Person::UsCfpbData::RaceDetails), self_identified_gender: T.nilable(String)).void
         }
        def initialize(ethnicity_details: nil, race_details: nil, self_identified_gender: nil); end
      end
      class Verification < ::Stripe::RequestParams
        class AdditionalDocument < ::Stripe::RequestParams
          # The back of an ID returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `identity_document`. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
          sig { returns(T.nilable(String)) }
          def back; end
          sig { params(_back: T.nilable(String)).returns(T.nilable(String)) }
          def back=(_back); end
          # The front of an ID returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `identity_document`. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
          sig { returns(T.nilable(String)) }
          def front; end
          sig { params(_front: T.nilable(String)).returns(T.nilable(String)) }
          def front=(_front); end
          sig { params(back: T.nilable(String), front: T.nilable(String)).void }
          def initialize(back: nil, front: nil); end
        end
        class Document < ::Stripe::RequestParams
          # The back of an ID returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `identity_document`. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
          sig { returns(T.nilable(String)) }
          def back; end
          sig { params(_back: T.nilable(String)).returns(T.nilable(String)) }
          def back=(_back); end
          # The front of an ID returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `identity_document`. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
          sig { returns(T.nilable(String)) }
          def front; end
          sig { params(_front: T.nilable(String)).returns(T.nilable(String)) }
          def front=(_front); end
          sig { params(back: T.nilable(String), front: T.nilable(String)).void }
          def initialize(back: nil, front: nil); end
        end
        # A document showing address, either a passport, local ID card, or utility bill from a well-known utility company.
        sig { returns(T.nilable(TokenCreateParams::Person::Verification::AdditionalDocument)) }
        def additional_document; end
        sig {
          params(_additional_document: T.nilable(TokenCreateParams::Person::Verification::AdditionalDocument)).returns(T.nilable(TokenCreateParams::Person::Verification::AdditionalDocument))
         }
        def additional_document=(_additional_document); end
        # An identifying document, either a passport or local ID card.
        sig { returns(T.nilable(TokenCreateParams::Person::Verification::Document)) }
        def document; end
        sig {
          params(_document: T.nilable(TokenCreateParams::Person::Verification::Document)).returns(T.nilable(TokenCreateParams::Person::Verification::Document))
         }
        def document=(_document); end
        sig {
          params(additional_document: T.nilable(TokenCreateParams::Person::Verification::AdditionalDocument), document: T.nilable(TokenCreateParams::Person::Verification::Document)).void
         }
        def initialize(additional_document: nil, document: nil); end
      end
      # Details on the legal guardian's or authorizer's acceptance of the required Stripe agreements.
      sig { returns(T.nilable(TokenCreateParams::Person::AdditionalTosAcceptances)) }
      def additional_tos_acceptances; end
      sig {
        params(_additional_tos_acceptances: T.nilable(TokenCreateParams::Person::AdditionalTosAcceptances)).returns(T.nilable(TokenCreateParams::Person::AdditionalTosAcceptances))
       }
      def additional_tos_acceptances=(_additional_tos_acceptances); end
      # The person's address.
      sig { returns(T.nilable(TokenCreateParams::Person::Address)) }
      def address; end
      sig {
        params(_address: T.nilable(TokenCreateParams::Person::Address)).returns(T.nilable(TokenCreateParams::Person::Address))
       }
      def address=(_address); end
      # The Kana variation of the person's address (Japan only).
      sig { returns(T.nilable(TokenCreateParams::Person::AddressKana)) }
      def address_kana; end
      sig {
        params(_address_kana: T.nilable(TokenCreateParams::Person::AddressKana)).returns(T.nilable(TokenCreateParams::Person::AddressKana))
       }
      def address_kana=(_address_kana); end
      # The Kanji variation of the person's address (Japan only).
      sig { returns(T.nilable(TokenCreateParams::Person::AddressKanji)) }
      def address_kanji; end
      sig {
        params(_address_kanji: T.nilable(TokenCreateParams::Person::AddressKanji)).returns(T.nilable(TokenCreateParams::Person::AddressKanji))
       }
      def address_kanji=(_address_kanji); end
      # The person's date of birth.
      sig { returns(T.nilable(T.any(String, TokenCreateParams::Person::Dob))) }
      def dob; end
      sig {
        params(_dob: T.nilable(T.any(String, TokenCreateParams::Person::Dob))).returns(T.nilable(T.any(String, TokenCreateParams::Person::Dob)))
       }
      def dob=(_dob); end
      # Documents that may be submitted to satisfy various informational requests.
      sig { returns(T.nilable(TokenCreateParams::Person::Documents)) }
      def documents; end
      sig {
        params(_documents: T.nilable(TokenCreateParams::Person::Documents)).returns(T.nilable(TokenCreateParams::Person::Documents))
       }
      def documents=(_documents); end
      # The person's email address.
      sig { returns(T.nilable(String)) }
      def email; end
      sig { params(_email: T.nilable(String)).returns(T.nilable(String)) }
      def email=(_email); end
      # The person's first name.
      sig { returns(T.nilable(String)) }
      def first_name; end
      sig { params(_first_name: T.nilable(String)).returns(T.nilable(String)) }
      def first_name=(_first_name); end
      # The Kana variation of the person's first name (Japan only).
      sig { returns(T.nilable(String)) }
      def first_name_kana; end
      sig { params(_first_name_kana: T.nilable(String)).returns(T.nilable(String)) }
      def first_name_kana=(_first_name_kana); end
      # The Kanji variation of the person's first name (Japan only).
      sig { returns(T.nilable(String)) }
      def first_name_kanji; end
      sig { params(_first_name_kanji: T.nilable(String)).returns(T.nilable(String)) }
      def first_name_kanji=(_first_name_kanji); end
      # A list of alternate names or aliases that the person is known by.
      sig { returns(T.nilable(T.any(String, T::Array[String]))) }
      def full_name_aliases; end
      sig {
        params(_full_name_aliases: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
       }
      def full_name_aliases=(_full_name_aliases); end
      # The person's gender (International regulations require either "male" or "female").
      sig { returns(T.nilable(String)) }
      def gender; end
      sig { params(_gender: T.nilable(String)).returns(T.nilable(String)) }
      def gender=(_gender); end
      # The person's ID number, as appropriate for their country. For example, a social security number in the U.S., social insurance number in Canada, etc. Instead of the number itself, you can also provide a [PII token provided by Stripe.js](https://docs.stripe.com/js/tokens/create_token?type=pii).
      sig { returns(T.nilable(String)) }
      def id_number; end
      sig { params(_id_number: T.nilable(String)).returns(T.nilable(String)) }
      def id_number=(_id_number); end
      # The person's secondary ID number, as appropriate for their country, will be used for enhanced verification checks. In Thailand, this would be the laser code found on the back of an ID card. Instead of the number itself, you can also provide a [PII token provided by Stripe.js](https://docs.stripe.com/js/tokens/create_token?type=pii).
      sig { returns(T.nilable(String)) }
      def id_number_secondary; end
      sig { params(_id_number_secondary: T.nilable(String)).returns(T.nilable(String)) }
      def id_number_secondary=(_id_number_secondary); end
      # The person's last name.
      sig { returns(T.nilable(String)) }
      def last_name; end
      sig { params(_last_name: T.nilable(String)).returns(T.nilable(String)) }
      def last_name=(_last_name); end
      # The Kana variation of the person's last name (Japan only).
      sig { returns(T.nilable(String)) }
      def last_name_kana; end
      sig { params(_last_name_kana: T.nilable(String)).returns(T.nilable(String)) }
      def last_name_kana=(_last_name_kana); end
      # The Kanji variation of the person's last name (Japan only).
      sig { returns(T.nilable(String)) }
      def last_name_kanji; end
      sig { params(_last_name_kanji: T.nilable(String)).returns(T.nilable(String)) }
      def last_name_kanji=(_last_name_kanji); end
      # The person's maiden name.
      sig { returns(T.nilable(String)) }
      def maiden_name; end
      sig { params(_maiden_name: T.nilable(String)).returns(T.nilable(String)) }
      def maiden_name=(_maiden_name); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
       }
      def metadata=(_metadata); end
      # The country where the person is a national. Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)), or "XX" if unavailable.
      sig { returns(T.nilable(String)) }
      def nationality; end
      sig { params(_nationality: T.nilable(String)).returns(T.nilable(String)) }
      def nationality=(_nationality); end
      # The person's phone number.
      sig { returns(T.nilable(String)) }
      def phone; end
      sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
      def phone=(_phone); end
      # Indicates if the person or any of their representatives, family members, or other closely related persons, declares that they hold or have held an important public job or function, in any jurisdiction.
      sig { returns(T.nilable(String)) }
      def political_exposure; end
      sig { params(_political_exposure: T.nilable(String)).returns(T.nilable(String)) }
      def political_exposure=(_political_exposure); end
      # The person's registered address.
      sig { returns(T.nilable(TokenCreateParams::Person::RegisteredAddress)) }
      def registered_address; end
      sig {
        params(_registered_address: T.nilable(TokenCreateParams::Person::RegisteredAddress)).returns(T.nilable(TokenCreateParams::Person::RegisteredAddress))
       }
      def registered_address=(_registered_address); end
      # The relationship that this person has with the account's legal entity.
      sig { returns(T.nilable(TokenCreateParams::Person::Relationship)) }
      def relationship; end
      sig {
        params(_relationship: T.nilable(TokenCreateParams::Person::Relationship)).returns(T.nilable(TokenCreateParams::Person::Relationship))
       }
      def relationship=(_relationship); end
      # The last four digits of the person's Social Security number (U.S. only).
      sig { returns(T.nilable(String)) }
      def ssn_last_4; end
      sig { params(_ssn_last_4: T.nilable(String)).returns(T.nilable(String)) }
      def ssn_last_4=(_ssn_last_4); end
      # Demographic data related to the person.
      sig { returns(T.nilable(TokenCreateParams::Person::UsCfpbData)) }
      def us_cfpb_data; end
      sig {
        params(_us_cfpb_data: T.nilable(TokenCreateParams::Person::UsCfpbData)).returns(T.nilable(TokenCreateParams::Person::UsCfpbData))
       }
      def us_cfpb_data=(_us_cfpb_data); end
      # The person's verification status.
      sig { returns(T.nilable(TokenCreateParams::Person::Verification)) }
      def verification; end
      sig {
        params(_verification: T.nilable(TokenCreateParams::Person::Verification)).returns(T.nilable(TokenCreateParams::Person::Verification))
       }
      def verification=(_verification); end
      sig {
        params(additional_tos_acceptances: T.nilable(TokenCreateParams::Person::AdditionalTosAcceptances), address: T.nilable(TokenCreateParams::Person::Address), address_kana: T.nilable(TokenCreateParams::Person::AddressKana), address_kanji: T.nilable(TokenCreateParams::Person::AddressKanji), dob: T.nilable(T.any(String, TokenCreateParams::Person::Dob)), documents: T.nilable(TokenCreateParams::Person::Documents), email: T.nilable(String), first_name: T.nilable(String), first_name_kana: T.nilable(String), first_name_kanji: T.nilable(String), full_name_aliases: T.nilable(T.any(String, T::Array[String])), gender: T.nilable(String), id_number: T.nilable(String), id_number_secondary: T.nilable(String), last_name: T.nilable(String), last_name_kana: T.nilable(String), last_name_kanji: T.nilable(String), maiden_name: T.nilable(String), metadata: T.nilable(T.any(String, T::Hash[String, String])), nationality: T.nilable(String), phone: T.nilable(String), political_exposure: T.nilable(String), registered_address: T.nilable(TokenCreateParams::Person::RegisteredAddress), relationship: T.nilable(TokenCreateParams::Person::Relationship), ssn_last_4: T.nilable(String), us_cfpb_data: T.nilable(TokenCreateParams::Person::UsCfpbData), verification: T.nilable(TokenCreateParams::Person::Verification)).void
       }
      def initialize(
        additional_tos_acceptances: nil,
        address: nil,
        address_kana: nil,
        address_kanji: nil,
        dob: nil,
        documents: nil,
        email: nil,
        first_name: nil,
        first_name_kana: nil,
        first_name_kanji: nil,
        full_name_aliases: nil,
        gender: nil,
        id_number: nil,
        id_number_secondary: nil,
        last_name: nil,
        last_name_kana: nil,
        last_name_kanji: nil,
        maiden_name: nil,
        metadata: nil,
        nationality: nil,
        phone: nil,
        political_exposure: nil,
        registered_address: nil,
        relationship: nil,
        ssn_last_4: nil,
        us_cfpb_data: nil,
        verification: nil
      ); end
    end
    class Pii < ::Stripe::RequestParams
      # The `id_number` for the PII, in string form.
      sig { returns(T.nilable(String)) }
      def id_number; end
      sig { params(_id_number: T.nilable(String)).returns(T.nilable(String)) }
      def id_number=(_id_number); end
      sig { params(id_number: T.nilable(String)).void }
      def initialize(id_number: nil); end
    end
    # Information for the account this token represents.
    sig { returns(T.nilable(TokenCreateParams::Account)) }
    def account; end
    sig {
      params(_account: T.nilable(TokenCreateParams::Account)).returns(T.nilable(TokenCreateParams::Account))
     }
    def account=(_account); end
    # The bank account this token will represent.
    sig { returns(T.nilable(TokenCreateParams::BankAccount)) }
    def bank_account; end
    sig {
      params(_bank_account: T.nilable(TokenCreateParams::BankAccount)).returns(T.nilable(TokenCreateParams::BankAccount))
     }
    def bank_account=(_bank_account); end
    # The card this token will represent. If you also pass in a customer, the card must be the ID of a card belonging to the customer. Otherwise, if you do not pass in a customer, this is a dictionary containing a user's credit card details, with the options described below.
    sig { returns(T.nilable(T.any(TokenCreateParams::Card, String))) }
    def card; end
    sig {
      params(_card: T.nilable(T.any(TokenCreateParams::Card, String))).returns(T.nilable(T.any(TokenCreateParams::Card, String)))
     }
    def card=(_card); end
    # Create a token for the customer, which is owned by the application's account. You can only use this with an [OAuth access token](https://docs.stripe.com/connect/standard-accounts) or [Stripe-Account header](https://docs.stripe.com/connect/authentication). Learn more about [cloning saved payment methods](https://docs.stripe.com/connect/cloning-saved-payment-methods).
    sig { returns(T.nilable(String)) }
    def customer; end
    sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
    def customer=(_customer); end
    # The updated CVC value this token represents.
    sig { returns(T.nilable(TokenCreateParams::CvcUpdate)) }
    def cvc_update; end
    sig {
      params(_cvc_update: T.nilable(TokenCreateParams::CvcUpdate)).returns(T.nilable(TokenCreateParams::CvcUpdate))
     }
    def cvc_update=(_cvc_update); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Information for the person this token represents.
    sig { returns(T.nilable(TokenCreateParams::Person)) }
    def person; end
    sig {
      params(_person: T.nilable(TokenCreateParams::Person)).returns(T.nilable(TokenCreateParams::Person))
     }
    def person=(_person); end
    # The PII this token represents.
    sig { returns(T.nilable(TokenCreateParams::Pii)) }
    def pii; end
    sig {
      params(_pii: T.nilable(TokenCreateParams::Pii)).returns(T.nilable(TokenCreateParams::Pii))
     }
    def pii=(_pii); end
    sig {
      params(account: T.nilable(TokenCreateParams::Account), bank_account: T.nilable(TokenCreateParams::BankAccount), card: T.nilable(T.any(TokenCreateParams::Card, String)), customer: T.nilable(String), cvc_update: T.nilable(TokenCreateParams::CvcUpdate), expand: T.nilable(T::Array[String]), person: T.nilable(TokenCreateParams::Person), pii: T.nilable(TokenCreateParams::Pii)).void
     }
    def initialize(
      account: nil,
      bank_account: nil,
      card: nil,
      customer: nil,
      cvc_update: nil,
      expand: nil,
      person: nil,
      pii: nil
    ); end
  end
end