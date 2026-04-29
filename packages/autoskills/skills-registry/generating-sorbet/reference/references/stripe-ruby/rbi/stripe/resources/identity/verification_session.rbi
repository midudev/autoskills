# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Identity
    # A VerificationSession guides you through the process of collecting and verifying the identities
    # of your users. It contains details about the type of verification, such as what [verification
    # check](https://docs.stripe.com/docs/identity/verification-checks) to perform. Only create one VerificationSession for
    # each verification in your system.
    #
    # A VerificationSession transitions through [multiple
    # statuses](https://docs.stripe.com/docs/identity/how-sessions-work) throughout its lifetime as it progresses through
    # the verification flow. The VerificationSession contains the user's verified data after
    # verification checks are complete.
    #
    # Related guide: [The Verification Sessions API](https://docs.stripe.com/identity/verification-sessions)
    class VerificationSession < APIResource
      class LastError < ::Stripe::StripeObject
        # A short machine-readable string giving the reason for the verification or user-session failure.
        sig { returns(T.nilable(String)) }
        def code; end
        # A message that explains the reason for verification or user-session failure.
        sig { returns(T.nilable(String)) }
        def reason; end
        def self.inner_class_types
          @inner_class_types = {}
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
        class Email < ::Stripe::StripeObject
          # Request one time password verification of `provided_details.email`.
          sig { returns(T.nilable(T::Boolean)) }
          def require_verification; end
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
        class Matching < ::Stripe::StripeObject
          # Strictness of the DOB matching policy to apply.
          sig { returns(T.nilable(String)) }
          def dob; end
          # Strictness of the name matching policy to apply.
          sig { returns(T.nilable(String)) }
          def name; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Phone < ::Stripe::StripeObject
          # Request one time password verification of `provided_details.phone`.
          sig { returns(T.nilable(T::Boolean)) }
          def require_verification; end
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
        # Attribute for field email
        sig { returns(T.nilable(Email)) }
        def email; end
        # Attribute for field id_number
        sig { returns(T.nilable(IdNumber)) }
        def id_number; end
        # Attribute for field matching
        sig { returns(T.nilable(Matching)) }
        def matching; end
        # Attribute for field phone
        sig { returns(T.nilable(Phone)) }
        def phone; end
        def self.inner_class_types
          @inner_class_types = {
            document: Document,
            email: Email,
            id_number: IdNumber,
            matching: Matching,
            phone: Phone,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class ProvidedDetails < ::Stripe::StripeObject
        # Email of user being verified
        sig { returns(T.nilable(String)) }
        def email; end
        # Phone number of user being verified
        sig { returns(T.nilable(String)) }
        def phone; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Redaction < ::Stripe::StripeObject
        # Indicates whether this object and its related objects have been redacted or not.
        sig { returns(String) }
        def status; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class RelatedPerson < ::Stripe::StripeObject
        # Token referencing the associated Account of the related Person resource.
        sig { returns(String) }
        def account; end
        # Token referencing the related Person resource.
        sig { returns(String) }
        def person; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class VerifiedOutputs < ::Stripe::StripeObject
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
        # The user's verified address.
        sig { returns(T.nilable(Address)) }
        def address; end
        # The user’s verified date of birth.
        sig { returns(T.nilable(Dob)) }
        def dob; end
        # The user's verified email address
        sig { returns(T.nilable(String)) }
        def email; end
        # The user's verified first name.
        sig { returns(T.nilable(String)) }
        def first_name; end
        # The user's verified id number.
        sig { returns(T.nilable(String)) }
        def id_number; end
        # The user's verified id number type.
        sig { returns(T.nilable(String)) }
        def id_number_type; end
        # The user's verified last name.
        sig { returns(T.nilable(String)) }
        def last_name; end
        # The user's verified phone number
        sig { returns(T.nilable(String)) }
        def phone; end
        # The user's verified sex.
        sig { returns(T.nilable(String)) }
        def sex; end
        # The user's verified place of birth as it appears in the document.
        sig { returns(T.nilable(String)) }
        def unparsed_place_of_birth; end
        # The user's verified sex as it appears in the document.
        sig { returns(T.nilable(String)) }
        def unparsed_sex; end
        def self.inner_class_types
          @inner_class_types = {address: Address, dob: Dob}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # A string to reference this user. This can be a customer ID, a session ID, or similar, and can be used to reconcile this verification with your internal systems.
      sig { returns(T.nilable(String)) }
      def client_reference_id; end
      # The short-lived client secret used by Stripe.js to [show a verification modal](https://docs.stripe.com/js/identity/modal) inside your app. This client secret expires after 24 hours and can only be used once. Don’t store it, log it, embed it in a URL, or expose it to anyone other than the user. Make sure that you have TLS enabled on any page that includes the client secret. Refer to our docs on [passing the client secret to the frontend](https://docs.stripe.com/identity/verification-sessions#client-secret) to learn more.
      sig { returns(T.nilable(String)) }
      def client_secret; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # If present, this property tells you the last error encountered when processing the verification.
      sig { returns(T.nilable(LastError)) }
      def last_error; end
      # ID of the most recent VerificationReport. [Learn more about accessing detailed verification results.](https://docs.stripe.com/identity/verification-sessions#results)
      sig { returns(T.nilable(T.any(String, ::Stripe::Identity::VerificationReport))) }
      def last_verification_report; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T::Hash[String, String]) }
      def metadata; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # A set of options for the session’s verification checks.
      sig { returns(T.nilable(Options)) }
      def options; end
      # Details provided about the user being verified. These details may be shown to the user.
      sig { returns(T.nilable(ProvidedDetails)) }
      def provided_details; end
      # Redaction status of this VerificationSession. If the VerificationSession is not redacted, this field will be null.
      sig { returns(T.nilable(Redaction)) }
      def redaction; end
      # Customer ID
      sig { returns(T.nilable(String)) }
      def related_customer; end
      # The ID of the Account representing a customer.
      sig { returns(T.nilable(String)) }
      def related_customer_account; end
      # Attribute for field related_person
      sig { returns(T.nilable(RelatedPerson)) }
      def related_person; end
      # Status of this VerificationSession. [Learn more about the lifecycle of sessions](https://docs.stripe.com/identity/how-sessions-work).
      sig { returns(String) }
      def status; end
      # The type of [verification check](https://docs.stripe.com/identity/verification-checks) to be performed.
      sig { returns(String) }
      def type; end
      # The short-lived URL that you use to redirect a user to Stripe to submit their identity information. This URL expires after 48 hours and can only be used once. Don’t store it, log it, send it in emails or expose it to anyone other than the user. Refer to our docs on [verifying identity documents](https://docs.stripe.com/identity/verify-identity-documents?platform=web&type=redirect) to learn how to redirect users to Stripe.
      sig { returns(T.nilable(String)) }
      def url; end
      # The configuration token of a verification flow from the dashboard.
      sig { returns(T.nilable(String)) }
      def verification_flow; end
      # The user’s verified data.
      sig { returns(T.nilable(VerifiedOutputs)) }
      def verified_outputs; end
      # A VerificationSession object can be canceled when it is in requires_input [status](https://docs.stripe.com/docs/identity/how-sessions-work).
      #
      # Once canceled, future submission attempts are disabled. This cannot be undone. [Learn more](https://docs.stripe.com/docs/identity/verification-sessions#cancel).
      sig {
        params(params: T.any(::Stripe::Identity::VerificationSessionCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Identity::VerificationSession)
       }
      def cancel(params = {}, opts = {}); end

      # A VerificationSession object can be canceled when it is in requires_input [status](https://docs.stripe.com/docs/identity/how-sessions-work).
      #
      # Once canceled, future submission attempts are disabled. This cannot be undone. [Learn more](https://docs.stripe.com/docs/identity/verification-sessions#cancel).
      sig {
        params(session: String, params: T.any(::Stripe::Identity::VerificationSessionCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Identity::VerificationSession)
       }
      def self.cancel(session, params = {}, opts = {}); end

      # Creates a VerificationSession object.
      #
      # After the VerificationSession is created, display a verification modal using the session client_secret or send your users to the session's url.
      #
      # If your API key is in test mode, verification checks won't actually process, though everything else will occur as if in live mode.
      #
      # Related guide: [Verify your users' identity documents](https://docs.stripe.com/docs/identity/verify-identity-documents)
      sig {
        params(params: T.any(::Stripe::Identity::VerificationSessionCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Identity::VerificationSession)
       }
      def self.create(params = {}, opts = {}); end

      # Returns a list of VerificationSessions
      sig {
        params(params: T.any(::Stripe::Identity::VerificationSessionListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Redact a VerificationSession to remove all collected information from Stripe. This will redact
      # the VerificationSession and all objects related to it, including VerificationReports, Events,
      # request logs, etc.
      #
      # A VerificationSession object can be redacted when it is in requires_input or verified
      # [status](https://docs.stripe.com/docs/identity/how-sessions-work). Redacting a VerificationSession in requires_action
      # state will automatically cancel it.
      #
      # The redaction process may take up to four days. When the redaction process is in progress, the
      # VerificationSession's redaction.status field will be set to processing; when the process is
      # finished, it will change to redacted and an identity.verification_session.redacted event
      # will be emitted.
      #
      # Redaction is irreversible. Redacted objects are still accessible in the Stripe API, but all the
      # fields that contain personal data will be replaced by the string [redacted] or a similar
      # placeholder. The metadata field will also be erased. Redacted objects cannot be updated or
      # used for any purpose.
      #
      # [Learn more](https://docs.stripe.com/docs/identity/verification-sessions#redact).
      sig {
        params(params: T.any(::Stripe::Identity::VerificationSessionRedactParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Identity::VerificationSession)
       }
      def redact(params = {}, opts = {}); end

      # Redact a VerificationSession to remove all collected information from Stripe. This will redact
      # the VerificationSession and all objects related to it, including VerificationReports, Events,
      # request logs, etc.
      #
      # A VerificationSession object can be redacted when it is in requires_input or verified
      # [status](https://docs.stripe.com/docs/identity/how-sessions-work). Redacting a VerificationSession in requires_action
      # state will automatically cancel it.
      #
      # The redaction process may take up to four days. When the redaction process is in progress, the
      # VerificationSession's redaction.status field will be set to processing; when the process is
      # finished, it will change to redacted and an identity.verification_session.redacted event
      # will be emitted.
      #
      # Redaction is irreversible. Redacted objects are still accessible in the Stripe API, but all the
      # fields that contain personal data will be replaced by the string [redacted] or a similar
      # placeholder. The metadata field will also be erased. Redacted objects cannot be updated or
      # used for any purpose.
      #
      # [Learn more](https://docs.stripe.com/docs/identity/verification-sessions#redact).
      sig {
        params(session: String, params: T.any(::Stripe::Identity::VerificationSessionRedactParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Identity::VerificationSession)
       }
      def self.redact(session, params = {}, opts = {}); end

      # Updates a VerificationSession object.
      #
      # When the session status is requires_input, you can use this method to update the
      # verification check and options.
      sig {
        params(session: String, params: T.any(::Stripe::Identity::VerificationSessionUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Identity::VerificationSession)
       }
      def self.update(session, params = {}, opts = {}); end
    end
  end
end