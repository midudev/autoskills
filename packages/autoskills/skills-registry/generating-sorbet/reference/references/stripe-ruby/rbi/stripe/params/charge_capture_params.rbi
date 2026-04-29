# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ChargeCaptureParams < ::Stripe::RequestParams
    class TransferData < ::Stripe::RequestParams
      # The amount transferred to the destination account, if specified. By default, the entire charge amount is transferred to the destination account.
      sig { returns(T.nilable(Integer)) }
      def amount; end
      sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def amount=(_amount); end
      sig { params(amount: T.nilable(Integer)).void }
      def initialize(amount: nil); end
    end
    # The amount to capture, which must be less than or equal to the original amount.
    sig { returns(T.nilable(Integer)) }
    def amount; end
    sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def amount=(_amount); end
    # An application fee to add on to this charge.
    sig { returns(T.nilable(Integer)) }
    def application_fee; end
    sig { params(_application_fee: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def application_fee=(_application_fee); end
    # An application fee amount to add on to this charge, which must be less than or equal to the original amount.
    sig { returns(T.nilable(Integer)) }
    def application_fee_amount; end
    sig { params(_application_fee_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def application_fee_amount=(_application_fee_amount); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # The email address to send this charge's receipt to. This will override the previously-specified email address for this charge, if one was set. Receipts will not be sent in test mode.
    sig { returns(T.nilable(String)) }
    def receipt_email; end
    sig { params(_receipt_email: T.nilable(String)).returns(T.nilable(String)) }
    def receipt_email=(_receipt_email); end
    # For a non-card charge, text that appears on the customer's statement as the statement descriptor. This value overrides the account's default statement descriptor. For information about requirements, including the 22-character limit, see [the Statement Descriptor docs](https://docs.stripe.com/get-started/account/statement-descriptors).
    #
    # For a card charge, this value is ignored unless you don't specify a `statement_descriptor_suffix`, in which case this value is used as the suffix.
    sig { returns(T.nilable(String)) }
    def statement_descriptor; end
    sig { params(_statement_descriptor: T.nilable(String)).returns(T.nilable(String)) }
    def statement_descriptor=(_statement_descriptor); end
    # Provides information about a card charge. Concatenated to the account's [statement descriptor prefix](https://docs.stripe.com/get-started/account/statement-descriptors#static) to form the complete statement descriptor that appears on the customer's statement. If the account has no prefix value, the suffix is concatenated to the account's statement descriptor.
    sig { returns(T.nilable(String)) }
    def statement_descriptor_suffix; end
    sig { params(_statement_descriptor_suffix: T.nilable(String)).returns(T.nilable(String)) }
    def statement_descriptor_suffix=(_statement_descriptor_suffix); end
    # An optional dictionary including the account to automatically transfer to as part of a destination charge. [See the Connect documentation](https://docs.stripe.com/connect/destination-charges) for details.
    sig { returns(T.nilable(ChargeCaptureParams::TransferData)) }
    def transfer_data; end
    sig {
      params(_transfer_data: T.nilable(ChargeCaptureParams::TransferData)).returns(T.nilable(ChargeCaptureParams::TransferData))
     }
    def transfer_data=(_transfer_data); end
    # A string that identifies this transaction as part of a group. `transfer_group` may only be provided if it has not been set. See the [Connect documentation](https://docs.stripe.com/connect/separate-charges-and-transfers#transfer-options) for details.
    sig { returns(T.nilable(String)) }
    def transfer_group; end
    sig { params(_transfer_group: T.nilable(String)).returns(T.nilable(String)) }
    def transfer_group=(_transfer_group); end
    sig {
      params(amount: T.nilable(Integer), application_fee: T.nilable(Integer), application_fee_amount: T.nilable(Integer), expand: T.nilable(T::Array[String]), receipt_email: T.nilable(String), statement_descriptor: T.nilable(String), statement_descriptor_suffix: T.nilable(String), transfer_data: T.nilable(ChargeCaptureParams::TransferData), transfer_group: T.nilable(String)).void
     }
    def initialize(
      amount: nil,
      application_fee: nil,
      application_fee_amount: nil,
      expand: nil,
      receipt_email: nil,
      statement_descriptor: nil,
      statement_descriptor_suffix: nil,
      transfer_data: nil,
      transfer_group: nil
    ); end
  end
end