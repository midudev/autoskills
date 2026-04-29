# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      module Accounts
        class PersonTokenCreateParams < ::Stripe::RequestParams
          class AdditionalAddress < ::Stripe::RequestParams
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
            # Address line 1 (e.g., street, PO Box, or company name).
            sig { returns(T.nilable(String)) }
            def line1; end
            sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
            def line1=(_line1); end
            # Address line 2 (e.g., apartment, suite, unit, or building).
            sig { returns(T.nilable(String)) }
            def line2; end
            sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
            def line2=(_line2); end
            # ZIP or postal code.
            sig { returns(T.nilable(String)) }
            def postal_code; end
            sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
            def postal_code=(_postal_code); end
            # Purpose of additional address.
            sig { returns(String) }
            def purpose; end
            sig { params(_purpose: String).returns(String) }
            def purpose=(_purpose); end
            # State, county, province, or region.
            sig { returns(T.nilable(String)) }
            def state; end
            sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
            def state=(_state); end
            # Town or district.
            sig { returns(T.nilable(String)) }
            def town; end
            sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
            def town=(_town); end
            sig {
              params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), purpose: String, state: T.nilable(String), town: T.nilable(String)).void
             }
            def initialize(
              city: nil,
              country: nil,
              line1: nil,
              line2: nil,
              postal_code: nil,
              purpose: nil,
              state: nil,
              town: nil
            ); end
          end
          class AdditionalName < ::Stripe::RequestParams
            # The person's full name.
            sig { returns(T.nilable(String)) }
            def full_name; end
            sig { params(_full_name: T.nilable(String)).returns(T.nilable(String)) }
            def full_name=(_full_name); end
            # The person's first or given name.
            sig { returns(T.nilable(String)) }
            def given_name; end
            sig { params(_given_name: T.nilable(String)).returns(T.nilable(String)) }
            def given_name=(_given_name); end
            # The purpose or type of the additional name.
            sig { returns(String) }
            def purpose; end
            sig { params(_purpose: String).returns(String) }
            def purpose=(_purpose); end
            # The person's last or family name.
            sig { returns(T.nilable(String)) }
            def surname; end
            sig { params(_surname: T.nilable(String)).returns(T.nilable(String)) }
            def surname=(_surname); end
            sig {
              params(full_name: T.nilable(String), given_name: T.nilable(String), purpose: String, surname: T.nilable(String)).void
             }
            def initialize(full_name: nil, given_name: nil, purpose: nil, surname: nil); end
          end
          class AdditionalTermsOfService < ::Stripe::RequestParams
            class Account < ::Stripe::RequestParams
              # The boolean value indicating if the terms of service have been accepted.
              sig { returns(T.nilable(T::Boolean)) }
              def shown_and_accepted; end
              sig {
                params(_shown_and_accepted: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean))
               }
              def shown_and_accepted=(_shown_and_accepted); end
              sig { params(shown_and_accepted: T.nilable(T::Boolean)).void }
              def initialize(shown_and_accepted: nil); end
            end
            # Details on the Person's acceptance of the [Stripe Services Agreement]; IP, date, and User Agent are expanded by Stripe.
            sig {
              returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::AdditionalTermsOfService::Account))
             }
            def account; end
            sig {
              params(_account: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::AdditionalTermsOfService::Account)).returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::AdditionalTermsOfService::Account))
             }
            def account=(_account); end
            sig {
              params(account: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::AdditionalTermsOfService::Account)).void
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
            # Address line 1 (e.g., street, PO Box, or company name).
            sig { returns(T.nilable(String)) }
            def line1; end
            sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
            def line1=(_line1); end
            # Address line 2 (e.g., apartment, suite, unit, or building).
            sig { returns(T.nilable(String)) }
            def line2; end
            sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
            def line2=(_line2); end
            # ZIP or postal code.
            sig { returns(T.nilable(String)) }
            def postal_code; end
            sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
            def postal_code=(_postal_code); end
            # State, county, province, or region.
            sig { returns(T.nilable(String)) }
            def state; end
            sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
            def state=(_state); end
            # Town or district.
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
          class DateOfBirth < ::Stripe::RequestParams
            # The day of the birth.
            sig { returns(Integer) }
            def day; end
            sig { params(_day: Integer).returns(Integer) }
            def day=(_day); end
            # The month of birth.
            sig { returns(Integer) }
            def month; end
            sig { params(_month: Integer).returns(Integer) }
            def month=(_month); end
            # The year of birth.
            sig { returns(Integer) }
            def year; end
            sig { params(_year: Integer).returns(Integer) }
            def year=(_year); end
            sig { params(day: Integer, month: Integer, year: Integer).void }
            def initialize(day: nil, month: nil, year: nil); end
          end
          class Documents < ::Stripe::RequestParams
            class CompanyAuthorization < ::Stripe::RequestParams
              # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
              sig { returns(T::Array[String]) }
              def files; end
              sig { params(_files: T::Array[String]).returns(T::Array[String]) }
              def files=(_files); end
              # The format of the document. Currently supports `files` only.
              sig { returns(String) }
              def type; end
              sig { params(_type: String).returns(String) }
              def type=(_type); end
              sig { params(files: T::Array[String], type: String).void }
              def initialize(files: nil, type: nil); end
            end
            class Passport < ::Stripe::RequestParams
              # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
              sig { returns(T::Array[String]) }
              def files; end
              sig { params(_files: T::Array[String]).returns(T::Array[String]) }
              def files=(_files); end
              # The format of the document. Currently supports `files` only.
              sig { returns(String) }
              def type; end
              sig { params(_type: String).returns(String) }
              def type=(_type); end
              sig { params(files: T::Array[String], type: String).void }
              def initialize(files: nil, type: nil); end
            end
            class PrimaryVerification < ::Stripe::RequestParams
              class FrontBack < ::Stripe::RequestParams
                # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the back of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                sig { returns(T.nilable(String)) }
                def back; end
                sig { params(_back: T.nilable(String)).returns(T.nilable(String)) }
                def back=(_back); end
                # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the front of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                sig { returns(T.nilable(String)) }
                def front; end
                sig { params(_front: T.nilable(String)).returns(T.nilable(String)) }
                def front=(_front); end
                sig { params(back: T.nilable(String), front: T.nilable(String)).void }
                def initialize(back: nil, front: nil); end
              end
              # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens referring to each side of the document.
              sig {
                returns(V2::Core::Accounts::PersonTokenCreateParams::Documents::PrimaryVerification::FrontBack)
               }
              def front_back; end
              sig {
                params(_front_back: V2::Core::Accounts::PersonTokenCreateParams::Documents::PrimaryVerification::FrontBack).returns(V2::Core::Accounts::PersonTokenCreateParams::Documents::PrimaryVerification::FrontBack)
               }
              def front_back=(_front_back); end
              # The format of the verification document. Currently supports `front_back` only.
              sig { returns(String) }
              def type; end
              sig { params(_type: String).returns(String) }
              def type=(_type); end
              sig {
                params(front_back: V2::Core::Accounts::PersonTokenCreateParams::Documents::PrimaryVerification::FrontBack, type: String).void
               }
              def initialize(front_back: nil, type: nil); end
            end
            class SecondaryVerification < ::Stripe::RequestParams
              class FrontBack < ::Stripe::RequestParams
                # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the back of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                sig { returns(T.nilable(String)) }
                def back; end
                sig { params(_back: T.nilable(String)).returns(T.nilable(String)) }
                def back=(_back); end
                # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the front of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                sig { returns(T.nilable(String)) }
                def front; end
                sig { params(_front: T.nilable(String)).returns(T.nilable(String)) }
                def front=(_front); end
                sig { params(back: T.nilable(String), front: T.nilable(String)).void }
                def initialize(back: nil, front: nil); end
              end
              # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens referring to each side of the document.
              sig {
                returns(V2::Core::Accounts::PersonTokenCreateParams::Documents::SecondaryVerification::FrontBack)
               }
              def front_back; end
              sig {
                params(_front_back: V2::Core::Accounts::PersonTokenCreateParams::Documents::SecondaryVerification::FrontBack).returns(V2::Core::Accounts::PersonTokenCreateParams::Documents::SecondaryVerification::FrontBack)
               }
              def front_back=(_front_back); end
              # The format of the verification document. Currently supports `front_back` only.
              sig { returns(String) }
              def type; end
              sig { params(_type: String).returns(String) }
              def type=(_type); end
              sig {
                params(front_back: V2::Core::Accounts::PersonTokenCreateParams::Documents::SecondaryVerification::FrontBack, type: String).void
               }
              def initialize(front_back: nil, type: nil); end
            end
            class Visa < ::Stripe::RequestParams
              # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
              sig { returns(T::Array[String]) }
              def files; end
              sig { params(_files: T::Array[String]).returns(T::Array[String]) }
              def files=(_files); end
              # The format of the document. Currently supports `files` only.
              sig { returns(String) }
              def type; end
              sig { params(_type: String).returns(String) }
              def type=(_type); end
              sig { params(files: T::Array[String], type: String).void }
              def initialize(files: nil, type: nil); end
            end
            # One or more documents that demonstrate proof that this person is authorized to represent the company.
            sig {
              returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::CompanyAuthorization))
             }
            def company_authorization; end
            sig {
              params(_company_authorization: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::CompanyAuthorization)).returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::CompanyAuthorization))
             }
            def company_authorization=(_company_authorization); end
            # One or more documents showing the person’s passport page with photo and personal data.
            sig {
              returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::Passport))
             }
            def passport; end
            sig {
              params(_passport: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::Passport)).returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::Passport))
             }
            def passport=(_passport); end
            # An identifying document showing the person's name, either a passport or local ID card.
            sig {
              returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::PrimaryVerification))
             }
            def primary_verification; end
            sig {
              params(_primary_verification: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::PrimaryVerification)).returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::PrimaryVerification))
             }
            def primary_verification=(_primary_verification); end
            # A document showing address, either a passport, local ID card, or utility bill from a well-known utility company.
            sig {
              returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::SecondaryVerification))
             }
            def secondary_verification; end
            sig {
              params(_secondary_verification: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::SecondaryVerification)).returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::SecondaryVerification))
             }
            def secondary_verification=(_secondary_verification); end
            # One or more documents showing the person’s visa required for living in the country where they are residing.
            sig { returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::Visa)) }
            def visa; end
            sig {
              params(_visa: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::Visa)).returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::Visa))
             }
            def visa=(_visa); end
            sig {
              params(company_authorization: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::CompanyAuthorization), passport: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::Passport), primary_verification: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::PrimaryVerification), secondary_verification: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::SecondaryVerification), visa: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents::Visa)).void
             }
            def initialize(
              company_authorization: nil,
              passport: nil,
              primary_verification: nil,
              secondary_verification: nil,
              visa: nil
            ); end
          end
          class IdNumber < ::Stripe::RequestParams
            # The ID number type of an individual.
            sig { returns(String) }
            def type; end
            sig { params(_type: String).returns(String) }
            def type=(_type); end
            # The value of the ID number.
            sig { returns(String) }
            def value; end
            sig { params(_value: String).returns(String) }
            def value=(_value); end
            sig { params(type: String, value: String).void }
            def initialize(type: nil, value: nil); end
          end
          class Relationship < ::Stripe::RequestParams
            # Whether the individual is an authorizer of the Account's identity.
            sig { returns(T.nilable(T::Boolean)) }
            def authorizer; end
            sig { params(_authorizer: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
            def authorizer=(_authorizer); end
            # Indicates whether the person is a director of the associated legal entity.
            sig { returns(T.nilable(T::Boolean)) }
            def director; end
            sig { params(_director: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
            def director=(_director); end
            # Indicates whether the person is an executive of the associated legal entity.
            sig { returns(T.nilable(T::Boolean)) }
            def executive; end
            sig { params(_executive: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
            def executive=(_executive); end
            # Indicates whether the person is a legal guardian of the associated legal entity.
            sig { returns(T.nilable(T::Boolean)) }
            def legal_guardian; end
            sig { params(_legal_guardian: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
            def legal_guardian=(_legal_guardian); end
            # Indicates whether the person is an owner of the associated legal entity.
            sig { returns(T.nilable(T::Boolean)) }
            def owner; end
            sig { params(_owner: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
            def owner=(_owner); end
            # The percentage of ownership the person has in the associated legal entity.
            sig { returns(T.nilable(String)) }
            def percent_ownership; end
            sig { params(_percent_ownership: T.nilable(String)).returns(T.nilable(String)) }
            def percent_ownership=(_percent_ownership); end
            # Indicates whether the person is a representative of the associated legal entity.
            sig { returns(T.nilable(T::Boolean)) }
            def representative; end
            sig { params(_representative: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
            def representative=(_representative); end
            # The title or position the person holds in the associated legal entity.
            sig { returns(T.nilable(String)) }
            def title; end
            sig { params(_title: T.nilable(String)).returns(T.nilable(String)) }
            def title=(_title); end
            sig {
              params(authorizer: T.nilable(T::Boolean), director: T.nilable(T::Boolean), executive: T.nilable(T::Boolean), legal_guardian: T.nilable(T::Boolean), owner: T.nilable(T::Boolean), percent_ownership: T.nilable(String), representative: T.nilable(T::Boolean), title: T.nilable(String)).void
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
          class ScriptAddresses < ::Stripe::RequestParams
            class Kana < ::Stripe::RequestParams
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
              # Address line 1 (e.g., street, PO Box, or company name).
              sig { returns(T.nilable(String)) }
              def line1; end
              sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
              def line1=(_line1); end
              # Address line 2 (e.g., apartment, suite, unit, or building).
              sig { returns(T.nilable(String)) }
              def line2; end
              sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
              def line2=(_line2); end
              # ZIP or postal code.
              sig { returns(T.nilable(String)) }
              def postal_code; end
              sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
              def postal_code=(_postal_code); end
              # State, county, province, or region.
              sig { returns(T.nilable(String)) }
              def state; end
              sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
              def state=(_state); end
              # Town or district.
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
            class Kanji < ::Stripe::RequestParams
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
              # Address line 1 (e.g., street, PO Box, or company name).
              sig { returns(T.nilable(String)) }
              def line1; end
              sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
              def line1=(_line1); end
              # Address line 2 (e.g., apartment, suite, unit, or building).
              sig { returns(T.nilable(String)) }
              def line2; end
              sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
              def line2=(_line2); end
              # ZIP or postal code.
              sig { returns(T.nilable(String)) }
              def postal_code; end
              sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
              def postal_code=(_postal_code); end
              # State, county, province, or region.
              sig { returns(T.nilable(String)) }
              def state; end
              sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
              def state=(_state); end
              # Town or district.
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
            # Kana Address.
            sig {
              returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptAddresses::Kana))
             }
            def kana; end
            sig {
              params(_kana: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptAddresses::Kana)).returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptAddresses::Kana))
             }
            def kana=(_kana); end
            # Kanji Address.
            sig {
              returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptAddresses::Kanji))
             }
            def kanji; end
            sig {
              params(_kanji: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptAddresses::Kanji)).returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptAddresses::Kanji))
             }
            def kanji=(_kanji); end
            sig {
              params(kana: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptAddresses::Kana), kanji: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptAddresses::Kanji)).void
             }
            def initialize(kana: nil, kanji: nil); end
          end
          class ScriptNames < ::Stripe::RequestParams
            class Kana < ::Stripe::RequestParams
              # The person's first or given name.
              sig { returns(T.nilable(String)) }
              def given_name; end
              sig { params(_given_name: T.nilable(String)).returns(T.nilable(String)) }
              def given_name=(_given_name); end
              # The person's last or family name.
              sig { returns(T.nilable(String)) }
              def surname; end
              sig { params(_surname: T.nilable(String)).returns(T.nilable(String)) }
              def surname=(_surname); end
              sig { params(given_name: T.nilable(String), surname: T.nilable(String)).void }
              def initialize(given_name: nil, surname: nil); end
            end
            class Kanji < ::Stripe::RequestParams
              # The person's first or given name.
              sig { returns(T.nilable(String)) }
              def given_name; end
              sig { params(_given_name: T.nilable(String)).returns(T.nilable(String)) }
              def given_name=(_given_name); end
              # The person's last or family name.
              sig { returns(T.nilable(String)) }
              def surname; end
              sig { params(_surname: T.nilable(String)).returns(T.nilable(String)) }
              def surname=(_surname); end
              sig { params(given_name: T.nilable(String), surname: T.nilable(String)).void }
              def initialize(given_name: nil, surname: nil); end
            end
            # Persons name in kana script.
            sig {
              returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptNames::Kana))
             }
            def kana; end
            sig {
              params(_kana: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptNames::Kana)).returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptNames::Kana))
             }
            def kana=(_kana); end
            # Persons name in kanji script.
            sig {
              returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptNames::Kanji))
             }
            def kanji; end
            sig {
              params(_kanji: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptNames::Kanji)).returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptNames::Kanji))
             }
            def kanji=(_kanji); end
            sig {
              params(kana: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptNames::Kana), kanji: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptNames::Kanji)).void
             }
            def initialize(kana: nil, kanji: nil); end
          end
          # Additional addresses associated with the person.
          sig {
            returns(T.nilable(T::Array[V2::Core::Accounts::PersonTokenCreateParams::AdditionalAddress]))
           }
          def additional_addresses; end
          sig {
            params(_additional_addresses: T.nilable(T::Array[V2::Core::Accounts::PersonTokenCreateParams::AdditionalAddress])).returns(T.nilable(T::Array[V2::Core::Accounts::PersonTokenCreateParams::AdditionalAddress]))
           }
          def additional_addresses=(_additional_addresses); end
          # Additional names (e.g. aliases) associated with the person.
          sig {
            returns(T.nilable(T::Array[V2::Core::Accounts::PersonTokenCreateParams::AdditionalName]))
           }
          def additional_names; end
          sig {
            params(_additional_names: T.nilable(T::Array[V2::Core::Accounts::PersonTokenCreateParams::AdditionalName])).returns(T.nilable(T::Array[V2::Core::Accounts::PersonTokenCreateParams::AdditionalName]))
           }
          def additional_names=(_additional_names); end
          # Attestations of accepted terms of service agreements.
          sig {
            returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::AdditionalTermsOfService))
           }
          def additional_terms_of_service; end
          sig {
            params(_additional_terms_of_service: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::AdditionalTermsOfService)).returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::AdditionalTermsOfService))
           }
          def additional_terms_of_service=(_additional_terms_of_service); end
          # The person's residential address.
          sig { returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Address)) }
          def address; end
          sig {
            params(_address: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Address)).returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Address))
           }
          def address=(_address); end
          # The person's date of birth.
          sig { returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::DateOfBirth)) }
          def date_of_birth; end
          sig {
            params(_date_of_birth: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::DateOfBirth)).returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::DateOfBirth))
           }
          def date_of_birth=(_date_of_birth); end
          # Documents that may be submitted to satisfy various informational requests.
          sig { returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents)) }
          def documents; end
          sig {
            params(_documents: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents)).returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents))
           }
          def documents=(_documents); end
          # Email.
          sig { returns(T.nilable(String)) }
          def email; end
          sig { params(_email: T.nilable(String)).returns(T.nilable(String)) }
          def email=(_email); end
          # The person's first name.
          sig { returns(T.nilable(String)) }
          def given_name; end
          sig { params(_given_name: T.nilable(String)).returns(T.nilable(String)) }
          def given_name=(_given_name); end
          # The identification numbers (e.g., SSN) associated with the person.
          sig {
            returns(T.nilable(T::Array[V2::Core::Accounts::PersonTokenCreateParams::IdNumber]))
           }
          def id_numbers; end
          sig {
            params(_id_numbers: T.nilable(T::Array[V2::Core::Accounts::PersonTokenCreateParams::IdNumber])).returns(T.nilable(T::Array[V2::Core::Accounts::PersonTokenCreateParams::IdNumber]))
           }
          def id_numbers=(_id_numbers); end
          # The person's gender (International regulations require either "male" or "female").
          sig { returns(T.nilable(String)) }
          def legal_gender; end
          sig { params(_legal_gender: T.nilable(String)).returns(T.nilable(String)) }
          def legal_gender=(_legal_gender); end
          # Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
          sig { returns(T.nilable(T::Hash[String, T.nilable(String)])) }
          def metadata; end
          sig {
            params(_metadata: T.nilable(T::Hash[String, T.nilable(String)])).returns(T.nilable(T::Hash[String, T.nilable(String)]))
           }
          def metadata=(_metadata); end
          # The nationalities (countries) this person is associated with.
          sig { returns(T.nilable(T::Array[String])) }
          def nationalities; end
          sig {
            params(_nationalities: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
           }
          def nationalities=(_nationalities); end
          # The phone number for this person.
          sig { returns(T.nilable(String)) }
          def phone; end
          sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
          def phone=(_phone); end
          # The person's political exposure.
          sig { returns(T.nilable(String)) }
          def political_exposure; end
          sig { params(_political_exposure: T.nilable(String)).returns(T.nilable(String)) }
          def political_exposure=(_political_exposure); end
          # The relationship that this person has with the Account's business or legal entity.
          sig { returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Relationship)) }
          def relationship; end
          sig {
            params(_relationship: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Relationship)).returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Relationship))
           }
          def relationship=(_relationship); end
          # The script addresses (e.g., non-Latin characters) associated with the person.
          sig { returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptAddresses)) }
          def script_addresses; end
          sig {
            params(_script_addresses: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptAddresses)).returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptAddresses))
           }
          def script_addresses=(_script_addresses); end
          # The script names (e.g. non-Latin characters) associated with the person.
          sig { returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptNames)) }
          def script_names; end
          sig {
            params(_script_names: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptNames)).returns(T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptNames))
           }
          def script_names=(_script_names); end
          # The person's last name.
          sig { returns(T.nilable(String)) }
          def surname; end
          sig { params(_surname: T.nilable(String)).returns(T.nilable(String)) }
          def surname=(_surname); end
          sig {
            params(additional_addresses: T.nilable(T::Array[V2::Core::Accounts::PersonTokenCreateParams::AdditionalAddress]), additional_names: T.nilable(T::Array[V2::Core::Accounts::PersonTokenCreateParams::AdditionalName]), additional_terms_of_service: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::AdditionalTermsOfService), address: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Address), date_of_birth: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::DateOfBirth), documents: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Documents), email: T.nilable(String), given_name: T.nilable(String), id_numbers: T.nilable(T::Array[V2::Core::Accounts::PersonTokenCreateParams::IdNumber]), legal_gender: T.nilable(String), metadata: T.nilable(T::Hash[String, T.nilable(String)]), nationalities: T.nilable(T::Array[String]), phone: T.nilable(String), political_exposure: T.nilable(String), relationship: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::Relationship), script_addresses: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptAddresses), script_names: T.nilable(V2::Core::Accounts::PersonTokenCreateParams::ScriptNames), surname: T.nilable(String)).void
           }
          def initialize(
            additional_addresses: nil,
            additional_names: nil,
            additional_terms_of_service: nil,
            address: nil,
            date_of_birth: nil,
            documents: nil,
            email: nil,
            given_name: nil,
            id_numbers: nil,
            legal_gender: nil,
            metadata: nil,
            nationalities: nil,
            phone: nil,
            political_exposure: nil,
            relationship: nil,
            script_addresses: nil,
            script_names: nil,
            surname: nil
          ); end
        end
      end
    end
  end
end