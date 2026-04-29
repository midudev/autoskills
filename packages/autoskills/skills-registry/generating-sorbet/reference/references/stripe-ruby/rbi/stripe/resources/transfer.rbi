# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # A `Transfer` object is created when you move funds between Stripe accounts as
  # part of Connect.
  #
  # Before April 6, 2017, transfers also represented movement of funds from a
  # Stripe account to a card or bank account. This behavior has since been split
  # out into a [Payout](https://api.stripe.com#payout_object) object, with corresponding payout endpoints. For more
  # information, read about the
  # [transfer/payout split](https://docs.stripe.com/transfer-payout-split).
  #
  # Related guide: [Creating separate charges and transfers](https://docs.stripe.com/connect/separate-charges-and-transfers)
  class Transfer < APIResource
    # Amount in cents (or local equivalent) to be transferred.
    sig { returns(Integer) }
    def amount; end
    # Amount in cents (or local equivalent) reversed (can be less than the amount attribute on the transfer if a partial reversal was issued).
    sig { returns(Integer) }
    def amount_reversed; end
    # Balance transaction that describes the impact of this transfer on your account balance.
    sig { returns(T.nilable(T.any(String, ::Stripe::BalanceTransaction))) }
    def balance_transaction; end
    # Time that this record of the transfer was first created.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # An arbitrary string attached to the object. Often useful for displaying to users.
    sig { returns(T.nilable(String)) }
    def description; end
    # ID of the Stripe account the transfer was sent to.
    sig { returns(T.nilable(T.any(String, ::Stripe::Account))) }
    def destination; end
    # If the destination is a Stripe account, this will be the ID of the payment that the destination account received for the transfer.
    sig { returns(T.nilable(T.any(String, ::Stripe::Charge))) }
    def destination_payment; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T::Hash[String, String]) }
    def metadata; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # A list of reversals that have been applied to the transfer.
    sig { returns(::Stripe::ListObject) }
    def reversals; end
    # Whether the transfer has been fully reversed. If the transfer is only partially reversed, this attribute will still be false.
    sig { returns(T::Boolean) }
    def reversed; end
    # ID of the charge that was used to fund the transfer. If null, the transfer was funded from the available balance.
    sig { returns(T.nilable(T.any(String, ::Stripe::Charge))) }
    def source_transaction; end
    # The source balance this transfer came from. One of `card`, `fpx`, or `bank_account`.
    sig { returns(T.nilable(String)) }
    def source_type; end
    # A string that identifies this transaction as part of a group. See the [Connect documentation](https://docs.stripe.com/connect/separate-charges-and-transfers#transfer-options) for details.
    sig { returns(T.nilable(String)) }
    def transfer_group; end
    # To send funds from your Stripe account to a connected account, you create a new transfer object. Your [Stripe balance](https://docs.stripe.com/api#balance) must be able to cover the transfer amount, or you'll receive an “Insufficient Funds” error.
    sig {
      params(params: T.any(::Stripe::TransferCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Transfer)
     }
    def self.create(params = {}, opts = {}); end

    # Returns a list of existing transfers sent to connected accounts. The transfers are returned in sorted order, with the most recently created transfers appearing first.
    sig {
      params(params: T.any(::Stripe::TransferListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Updates the specified transfer by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    #
    # This request accepts only metadata as an argument.
    sig {
      params(transfer: String, params: T.any(::Stripe::TransferUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Transfer)
     }
    def self.update(transfer, params = {}, opts = {}); end
  end
end