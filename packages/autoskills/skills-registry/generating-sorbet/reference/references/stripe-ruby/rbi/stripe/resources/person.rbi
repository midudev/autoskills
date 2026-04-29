# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # This is an object representing a person associated with a Stripe account.
  #
  # A platform can only access a subset of data in a person for an account where [account.controller.requirement_collection](https://docs.stripe.com/api/accounts/object#account_object-controller-requirement_collection) is `stripe`, which includes Standard and Express accounts, after creating an Account Link or Account Session to start Connect onboarding.
  #
  # See the [Standard onboarding](https://docs.stripe.com/connect/standard-accounts) or [Express onboarding](https://docs.stripe.com/connect/express-accounts) documentation for information about prefilling information and account onboarding steps. Learn more about [handling identity verification with the API](https://docs.stripe.com/connect/handling-api-verification#person-information).
  class Person < APIResource
    class AdditionalTosAcceptances < ::Stripe::StripeObject
      class Account < ::Stripe::StripeObject
        # The Unix timestamp marking when the legal guardian accepted the service agreement.
        sig { returns(T.nilable(Integer)) }
        def date; end
        # The IP address from which the legal guardian accepted the service agreement.
        sig { returns(T.nilable(String)) }
        def ip; end
        # The user agent of the browser from which the legal guardian accepted the service agreement.
        sig { returns(T.nilable(String)) }
        def user_agent; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Details on the legal guardian's acceptance of the main Stripe service agreement.
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
    class AddressKana < ::Stripe::StripeObject
      # City/Ward.
      sig { returns(T.nilable(String)) }
      def city; end
      # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
      sig { returns(T.nilable(String)) }
      def country; end
      # Block/Building number.
      sig { returns(T.nilable(String)) }
      def line1; end
      # Building details.
      sig { returns(T.nilable(String)) }
      def line2; end
      # ZIP or postal code.
      sig { returns(T.nilable(String)) }
      def postal_code; end
      # Prefecture.
      sig { returns(T.nilable(String)) }
      def state; end
      # Town/cho-me.
      sig { returns(T.nilable(String)) }
      def town; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class AddressKanji < ::Stripe::StripeObject
      # City/Ward.
      sig { returns(T.nilable(String)) }
      def city; end
      # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
      sig { returns(T.nilable(String)) }
      def country; end
      # Block/Building number.
      sig { returns(T.nilable(String)) }
      def line1; end
      # Building details.
      sig { returns(T.nilable(String)) }
      def line2; end
      # ZIP or postal code.
      sig { returns(T.nilable(String)) }
      def postal_code; end
      # Prefecture.
      sig { returns(T.nilable(String)) }
      def state; end
      # Town/cho-me.
      sig { returns(T.nilable(String)) }
      def town; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Dob < ::Stripe::StripeObject
      # The day of birth, between 1 and 31.
      sig { returns(T.nilable(Integer)) }
      def day; end
      # The month of birth, between 1 and 12.
      sig { returns(T.nilable(Integer)) }
      def month; end
      # The four-digit year of birth.
      sig { returns(T.nilable(Integer)) }
      def year; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class FutureRequirements < ::Stripe::StripeObject
      class Alternative < ::Stripe::StripeObject
        # Fields that can be provided to resolve all fields in `original_fields_due`.
        sig { returns(T::Array[String]) }
        def alternative_fields_due; end
        # Fields that are due and can be resolved by providing all fields in `alternative_fields_due`.
        sig { returns(T::Array[String]) }
        def original_fields_due; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Error < ::Stripe::StripeObject
        # The code for the type of error.
        sig { returns(String) }
        def code; end
        # An informative message that indicates the error type and provides additional details about the error.
        sig { returns(String) }
        def reason; end
        # The specific user onboarding requirement field (in the requirements hash) that needs to be resolved.
        sig { returns(String) }
        def requirement; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Fields that are due and can be resolved by providing the corresponding alternative fields instead. Many alternatives can list the same `original_fields_due`, and any of these alternatives can serve as a pathway for attempting to resolve the fields again. Re-providing `original_fields_due` also serves as a pathway for attempting to resolve the fields again.
      sig { returns(T.nilable(T::Array[Alternative])) }
      def alternatives; end
      # Fields that need to be resolved to keep the person's account enabled. If not resolved by the account's `future_requirements[current_deadline]`, these fields will transition to the main `requirements` hash, and may immediately become `past_due`, but the account may also be given a grace period depending on the account's enablement state prior to transition.
      sig { returns(T::Array[String]) }
      def currently_due; end
      # Details about validation and verification failures for `due` requirements that must be resolved.
      sig { returns(T::Array[Error]) }
      def errors; end
      # Fields you must collect when all thresholds are reached. As they become required, they appear in `currently_due` as well, and the account's `future_requirements[current_deadline]` becomes set.
      sig { returns(T::Array[String]) }
      def eventually_due; end
      # Fields that haven't been resolved by the account's `requirements.current_deadline`. These fields need to be resolved to enable the person's account. `future_requirements.past_due` is a subset of `requirements.past_due`.
      sig { returns(T::Array[String]) }
      def past_due; end
      # Fields that are being reviewed, or might become required depending on the results of a review. If the review fails, these fields can move to `eventually_due`, `currently_due`, `past_due` or `alternatives`. Fields might appear in `eventually_due`, `currently_due`, `past_due` or `alternatives` and in `pending_verification` if one verification fails but another is still pending.
      sig { returns(T::Array[String]) }
      def pending_verification; end
      def self.inner_class_types
        @inner_class_types = {alternatives: Alternative, errors: Error}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class RegisteredAddress < ::Stripe::StripeObject
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
    class Relationship < ::Stripe::StripeObject
      # Whether the person is the authorizer of the account's representative.
      sig { returns(T.nilable(T::Boolean)) }
      def authorizer; end
      # Whether the person is a director of the account's legal entity. Directors are typically members of the governing board of the company, or responsible for ensuring the company meets its regulatory obligations.
      sig { returns(T.nilable(T::Boolean)) }
      def director; end
      # Whether the person has significant responsibility to control, manage, or direct the organization.
      sig { returns(T.nilable(T::Boolean)) }
      def executive; end
      # Whether the person is the legal guardian of the account's representative.
      sig { returns(T.nilable(T::Boolean)) }
      def legal_guardian; end
      # Whether the person is an owner of the account’s legal entity.
      sig { returns(T.nilable(T::Boolean)) }
      def owner; end
      # The percent owned by the person of the account's legal entity.
      sig { returns(T.nilable(Float)) }
      def percent_ownership; end
      # Whether the person is authorized as the primary representative of the account. This is the person nominated by the business to provide information about themselves, and general information about the account. There can only be one representative at any given time. At the time the account is created, this person should be set to the person responsible for opening the account.
      sig { returns(T.nilable(T::Boolean)) }
      def representative; end
      # The person's title (e.g., CEO, Support Engineer).
      sig { returns(T.nilable(String)) }
      def title; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Requirements < ::Stripe::StripeObject
      class Alternative < ::Stripe::StripeObject
        # Fields that can be provided to resolve all fields in `original_fields_due`.
        sig { returns(T::Array[String]) }
        def alternative_fields_due; end
        # Fields that are due and can be resolved by providing all fields in `alternative_fields_due`.
        sig { returns(T::Array[String]) }
        def original_fields_due; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Error < ::Stripe::StripeObject
        # The code for the type of error.
        sig { returns(String) }
        def code; end
        # An informative message that indicates the error type and provides additional details about the error.
        sig { returns(String) }
        def reason; end
        # The specific user onboarding requirement field (in the requirements hash) that needs to be resolved.
        sig { returns(String) }
        def requirement; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Fields that are due and can be resolved by providing the corresponding alternative fields instead. Many alternatives can list the same `original_fields_due`, and any of these alternatives can serve as a pathway for attempting to resolve the fields again. Re-providing `original_fields_due` also serves as a pathway for attempting to resolve the fields again.
      sig { returns(T.nilable(T::Array[Alternative])) }
      def alternatives; end
      # Fields that need to be resolved to keep the person's account enabled. If not resolved by the account's `current_deadline`, these fields will appear in `past_due` as well, and the account is disabled.
      sig { returns(T::Array[String]) }
      def currently_due; end
      # Details about validation and verification failures for `due` requirements that must be resolved.
      sig { returns(T::Array[Error]) }
      def errors; end
      # Fields you must collect when all thresholds are reached. As they become required, they appear in `currently_due` as well, and the account's `current_deadline` becomes set.
      sig { returns(T::Array[String]) }
      def eventually_due; end
      # Fields that haven't been resolved by `current_deadline`. These fields need to be resolved to enable the person's account.
      sig { returns(T::Array[String]) }
      def past_due; end
      # Fields that are being reviewed, or might become required depending on the results of a review. If the review fails, these fields can move to `eventually_due`, `currently_due`, `past_due` or `alternatives`. Fields might appear in `eventually_due`, `currently_due`, `past_due` or `alternatives` and in `pending_verification` if one verification fails but another is still pending.
      sig { returns(T::Array[String]) }
      def pending_verification; end
      def self.inner_class_types
        @inner_class_types = {alternatives: Alternative, errors: Error}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class UsCfpbData < ::Stripe::StripeObject
      class EthnicityDetails < ::Stripe::StripeObject
        # The persons ethnicity
        sig { returns(T.nilable(T::Array[String])) }
        def ethnicity; end
        # Please specify your origin, when other is selected.
        sig { returns(T.nilable(String)) }
        def ethnicity_other; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class RaceDetails < ::Stripe::StripeObject
        # The persons race.
        sig { returns(T.nilable(T::Array[String])) }
        def race; end
        # Please specify your race, when other is selected.
        sig { returns(T.nilable(String)) }
        def race_other; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The persons ethnicity details
      sig { returns(T.nilable(EthnicityDetails)) }
      def ethnicity_details; end
      # The persons race details
      sig { returns(T.nilable(RaceDetails)) }
      def race_details; end
      # The persons self-identified gender
      sig { returns(T.nilable(String)) }
      def self_identified_gender; end
      def self.inner_class_types
        @inner_class_types = {ethnicity_details: EthnicityDetails, race_details: RaceDetails}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Verification < ::Stripe::StripeObject
      class AdditionalDocument < ::Stripe::StripeObject
        # The back of an ID returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `identity_document`.
        sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
        def back; end
        # A user-displayable string describing the verification state of this document. For example, if a document is uploaded and the picture is too fuzzy, this may say "Identity document is too unclear to read".
        sig { returns(T.nilable(String)) }
        def details; end
        # One of `document_corrupt`, `document_country_not_supported`, `document_expired`, `document_failed_copy`, `document_failed_other`, `document_failed_test_mode`, `document_fraudulent`, `document_failed_greyscale`, `document_incomplete`, `document_invalid`, `document_manipulated`, `document_missing_back`, `document_missing_front`, `document_not_readable`, `document_not_uploaded`, `document_photo_mismatch`, `document_too_large`, or `document_type_not_supported`. A machine-readable code specifying the verification state for this document.
        sig { returns(T.nilable(String)) }
        def details_code; end
        # The front of an ID returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `identity_document`.
        sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
        def front; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Document < ::Stripe::StripeObject
        # The back of an ID returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `identity_document`.
        sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
        def back; end
        # A user-displayable string describing the verification state of this document. For example, if a document is uploaded and the picture is too fuzzy, this may say "Identity document is too unclear to read".
        sig { returns(T.nilable(String)) }
        def details; end
        # One of `document_corrupt`, `document_country_not_supported`, `document_expired`, `document_failed_copy`, `document_failed_other`, `document_failed_test_mode`, `document_fraudulent`, `document_failed_greyscale`, `document_incomplete`, `document_invalid`, `document_manipulated`, `document_missing_back`, `document_missing_front`, `document_not_readable`, `document_not_uploaded`, `document_photo_mismatch`, `document_too_large`, or `document_type_not_supported`. A machine-readable code specifying the verification state for this document.
        sig { returns(T.nilable(String)) }
        def details_code; end
        # The front of an ID returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `identity_document`.
        sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
        def front; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # A document showing address, either a passport, local ID card, or utility bill from a well-known utility company.
      sig { returns(T.nilable(AdditionalDocument)) }
      def additional_document; end
      # A user-displayable string describing the verification state for the person. For example, this may say "Provided identity information could not be verified".
      sig { returns(T.nilable(String)) }
      def details; end
      # One of `document_address_mismatch`, `document_dob_mismatch`, `document_duplicate_type`, `document_id_number_mismatch`, `document_name_mismatch`, `document_nationality_mismatch`, `failed_keyed_identity`, or `failed_other`. A machine-readable code specifying the verification state for the person.
      sig { returns(T.nilable(String)) }
      def details_code; end
      # Attribute for field document
      sig { returns(T.nilable(Document)) }
      def document; end
      # The state of verification for the person. Possible values are `unverified`, `pending`, or `verified`. Please refer [guide](https://docs.stripe.com/connect/handling-api-verification) to handle verification updates.
      sig { returns(String) }
      def status; end
      def self.inner_class_types
        @inner_class_types = {additional_document: AdditionalDocument, document: Document}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # The account the person is associated with.
    sig { returns(T.nilable(String)) }
    def account; end
    # Attribute for field additional_tos_acceptances
    sig { returns(T.nilable(AdditionalTosAcceptances)) }
    def additional_tos_acceptances; end
    # Attribute for field address
    sig { returns(T.nilable(Address)) }
    def address; end
    # The Kana variation of the person's address (Japan only).
    sig { returns(T.nilable(AddressKana)) }
    def address_kana; end
    # The Kanji variation of the person's address (Japan only).
    sig { returns(T.nilable(AddressKanji)) }
    def address_kanji; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Attribute for field dob
    sig { returns(T.nilable(Dob)) }
    def dob; end
    # The person's email address. Also available for accounts where [controller.requirement_collection](/api/accounts/object#account_object-controller-requirement_collection) is `stripe`.
    sig { returns(T.nilable(String)) }
    def email; end
    # The person's first name. Also available for accounts where [controller.requirement_collection](/api/accounts/object#account_object-controller-requirement_collection) is `stripe`.
    sig { returns(T.nilable(String)) }
    def first_name; end
    # The Kana variation of the person's first name (Japan only). Also available for accounts where [controller.requirement_collection](/api/accounts/object#account_object-controller-requirement_collection) is `stripe`.
    sig { returns(T.nilable(String)) }
    def first_name_kana; end
    # The Kanji variation of the person's first name (Japan only). Also available for accounts where [controller.requirement_collection](/api/accounts/object#account_object-controller-requirement_collection) is `stripe`.
    sig { returns(T.nilable(String)) }
    def first_name_kanji; end
    # A list of alternate names or aliases that the person is known by. Also available for accounts where [controller.requirement_collection](/api/accounts/object#account_object-controller-requirement_collection) is `stripe`.
    sig { returns(T.nilable(T::Array[String])) }
    def full_name_aliases; end
    # Information about the [upcoming new requirements for this person](https://docs.stripe.com/connect/custom-accounts/future-requirements), including what information needs to be collected, and by when.
    sig { returns(T.nilable(FutureRequirements)) }
    def future_requirements; end
    # The person's gender.
    sig { returns(T.nilable(String)) }
    def gender; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Whether the person's `id_number` was provided. True if either the full ID number was provided or if only the required part of the ID number was provided (ex. last four of an individual's SSN for the US indicated by `ssn_last_4_provided`).
    sig { returns(T.nilable(T::Boolean)) }
    def id_number_provided; end
    # Whether the person's `id_number_secondary` was provided.
    sig { returns(T.nilable(T::Boolean)) }
    def id_number_secondary_provided; end
    # The person's last name. Also available for accounts where [controller.requirement_collection](/api/accounts/object#account_object-controller-requirement_collection) is `stripe`.
    sig { returns(T.nilable(String)) }
    def last_name; end
    # The Kana variation of the person's last name (Japan only). Also available for accounts where [controller.requirement_collection](/api/accounts/object#account_object-controller-requirement_collection) is `stripe`.
    sig { returns(T.nilable(String)) }
    def last_name_kana; end
    # The Kanji variation of the person's last name (Japan only). Also available for accounts where [controller.requirement_collection](/api/accounts/object#account_object-controller-requirement_collection) is `stripe`.
    sig { returns(T.nilable(String)) }
    def last_name_kanji; end
    # The person's maiden name.
    sig { returns(T.nilable(String)) }
    def maiden_name; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # The country where the person is a national.
    sig { returns(T.nilable(String)) }
    def nationality; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The person's phone number.
    sig { returns(T.nilable(String)) }
    def phone; end
    # Indicates if the person or any of their representatives, family members, or other closely related persons, declares that they hold or have held an important public job or function, in any jurisdiction.
    sig { returns(T.nilable(String)) }
    def political_exposure; end
    # Attribute for field registered_address
    sig { returns(T.nilable(RegisteredAddress)) }
    def registered_address; end
    # Attribute for field relationship
    sig { returns(T.nilable(Relationship)) }
    def relationship; end
    # Information about the requirements for this person, including what information needs to be collected, and by when.
    sig { returns(T.nilable(Requirements)) }
    def requirements; end
    # Whether the last four digits of the person's Social Security number have been provided (U.S. only).
    sig { returns(T.nilable(T::Boolean)) }
    def ssn_last_4_provided; end
    # Demographic data related to the person.
    sig { returns(T.nilable(UsCfpbData)) }
    def us_cfpb_data; end
    # Attribute for field verification
    sig { returns(T.nilable(Verification)) }
    def verification; end
    # Always true for a deleted object
    sig { returns(T.nilable(T::Boolean)) }
    def deleted; end
  end
end