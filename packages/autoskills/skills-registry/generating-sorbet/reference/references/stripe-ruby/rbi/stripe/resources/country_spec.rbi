# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Stripe needs to collect certain pieces of information about each account
  # created. These requirements can differ depending on the account's country. The
  # Country Specs API makes these rules available to your integration.
  #
  # You can also view the information from this API call as [an online
  # guide](https://docs.stripe.com/docs/connect/required-verification-information).
  class CountrySpec < APIResource
    class VerificationFields < ::Stripe::StripeObject
      class Company < ::Stripe::StripeObject
        # Additional fields which are only required for some users.
        sig { returns(T::Array[String]) }
        def additional; end
        # Fields which every account must eventually provide.
        sig { returns(T::Array[String]) }
        def minimum; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Individual < ::Stripe::StripeObject
        # Additional fields which are only required for some users.
        sig { returns(T::Array[String]) }
        def additional; end
        # Fields which every account must eventually provide.
        sig { returns(T::Array[String]) }
        def minimum; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field company
      sig { returns(Company) }
      def company; end
      # Attribute for field individual
      sig { returns(Individual) }
      def individual; end
      def self.inner_class_types
        @inner_class_types = {company: Company, individual: Individual}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # The default currency for this country. This applies to both payment methods and bank accounts.
    sig { returns(String) }
    def default_currency; end
    # Unique identifier for the object. Represented as the ISO country code for this country.
    sig { returns(String) }
    def id; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Currencies that can be accepted in the specific country (for transfers).
    sig { returns(T::Hash[String, T::Array[String]]) }
    def supported_bank_account_currencies; end
    # Currencies that can be accepted in the specified country (for payments).
    sig { returns(T::Array[String]) }
    def supported_payment_currencies; end
    # Payment methods available in the specified country. You may need to enable some payment methods (e.g., [ACH](https://stripe.com/docs/ach)) on your account before they appear in this list. The `stripe` payment method refers to [charging through your platform](https://stripe.com/docs/connect/destination-charges).
    sig { returns(T::Array[String]) }
    def supported_payment_methods; end
    # Countries that can accept transfers from the specified country.
    sig { returns(T::Array[String]) }
    def supported_transfer_countries; end
    # Attribute for field verification_fields
    sig { returns(VerificationFields) }
    def verification_fields; end
    # Lists all Country Spec objects available in the API.
    sig {
      params(params: T.any(::Stripe::CountrySpecListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end
  end
end