# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Identity
    # A VerificationReport is the result of an attempt to collect and verify data from a user.
    # The collection of verification checks performed is determined from the `type` and `options`
    # parameters used. You can find the result of each verification check performed in the
    # appropriate sub-resource: `document`, `id_number`, `selfie`.
    #
    # Each VerificationReport contains a copy of any data collected by the user as well as
    # reference IDs which can be used to access collected images through the [FileUpload](https://docs.stripe.com/api/files)
    # API. To configure and create VerificationReports, use the
    # [VerificationSession](https://docs.stripe.com/api/identity/verification_sessions) API.
    #
    # Related guide: [Accessing verification results](https://docs.stripe.com/identity/verification-sessions#results).
    class VerificationReport < APIResource
      class Document < ::Stripe::StripeObject
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
        class Dob < ::Stripe::StripeObject
          # Numerical day between 1 and 31.
          sig { returns(T.nilable(Integer)) }
          def day; end
          # Numerical month between 1 and 12.
          sig { returns(T.nilable(Integer)) }
          def month; end
          # The four-digit year.
          sig { returns(T.nilable(Integer)) }
          def year; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Error < ::Stripe::StripeObject
          # A short machine-readable string giving the reason for the verification failure.
          sig { returns(T.nilable(String)) }
          def code; end
          # A human-readable message giving the reason for the failure. These messages can be shown to your users.
          sig { returns(T.nilable(String)) }
          def reason; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class ExpirationDate < ::Stripe::StripeObject
          # Numerical day between 1 and 31.
          sig { returns(T.nilable(Integer)) }
          def day; end
          # Numerical month between 1 and 12.
          sig { returns(T.nilable(Integer)) }
          def month; end
          # The four-digit year.
          sig { returns(T.nilable(Integer)) }
          def year; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class IssuedDate < ::Stripe::StripeObject
          # Numerical day between 1 and 31.
          sig { returns(T.nilable(Integer)) }
          def day; end
          # Numerical month between 1 and 12.
          sig { returns(T.nilable(Integer)) }
          def month; end
          # The four-digit year.
          sig { returns(T.nilable(Integer)) }
          def year; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Address as it appears in the document.
        sig { returns(T.nilable(Address)) }
        def address; end
        # Date of birth as it appears in the document.
        sig { returns(T.nilable(Dob)) }
        def dob; end
        # Details on the verification error. Present when status is `unverified`.
        sig { returns(T.nilable(Error)) }
        def error; end
        # Expiration date of the document.
        sig { returns(T.nilable(ExpirationDate)) }
        def expiration_date; end
        # Array of [File](https://docs.stripe.com/api/files) ids containing images for this document.
        sig { returns(T.nilable(T::Array[String])) }
        def files; end
        # First name as it appears in the document.
        sig { returns(T.nilable(String)) }
        def first_name; end
        # Issued date of the document.
        sig { returns(T.nilable(IssuedDate)) }
        def issued_date; end
        # Issuing country of the document.
        sig { returns(T.nilable(String)) }
        def issuing_country; end
        # Last name as it appears in the document.
        sig { returns(T.nilable(String)) }
        def last_name; end
        # Document ID number.
        sig { returns(T.nilable(String)) }
        def number; end
        # Sex of the person in the document.
        sig { returns(T.nilable(String)) }
        def sex; end
        # Status of this `document` check.
        sig { returns(String) }
        def status; end
        # Type of the document.
        sig { returns(T.nilable(String)) }
        def type; end
        # Place of birth as it appears in the document.
        sig { returns(T.nilable(String)) }
        def unparsed_place_of_birth; end
        # Sex as it appears in the document.
        sig { returns(T.nilable(String)) }
        def unparsed_sex; end
        def self.inner_class_types
          @inner_class_types = {
            address: Address,
            dob: Dob,
            error: Error,
            expiration_date: ExpirationDate,
            issued_date: IssuedDate,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Email < ::Stripe::StripeObject
        class Error < ::Stripe::StripeObject
          # A short machine-readable string giving the reason for the verification failure.
          sig { returns(T.nilable(String)) }
          def code; end
          # A human-readable message giving the reason for the failure. These messages can be shown to your users.
          sig { returns(T.nilable(String)) }
          def reason; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Email to be verified.
        sig { returns(T.nilable(String)) }
        def email; end
        # Details on the verification error. Present when status is `unverified`.
        sig { returns(T.nilable(Error)) }
        def error; end
        # Status of this `email` check.
        sig { returns(String) }
        def status; end
        def self.inner_class_types
          @inner_class_types = {error: Error}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class IdNumber < ::Stripe::StripeObject
        class Dob < ::Stripe::StripeObject
          # Numerical day between 1 and 31.
          sig { returns(T.nilable(Integer)) }
          def day; end
          # Numerical month between 1 and 12.
          sig { returns(T.nilable(Integer)) }
          def month; end
          # The four-digit year.
          sig { returns(T.nilable(Integer)) }
          def year; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Error < ::Stripe::StripeObject
          # A short machine-readable string giving the reason for the verification failure.
          sig { returns(T.nilable(String)) }
          def code; end
          # A human-readable message giving the reason for the failure. These messages can be shown to your users.
          sig { returns(T.nilable(String)) }
          def reason; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Date of birth.
        sig { returns(T.nilable(Dob)) }
        def dob; end
        # Details on the verification error. Present when status is `unverified`.
        sig { returns(T.nilable(Error)) }
        def error; end
        # First name.
        sig { returns(T.nilable(String)) }
        def first_name; end
        # ID number. When `id_number_type` is `us_ssn`, only the last 4 digits are present.
        sig { returns(T.nilable(String)) }
        def id_number; end
        # Type of ID number.
        sig { returns(T.nilable(String)) }
        def id_number_type; end
        # Last name.
        sig { returns(T.nilable(String)) }
        def last_name; end
        # Status of this `id_number` check.
        sig { returns(String) }
        def status; end
        def self.inner_class_types
          @inner_class_types = {dob: Dob, error: Error}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Options < ::Stripe::StripeObject
        class Document < ::Stripe::StripeObject
          # Array of strings of allowed identity document types. If the provided identity document isn’t one of the allowed types, the verification check will fail with a document_type_not_allowed error code.
          sig { returns(T.nilable(T::Array[String])) }
          def allowed_types; end
          # Collect an ID number and perform an [ID number check](https://docs.stripe.com/identity/verification-checks?type=id-number) with the document’s extracted name and date of birth.
          sig { returns(T.nilable(T::Boolean)) }
          def require_id_number; end
          # Disable image uploads, identity document images have to be captured using the device’s camera.
          sig { returns(T.nilable(T::Boolean)) }
          def require_live_capture; end
          # Capture a face image and perform a [selfie check](https://docs.stripe.com/identity/verification-checks?type=selfie) comparing a photo ID and a picture of your user’s face. [Learn more](https://docs.stripe.com/identity/selfie).
          sig { returns(T.nilable(T::Boolean)) }
          def require_matching_selfie; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class IdNumber < ::Stripe::StripeObject
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field document
        sig { returns(T.nilable(Document)) }
        def document; end
        # Attribute for field id_number
        sig { returns(T.nilable(IdNumber)) }
        def id_number; end
        def self.inner_class_types
          @inner_class_types = {document: Document, id_number: IdNumber}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Phone < ::Stripe::StripeObject
        class Error < ::Stripe::StripeObject
          # A short machine-readable string giving the reason for the verification failure.
          sig { returns(T.nilable(String)) }
          def code; end
          # A human-readable message giving the reason for the failure. These messages can be shown to your users.
          sig { returns(T.nilable(String)) }
          def reason; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Details on the verification error. Present when status is `unverified`.
        sig { returns(T.nilable(Error)) }
        def error; end
        # Phone to be verified.
        sig { returns(T.nilable(String)) }
        def phone; end
        # Status of this `phone` check.
        sig { returns(String) }
        def status; end
        def self.inner_class_types
          @inner_class_types = {error: Error}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Selfie < ::Stripe::StripeObject
        class Error < ::Stripe::StripeObject
          # A short machine-readable string giving the reason for the verification failure.
          sig { returns(T.nilable(String)) }
          def code; end
          # A human-readable message giving the reason for the failure. These messages can be shown to your users.
          sig { returns(T.nilable(String)) }
          def reason; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # ID of the [File](https://docs.stripe.com/api/files) holding the image of the identity document used in this check.
        sig { returns(T.nilable(String)) }
        def document; end
        # Details on the verification error. Present when status is `unverified`.
        sig { returns(T.nilable(Error)) }
        def error; end
        # ID of the [File](https://docs.stripe.com/api/files) holding the image of the selfie used in this check.
        sig { returns(T.nilable(String)) }
        def selfie; end
        # Status of this `selfie` check.
        sig { returns(String) }
        def status; end
        def self.inner_class_types
          @inner_class_types = {error: Error}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # A string to reference this user. This can be a customer ID, a session ID, or similar, and can be used to reconcile this verification with your internal systems.
      sig { returns(T.nilable(String)) }
      def client_reference_id; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Result from a document check
      sig { returns(T.nilable(Document)) }
      def document; end
      # Result from a email check
      sig { returns(T.nilable(Email)) }
      def email; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Result from an id_number check
      sig { returns(T.nilable(IdNumber)) }
      def id_number; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Attribute for field options
      sig { returns(T.nilable(Options)) }
      def options; end
      # Result from a phone check
      sig { returns(T.nilable(Phone)) }
      def phone; end
      # Result from a selfie check
      sig { returns(T.nilable(Selfie)) }
      def selfie; end
      # Type of report.
      sig { returns(String) }
      def type; end
      # The configuration token of a verification flow from the dashboard.
      sig { returns(T.nilable(String)) }
      def verification_flow; end
      # ID of the VerificationSession that created this report.
      sig { returns(T.nilable(String)) }
      def verification_session; end
      # List all verification reports.
      sig {
        params(params: T.any(::Stripe::Identity::VerificationReportListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end