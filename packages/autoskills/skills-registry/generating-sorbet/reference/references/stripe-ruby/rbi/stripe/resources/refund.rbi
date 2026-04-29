# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Refund objects allow you to refund a previously created charge that isn't
  # refunded yet. Funds are refunded to the credit or debit card that's
  # initially charged.
  #
  # Related guide: [Refunds](https://docs.stripe.com/refunds)
  class Refund < APIResource
    class DestinationDetails < ::Stripe::StripeObject
      class Affirm < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class AfterpayClearpay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Alipay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Alma < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class AmazonPay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class AuBankTransfer < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Blik < ::Stripe::StripeObject
        # For refunds declined by the network, a decline code provided by the network which indicates the reason the refund failed.
        sig { returns(T.nilable(String)) }
        def network_decline_code; end
        # The reference assigned to the refund.
        sig { returns(T.nilable(String)) }
        def reference; end
        # Status of the reference on the refund. This can be `pending`, `available` or `unavailable`.
        sig { returns(T.nilable(String)) }
        def reference_status; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class BrBankTransfer < ::Stripe::StripeObject
        # The reference assigned to the refund.
        sig { returns(T.nilable(String)) }
        def reference; end
        # Status of the reference on the refund. This can be `pending`, `available` or `unavailable`.
        sig { returns(T.nilable(String)) }
        def reference_status; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Card < ::Stripe::StripeObject
        # Value of the reference number assigned to the refund.
        sig { returns(T.nilable(String)) }
        def reference; end
        # Status of the reference number on the refund. This can be `pending`, `available` or `unavailable`.
        sig { returns(T.nilable(String)) }
        def reference_status; end
        # Type of the reference number assigned to the refund.
        sig { returns(T.nilable(String)) }
        def reference_type; end
        # The type of refund. This can be `refund`, `reversal`, or `pending`.
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Cashapp < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Crypto < ::Stripe::StripeObject
        # The transaction hash of the refund.
        sig { returns(T.nilable(String)) }
        def reference; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class CustomerCashBalance < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Eps < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class EuBankTransfer < ::Stripe::StripeObject
        # The reference assigned to the refund.
        sig { returns(T.nilable(String)) }
        def reference; end
        # Status of the reference on the refund. This can be `pending`, `available` or `unavailable`.
        sig { returns(T.nilable(String)) }
        def reference_status; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class GbBankTransfer < ::Stripe::StripeObject
        # The reference assigned to the refund.
        sig { returns(T.nilable(String)) }
        def reference; end
        # Status of the reference on the refund. This can be `pending`, `available` or `unavailable`.
        sig { returns(T.nilable(String)) }
        def reference_status; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Giropay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Grabpay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class JpBankTransfer < ::Stripe::StripeObject
        # The reference assigned to the refund.
        sig { returns(T.nilable(String)) }
        def reference; end
        # Status of the reference on the refund. This can be `pending`, `available` or `unavailable`.
        sig { returns(T.nilable(String)) }
        def reference_status; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Klarna < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class MbWay < ::Stripe::StripeObject
        # The reference assigned to the refund.
        sig { returns(T.nilable(String)) }
        def reference; end
        # Status of the reference on the refund. This can be `pending`, `available` or `unavailable`.
        sig { returns(T.nilable(String)) }
        def reference_status; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Multibanco < ::Stripe::StripeObject
        # The reference assigned to the refund.
        sig { returns(T.nilable(String)) }
        def reference; end
        # Status of the reference on the refund. This can be `pending`, `available` or `unavailable`.
        sig { returns(T.nilable(String)) }
        def reference_status; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class MxBankTransfer < ::Stripe::StripeObject
        # The reference assigned to the refund.
        sig { returns(T.nilable(String)) }
        def reference; end
        # Status of the reference on the refund. This can be `pending`, `available` or `unavailable`.
        sig { returns(T.nilable(String)) }
        def reference_status; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class NzBankTransfer < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class P24 < ::Stripe::StripeObject
        # The reference assigned to the refund.
        sig { returns(T.nilable(String)) }
        def reference; end
        # Status of the reference on the refund. This can be `pending`, `available` or `unavailable`.
        sig { returns(T.nilable(String)) }
        def reference_status; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Paynow < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Paypal < ::Stripe::StripeObject
        # For refunds declined by the network, a decline code provided by the network which indicates the reason the refund failed.
        sig { returns(T.nilable(String)) }
        def network_decline_code; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Pix < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Revolut < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Sofort < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Swish < ::Stripe::StripeObject
        # For refunds declined by the network, a decline code provided by the network which indicates the reason the refund failed.
        sig { returns(T.nilable(String)) }
        def network_decline_code; end
        # The reference assigned to the refund.
        sig { returns(T.nilable(String)) }
        def reference; end
        # Status of the reference on the refund. This can be `pending`, `available` or `unavailable`.
        sig { returns(T.nilable(String)) }
        def reference_status; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class ThBankTransfer < ::Stripe::StripeObject
        # The reference assigned to the refund.
        sig { returns(T.nilable(String)) }
        def reference; end
        # Status of the reference on the refund. This can be `pending`, `available` or `unavailable`.
        sig { returns(T.nilable(String)) }
        def reference_status; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Twint < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class UsBankTransfer < ::Stripe::StripeObject
        # The reference assigned to the refund.
        sig { returns(T.nilable(String)) }
        def reference; end
        # Status of the reference on the refund. This can be `pending`, `available` or `unavailable`.
        sig { returns(T.nilable(String)) }
        def reference_status; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class WechatPay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Zip < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field affirm
      sig { returns(T.nilable(Affirm)) }
      def affirm; end
      # Attribute for field afterpay_clearpay
      sig { returns(T.nilable(AfterpayClearpay)) }
      def afterpay_clearpay; end
      # Attribute for field alipay
      sig { returns(T.nilable(Alipay)) }
      def alipay; end
      # Attribute for field alma
      sig { returns(T.nilable(Alma)) }
      def alma; end
      # Attribute for field amazon_pay
      sig { returns(T.nilable(AmazonPay)) }
      def amazon_pay; end
      # Attribute for field au_bank_transfer
      sig { returns(T.nilable(AuBankTransfer)) }
      def au_bank_transfer; end
      # Attribute for field blik
      sig { returns(T.nilable(Blik)) }
      def blik; end
      # Attribute for field br_bank_transfer
      sig { returns(T.nilable(BrBankTransfer)) }
      def br_bank_transfer; end
      # Attribute for field card
      sig { returns(T.nilable(Card)) }
      def card; end
      # Attribute for field cashapp
      sig { returns(T.nilable(Cashapp)) }
      def cashapp; end
      # Attribute for field crypto
      sig { returns(T.nilable(Crypto)) }
      def crypto; end
      # Attribute for field customer_cash_balance
      sig { returns(T.nilable(CustomerCashBalance)) }
      def customer_cash_balance; end
      # Attribute for field eps
      sig { returns(T.nilable(Eps)) }
      def eps; end
      # Attribute for field eu_bank_transfer
      sig { returns(T.nilable(EuBankTransfer)) }
      def eu_bank_transfer; end
      # Attribute for field gb_bank_transfer
      sig { returns(T.nilable(GbBankTransfer)) }
      def gb_bank_transfer; end
      # Attribute for field giropay
      sig { returns(T.nilable(Giropay)) }
      def giropay; end
      # Attribute for field grabpay
      sig { returns(T.nilable(Grabpay)) }
      def grabpay; end
      # Attribute for field jp_bank_transfer
      sig { returns(T.nilable(JpBankTransfer)) }
      def jp_bank_transfer; end
      # Attribute for field klarna
      sig { returns(T.nilable(Klarna)) }
      def klarna; end
      # Attribute for field mb_way
      sig { returns(T.nilable(MbWay)) }
      def mb_way; end
      # Attribute for field multibanco
      sig { returns(T.nilable(Multibanco)) }
      def multibanco; end
      # Attribute for field mx_bank_transfer
      sig { returns(T.nilable(MxBankTransfer)) }
      def mx_bank_transfer; end
      # Attribute for field nz_bank_transfer
      sig { returns(T.nilable(NzBankTransfer)) }
      def nz_bank_transfer; end
      # Attribute for field p24
      sig { returns(T.nilable(P24)) }
      def p24; end
      # Attribute for field paynow
      sig { returns(T.nilable(Paynow)) }
      def paynow; end
      # Attribute for field paypal
      sig { returns(T.nilable(Paypal)) }
      def paypal; end
      # Attribute for field pix
      sig { returns(T.nilable(Pix)) }
      def pix; end
      # Attribute for field revolut
      sig { returns(T.nilable(Revolut)) }
      def revolut; end
      # Attribute for field sofort
      sig { returns(T.nilable(Sofort)) }
      def sofort; end
      # Attribute for field swish
      sig { returns(T.nilable(Swish)) }
      def swish; end
      # Attribute for field th_bank_transfer
      sig { returns(T.nilable(ThBankTransfer)) }
      def th_bank_transfer; end
      # Attribute for field twint
      sig { returns(T.nilable(Twint)) }
      def twint; end
      # The type of transaction-specific details of the payment method used in the refund (e.g., `card`). An additional hash is included on `destination_details` with a name matching this value. It contains information specific to the refund transaction.
      sig { returns(String) }
      def type; end
      # Attribute for field us_bank_transfer
      sig { returns(T.nilable(UsBankTransfer)) }
      def us_bank_transfer; end
      # Attribute for field wechat_pay
      sig { returns(T.nilable(WechatPay)) }
      def wechat_pay; end
      # Attribute for field zip
      sig { returns(T.nilable(Zip)) }
      def zip; end
      def self.inner_class_types
        @inner_class_types = {
          affirm: Affirm,
          afterpay_clearpay: AfterpayClearpay,
          alipay: Alipay,
          alma: Alma,
          amazon_pay: AmazonPay,
          au_bank_transfer: AuBankTransfer,
          blik: Blik,
          br_bank_transfer: BrBankTransfer,
          card: Card,
          cashapp: Cashapp,
          crypto: Crypto,
          customer_cash_balance: CustomerCashBalance,
          eps: Eps,
          eu_bank_transfer: EuBankTransfer,
          gb_bank_transfer: GbBankTransfer,
          giropay: Giropay,
          grabpay: Grabpay,
          jp_bank_transfer: JpBankTransfer,
          klarna: Klarna,
          mb_way: MbWay,
          multibanco: Multibanco,
          mx_bank_transfer: MxBankTransfer,
          nz_bank_transfer: NzBankTransfer,
          p24: P24,
          paynow: Paynow,
          paypal: Paypal,
          pix: Pix,
          revolut: Revolut,
          sofort: Sofort,
          swish: Swish,
          th_bank_transfer: ThBankTransfer,
          twint: Twint,
          us_bank_transfer: UsBankTransfer,
          wechat_pay: WechatPay,
          zip: Zip,
        }
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class NextAction < ::Stripe::StripeObject
      class DisplayDetails < ::Stripe::StripeObject
        class EmailSent < ::Stripe::StripeObject
          # The timestamp when the email was sent.
          sig { returns(Integer) }
          def email_sent_at; end
          # The recipient's email address.
          sig { returns(String) }
          def email_sent_to; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field email_sent
        sig { returns(EmailSent) }
        def email_sent; end
        # The expiry timestamp.
        sig { returns(Integer) }
        def expires_at; end
        def self.inner_class_types
          @inner_class_types = {email_sent: EmailSent}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field display_details
      sig { returns(T.nilable(DisplayDetails)) }
      def display_details; end
      # Type of the next action to perform.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {display_details: DisplayDetails}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class PresentmentDetails < ::Stripe::StripeObject
      # Amount intended to be collected by this payment, denominated in `presentment_currency`.
      sig { returns(Integer) }
      def presentment_amount; end
      # Currency presented to the customer during payment.
      sig { returns(String) }
      def presentment_currency; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Amount, in cents (or local equivalent).
    sig { returns(Integer) }
    def amount; end
    # Balance transaction that describes the impact on your account balance.
    sig { returns(T.nilable(T.any(String, ::Stripe::BalanceTransaction))) }
    def balance_transaction; end
    # ID of the charge that's refunded.
    sig { returns(T.nilable(T.any(String, ::Stripe::Charge))) }
    def charge; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # An arbitrary string attached to the object. You can use this for displaying to users (available on non-card refunds only).
    sig { returns(T.nilable(String)) }
    def description; end
    # Attribute for field destination_details
    sig { returns(T.nilable(DestinationDetails)) }
    def destination_details; end
    # After the refund fails, this balance transaction describes the adjustment made on your account balance that reverses the initial balance transaction.
    sig { returns(T.nilable(T.any(String, ::Stripe::BalanceTransaction))) }
    def failure_balance_transaction; end
    # Provides the reason for the refund failure. Possible values are: `lost_or_stolen_card`, `expired_or_canceled_card`, `charge_for_pending_refund_disputed`, `insufficient_funds`, `declined`, `merchant_request`, or `unknown`.
    sig { returns(T.nilable(String)) }
    def failure_reason; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # For payment methods without native refund support (for example, Konbini, PromptPay), provide an email address for the customer to receive refund instructions.
    sig { returns(T.nilable(String)) }
    def instructions_email; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # Attribute for field next_action
    sig { returns(T.nilable(NextAction)) }
    def next_action; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # ID of the PaymentIntent that's refunded.
    sig { returns(T.nilable(T.any(String, ::Stripe::PaymentIntent))) }
    def payment_intent; end
    # Provides the reason for why the refund is pending. Possible values are: `processing`, `insufficient_funds`, or `charge_pending`.
    sig { returns(T.nilable(String)) }
    def pending_reason; end
    # Attribute for field presentment_details
    sig { returns(T.nilable(PresentmentDetails)) }
    def presentment_details; end
    # Reason for the refund, which is either user-provided (`duplicate`, `fraudulent`, or `requested_by_customer`) or generated by Stripe internally (`expired_uncaptured_charge`).
    sig { returns(T.nilable(String)) }
    def reason; end
    # This is the transaction number that appears on email receipts sent for this refund.
    sig { returns(T.nilable(String)) }
    def receipt_number; end
    # The transfer reversal that's associated with the refund. Only present if the charge came from another Stripe account.
    sig { returns(T.nilable(T.any(String, ::Stripe::Reversal))) }
    def source_transfer_reversal; end
    # Status of the refund. This can be `pending`, `requires_action`, `succeeded`, `failed`, or `canceled`. Learn more about [failed refunds](https://docs.stripe.com/refunds#failed-refunds).
    sig { returns(T.nilable(String)) }
    def status; end
    # This refers to the transfer reversal object if the accompanying transfer reverses. This is only applicable if the charge was created using the destination parameter.
    sig { returns(T.nilable(T.any(String, ::Stripe::Reversal))) }
    def transfer_reversal; end
    # Cancels a refund with a status of requires_action.
    #
    # You can't cancel refunds in other states. Only refunds for payment methods that require customer action can enter the requires_action state.
    sig {
      params(params: T.any(::Stripe::RefundCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Refund)
     }
    def cancel(params = {}, opts = {}); end

    # Cancels a refund with a status of requires_action.
    #
    # You can't cancel refunds in other states. Only refunds for payment methods that require customer action can enter the requires_action state.
    sig {
      params(refund: String, params: T.any(::Stripe::RefundCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Refund)
     }
    def self.cancel(refund, params = {}, opts = {}); end

    # When you create a new refund, you must specify a Charge or a PaymentIntent object on which to create it.
    #
    # Creating a new refund will refund a charge that has previously been created but not yet refunded.
    # Funds will be refunded to the credit or debit card that was originally charged.
    #
    # You can optionally refund only part of a charge.
    # You can do so multiple times, until the entire charge has been refunded.
    #
    # Once entirely refunded, a charge can't be refunded again.
    # This method will raise an error when called on an already-refunded charge,
    # or when trying to refund more money than is left on a charge.
    sig {
      params(params: T.any(::Stripe::RefundCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Refund)
     }
    def self.create(params = {}, opts = {}); end

    # Returns a list of all refunds you created. We return the refunds in sorted order, with the most recent refunds appearing first. The 10 most recent refunds are always available by default on the Charge object.
    sig {
      params(params: T.any(::Stripe::RefundListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Updates the refund that you specify by setting the values of the passed parameters. Any parameters that you don't provide remain unchanged.
    #
    # This request only accepts metadata as an argument.
    sig {
      params(refund: String, params: T.any(::Stripe::RefundUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Refund)
     }
    def self.update(refund, params = {}, opts = {}); end
  end
end