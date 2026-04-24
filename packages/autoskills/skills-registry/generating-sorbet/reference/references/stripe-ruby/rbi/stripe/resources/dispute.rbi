# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # A dispute occurs when a customer questions your charge with their card issuer.
  # When this happens, you have the opportunity to respond to the dispute with
  # evidence that shows that the charge is legitimate.
  #
  # Related guide: [Disputes and fraud](https://docs.stripe.com/disputes)
  class Dispute < APIResource
    class Evidence < ::Stripe::StripeObject
      class EnhancedEvidence < ::Stripe::StripeObject
        class VisaCompellingEvidence3 < ::Stripe::StripeObject
          class DisputedTransaction < ::Stripe::StripeObject
            class ShippingAddress < ::Stripe::StripeObject
              # City, district, suburb, town, or village.
              sig { returns(T.nilable(String)) }
              def city; end
              # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
              sig { returns(T.nilable(String)) }
              def country; end
              # Address line 1, such as the street, PO Box, or company name.
              sig { returns(T.nilable(String)) }
              def line1; end
              # Address line 2, such as the apartment, suite, unit, or building.
              sig { returns(T.nilable(String)) }
              def line2; end
              # ZIP or postal code.
              sig { returns(T.nilable(String)) }
              def postal_code; end
              # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
              sig { returns(T.nilable(String)) }
              def state; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # User Account ID used to log into business platform. Must be recognizable by the user.
            sig { returns(T.nilable(String)) }
            def customer_account_id; end
            # Unique identifier of the cardholder’s device derived from a combination of at least two hardware and software attributes. Must be at least 20 characters.
            sig { returns(T.nilable(String)) }
            def customer_device_fingerprint; end
            # Unique identifier of the cardholder’s device such as a device serial number (e.g., International Mobile Equipment Identity [IMEI]). Must be at least 15 characters.
            sig { returns(T.nilable(String)) }
            def customer_device_id; end
            # The email address of the customer.
            sig { returns(T.nilable(String)) }
            def customer_email_address; end
            # The IP address that the customer used when making the purchase.
            sig { returns(T.nilable(String)) }
            def customer_purchase_ip; end
            # Categorization of disputed payment.
            sig { returns(T.nilable(String)) }
            def merchandise_or_services; end
            # A description of the product or service that was sold.
            sig { returns(T.nilable(String)) }
            def product_description; end
            # The address to which a physical product was shipped. All fields are required for Visa Compelling Evidence 3.0 evidence submission.
            sig { returns(T.nilable(ShippingAddress)) }
            def shipping_address; end
            def self.inner_class_types
              @inner_class_types = {shipping_address: ShippingAddress}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class PriorUndisputedTransaction < ::Stripe::StripeObject
            class ShippingAddress < ::Stripe::StripeObject
              # City, district, suburb, town, or village.
              sig { returns(T.nilable(String)) }
              def city; end
              # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
              sig { returns(T.nilable(String)) }
              def country; end
              # Address line 1, such as the street, PO Box, or company name.
              sig { returns(T.nilable(String)) }
              def line1; end
              # Address line 2, such as the apartment, suite, unit, or building.
              sig { returns(T.nilable(String)) }
              def line2; end
              # ZIP or postal code.
              sig { returns(T.nilable(String)) }
              def postal_code; end
              # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
              sig { returns(T.nilable(String)) }
              def state; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Stripe charge ID for the Visa Compelling Evidence 3.0 eligible prior charge.
            sig { returns(String) }
            def charge; end
            # User Account ID used to log into business platform. Must be recognizable by the user.
            sig { returns(T.nilable(String)) }
            def customer_account_id; end
            # Unique identifier of the cardholder’s device derived from a combination of at least two hardware and software attributes. Must be at least 20 characters.
            sig { returns(T.nilable(String)) }
            def customer_device_fingerprint; end
            # Unique identifier of the cardholder’s device such as a device serial number (e.g., International Mobile Equipment Identity [IMEI]). Must be at least 15 characters.
            sig { returns(T.nilable(String)) }
            def customer_device_id; end
            # The email address of the customer.
            sig { returns(T.nilable(String)) }
            def customer_email_address; end
            # The IP address that the customer used when making the purchase.
            sig { returns(T.nilable(String)) }
            def customer_purchase_ip; end
            # A description of the product or service that was sold.
            sig { returns(T.nilable(String)) }
            def product_description; end
            # The address to which a physical product was shipped. All fields are required for Visa Compelling Evidence 3.0 evidence submission.
            sig { returns(T.nilable(ShippingAddress)) }
            def shipping_address; end
            def self.inner_class_types
              @inner_class_types = {shipping_address: ShippingAddress}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Disputed transaction details for Visa Compelling Evidence 3.0 evidence submission.
          sig { returns(T.nilable(DisputedTransaction)) }
          def disputed_transaction; end
          # List of exactly two prior undisputed transaction objects for Visa Compelling Evidence 3.0 evidence submission.
          sig { returns(T::Array[PriorUndisputedTransaction]) }
          def prior_undisputed_transactions; end
          def self.inner_class_types
            @inner_class_types = {
              disputed_transaction: DisputedTransaction,
              prior_undisputed_transactions: PriorUndisputedTransaction,
            }
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class VisaCompliance < ::Stripe::StripeObject
          # A field acknowledging the fee incurred when countering a Visa compliance dispute. If this field is set to true, evidence can be submitted for the compliance dispute. Stripe collects a 500 USD (or local equivalent) amount to cover the network costs associated with resolving compliance disputes. Stripe refunds the 500 USD network fee if you win the dispute.
          sig { returns(T::Boolean) }
          def fee_acknowledged; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field visa_compelling_evidence_3
        sig { returns(T.nilable(VisaCompellingEvidence3)) }
        def visa_compelling_evidence_3; end
        # Attribute for field visa_compliance
        sig { returns(T.nilable(VisaCompliance)) }
        def visa_compliance; end
        def self.inner_class_types
          @inner_class_types = {
            visa_compelling_evidence_3: VisaCompellingEvidence3,
            visa_compliance: VisaCompliance,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Any server or activity logs showing proof that the customer accessed or downloaded the purchased digital product. This information should include IP addresses, corresponding timestamps, and any detailed recorded activity.
      sig { returns(T.nilable(String)) }
      def access_activity_log; end
      # The billing address provided by the customer.
      sig { returns(T.nilable(String)) }
      def billing_address; end
      # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Your subscription cancellation policy, as shown to the customer.
      sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
      def cancellation_policy; end
      # An explanation of how and when the customer was shown your refund policy prior to purchase.
      sig { returns(T.nilable(String)) }
      def cancellation_policy_disclosure; end
      # A justification for why the customer's subscription was not canceled.
      sig { returns(T.nilable(String)) }
      def cancellation_rebuttal; end
      # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Any communication with the customer that you feel is relevant to your case. Examples include emails proving that the customer received the product or service, or demonstrating their use of or satisfaction with the product or service.
      sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
      def customer_communication; end
      # The email address of the customer.
      sig { returns(T.nilable(String)) }
      def customer_email_address; end
      # The name of the customer.
      sig { returns(T.nilable(String)) }
      def customer_name; end
      # The IP address that the customer used when making the purchase.
      sig { returns(T.nilable(String)) }
      def customer_purchase_ip; end
      # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) A relevant document or contract showing the customer's signature.
      sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
      def customer_signature; end
      # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Documentation for the prior charge that can uniquely identify the charge, such as a receipt, shipping label, work order, etc. This document should be paired with a similar document from the disputed payment that proves the two payments are separate.
      sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
      def duplicate_charge_documentation; end
      # An explanation of the difference between the disputed charge versus the prior charge that appears to be a duplicate.
      sig { returns(T.nilable(String)) }
      def duplicate_charge_explanation; end
      # The Stripe ID for the prior charge which appears to be a duplicate of the disputed charge.
      sig { returns(T.nilable(String)) }
      def duplicate_charge_id; end
      # Attribute for field enhanced_evidence
      sig { returns(EnhancedEvidence) }
      def enhanced_evidence; end
      # A description of the product or service that was sold.
      sig { returns(T.nilable(String)) }
      def product_description; end
      # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Any receipt or message sent to the customer notifying them of the charge.
      sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
      def receipt; end
      # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Your refund policy, as shown to the customer.
      sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
      def refund_policy; end
      # Documentation demonstrating that the customer was shown your refund policy prior to purchase.
      sig { returns(T.nilable(String)) }
      def refund_policy_disclosure; end
      # A justification for why the customer is not entitled to a refund.
      sig { returns(T.nilable(String)) }
      def refund_refusal_explanation; end
      # The date on which the customer received or began receiving the purchased service, in a clear human-readable format.
      sig { returns(T.nilable(String)) }
      def service_date; end
      # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Documentation showing proof that a service was provided to the customer. This could include a copy of a signed contract, work order, or other form of written agreement.
      sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
      def service_documentation; end
      # The address to which a physical product was shipped. You should try to include as complete address information as possible.
      sig { returns(T.nilable(String)) }
      def shipping_address; end
      # The delivery service that shipped a physical product, such as Fedex, UPS, USPS, etc. If multiple carriers were used for this purchase, please separate them with commas.
      sig { returns(T.nilable(String)) }
      def shipping_carrier; end
      # The date on which a physical product began its route to the shipping address, in a clear human-readable format.
      sig { returns(T.nilable(String)) }
      def shipping_date; end
      # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Documentation showing proof that a product was shipped to the customer at the same address the customer provided to you. This could include a copy of the shipment receipt, shipping label, etc. It should show the customer's full shipping address, if possible.
      sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
      def shipping_documentation; end
      # The tracking number for a physical product, obtained from the delivery service. If multiple tracking numbers were generated for this purchase, please separate them with commas.
      sig { returns(T.nilable(String)) }
      def shipping_tracking_number; end
      # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Any additional evidence or statements.
      sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
      def uncategorized_file; end
      # Any additional evidence or statements.
      sig { returns(T.nilable(String)) }
      def uncategorized_text; end
      def self.inner_class_types
        @inner_class_types = {enhanced_evidence: EnhancedEvidence}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class EvidenceDetails < ::Stripe::StripeObject
      class EnhancedEligibility < ::Stripe::StripeObject
        class VisaCompellingEvidence3 < ::Stripe::StripeObject
          # List of actions required to qualify dispute for Visa Compelling Evidence 3.0 evidence submission.
          sig { returns(T::Array[String]) }
          def required_actions; end
          # Visa Compelling Evidence 3.0 eligibility status.
          sig { returns(String) }
          def status; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class VisaCompliance < ::Stripe::StripeObject
          # Visa compliance eligibility status.
          sig { returns(String) }
          def status; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field visa_compelling_evidence_3
        sig { returns(T.nilable(VisaCompellingEvidence3)) }
        def visa_compelling_evidence_3; end
        # Attribute for field visa_compliance
        sig { returns(T.nilable(VisaCompliance)) }
        def visa_compliance; end
        def self.inner_class_types
          @inner_class_types = {
            visa_compelling_evidence_3: VisaCompellingEvidence3,
            visa_compliance: VisaCompliance,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Date by which evidence must be submitted in order to successfully challenge dispute. Will be 0 if the customer's bank or credit card company doesn't allow a response for this particular dispute.
      sig { returns(T.nilable(Integer)) }
      def due_by; end
      # Attribute for field enhanced_eligibility
      sig { returns(EnhancedEligibility) }
      def enhanced_eligibility; end
      # Whether evidence has been staged for this dispute.
      sig { returns(T::Boolean) }
      def has_evidence; end
      # Whether the last evidence submission was submitted past the due date. Defaults to `false` if no evidence submissions have occurred. If `true`, then delivery of the latest evidence is *not* guaranteed.
      sig { returns(T::Boolean) }
      def past_due; end
      # The number of times evidence has been submitted. Typically, you may only submit evidence once.
      sig { returns(Integer) }
      def submission_count; end
      def self.inner_class_types
        @inner_class_types = {enhanced_eligibility: EnhancedEligibility}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class PaymentMethodDetails < ::Stripe::StripeObject
      class AmazonPay < ::Stripe::StripeObject
        # The AmazonPay dispute type, chargeback or claim
        sig { returns(T.nilable(String)) }
        def dispute_type; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Card < ::Stripe::StripeObject
        # Card brand. Can be `amex`, `cartes_bancaires`, `diners`, `discover`, `eftpos_au`, `jcb`, `link`, `mastercard`, `unionpay`, `visa` or `unknown`.
        sig { returns(String) }
        def brand; end
        # The type of dispute opened. Different case types may have varying fees and financial impact.
        sig { returns(String) }
        def case_type; end
        # The card network's specific dispute reason code, which maps to one of Stripe's primary dispute categories to simplify response guidance. The [Network code map](https://stripe.com/docs/disputes/categories#network-code-map) lists all available dispute reason codes by network.
        sig { returns(T.nilable(String)) }
        def network_reason_code; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Klarna < ::Stripe::StripeObject
        # Chargeback loss reason mapped by Stripe from Klarna's chargeback loss reason
        sig { returns(T.nilable(String)) }
        def chargeback_loss_reason_code; end
        # The reason for the dispute as defined by Klarna
        sig { returns(T.nilable(String)) }
        def reason_code; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Paypal < ::Stripe::StripeObject
        # The ID of the dispute in PayPal.
        sig { returns(T.nilable(String)) }
        def case_id; end
        # The reason for the dispute as defined by PayPal
        sig { returns(T.nilable(String)) }
        def reason_code; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field amazon_pay
      sig { returns(T.nilable(AmazonPay)) }
      def amazon_pay; end
      # Attribute for field card
      sig { returns(T.nilable(Card)) }
      def card; end
      # Attribute for field klarna
      sig { returns(T.nilable(Klarna)) }
      def klarna; end
      # Attribute for field paypal
      sig { returns(T.nilable(Paypal)) }
      def paypal; end
      # Payment method type.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {amazon_pay: AmazonPay, card: Card, klarna: Klarna, paypal: Paypal}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Disputed amount. Usually the amount of the charge, but it can differ (usually because of currency fluctuation or because only part of the order is disputed).
    sig { returns(Integer) }
    def amount; end
    # List of zero, one, or two balance transactions that show funds withdrawn and reinstated to your Stripe account as a result of this dispute.
    sig { returns(T::Array[::Stripe::BalanceTransaction]) }
    def balance_transactions; end
    # ID of the charge that's disputed.
    sig { returns(T.any(String, ::Stripe::Charge)) }
    def charge; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # List of eligibility types that are included in `enhanced_evidence`.
    sig { returns(T::Array[String]) }
    def enhanced_eligibility_types; end
    # Attribute for field evidence
    sig { returns(Evidence) }
    def evidence; end
    # Attribute for field evidence_details
    sig { returns(EvidenceDetails) }
    def evidence_details; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # If true, it's still possible to refund the disputed payment. After the payment has been fully refunded, no further funds are withdrawn from your Stripe account as a result of this dispute.
    sig { returns(T::Boolean) }
    def is_charge_refundable; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T::Hash[String, String]) }
    def metadata; end
    # Network-dependent reason code for the dispute.
    sig { returns(T.nilable(String)) }
    def network_reason_code; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # ID of the PaymentIntent that's disputed.
    sig { returns(T.nilable(T.any(String, ::Stripe::PaymentIntent))) }
    def payment_intent; end
    # Attribute for field payment_method_details
    sig { returns(T.nilable(PaymentMethodDetails)) }
    def payment_method_details; end
    # Reason given by cardholder for dispute. Possible values are `bank_cannot_process`, `check_returned`, `credit_not_processed`, `customer_initiated`, `debit_not_authorized`, `duplicate`, `fraudulent`, `general`, `incorrect_account_details`, `insufficient_funds`, `noncompliant`, `product_not_received`, `product_unacceptable`, `subscription_canceled`, or `unrecognized`. Learn more about [dispute reasons](https://docs.stripe.com/disputes/categories).
    sig { returns(String) }
    def reason; end
    # The current status of a dispute. Possible values include:`warning_needs_response`, `warning_under_review`, `warning_closed`, `needs_response`, `under_review`, `won`, `lost`, or `prevented`.
    sig { returns(String) }
    def status; end
    # Closing the dispute for a charge indicates that you do not have any evidence to submit and are essentially dismissing the dispute, acknowledging it as lost.
    #
    # The status of the dispute will change from needs_response to lost. Closing a dispute is irreversible.
    sig {
      params(params: T.any(::Stripe::DisputeCloseParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Dispute)
     }
    def close(params = {}, opts = {}); end

    # Closing the dispute for a charge indicates that you do not have any evidence to submit and are essentially dismissing the dispute, acknowledging it as lost.
    #
    # The status of the dispute will change from needs_response to lost. Closing a dispute is irreversible.
    sig {
      params(dispute: String, params: T.any(::Stripe::DisputeCloseParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Dispute)
     }
    def self.close(dispute, params = {}, opts = {}); end

    # Returns a list of your disputes.
    sig {
      params(params: T.any(::Stripe::DisputeListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # When you get a dispute, contacting your customer is always the best first step. If that doesn't work, you can submit evidence to help us resolve the dispute in your favor. You can do this in your [dashboard](https://dashboard.stripe.com/disputes), but if you prefer, you can use the API to submit evidence programmatically.
    #
    # Depending on your dispute type, different evidence fields will give you a better chance of winning your dispute. To figure out which evidence fields to provide, see our [guide to dispute types](https://docs.stripe.com/docs/disputes/categories).
    sig {
      params(dispute: String, params: T.any(::Stripe::DisputeUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Dispute)
     }
    def self.update(dispute, params = {}, opts = {}); end
  end
end