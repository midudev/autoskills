# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # To top up your Stripe balance, you create a top-up object. You can retrieve
  # individual top-ups, as well as list all top-ups. Top-ups are identified by a
  # unique, random ID.
  #
  # Related guide: [Topping up your platform account](https://docs.stripe.com/connect/top-ups)
  class Topup < APIResource
    # Amount transferred.
    sig { returns(Integer) }
    def amount; end
    # ID of the balance transaction that describes the impact of this top-up on your account balance. May not be specified depending on status of top-up.
    sig { returns(T.nilable(T.any(String, ::Stripe::BalanceTransaction))) }
    def balance_transaction; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # An arbitrary string attached to the object. Often useful for displaying to users.
    sig { returns(T.nilable(String)) }
    def description; end
    # Date the funds are expected to arrive in your Stripe account for payouts. This factors in delays like weekends or bank holidays. May not be specified depending on status of top-up.
    sig { returns(T.nilable(Integer)) }
    def expected_availability_date; end
    # Error code explaining reason for top-up failure if available (see [the errors section](https://docs.stripe.com/api#errors) for a list of codes).
    sig { returns(T.nilable(String)) }
    def failure_code; end
    # Message to user further explaining reason for top-up failure if available.
    sig { returns(T.nilable(String)) }
    def failure_message; end
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
    # The source field is deprecated. It might not always be present in the API response.
    sig { returns(T.nilable(::Stripe::Source)) }
    def source; end
    # Extra information about a top-up. This will appear on your source's bank statement. It must contain at least one letter.
    sig { returns(T.nilable(String)) }
    def statement_descriptor; end
    # The status of the top-up is either `canceled`, `failed`, `pending`, `reversed`, or `succeeded`.
    sig { returns(String) }
    def status; end
    # A string that identifies this top-up as part of a group.
    sig { returns(T.nilable(String)) }
    def transfer_group; end
    # Cancels a top-up. Only pending top-ups can be canceled.
    sig {
      params(params: T.any(::Stripe::TopupCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Topup)
     }
    def cancel(params = {}, opts = {}); end

    # Cancels a top-up. Only pending top-ups can be canceled.
    sig {
      params(topup: String, params: T.any(::Stripe::TopupCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Topup)
     }
    def self.cancel(topup, params = {}, opts = {}); end

    # Top up the balance of an account
    sig {
      params(params: T.any(::Stripe::TopupCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Topup)
     }
    def self.create(params = {}, opts = {}); end

    # Returns a list of top-ups.
    sig {
      params(params: T.any(::Stripe::TopupListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Updates the metadata of a top-up. Other top-up details are not editable by design.
    sig {
      params(topup: String, params: T.any(::Stripe::TopupUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Topup)
     }
    def self.update(topup, params = {}, opts = {}); end
  end
end