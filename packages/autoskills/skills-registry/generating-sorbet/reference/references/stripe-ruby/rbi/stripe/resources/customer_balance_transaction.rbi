# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Each customer has a [Balance](https://docs.stripe.com/api/customers/object#customer_object-balance) value,
  # which denotes a debit or credit that's automatically applied to their next invoice upon finalization.
  # You may modify the value directly by using the [update customer API](https://docs.stripe.com/api/customers/update),
  # or by creating a Customer Balance Transaction, which increments or decrements the customer's `balance` by the specified `amount`.
  #
  # Related guide: [Customer balance](https://docs.stripe.com/billing/customer/balance)
  class CustomerBalanceTransaction < APIResource
    # The amount of the transaction. A negative value is a credit for the customer's balance, and a positive value is a debit to the customer's `balance`.
    sig { returns(Integer) }
    def amount; end
    # The ID of the checkout session (if any) that created the transaction.
    sig { returns(T.nilable(T.any(String, ::Stripe::Checkout::Session))) }
    def checkout_session; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # The ID of the credit note (if any) related to the transaction.
    sig { returns(T.nilable(T.any(String, ::Stripe::CreditNote))) }
    def credit_note; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # The ID of the customer the transaction belongs to.
    sig { returns(T.any(String, ::Stripe::Customer)) }
    def customer; end
    # The ID of an Account representing a customer that the transaction belongs to.
    sig { returns(T.nilable(String)) }
    def customer_account; end
    # An arbitrary string attached to the object. Often useful for displaying to users.
    sig { returns(T.nilable(String)) }
    def description; end
    # The customer's `balance` after the transaction was applied. A negative value decreases the amount due on the customer's next invoice. A positive value increases the amount due on the customer's next invoice.
    sig { returns(Integer) }
    def ending_balance; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # The ID of the invoice (if any) related to the transaction.
    sig { returns(T.nilable(T.any(String, ::Stripe::Invoice))) }
    def invoice; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Transaction type: `adjustment`, `applied_to_invoice`, `credit_note`, `initial`, `invoice_overpaid`, `invoice_too_large`, `invoice_too_small`, `unspent_receiver_credit`, `unapplied_from_invoice`, `checkout_session_subscription_payment`, or `checkout_session_subscription_payment_canceled`. See the [Customer Balance page](https://docs.stripe.com/billing/customer/balance#types) to learn more about transaction types.
    sig { returns(String) }
    def type; end
  end
end