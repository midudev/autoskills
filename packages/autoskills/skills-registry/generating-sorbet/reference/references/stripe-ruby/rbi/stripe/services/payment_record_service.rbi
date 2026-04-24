# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentRecordService < StripeService
    # Report a new Payment Record. You may report a Payment Record as it is
    #  initialized and later report updates through the other report_* methods, or report Payment
    #  Records in a terminal state directly, through this method.
    sig {
      params(params: T.any(::Stripe::PaymentRecordReportPaymentParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def report_payment(params = {}, opts = {}); end

    # Report a new payment attempt on the specified Payment Record. A new payment
    #  attempt can only be specified if all other payment attempts are canceled or failed.
    sig {
      params(id: String, params: T.any(::Stripe::PaymentRecordReportPaymentAttemptParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def report_payment_attempt(id, params = {}, opts = {}); end

    # Report that the most recent payment attempt on the specified Payment Record
    #  was canceled.
    sig {
      params(id: String, params: T.any(::Stripe::PaymentRecordReportPaymentAttemptCanceledParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def report_payment_attempt_canceled(id, params = {}, opts = {}); end

    # Report that the most recent payment attempt on the specified Payment Record
    #  failed or errored.
    sig {
      params(id: String, params: T.any(::Stripe::PaymentRecordReportPaymentAttemptFailedParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def report_payment_attempt_failed(id, params = {}, opts = {}); end

    # Report that the most recent payment attempt on the specified Payment Record
    #  was guaranteed.
    sig {
      params(id: String, params: T.any(::Stripe::PaymentRecordReportPaymentAttemptGuaranteedParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def report_payment_attempt_guaranteed(id, params = {}, opts = {}); end

    # Report informational updates on the specified Payment Record.
    sig {
      params(id: String, params: T.any(::Stripe::PaymentRecordReportPaymentAttemptInformationalParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def report_payment_attempt_informational(id, params = {}, opts = {}); end

    # Report that the most recent payment attempt on the specified Payment Record
    #  was refunded.
    sig {
      params(id: String, params: T.any(::Stripe::PaymentRecordReportRefundParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def report_refund(id, params = {}, opts = {}); end

    # Retrieves a Payment Record with the given ID
    sig {
      params(id: String, params: T.any(::Stripe::PaymentRecordRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def retrieve(id, params = {}, opts = {}); end
  end
end