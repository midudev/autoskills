# File generated from our OpenAPI spec
# frozen_string_literal: true

module Stripe
  module V2
    module Core
      # A Person represents an individual associated with an Account's identity (for example, an owner, director, executive, or representative). Use Persons to provide and update identity information for verification and compliance.
      class AccountPerson < APIResource
        OBJECT_NAME = "v2.core.account_person"
        def self.object_name
          "v2.core.account_person"
        end

        class AdditionalAddress < ::Stripe::StripeObject
          # City, district, suburb, town, or village.
          attr_reader :city
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          attr_reader :country
          # Address line 1 (e.g., street, PO Box, or company name).
          attr_reader :line1
          # Address line 2 (e.g., apartment, suite, unit, or building).
          attr_reader :line2
          # ZIP or postal code.
          attr_reader :postal_code
          # Purpose of additional address.
          attr_reader :purpose
          # State, county, province, or region.
          attr_reader :state
          # Town or district.
          attr_reader :town

          def self.inner_class_types
            @inner_class_types = {}
          end

          def self.field_remappings
            @field_remappings = {}
          end
        end

        class AdditionalName < ::Stripe::StripeObject
          # The individual's full name.
          attr_reader :full_name
          # The individual's first or given name.
          attr_reader :given_name
          # The purpose or type of the additional name.
          attr_reader :purpose
          # The individual's last or family name.
          attr_reader :surname

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
            attr_reader :date
            # The IP address from which the Account's representative accepted the terms of service.
            attr_reader :ip
            # The user agent of the browser from which the Account's representative accepted the terms of service.
            attr_reader :user_agent

            def self.inner_class_types
              @inner_class_types = {}
            end

            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Stripe terms of service agreement.
          attr_reader :account

          def self.inner_class_types
            @inner_class_types = { account: Account }
          end

          def self.field_remappings
            @field_remappings = {}
          end
        end

        class Address < ::Stripe::StripeObject
          # City, district, suburb, town, or village.
          attr_reader :city
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          attr_reader :country
          # Address line 1 (e.g., street, PO Box, or company name).
          attr_reader :line1
          # Address line 2 (e.g., apartment, suite, unit, or building).
          attr_reader :line2
          # ZIP or postal code.
          attr_reader :postal_code
          # State, county, province, or region.
          attr_reader :state
          # Town or district.
          attr_reader :town

          def self.inner_class_types
            @inner_class_types = {}
          end

          def self.field_remappings
            @field_remappings = {}
          end
        end

        class DateOfBirth < ::Stripe::StripeObject
          # The day of birth, between 1 and 31.
          attr_reader :day
          # The month of birth, between 1 and 12.
          attr_reader :month
          # The four-digit year of birth.
          attr_reader :year

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
            attr_reader :files
            # The format of the document. Currently supports `files` only.
            attr_reader :type

            def self.inner_class_types
              @inner_class_types = {}
            end

            def self.field_remappings
              @field_remappings = {}
            end
          end

          class Passport < ::Stripe::StripeObject
            # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
            attr_reader :files
            # The format of the document. Currently supports `files` only.
            attr_reader :type

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
              attr_reader :back
              # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the front of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
              attr_reader :front

              def self.inner_class_types
                @inner_class_types = {}
              end

              def self.field_remappings
                @field_remappings = {}
              end
            end
            # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens for the front and back of the verification document.
            attr_reader :front_back
            # The format of the verification document. Currently supports `front_back` only.
            attr_reader :type

            def self.inner_class_types
              @inner_class_types = { front_back: FrontBack }
            end

            def self.field_remappings
              @field_remappings = {}
            end
          end

          class SecondaryVerification < ::Stripe::StripeObject
            class FrontBack < ::Stripe::StripeObject
              # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the back of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
              attr_reader :back
              # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the front of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
              attr_reader :front

              def self.inner_class_types
                @inner_class_types = {}
              end

              def self.field_remappings
                @field_remappings = {}
              end
            end
            # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens for the front and back of the verification document.
            attr_reader :front_back
            # The format of the verification document. Currently supports `front_back` only.
            attr_reader :type

            def self.inner_class_types
              @inner_class_types = { front_back: FrontBack }
            end

            def self.field_remappings
              @field_remappings = {}
            end
          end

          class Visa < ::Stripe::StripeObject
            # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
            attr_reader :files
            # The format of the document. Currently supports `files` only.
            attr_reader :type

            def self.inner_class_types
              @inner_class_types = {}
            end

            def self.field_remappings
              @field_remappings = {}
            end
          end
          # One or more documents that demonstrate proof that this person is authorized to represent the company.
          attr_reader :company_authorization
          # One or more documents showing the person’s passport page with photo and personal data.
          attr_reader :passport
          # An identifying document showing the person's name, either a passport or local ID card.
          attr_reader :primary_verification
          # A document showing address, either a passport, local ID card, or utility bill from a well-known utility company.
          attr_reader :secondary_verification
          # One or more documents showing the person’s visa required for living in the country where they are residing.
          attr_reader :visa

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
          attr_reader :type

          def self.inner_class_types
            @inner_class_types = {}
          end

          def self.field_remappings
            @field_remappings = {}
          end
        end

        class Relationship < ::Stripe::StripeObject
          # Whether the individual is an authorizer of the Account's identity.
          attr_reader :authorizer
          # Whether the individual is a director of the Account's identity. Directors are typically members of the governing board of the company or are responsible for making sure that the company meets its regulatory obligations.
          attr_reader :director
          # Whether the individual has significant responsibility to control, manage, or direct the organization.
          attr_reader :executive
          # Whether the individual is the legal guardian of the Account's representative.
          attr_reader :legal_guardian
          # Whether the individual is an owner of the Account's identity.
          attr_reader :owner
          # The percentage of the Account's identity that the individual owns.
          attr_reader :percent_ownership
          # Whether the individual is authorized as the primary representative of the Account. This is the person nominated by the business to provide information about themselves, and general information about the account. There can only be one representative at any given time. At the time the account is created, this person should be set to the person responsible for opening the account.
          attr_reader :representative
          # The individual's title (e.g., CEO, Support Engineer).
          attr_reader :title

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
            attr_reader :city
            # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
            attr_reader :country
            # Address line 1 (e.g., street, PO Box, or company name).
            attr_reader :line1
            # Address line 2 (e.g., apartment, suite, unit, or building).
            attr_reader :line2
            # ZIP or postal code.
            attr_reader :postal_code
            # State, county, province, or region.
            attr_reader :state
            # Town or district.
            attr_reader :town

            def self.inner_class_types
              @inner_class_types = {}
            end

            def self.field_remappings
              @field_remappings = {}
            end
          end

          class Kanji < ::Stripe::StripeObject
            # City, district, suburb, town, or village.
            attr_reader :city
            # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
            attr_reader :country
            # Address line 1 (e.g., street, PO Box, or company name).
            attr_reader :line1
            # Address line 2 (e.g., apartment, suite, unit, or building).
            attr_reader :line2
            # ZIP or postal code.
            attr_reader :postal_code
            # State, county, province, or region.
            attr_reader :state
            # Town or district.
            attr_reader :town

            def self.inner_class_types
              @inner_class_types = {}
            end

            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Kana Address.
          attr_reader :kana
          # Kanji Address.
          attr_reader :kanji

          def self.inner_class_types
            @inner_class_types = { kana: Kana, kanji: Kanji }
          end

          def self.field_remappings
            @field_remappings = {}
          end
        end

        class ScriptNames < ::Stripe::StripeObject
          class Kana < ::Stripe::StripeObject
            # The person's first or given name.
            attr_reader :given_name
            # The person's last or family name.
            attr_reader :surname

            def self.inner_class_types
              @inner_class_types = {}
            end

            def self.field_remappings
              @field_remappings = {}
            end
          end

          class Kanji < ::Stripe::StripeObject
            # The person's first or given name.
            attr_reader :given_name
            # The person's last or family name.
            attr_reader :surname

            def self.inner_class_types
              @inner_class_types = {}
            end

            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Persons name in kana script.
          attr_reader :kana
          # Persons name in kanji script.
          attr_reader :kanji

          def self.inner_class_types
            @inner_class_types = { kana: Kana, kanji: Kanji }
          end

          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The account ID which the individual belongs to.
        attr_reader :account
        # Additional addresses associated with the person.
        attr_reader :additional_addresses
        # Additional names (e.g. aliases) associated with the person.
        attr_reader :additional_names
        # Attestations of accepted terms of service agreements.
        attr_reader :additional_terms_of_service
        # The person's residential address.
        attr_reader :address
        # Time at which the object was created. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
        attr_reader :created
        # The person's date of birth.
        attr_reader :date_of_birth
        # Documents that may be submitted to satisfy various informational requests.
        attr_reader :documents
        # The person's email address.
        attr_reader :email
        # The person's first name.
        attr_reader :given_name
        # Unique identifier for the Person.
        attr_reader :id
        # The identification numbers (e.g., SSN) associated with the person.
        attr_reader :id_numbers
        # The person's gender (International regulations require either "male" or "female").
        attr_reader :legal_gender
        # Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        attr_reader :metadata
        # The countries where the person is a national. Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        attr_reader :nationalities
        # String representing the object's type. Objects of the same type share the same value of the object field.
        attr_reader :object
        # The person's phone number.
        attr_reader :phone
        # The person's political exposure.
        attr_reader :political_exposure
        # The relationship that this person has with the Account's business or legal entity.
        attr_reader :relationship
        # The script addresses (e.g., non-Latin characters) associated with the person.
        attr_reader :script_addresses
        # The script names (e.g. non-Latin characters) associated with the person.
        attr_reader :script_names
        # The person's last name.
        attr_reader :surname
        # Time at which the object was last updated. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
        attr_reader :updated
        # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        attr_reader :livemode

        def self.inner_class_types
          @inner_class_types = {
            additional_addresses: AdditionalAddress,
            additional_names: AdditionalName,
            additional_terms_of_service: AdditionalTermsOfService,
            address: Address,
            date_of_birth: DateOfBirth,
            documents: Documents,
            id_numbers: IdNumber,
            relationship: Relationship,
            script_addresses: ScriptAddresses,
            script_names: ScriptNames,
          }
        end

        def self.field_remappings
          @field_remappings = {}
        end
      end
    end
  end
end
