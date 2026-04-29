# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # These bank accounts are payment methods on `Customer` objects.
  #
  # On the other hand [External Accounts](https://docs.stripe.com/api#external_accounts) are transfer
  # destinations on `Account` objects for connected accounts.
  # They can be bank accounts or debit cards as well, and are documented in the links above.
  #
  # Related guide: [Bank debits and transfers](https://docs.stripe.com/payments/bank-debits-transfers)
  class BankAccount < APIResource
    class FutureRequirements < ::Stripe::StripeObject
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
      # Fields that need to be resolved to keep the external account enabled. If not resolved by `current_deadline`, these fields will appear in `past_due` as well, and the account is disabled.
      sig { returns(T.nilable(T::Array[String])) }
      def currently_due; end
      # Details about validation and verification failures for `due` requirements that must be resolved.
      sig { returns(T.nilable(T::Array[Error])) }
      def errors; end
      # Fields that haven't been resolved by `current_deadline`. These fields need to be resolved to enable the external account.
      sig { returns(T.nilable(T::Array[String])) }
      def past_due; end
      # Fields that are being reviewed, or might become required depending on the results of a review. If the review fails, these fields can move to `eventually_due`, `currently_due`, `past_due` or `alternatives`. Fields might appear in `eventually_due`, `currently_due`, `past_due` or `alternatives` and in `pending_verification` if one verification fails but another is still pending.
      sig { returns(T.nilable(T::Array[String])) }
      def pending_verification; end
      def self.inner_class_types
        @inner_class_types = {errors: Error}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Requirements < ::Stripe::StripeObject
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
      # Fields that need to be resolved to keep the external account enabled. If not resolved by `current_deadline`, these fields will appear in `past_due` as well, and the account is disabled.
      sig { returns(T.nilable(T::Array[String])) }
      def currently_due; end
      # Details about validation and verification failures for `due` requirements that must be resolved.
      sig { returns(T.nilable(T::Array[Error])) }
      def errors; end
      # Fields that haven't been resolved by `current_deadline`. These fields need to be resolved to enable the external account.
      sig { returns(T.nilable(T::Array[String])) }
      def past_due; end
      # Fields that are being reviewed, or might become required depending on the results of a review. If the review fails, these fields can move to `eventually_due`, `currently_due`, `past_due` or `alternatives`. Fields might appear in `eventually_due`, `currently_due`, `past_due` or `alternatives` and in `pending_verification` if one verification fails but another is still pending.
      sig { returns(T.nilable(T::Array[String])) }
      def pending_verification; end
      def self.inner_class_types
        @inner_class_types = {errors: Error}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # The account this bank account belongs to. Only applicable on Accounts (not customers or recipients) This property is only available when returned as an [External Account](/api/external_account_bank_accounts/object) where [controller.is_controller](/api/accounts/object#account_object-controller-is_controller) is `true`.
    sig { returns(T.nilable(T.any(String, ::Stripe::Account))) }
    def account; end
    # The name of the person or business that owns the bank account.
    sig { returns(T.nilable(String)) }
    def account_holder_name; end
    # The type of entity that holds the account. This can be either `individual` or `company`.
    sig { returns(T.nilable(String)) }
    def account_holder_type; end
    # The bank account type. This can only be `checking` or `savings` in most countries. In Japan, this can only be `futsu` or `toza`.
    sig { returns(T.nilable(String)) }
    def account_type; end
    # A set of available payout methods for this bank account. Only values from this set should be passed as the `method` when creating a payout.
    sig { returns(T.nilable(T::Array[String])) }
    def available_payout_methods; end
    # Name of the bank associated with the routing number (e.g., `WELLS FARGO`).
    sig { returns(T.nilable(String)) }
    def bank_name; end
    # Two-letter ISO code representing the country the bank account is located in.
    sig { returns(String) }
    def country; end
    # Three-letter [ISO code for the currency](https://stripe.com/docs/payouts) paid out to the bank account.
    sig { returns(String) }
    def currency; end
    # The ID of the customer that the bank account is associated with.
    sig { returns(T.nilable(T.any(String, ::Stripe::Customer))) }
    def customer; end
    # Whether this bank account is the default external account for its currency.
    sig { returns(T.nilable(T::Boolean)) }
    def default_for_currency; end
    # Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    sig { returns(T.nilable(String)) }
    def fingerprint; end
    # Information about the [upcoming new requirements for the bank account](https://docs.stripe.com/connect/custom-accounts/future-requirements), including what information needs to be collected, and by when.
    sig { returns(T.nilable(FutureRequirements)) }
    def future_requirements; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # The last four digits of the bank account number.
    sig { returns(String) }
    def last4; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Information about the requirements for the bank account, including what information needs to be collected.
    sig { returns(T.nilable(Requirements)) }
    def requirements; end
    # The routing transit number for the bank account.
    sig { returns(T.nilable(String)) }
    def routing_number; end
    # For bank accounts, possible values are `new`, `validated`, `verified`, `verification_failed`, `tokenized_account_number_deactivated` or `errored`. A bank account that hasn't had any activity or validation performed is `new`. If Stripe can determine that the bank account exists, its status will be `validated`. Note that there often isn’t enough information to know (e.g., for smaller credit unions), and the validation is not always run. If customer bank account verification has succeeded, the bank account status will be `verified`. If the verification failed for any reason, such as microdeposit failure, the status will be `verification_failed`. If the status is `tokenized_account_number_deactivated`, the account utilizes a tokenized account number which has been deactivated due to expiration or revocation. This account will need to be reverified to continue using it for money movement. If a payout sent to this bank account fails, we'll set the status to `errored` and will not continue to send [scheduled payouts](https://stripe.com/docs/payouts#payout-schedule) until the bank details are updated.
    #
    # For external accounts, possible values are `new`, `errored`, `verification_failed`, and `tokenized_account_number_deactivated`. If a payout fails, the status is set to `errored` and scheduled payouts are stopped until account details are updated. In the US and India, if we can't [verify the owner of the bank account](https://support.stripe.com/questions/bank-account-ownership-verification), we'll set the status to `verification_failed`. Other validations aren't run against external accounts because they're only used for payouts. This means the other statuses don't apply.
    sig { returns(String) }
    def status; end
    # Always true for a deleted object
    sig { returns(T.nilable(T::Boolean)) }
    def deleted; end
  end
end