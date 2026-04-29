# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Identity
    class VerificationSessionCreateParams < ::Stripe::RequestParams
      class Options < ::Stripe::RequestParams
        class Document < ::Stripe::RequestParams
          # Array of strings of allowed identity document types. If the provided identity document isn’t one of the allowed types, the verification check will fail with a document_type_not_allowed error code.
          sig { returns(T.nilable(T::Array[String])) }
          def allowed_types; end
          sig {
            params(_allowed_types: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
           }
          def allowed_types=(_allowed_types); end
          # Collect an ID number and perform an [ID number check](https://docs.stripe.com/identity/verification-checks?type=id-number) with the document’s extracted name and date of birth.
          sig { returns(T.nilable(T::Boolean)) }
          def require_id_number; end
          sig { params(_require_id_number: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
          def require_id_number=(_require_id_number); end
          # Disable image uploads, identity document images have to be captured using the device’s camera.
          sig { returns(T.nilable(T::Boolean)) }
          def require_live_capture; end
          sig {
            params(_require_live_capture: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean))
           }
          def require_live_capture=(_require_live_capture); end
          # Capture a face image and perform a [selfie check](https://docs.stripe.com/identity/verification-checks?type=selfie) comparing a photo ID and a picture of your user’s face. [Learn more](https://docs.stripe.com/identity/selfie).
          sig { returns(T.nilable(T::Boolean)) }
          def require_matching_selfie; end
          sig {
            params(_require_matching_selfie: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean))
           }
          def require_matching_selfie=(_require_matching_selfie); end
          sig {
            params(allowed_types: T.nilable(T::Array[String]), require_id_number: T.nilable(T::Boolean), require_live_capture: T.nilable(T::Boolean), require_matching_selfie: T.nilable(T::Boolean)).void
           }
          def initialize(
            allowed_types: nil,
            require_id_number: nil,
            require_live_capture: nil,
            require_matching_selfie: nil
          ); end
        end
        # Options that apply to the [document check](https://docs.stripe.com/identity/verification-checks?type=document).
        sig {
          returns(T.nilable(T.any(String, Identity::VerificationSessionCreateParams::Options::Document)))
         }
        def document; end
        sig {
          params(_document: T.nilable(T.any(String, Identity::VerificationSessionCreateParams::Options::Document))).returns(T.nilable(T.any(String, Identity::VerificationSessionCreateParams::Options::Document)))
         }
        def document=(_document); end
        sig {
          params(document: T.nilable(T.any(String, Identity::VerificationSessionCreateParams::Options::Document))).void
         }
        def initialize(document: nil); end
      end
      class ProvidedDetails < ::Stripe::RequestParams
        # Email of user being verified
        sig { returns(T.nilable(String)) }
        def email; end
        sig { params(_email: T.nilable(String)).returns(T.nilable(String)) }
        def email=(_email); end
        # Phone number of user being verified
        sig { returns(T.nilable(String)) }
        def phone; end
        sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
        def phone=(_phone); end
        sig { params(email: T.nilable(String), phone: T.nilable(String)).void }
        def initialize(email: nil, phone: nil); end
      end
      class RelatedPerson < ::Stripe::RequestParams
        # A token representing a connected account. If provided, the person parameter is also required and must be associated with the account.
        sig { returns(String) }
        def account; end
        sig { params(_account: String).returns(String) }
        def account=(_account); end
        # A token referencing a Person resource that this verification is being used to verify.
        sig { returns(String) }
        def person; end
        sig { params(_person: String).returns(String) }
        def person=(_person); end
        sig { params(account: String, person: String).void }
        def initialize(account: nil, person: nil); end
      end
      # A string to reference this user. This can be a customer ID, a session ID, or similar, and can be used to reconcile this verification with your internal systems.
      sig { returns(T.nilable(String)) }
      def client_reference_id; end
      sig { params(_client_reference_id: T.nilable(String)).returns(T.nilable(String)) }
      def client_reference_id=(_client_reference_id); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # A set of options for the session’s verification checks.
      sig { returns(T.nilable(Identity::VerificationSessionCreateParams::Options)) }
      def options; end
      sig {
        params(_options: T.nilable(Identity::VerificationSessionCreateParams::Options)).returns(T.nilable(Identity::VerificationSessionCreateParams::Options))
       }
      def options=(_options); end
      # Details provided about the user being verified. These details may be shown to the user.
      sig { returns(T.nilable(Identity::VerificationSessionCreateParams::ProvidedDetails)) }
      def provided_details; end
      sig {
        params(_provided_details: T.nilable(Identity::VerificationSessionCreateParams::ProvidedDetails)).returns(T.nilable(Identity::VerificationSessionCreateParams::ProvidedDetails))
       }
      def provided_details=(_provided_details); end
      # Customer ID
      sig { returns(T.nilable(String)) }
      def related_customer; end
      sig { params(_related_customer: T.nilable(String)).returns(T.nilable(String)) }
      def related_customer=(_related_customer); end
      # The ID of the Account representing a customer.
      sig { returns(T.nilable(String)) }
      def related_customer_account; end
      sig { params(_related_customer_account: T.nilable(String)).returns(T.nilable(String)) }
      def related_customer_account=(_related_customer_account); end
      # Tokens referencing a Person resource and it's associated account.
      sig { returns(T.nilable(Identity::VerificationSessionCreateParams::RelatedPerson)) }
      def related_person; end
      sig {
        params(_related_person: T.nilable(Identity::VerificationSessionCreateParams::RelatedPerson)).returns(T.nilable(Identity::VerificationSessionCreateParams::RelatedPerson))
       }
      def related_person=(_related_person); end
      # The URL that the user will be redirected to upon completing the verification flow.
      sig { returns(T.nilable(String)) }
      def return_url; end
      sig { params(_return_url: T.nilable(String)).returns(T.nilable(String)) }
      def return_url=(_return_url); end
      # The type of [verification check](https://docs.stripe.com/identity/verification-checks) to be performed. You must provide a `type` if not passing `verification_flow`.
      sig { returns(T.nilable(String)) }
      def type; end
      sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
      def type=(_type); end
      # The ID of a verification flow from the Dashboard. See https://docs.stripe.com/identity/verification-flows.
      sig { returns(T.nilable(String)) }
      def verification_flow; end
      sig { params(_verification_flow: T.nilable(String)).returns(T.nilable(String)) }
      def verification_flow=(_verification_flow); end
      sig {
        params(client_reference_id: T.nilable(String), expand: T.nilable(T::Array[String]), metadata: T.nilable(T::Hash[String, String]), options: T.nilable(Identity::VerificationSessionCreateParams::Options), provided_details: T.nilable(Identity::VerificationSessionCreateParams::ProvidedDetails), related_customer: T.nilable(String), related_customer_account: T.nilable(String), related_person: T.nilable(Identity::VerificationSessionCreateParams::RelatedPerson), return_url: T.nilable(String), type: T.nilable(String), verification_flow: T.nilable(String)).void
       }
      def initialize(
        client_reference_id: nil,
        expand: nil,
        metadata: nil,
        options: nil,
        provided_details: nil,
        related_customer: nil,
        related_customer_account: nil,
        related_person: nil,
        return_url: nil,
        type: nil,
        verification_flow: nil
      ); end
    end
  end
end