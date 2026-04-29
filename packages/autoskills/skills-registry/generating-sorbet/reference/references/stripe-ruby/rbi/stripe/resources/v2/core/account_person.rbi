# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      # A Person represents an individual associated with an Account's identity (for example, an owner, director, executive, or representative). Use Persons to provide and update identity information for verification and compliance.
      class AccountPerson < APIResource
        class AdditionalAddress < ::Stripe::StripeObject
          # City, district, suburb, town, or village.
          sig { returns(T.nilable(String)) }
          def city; end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(T.nilable(String)) }
          def country; end
          # Address line 1 (e.g., street, PO Box, or company name).
          sig { returns(T.nilable(String)) }
          def line1; end
          # Address line 2 (e.g., apartment, suite, unit, or building).
          sig { returns(T.nilable(String)) }
          def line2; end
          # ZIP or postal code.
          sig { returns(T.nilable(String)) }
          def postal_code; end
          # Purpose of additional address.
          sig { returns(String) }
          def purpose; end
          # State, county, province, or region.
          sig { returns(T.nilable(String)) }
          def state; end
          # Town or district.
          sig { returns(T.nilable(String)) }
          def town; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class AdditionalName < ::Stripe::StripeObject
          # The individual's full name.
          sig { returns(T.nilable(String)) }
          def full_name; end
          # The individual's first or given name.
          sig { returns(T.nilable(String)) }
          def given_name; end
          # The purpose or type of the additional name.
          sig { returns(String) }
          def purpose; end
          # The individual's last or family name.
          sig { returns(T.nilable(String)) }
          def surname; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class AdditionalTermsOfService < ::Stripe::StripeObject
          class Account < ::Stripe::StripeObject
            # The time when the Account's representative accepted the terms of service. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
            sig { returns(T.nilable(String)) }
            def date; end
            # The IP address from which the Account's representative accepted the terms of service.
            sig { returns(T.nilable(String)) }
            def ip; end
            # The user agent of the browser from which the Account's representative accepted the terms of service.
            sig { returns(T.nilable(String)) }
            def user_agent; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Stripe terms of service agreement.
          sig { returns(T.nilable(Account)) }
          def account; end
          def self.inner_class_types
            @inner_class_types = {account: Account}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Address < ::Stripe::StripeObject
          # City, district, suburb, town, or village.
          sig { returns(T.nilable(String)) }
          def city; end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(T.nilable(String)) }
          def country; end
          # Address line 1 (e.g., street, PO Box, or company name).
          sig { returns(T.nilable(String)) }
          def line1; end
          # Address line 2 (e.g., apartment, suite, unit, or building).
          sig { returns(T.nilable(String)) }
          def line2; end
          # ZIP or postal code.
          sig { returns(T.nilable(String)) }
          def postal_code; end
          # State, county, province, or region.
          sig { returns(T.nilable(String)) }
          def state; end
          # Town or district.
          sig { returns(T.nilable(String)) }
          def town; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class DateOfBirth < ::Stripe::StripeObject
          # The day of birth, between 1 and 31.
          sig { returns(Integer) }
          def day; end
          # The month of birth, between 1 and 12.
          sig { returns(Integer) }
          def month; end
          # The four-digit year of birth.
          sig { returns(Integer) }
          def year; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Documents < ::Stripe::StripeObject
          class CompanyAuthorization < ::Stripe::StripeObject
            # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
            sig { returns(T::Array[String]) }
            def files; end
            # The format of the document. Currently supports `files` only.
            sig { returns(String) }
            def type; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class Passport < ::Stripe::StripeObject
            # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
            sig { returns(T::Array[String]) }
            def files; end
            # The format of the document. Currently supports `files` only.
            sig { returns(String) }
            def type; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class PrimaryVerification < ::Stripe::StripeObject
            class FrontBack < ::Stripe::StripeObject
              # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the back of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
              sig { returns(T.nilable(String)) }
              def back; end
              # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the front of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
              sig { returns(String) }
              def front; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens for the front and back of the verification document.
            sig { returns(FrontBack) }
            def front_back; end
            # The format of the verification document. Currently supports `front_back` only.
            sig { returns(String) }
            def type; end
            def self.inner_class_types
              @inner_class_types = {front_back: FrontBack}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class SecondaryVerification < ::Stripe::StripeObject
            class FrontBack < ::Stripe::StripeObject
              # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the back of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
              sig { returns(T.nilable(String)) }
              def back; end
              # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the front of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
              sig { returns(String) }
              def front; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens for the front and back of the verification document.
            sig { returns(FrontBack) }
            def front_back; end
            # The format of the verification document. Currently supports `front_back` only.
            sig { returns(String) }
            def type; end
            def self.inner_class_types
              @inner_class_types = {front_back: FrontBack}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class Visa < ::Stripe::StripeObject
            # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
            sig { returns(T::Array[String]) }
            def files; end
            # The format of the document. Currently supports `files` only.
            sig { returns(String) }
            def type; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # One or more documents that demonstrate proof that this person is authorized to represent the company.
          sig { returns(T.nilable(CompanyAuthorization)) }
          def company_authorization; end
          # One or more documents showing the person’s passport page with photo and personal data.
          sig { returns(T.nilable(Passport)) }
          def passport; end
          # An identifying document showing the person's name, either a passport or local ID card.
          sig { returns(T.nilable(PrimaryVerification)) }
          def primary_verification; end
          # A document showing address, either a passport, local ID card, or utility bill from a well-known utility company.
          sig { returns(T.nilable(SecondaryVerification)) }
          def secondary_verification; end
          # One or more documents showing the person’s visa required for living in the country where they are residing.
          sig { returns(T.nilable(Visa)) }
          def visa; end
          def self.inner_class_types
            @inner_class_types = {
              company_authorization: CompanyAuthorization,
              passport: Passport,
              primary_verification: PrimaryVerification,
              secondary_verification: SecondaryVerification,
              visa: Visa,
            }
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class IdNumber < ::Stripe::StripeObject
          # The ID number type of an individual.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Relationship < ::Stripe::StripeObject
          # Whether the individual is an authorizer of the Account's identity.
          sig { returns(T.nilable(T::Boolean)) }
          def authorizer; end
          # Whether the individual is a director of the Account's identity. Directors are typically members of the governing board of the company or are responsible for making sure that the company meets its regulatory obligations.
          sig { returns(T.nilable(T::Boolean)) }
          def director; end
          # Whether the individual has significant responsibility to control, manage, or direct the organization.
          sig { returns(T.nilable(T::Boolean)) }
          def executive; end
          # Whether the individual is the legal guardian of the Account's representative.
          sig { returns(T.nilable(T::Boolean)) }
          def legal_guardian; end
          # Whether the individual is an owner of the Account's identity.
          sig { returns(T.nilable(T::Boolean)) }
          def owner; end
          # The percentage of the Account's identity that the individual owns.
          sig { returns(T.nilable(String)) }
          def percent_ownership; end
          # Whether the individual is authorized as the primary representative of the Account. This is the person nominated by the business to provide information about themselves, and general information about the account. There can only be one representative at any given time. At the time the account is created, this person should be set to the person responsible for opening the account.
          sig { returns(T.nilable(T::Boolean)) }
          def representative; end
          # The individual's title (e.g., CEO, Support Engineer).
          sig { returns(T.nilable(String)) }
          def title; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class ScriptAddresses < ::Stripe::StripeObject
          class Kana < ::Stripe::StripeObject
            # City, district, suburb, town, or village.
            sig { returns(T.nilable(String)) }
            def city; end
            # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
            sig { returns(T.nilable(String)) }
            def country; end
            # Address line 1 (e.g., street, PO Box, or company name).
            sig { returns(T.nilable(String)) }
            def line1; end
            # Address line 2 (e.g., apartment, suite, unit, or building).
            sig { returns(T.nilable(String)) }
            def line2; end
            # ZIP or postal code.
            sig { returns(T.nilable(String)) }
            def postal_code; end
            # State, county, province, or region.
            sig { returns(T.nilable(String)) }
            def state; end
            # Town or district.
            sig { returns(T.nilable(String)) }
            def town; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class Kanji < ::Stripe::StripeObject
            # City, district, suburb, town, or village.
            sig { returns(T.nilable(String)) }
            def city; end
            # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
            sig { returns(T.nilable(String)) }
            def country; end
            # Address line 1 (e.g., street, PO Box, or company name).
            sig { returns(T.nilable(String)) }
            def line1; end
            # Address line 2 (e.g., apartment, suite, unit, or building).
            sig { returns(T.nilable(String)) }
            def line2; end
            # ZIP or postal code.
            sig { returns(T.nilable(String)) }
            def postal_code; end
            # State, county, province, or region.
            sig { returns(T.nilable(String)) }
            def state; end
            # Town or district.
            sig { returns(T.nilable(String)) }
            def town; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Kana Address.
          sig { returns(T.nilable(Kana)) }
          def kana; end
          # Kanji Address.
          sig { returns(T.nilable(Kanji)) }
          def kanji; end
          def self.inner_class_types
            @inner_class_types = {kana: Kana, kanji: Kanji}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class ScriptNames < ::Stripe::StripeObject
          class Kana < ::Stripe::StripeObject
            # The person's first or given name.
            sig { returns(T.nilable(String)) }
            def given_name; end
            # The person's last or family name.
            sig { returns(T.nilable(String)) }
            def surname; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class Kanji < ::Stripe::StripeObject
            # The person's first or given name.
            sig { returns(T.nilable(String)) }
            def given_name; end
            # The person's last or family name.
            sig { returns(T.nilable(String)) }
            def surname; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Persons name in kana script.
          sig { returns(T.nilable(Kana)) }
          def kana; end
          # Persons name in kanji script.
          sig { returns(T.nilable(Kanji)) }
          def kanji; end
          def self.inner_class_types
            @inner_class_types = {kana: Kana, kanji: Kanji}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The account ID which the individual belongs to.
        sig { returns(String) }
        def account; end
        # Additional addresses associated with the person.
        sig { returns(T.nilable(T::Array[AdditionalAddress])) }
        def additional_addresses; end
        # Additional names (e.g. aliases) associated with the person.
        sig { returns(T.nilable(T::Array[AdditionalName])) }
        def additional_names; end
        # Attestations of accepted terms of service agreements.
        sig { returns(T.nilable(AdditionalTermsOfService)) }
        def additional_terms_of_service; end
        # The person's residential address.
        sig { returns(T.nilable(Address)) }
        def address; end
        # Time at which the object was created. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
        sig { returns(String) }
        def created; end
        # The person's date of birth.
        sig { returns(T.nilable(DateOfBirth)) }
        def date_of_birth; end
        # Documents that may be submitted to satisfy various informational requests.
        sig { returns(T.nilable(Documents)) }
        def documents; end
        # The person's email address.
        sig { returns(T.nilable(String)) }
        def email; end
        # The person's first name.
        sig { returns(T.nilable(String)) }
        def given_name; end
        # Unique identifier for the Person.
        sig { returns(String) }
        def id; end
        # The identification numbers (e.g., SSN) associated with the person.
        sig { returns(T.nilable(T::Array[IdNumber])) }
        def id_numbers; end
        # The person's gender (International regulations require either "male" or "female").
        sig { returns(T.nilable(String)) }
        def legal_gender; end
        # Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        sig { returns(T.nilable(T::Hash[String, String])) }
        def metadata; end
        # The countries where the person is a national. Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        sig { returns(T.nilable(T::Array[String])) }
        def nationalities; end
        # String representing the object's type. Objects of the same type share the same value of the object field.
        sig { returns(String) }
        def object; end
        # The person's phone number.
        sig { returns(T.nilable(String)) }
        def phone; end
        # The person's political exposure.
        sig { returns(T.nilable(String)) }
        def political_exposure; end
        # The relationship that this person has with the Account's business or legal entity.
        sig { returns(T.nilable(Relationship)) }
        def relationship; end
        # The script addresses (e.g., non-Latin characters) associated with the person.
        sig { returns(T.nilable(ScriptAddresses)) }
        def script_addresses; end
        # The script names (e.g. non-Latin characters) associated with the person.
        sig { returns(T.nilable(ScriptNames)) }
        def script_names; end
        # The person's last name.
        sig { returns(T.nilable(String)) }
        def surname; end
        # Time at which the object was last updated. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
        sig { returns(String) }
        def updated; end
        # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        sig { returns(T::Boolean) }
        def livemode; end
      end
    end
  end
end