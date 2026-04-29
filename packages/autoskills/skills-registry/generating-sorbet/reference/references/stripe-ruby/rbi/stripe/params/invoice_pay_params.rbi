# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class InvoicePayParams < ::Stripe::RequestParams
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # In cases where the source used to pay the invoice has insufficient funds, passing `forgive=true` controls whether a charge should be attempted for the full amount available on the source, up to the amount to fully pay the invoice. This effectively forgives the difference between the amount available on the source and the amount due.
    #
    # Passing `forgive=false` will fail the charge if the source hasn't been pre-funded with the right amount. An example for this case is with ACH Credit Transfers and wires: if the amount wired is less than the amount due by a small amount, you might want to forgive the difference. Defaults to `false`.
    sig { returns(T.nilable(T::Boolean)) }
    def forgive; end
    sig { params(_forgive: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def forgive=(_forgive); end
    # ID of the mandate to be used for this invoice. It must correspond to the payment method used to pay the invoice, including the payment_method param or the invoice's default_payment_method or default_source, if set.
    sig { returns(T.nilable(String)) }
    def mandate; end
    sig { params(_mandate: T.nilable(String)).returns(T.nilable(String)) }
    def mandate=(_mandate); end
    # Indicates if a customer is on or off-session while an invoice payment is attempted. Defaults to `true` (off-session).
    sig { returns(T.nilable(T::Boolean)) }
    def off_session; end
    sig { params(_off_session: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def off_session=(_off_session); end
    # Boolean representing whether an invoice is paid outside of Stripe. This will result in no charge being made. Defaults to `false`.
    sig { returns(T.nilable(T::Boolean)) }
    def paid_out_of_band; end
    sig { params(_paid_out_of_band: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def paid_out_of_band=(_paid_out_of_band); end
    # A PaymentMethod to be charged. The PaymentMethod must be the ID of a PaymentMethod belonging to the customer associated with the invoice being paid.
    sig { returns(T.nilable(String)) }
    def payment_method; end
    sig { params(_payment_method: T.nilable(String)).returns(T.nilable(String)) }
    def payment_method=(_payment_method); end
    # A payment source to be charged. The source must be the ID of a source belonging to the customer associated with the invoice being paid.
    sig { returns(T.nilable(String)) }
    def source; end
    sig { params(_source: T.nilable(String)).returns(T.nilable(String)) }
    def source=(_source); end
    sig {
      params(expand: T.nilable(T::Array[String]), forgive: T.nilable(T::Boolean), mandate: T.nilable(String), off_session: T.nilable(T::Boolean), paid_out_of_band: T.nilable(T::Boolean), payment_method: T.nilable(String), source: T.nilable(String)).void
     }
    def initialize(
      expand: nil,
      forgive: nil,
      mandate: nil,
      off_session: nil,
      paid_out_of_band: nil,
      payment_method: nil,
      source: nil
    ); end
  end
end