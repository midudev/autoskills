# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Invoices are statements of amounts owed by a customer, and are either
  # generated one-off, or generated periodically from a subscription.
  #
  # They contain [invoice items](https://api.stripe.com#invoiceitems), and proration adjustments
  # that may be caused by subscription upgrades/downgrades (if necessary).
  #
  # If your invoice is configured to be billed through automatic charges,
  # Stripe automatically finalizes your invoice and attempts payment. Note
  # that finalizing the invoice,
  # [when automatic](https://docs.stripe.com/invoicing/integration/automatic-advancement-collection), does
  # not happen immediately as the invoice is created. Stripe waits
  # until one hour after the last webhook was successfully sent (or the last
  # webhook timed out after failing). If you (and the platforms you may have
  # connected to) have no webhooks configured, Stripe waits one hour after
  # creation to finalize the invoice.
  #
  # If your invoice is configured to be billed by sending an email, then based on your
  # [email settings](https://dashboard.stripe.com/account/billing/automatic),
  # Stripe will email the invoice to your customer and await payment. These
  # emails can contain a link to a hosted page to pay the invoice.
  #
  # Stripe applies any customer credit on the account before determining the
  # amount due for the invoice (i.e., the amount that will be actually
  # charged). If the amount due for the invoice is less than Stripe's [minimum allowed charge
  # per currency](https://docs.stripe.com/docs/currencies#minimum-and-maximum-charge-amounts), the
  # invoice is automatically marked paid, and we add the amount due to the
  # customer's credit balance which is applied to the next invoice.
  #
  # More details on the customer's credit balance are
  # [here](https://docs.stripe.com/billing/customer/balance).
  #
  # Related guide: [Send invoices to customers](https://docs.stripe.com/billing/invoices/sending)
  class Invoice < APIResource
    class AutomaticTax < ::Stripe::StripeObject
      class Liability < ::Stripe::StripeObject
        # The connected account being referenced when `type` is `account`.
        sig { returns(T.nilable(T.any(String, ::Stripe::Account))) }
        def account; end
        # Type of the account referenced.
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # If Stripe disabled automatic tax, this enum describes why.
      sig { returns(T.nilable(String)) }
      def disabled_reason; end
      # Whether Stripe automatically computes tax on this invoice. Note that incompatible invoice items (invoice items with manually specified [tax rates](https://docs.stripe.com/api/tax_rates), negative amounts, or `tax_behavior=unspecified`) cannot be added to automatic tax invoices.
      sig { returns(T::Boolean) }
      def enabled; end
      # The account that's liable for tax. If set, the business address and tax registrations required to perform the tax calculation are loaded from this account. The tax transaction is returned in the report of the connected account.
      sig { returns(T.nilable(Liability)) }
      def liability; end
      # The tax provider powering automatic tax.
      sig { returns(T.nilable(String)) }
      def provider; end
      # The status of the most recent automated tax calculation for this invoice.
      sig { returns(T.nilable(String)) }
      def status; end
      def self.inner_class_types
        @inner_class_types = {liability: Liability}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class ConfirmationSecret < ::Stripe::StripeObject
      # The client_secret of the payment that Stripe creates for the invoice after finalization.
      sig { returns(String) }
      def client_secret; end
      # The type of client_secret. Currently this is always payment_intent, referencing the default payment_intent that Stripe creates during invoice finalization
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class CustomField < ::Stripe::StripeObject
      # The name of the custom field.
      sig { returns(String) }
      def name; end
      # The value of the custom field.
      sig { returns(String) }
      def value; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class CustomerAddress < ::Stripe::StripeObject
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
    class CustomerShipping < ::Stripe::StripeObject
      class Address < ::Stripe::StripeObject
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
      # Attribute for field address
      sig { returns(T.nilable(Address)) }
      def address; end
      # The delivery service that shipped a physical product, such as Fedex, UPS, USPS, etc.
      sig { returns(T.nilable(String)) }
      def carrier; end
      # Recipient name.
      sig { returns(T.nilable(String)) }
      def name; end
      # Recipient phone (including extension).
      sig { returns(T.nilable(String)) }
      def phone; end
      # The tracking number for a physical product, obtained from the delivery service. If multiple tracking numbers were generated for this purchase, please separate them with commas.
      sig { returns(T.nilable(String)) }
      def tracking_number; end
      def self.inner_class_types
        @inner_class_types = {address: Address}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class CustomerTaxId < ::Stripe::StripeObject
      # The type of the tax ID, one of `ad_nrt`, `ar_cuit`, `eu_vat`, `bo_tin`, `br_cnpj`, `br_cpf`, `cn_tin`, `co_nit`, `cr_tin`, `do_rcn`, `ec_ruc`, `eu_oss_vat`, `hr_oib`, `pe_ruc`, `ro_tin`, `rs_pib`, `sv_nit`, `uy_ruc`, `ve_rif`, `vn_tin`, `gb_vat`, `nz_gst`, `au_abn`, `au_arn`, `in_gst`, `no_vat`, `no_voec`, `za_vat`, `ch_vat`, `mx_rfc`, `sg_uen`, `ru_inn`, `ru_kpp`, `ca_bn`, `hk_br`, `es_cif`, `tw_vat`, `th_vat`, `jp_cn`, `jp_rn`, `jp_trn`, `li_uid`, `li_vat`, `my_itn`, `us_ein`, `kr_brn`, `ca_qst`, `ca_gst_hst`, `ca_pst_bc`, `ca_pst_mb`, `ca_pst_sk`, `my_sst`, `sg_gst`, `ae_trn`, `cl_tin`, `sa_vat`, `id_npwp`, `my_frp`, `il_vat`, `ge_vat`, `ua_vat`, `is_vat`, `bg_uic`, `hu_tin`, `si_tin`, `ke_pin`, `tr_tin`, `eg_tin`, `ph_tin`, `al_tin`, `bh_vat`, `kz_bin`, `ng_tin`, `om_vat`, `de_stn`, `ch_uid`, `tz_vat`, `uz_vat`, `uz_tin`, `md_vat`, `ma_vat`, `by_tin`, `ao_tin`, `bs_tin`, `bb_tin`, `cd_nif`, `mr_nif`, `me_pib`, `zw_tin`, `ba_tin`, `gn_nif`, `mk_vat`, `sr_fin`, `sn_ninea`, `am_tin`, `np_pan`, `tj_tin`, `ug_tin`, `zm_tin`, `kh_tin`, `aw_tin`, `az_tin`, `bd_bin`, `bj_ifu`, `et_tin`, `kg_tin`, `la_tin`, `cm_niu`, `cv_nif`, `bf_ifu`, or `unknown`
      sig { returns(String) }
      def type; end
      # The value of the tax ID.
      sig { returns(T.nilable(String)) }
      def value; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class FromInvoice < ::Stripe::StripeObject
      # The relation between this invoice and the cloned invoice
      sig { returns(String) }
      def action; end
      # The invoice that was cloned.
      sig { returns(T.any(String, ::Stripe::Invoice)) }
      def invoice; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Issuer < ::Stripe::StripeObject
      # The connected account being referenced when `type` is `account`.
      sig { returns(T.nilable(T.any(String, ::Stripe::Account))) }
      def account; end
      # Type of the account referenced.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class LastFinalizationError < ::Stripe::StripeObject
      # For card errors resulting from a card issuer decline, a short string indicating [how to proceed with an error](https://docs.stripe.com/declines#retrying-issuer-declines) if they provide one.
      sig { returns(T.nilable(String)) }
      def advice_code; end
      # For card errors, the ID of the failed charge.
      sig { returns(T.nilable(String)) }
      def charge; end
      # For some errors that could be handled programmatically, a short string indicating the [error code](https://docs.stripe.com/error-codes) reported.
      sig { returns(T.nilable(String)) }
      def code; end
      # For card errors resulting from a card issuer decline, a short string indicating the [card issuer's reason for the decline](https://docs.stripe.com/declines#issuer-declines) if they provide one.
      sig { returns(T.nilable(String)) }
      def decline_code; end
      # A URL to more information about the [error code](https://docs.stripe.com/error-codes) reported.
      sig { returns(T.nilable(String)) }
      def doc_url; end
      # A human-readable message providing more details about the error. For card errors, these messages can be shown to your users.
      sig { returns(T.nilable(String)) }
      def message; end
      # For card errors resulting from a card issuer decline, a 2 digit code which indicates the advice given to merchant by the card network on how to proceed with an error.
      sig { returns(T.nilable(String)) }
      def network_advice_code; end
      # For payments declined by the network, an alphanumeric code which indicates the reason the payment failed.
      sig { returns(T.nilable(String)) }
      def network_decline_code; end
      # If the error is parameter-specific, the parameter related to the error. For example, you can use this to display a message near the correct form field.
      sig { returns(T.nilable(String)) }
      def param; end
      # A PaymentIntent guides you through the process of collecting a payment from your customer.
      # We recommend that you create exactly one PaymentIntent for each order or
      # customer session in your system. You can reference the PaymentIntent later to
      # see the history of payment attempts for a particular session.
      #
      # A PaymentIntent transitions through
      # [multiple statuses](/payments/paymentintents/lifecycle)
      # throughout its lifetime as it interfaces with Stripe.js to perform
      # authentication flows and ultimately creates at most one successful charge.
      #
      # Related guide: [Payment Intents API](https://docs.stripe.com/payments/payment-intents)
      sig { returns(T.nilable(::Stripe::PaymentIntent)) }
      def payment_intent; end
      # PaymentMethod objects represent your customer's payment instruments.
      # You can use them with [PaymentIntents](https://docs.stripe.com/payments/payment-intents) to collect payments or save them to
      # Customer objects to store instrument details for future payments.
      #
      # Related guides: [Payment Methods](https://docs.stripe.com/payments/payment-methods) and [More Payment Scenarios](https://docs.stripe.com/payments/more-payment-scenarios).
      sig { returns(T.nilable(::Stripe::PaymentMethod)) }
      def payment_method; end
      # If the error is specific to the type of payment method, the payment method type that had a problem. This field is only populated for invoice-related errors.
      sig { returns(T.nilable(String)) }
      def payment_method_type; end
      # A URL to the request log entry in your dashboard.
      sig { returns(T.nilable(String)) }
      def request_log_url; end
      # A SetupIntent guides you through the process of setting up and saving a customer's payment credentials for future payments.
      # For example, you can use a SetupIntent to set up and save your customer's card without immediately collecting a payment.
      # Later, you can use [PaymentIntents](https://api.stripe.com#payment_intents) to drive the payment flow.
      #
      # Create a SetupIntent when you're ready to collect your customer's payment credentials.
      # Don't maintain long-lived, unconfirmed SetupIntents because they might not be valid.
      # The SetupIntent transitions through multiple [statuses](https://docs.stripe.com/payments/intents#intent-statuses) as it guides
      # you through the setup process.
      #
      # Successful SetupIntents result in payment credentials that are optimized for future payments.
      # For example, cardholders in [certain regions](https://stripe.com/guides/strong-customer-authentication) might need to be run through
      # [Strong Customer Authentication](https://docs.stripe.com/strong-customer-authentication) during payment method collection
      # to streamline later [off-session payments](https://docs.stripe.com/payments/setup-intents).
      # If you use the SetupIntent with a [Customer](https://api.stripe.com#setup_intent_object-customer),
      # it automatically attaches the resulting payment method to that Customer after successful setup.
      # We recommend using SetupIntents or [setup_future_usage](https://api.stripe.com#payment_intent_object-setup_future_usage) on
      # PaymentIntents to save payment methods to prevent saving invalid or unoptimized payment methods.
      #
      # By using SetupIntents, you can reduce friction for your customers, even as regulations change over time.
      #
      # Related guide: [Setup Intents API](https://docs.stripe.com/payments/setup-intents)
      sig { returns(T.nilable(::Stripe::SetupIntent)) }
      def setup_intent; end
      # Attribute for field source
      sig {
        returns(T.nilable(T.any(::Stripe::Account, ::Stripe::BankAccount, ::Stripe::Card, ::Stripe::Source)))
       }
      def source; end
      # The type of error returned. One of `api_error`, `card_error`, `idempotency_error`, or `invalid_request_error`
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Parent < ::Stripe::StripeObject
      class QuoteDetails < ::Stripe::StripeObject
        # The quote that generated this invoice
        sig { returns(String) }
        def quote; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class SubscriptionDetails < ::Stripe::StripeObject
        # Set of [key-value pairs](https://docs.stripe.com/api/metadata) defined as subscription metadata when an invoice is created. Becomes an immutable snapshot of the subscription metadata at the time of invoice finalization.
        #  *Note: This attribute is populated only for invoices created on or after June 29, 2023.*
        sig { returns(T.nilable(T::Hash[String, String])) }
        def metadata; end
        # The subscription that generated this invoice
        sig { returns(T.any(String, ::Stripe::Subscription)) }
        def subscription; end
        # Only set for upcoming invoices that preview prorations. The time used to calculate prorations.
        sig { returns(T.nilable(Integer)) }
        def subscription_proration_date; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Details about the quote that generated this invoice
      sig { returns(T.nilable(QuoteDetails)) }
      def quote_details; end
      # Details about the subscription that generated this invoice
      sig { returns(T.nilable(SubscriptionDetails)) }
      def subscription_details; end
      # The type of parent that generated this invoice
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {
          quote_details: QuoteDetails,
          subscription_details: SubscriptionDetails,
        }
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class PaymentSettings < ::Stripe::StripeObject
      class PaymentMethodOptions < ::Stripe::StripeObject
        class AcssDebit < ::Stripe::StripeObject
          class MandateOptions < ::Stripe::StripeObject
            # Transaction type of the mandate.
            sig { returns(T.nilable(String)) }
            def transaction_type; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field mandate_options
          sig { returns(T.nilable(MandateOptions)) }
          def mandate_options; end
          # Bank account verification method.
          sig { returns(T.nilable(String)) }
          def verification_method; end
          def self.inner_class_types
            @inner_class_types = {mandate_options: MandateOptions}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Bancontact < ::Stripe::StripeObject
          # Preferred language of the Bancontact authorization page that the customer is redirected to.
          sig { returns(String) }
          def preferred_language; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Card < ::Stripe::StripeObject
          class Installments < ::Stripe::StripeObject
            # Whether Installments are enabled for this Invoice.
            sig { returns(T.nilable(T::Boolean)) }
            def enabled; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field installments
          sig { returns(T.nilable(Installments)) }
          def installments; end
          # We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and [other requirements](https://docs.stripe.com/strong-customer-authentication). However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. Read our guide on [manually requesting 3D Secure](https://docs.stripe.com/payments/3d-secure/authentication-flow#manual-three-ds) for more information on how this configuration interacts with Radar and our SCA Engine.
          sig { returns(T.nilable(String)) }
          def request_three_d_secure; end
          def self.inner_class_types
            @inner_class_types = {installments: Installments}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class CustomerBalance < ::Stripe::StripeObject
          class BankTransfer < ::Stripe::StripeObject
            class EuBankTransfer < ::Stripe::StripeObject
              # The desired country code of the bank account information. Permitted values include: `BE`, `DE`, `ES`, `FR`, `IE`, or `NL`.
              sig { returns(String) }
              def country; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Attribute for field eu_bank_transfer
            sig { returns(T.nilable(EuBankTransfer)) }
            def eu_bank_transfer; end
            # The bank transfer type that can be used for funding. Permitted values include: `eu_bank_transfer`, `gb_bank_transfer`, `jp_bank_transfer`, `mx_bank_transfer`, or `us_bank_transfer`.
            sig { returns(T.nilable(String)) }
            def type; end
            def self.inner_class_types
              @inner_class_types = {eu_bank_transfer: EuBankTransfer}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field bank_transfer
          sig { returns(T.nilable(BankTransfer)) }
          def bank_transfer; end
          # The funding method type to be used when there are not enough funds in the customer balance. Permitted values include: `bank_transfer`.
          sig { returns(T.nilable(String)) }
          def funding_type; end
          def self.inner_class_types
            @inner_class_types = {bank_transfer: BankTransfer}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Konbini < ::Stripe::StripeObject
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Payto < ::Stripe::StripeObject
          class MandateOptions < ::Stripe::StripeObject
            # The maximum amount that can be collected in a single invoice. If you don't specify a maximum, then there is no limit.
            sig { returns(T.nilable(Integer)) }
            def amount; end
            # Only `maximum` is supported.
            sig { returns(T.nilable(String)) }
            def amount_type; end
            # The purpose for which payments are made. Has a default value based on your merchant category code.
            sig { returns(T.nilable(String)) }
            def purpose; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field mandate_options
          sig { returns(T.nilable(MandateOptions)) }
          def mandate_options; end
          def self.inner_class_types
            @inner_class_types = {mandate_options: MandateOptions}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class SepaDebit < ::Stripe::StripeObject
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class UsBankAccount < ::Stripe::StripeObject
          class FinancialConnections < ::Stripe::StripeObject
            class Filters < ::Stripe::StripeObject
              # The account subcategories to use to filter for possible accounts to link. Valid subcategories are `checking` and `savings`.
              sig { returns(T.nilable(T::Array[String])) }
              def account_subcategories; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Attribute for field filters
            sig { returns(T.nilable(Filters)) }
            def filters; end
            # The list of permissions to request. The `payment_method` permission must be included.
            sig { returns(T.nilable(T::Array[String])) }
            def permissions; end
            # Data features requested to be retrieved upon account creation.
            sig { returns(T.nilable(T::Array[String])) }
            def prefetch; end
            def self.inner_class_types
              @inner_class_types = {filters: Filters}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field financial_connections
          sig { returns(T.nilable(FinancialConnections)) }
          def financial_connections; end
          # Bank account verification method.
          sig { returns(T.nilable(String)) }
          def verification_method; end
          def self.inner_class_types
            @inner_class_types = {financial_connections: FinancialConnections}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # If paying by `acss_debit`, this sub-hash contains details about the Canadian pre-authorized debit payment method options to pass to the invoice’s PaymentIntent.
        sig { returns(T.nilable(AcssDebit)) }
        def acss_debit; end
        # If paying by `bancontact`, this sub-hash contains details about the Bancontact payment method options to pass to the invoice’s PaymentIntent.
        sig { returns(T.nilable(Bancontact)) }
        def bancontact; end
        # If paying by `card`, this sub-hash contains details about the Card payment method options to pass to the invoice’s PaymentIntent.
        sig { returns(T.nilable(Card)) }
        def card; end
        # If paying by `customer_balance`, this sub-hash contains details about the Bank transfer payment method options to pass to the invoice’s PaymentIntent.
        sig { returns(T.nilable(CustomerBalance)) }
        def customer_balance; end
        # If paying by `konbini`, this sub-hash contains details about the Konbini payment method options to pass to the invoice’s PaymentIntent.
        sig { returns(T.nilable(Konbini)) }
        def konbini; end
        # If paying by `payto`, this sub-hash contains details about the PayTo payment method options to pass to the invoice’s PaymentIntent.
        sig { returns(T.nilable(Payto)) }
        def payto; end
        # If paying by `sepa_debit`, this sub-hash contains details about the SEPA Direct Debit payment method options to pass to the invoice’s PaymentIntent.
        sig { returns(T.nilable(SepaDebit)) }
        def sepa_debit; end
        # If paying by `us_bank_account`, this sub-hash contains details about the ACH direct debit payment method options to pass to the invoice’s PaymentIntent.
        sig { returns(T.nilable(UsBankAccount)) }
        def us_bank_account; end
        def self.inner_class_types
          @inner_class_types = {
            acss_debit: AcssDebit,
            bancontact: Bancontact,
            card: Card,
            customer_balance: CustomerBalance,
            konbini: Konbini,
            payto: Payto,
            sepa_debit: SepaDebit,
            us_bank_account: UsBankAccount,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # ID of the mandate to be used for this invoice. It must correspond to the payment method used to pay the invoice, including the invoice's default_payment_method or default_source, if set.
      sig { returns(T.nilable(String)) }
      def default_mandate; end
      # Payment-method-specific configuration to provide to the invoice’s PaymentIntent.
      sig { returns(T.nilable(PaymentMethodOptions)) }
      def payment_method_options; end
      # The list of payment method types (e.g. card) to provide to the invoice’s PaymentIntent. If not set, Stripe attempts to automatically determine the types to use by looking at the invoice’s default payment method, the subscription’s default payment method, the customer’s default payment method, and your [invoice template settings](https://dashboard.stripe.com/settings/billing/invoice).
      sig { returns(T.nilable(T::Array[String])) }
      def payment_method_types; end
      def self.inner_class_types
        @inner_class_types = {payment_method_options: PaymentMethodOptions}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Rendering < ::Stripe::StripeObject
      class Pdf < ::Stripe::StripeObject
        # Page size of invoice pdf. Options include a4, letter, and auto. If set to auto, page size will be switched to a4 or letter based on customer locale.
        sig { returns(T.nilable(String)) }
        def page_size; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
      sig { returns(T.nilable(String)) }
      def amount_tax_display; end
      # Invoice pdf rendering options
      sig { returns(T.nilable(Pdf)) }
      def pdf; end
      # ID of the rendering template that the invoice is formatted by.
      sig { returns(T.nilable(String)) }
      def template; end
      # Version of the rendering template that the invoice is using.
      sig { returns(T.nilable(Integer)) }
      def template_version; end
      def self.inner_class_types
        @inner_class_types = {pdf: Pdf}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class ShippingCost < ::Stripe::StripeObject
      class Tax < ::Stripe::StripeObject
        # Amount of tax applied for this rate.
        sig { returns(Integer) }
        def amount; end
        # Tax rates can be applied to [invoices](/invoicing/taxes/tax-rates), [subscriptions](/billing/taxes/tax-rates) and [Checkout Sessions](/payments/checkout/use-manual-tax-rates) to collect tax.
        #
        # Related guide: [Tax rates](/billing/taxes/tax-rates)
        sig { returns(::Stripe::TaxRate) }
        def rate; end
        # The reasoning behind this tax, for example, if the product is tax exempt. The possible values for this field may be extended as new tax rules are supported.
        sig { returns(T.nilable(String)) }
        def taxability_reason; end
        # The amount on which tax is calculated, in cents (or local equivalent).
        sig { returns(T.nilable(Integer)) }
        def taxable_amount; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Total shipping cost before any taxes are applied.
      sig { returns(Integer) }
      def amount_subtotal; end
      # Total tax amount applied due to shipping costs. If no tax was applied, defaults to 0.
      sig { returns(Integer) }
      def amount_tax; end
      # Total shipping cost after taxes are applied.
      sig { returns(Integer) }
      def amount_total; end
      # The ID of the ShippingRate for this invoice.
      sig { returns(T.nilable(T.any(String, ::Stripe::ShippingRate))) }
      def shipping_rate; end
      # The taxes applied to the shipping rate.
      sig { returns(T.nilable(T::Array[Tax])) }
      def taxes; end
      def self.inner_class_types
        @inner_class_types = {taxes: Tax}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class ShippingDetails < ::Stripe::StripeObject
      class Address < ::Stripe::StripeObject
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
      # Attribute for field address
      sig { returns(T.nilable(Address)) }
      def address; end
      # The delivery service that shipped a physical product, such as Fedex, UPS, USPS, etc.
      sig { returns(T.nilable(String)) }
      def carrier; end
      # Recipient name.
      sig { returns(T.nilable(String)) }
      def name; end
      # Recipient phone (including extension).
      sig { returns(T.nilable(String)) }
      def phone; end
      # The tracking number for a physical product, obtained from the delivery service. If multiple tracking numbers were generated for this purchase, please separate them with commas.
      sig { returns(T.nilable(String)) }
      def tracking_number; end
      def self.inner_class_types
        @inner_class_types = {address: Address}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class StatusTransitions < ::Stripe::StripeObject
      # The time that the invoice draft was finalized.
      sig { returns(T.nilable(Integer)) }
      def finalized_at; end
      # The time that the invoice was marked uncollectible.
      sig { returns(T.nilable(Integer)) }
      def marked_uncollectible_at; end
      # The time that the invoice was paid.
      sig { returns(T.nilable(Integer)) }
      def paid_at; end
      # The time that the invoice was voided.
      sig { returns(T.nilable(Integer)) }
      def voided_at; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class ThresholdReason < ::Stripe::StripeObject
      class ItemReason < ::Stripe::StripeObject
        # The IDs of the line items that triggered the threshold invoice.
        sig { returns(T::Array[String]) }
        def line_item_ids; end
        # The quantity threshold boundary that applied to the given line item.
        sig { returns(Integer) }
        def usage_gte; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The total invoice amount threshold boundary if it triggered the threshold invoice.
      sig { returns(T.nilable(Integer)) }
      def amount_gte; end
      # Indicates which line items triggered a threshold invoice.
      sig { returns(T::Array[ItemReason]) }
      def item_reasons; end
      def self.inner_class_types
        @inner_class_types = {item_reasons: ItemReason}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class TotalDiscountAmount < ::Stripe::StripeObject
      # The amount, in cents (or local equivalent), of the discount.
      sig { returns(Integer) }
      def amount; end
      # The discount that was applied to get this discount amount.
      sig { returns(T.any(String, ::Stripe::Discount)) }
      def discount; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class TotalPretaxCreditAmount < ::Stripe::StripeObject
      # The amount, in cents (or local equivalent), of the pretax credit amount.
      sig { returns(Integer) }
      def amount; end
      # The credit balance transaction that was applied to get this pretax credit amount.
      sig { returns(T.nilable(T.any(String, ::Stripe::Billing::CreditBalanceTransaction))) }
      def credit_balance_transaction; end
      # The discount that was applied to get this pretax credit amount.
      sig { returns(T.nilable(T.any(String, ::Stripe::Discount))) }
      def discount; end
      # Type of the pretax credit amount referenced.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class TotalTax < ::Stripe::StripeObject
      class TaxRateDetails < ::Stripe::StripeObject
        # ID of the tax rate
        sig { returns(String) }
        def tax_rate; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The amount of the tax, in cents (or local equivalent).
      sig { returns(Integer) }
      def amount; end
      # Whether this tax is inclusive or exclusive.
      sig { returns(String) }
      def tax_behavior; end
      # Additional details about the tax rate. Only present when `type` is `tax_rate_details`.
      sig { returns(T.nilable(TaxRateDetails)) }
      def tax_rate_details; end
      # The reasoning behind this tax, for example, if the product is tax exempt. The possible values for this field may be extended as new tax rules are supported.
      sig { returns(String) }
      def taxability_reason; end
      # The amount on which tax is calculated, in cents (or local equivalent).
      sig { returns(T.nilable(Integer)) }
      def taxable_amount; end
      # The type of tax information.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {tax_rate_details: TaxRateDetails}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # The country of the business associated with this invoice, most often the business creating the invoice.
    sig { returns(T.nilable(String)) }
    def account_country; end
    # The public name of the business associated with this invoice, most often the business creating the invoice.
    sig { returns(T.nilable(String)) }
    def account_name; end
    # The account tax IDs associated with the invoice. Only editable when the invoice is a draft.
    sig { returns(T.nilable(T::Array[T.any(String, ::Stripe::TaxId)])) }
    def account_tax_ids; end
    # Final amount due at this time for this invoice. If the invoice's total is smaller than the minimum charge amount, for example, or if there is account credit that can be applied to the invoice, the `amount_due` may be 0. If there is a positive `starting_balance` for the invoice (the customer owes money), the `amount_due` will also take that into account. The charge that gets generated for the invoice will be for the amount specified in `amount_due`.
    sig { returns(Integer) }
    def amount_due; end
    # Amount that was overpaid on the invoice. The amount overpaid is credited to the customer's credit balance.
    sig { returns(Integer) }
    def amount_overpaid; end
    # The amount, in cents (or local equivalent), that was paid.
    sig { returns(Integer) }
    def amount_paid; end
    # The difference between amount_due and amount_paid, in cents (or local equivalent).
    sig { returns(Integer) }
    def amount_remaining; end
    # This is the sum of all the shipping amounts.
    sig { returns(Integer) }
    def amount_shipping; end
    # ID of the Connect Application that created the invoice.
    sig { returns(T.nilable(T.any(String, ::Stripe::Application))) }
    def application; end
    # Number of payment attempts made for this invoice, from the perspective of the payment retry schedule. Any payment attempt counts as the first attempt, and subsequently only automatic retries increment the attempt count. In other words, manual payment attempts after the first attempt do not affect the retry schedule. If a failure is returned with a non-retryable return code, the invoice can no longer be retried unless a new payment method is obtained. Retries will continue to be scheduled, and attempt_count will continue to increment, but retries will only be executed if a new payment method is obtained.
    sig { returns(Integer) }
    def attempt_count; end
    # Whether an attempt has been made to pay the invoice. An invoice is not attempted until 1 hour after the `invoice.created` webhook, for example, so you might not want to display that invoice as unpaid to your users.
    sig { returns(T::Boolean) }
    def attempted; end
    # Controls whether Stripe performs [automatic collection](https://docs.stripe.com/invoicing/integration/automatic-advancement-collection) of the invoice. If `false`, the invoice's state doesn't automatically advance without an explicit action.
    sig { returns(T.nilable(T::Boolean)) }
    def auto_advance; end
    # Attribute for field automatic_tax
    sig { returns(AutomaticTax) }
    def automatic_tax; end
    # The time when this invoice is currently scheduled to be automatically finalized. The field will be `null` if the invoice is not scheduled to finalize in the future. If the invoice is not in the draft state, this field will always be `null` - see `finalized_at` for the time when an already-finalized invoice was finalized.
    sig { returns(T.nilable(Integer)) }
    def automatically_finalizes_at; end
    # Indicates the reason why the invoice was created.
    #
    # * `manual`: Unrelated to a subscription, for example, created via the invoice editor.
    # * `subscription`: No longer in use. Applies to subscriptions from before May 2018 where no distinction was made between updates, cycles, and thresholds.
    # * `subscription_create`: A new subscription was created.
    # * `subscription_cycle`: A subscription advanced into a new period.
    # * `subscription_threshold`: A subscription reached a billing threshold.
    # * `subscription_update`: A subscription was updated.
    # * `upcoming`: Reserved for upcoming invoices created through the Create Preview Invoice API or when an `invoice.upcoming` event is generated for an upcoming invoice on a subscription.
    sig { returns(T.nilable(String)) }
    def billing_reason; end
    # Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay this invoice using the default source attached to the customer. When sending an invoice, Stripe will email this invoice to the customer with payment instructions.
    sig { returns(String) }
    def collection_method; end
    # The confirmation secret associated with this invoice. Currently, this contains the client_secret of the PaymentIntent that Stripe creates during invoice finalization.
    sig { returns(T.nilable(ConfirmationSecret)) }
    def confirmation_secret; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # Custom fields displayed on the invoice.
    sig { returns(T.nilable(T::Array[CustomField])) }
    def custom_fields; end
    # The ID of the customer to bill.
    sig { returns(T.nilable(T.any(String, ::Stripe::Customer))) }
    def customer; end
    # The ID of the account representing the customer to bill.
    sig { returns(T.nilable(String)) }
    def customer_account; end
    # The customer's address. Until the invoice is finalized, this field will equal `customer.address`. Once the invoice is finalized, this field will no longer be updated.
    sig { returns(T.nilable(CustomerAddress)) }
    def customer_address; end
    # The customer's email. Until the invoice is finalized, this field will equal `customer.email`. Once the invoice is finalized, this field will no longer be updated.
    sig { returns(T.nilable(String)) }
    def customer_email; end
    # The customer's name. Until the invoice is finalized, this field will equal `customer.name`. Once the invoice is finalized, this field will no longer be updated.
    sig { returns(T.nilable(String)) }
    def customer_name; end
    # The customer's phone number. Until the invoice is finalized, this field will equal `customer.phone`. Once the invoice is finalized, this field will no longer be updated.
    sig { returns(T.nilable(String)) }
    def customer_phone; end
    # The customer's shipping information. Until the invoice is finalized, this field will equal `customer.shipping`. Once the invoice is finalized, this field will no longer be updated.
    sig { returns(T.nilable(CustomerShipping)) }
    def customer_shipping; end
    # The customer's tax exempt status. Until the invoice is finalized, this field will equal `customer.tax_exempt`. Once the invoice is finalized, this field will no longer be updated.
    sig { returns(T.nilable(String)) }
    def customer_tax_exempt; end
    # The customer's tax IDs. Until the invoice is finalized, this field will contain the same tax IDs as `customer.tax_ids`. Once the invoice is finalized, this field will no longer be updated.
    sig { returns(T.nilable(T::Array[CustomerTaxId])) }
    def customer_tax_ids; end
    # ID of the default payment method for the invoice. It must belong to the customer associated with the invoice. If not set, defaults to the subscription's default payment method, if any, or to the default payment method in the customer's invoice settings.
    sig { returns(T.nilable(T.any(String, ::Stripe::PaymentMethod))) }
    def default_payment_method; end
    # ID of the default payment source for the invoice. It must belong to the customer associated with the invoice and be in a chargeable state. If not set, defaults to the subscription's default source, if any, or to the customer's default source.
    sig {
      returns(T.nilable(T.any(String, T.any(::Stripe::Account, ::Stripe::BankAccount, ::Stripe::Card, ::Stripe::Source))))
     }
    def default_source; end
    # The tax rates applied to this invoice, if any.
    sig { returns(T::Array[::Stripe::TaxRate]) }
    def default_tax_rates; end
    # An arbitrary string attached to the object. Often useful for displaying to users. Referenced as 'memo' in the Dashboard.
    sig { returns(T.nilable(String)) }
    def description; end
    # The discounts applied to the invoice. Line item discounts are applied before invoice discounts. Use `expand[]=discounts` to expand each discount.
    sig { returns(T::Array[T.any(String, ::Stripe::Discount)]) }
    def discounts; end
    # The date on which payment for this invoice is due. This value will be `null` for invoices where `collection_method=charge_automatically`.
    sig { returns(T.nilable(Integer)) }
    def due_date; end
    # The date when this invoice is in effect. Same as `finalized_at` unless overwritten. When defined, this value replaces the system-generated 'Date of issue' printed on the invoice PDF and receipt.
    sig { returns(T.nilable(Integer)) }
    def effective_at; end
    # Ending customer balance after the invoice is finalized. Invoices are finalized approximately an hour after successful webhook delivery or when payment collection is attempted for the invoice. If the invoice has not been finalized yet, this will be null.
    sig { returns(T.nilable(Integer)) }
    def ending_balance; end
    # Footer displayed on the invoice.
    sig { returns(T.nilable(String)) }
    def footer; end
    # Details of the invoice that was cloned. See the [revision documentation](https://docs.stripe.com/invoicing/invoice-revisions) for more details.
    sig { returns(T.nilable(FromInvoice)) }
    def from_invoice; end
    # The URL for the hosted invoice page, which allows customers to view and pay an invoice. If the invoice has not been finalized yet, this will be null.
    sig { returns(T.nilable(String)) }
    def hosted_invoice_url; end
    # Unique identifier for the object. For preview invoices created using the [create preview](https://stripe.com/docs/api/invoices/create_preview) endpoint, this id will be prefixed with `upcoming_in`.
    sig { returns(String) }
    def id; end
    # The link to download the PDF for the invoice. If the invoice has not been finalized yet, this will be null.
    sig { returns(T.nilable(String)) }
    def invoice_pdf; end
    # Attribute for field issuer
    sig { returns(Issuer) }
    def issuer; end
    # The error encountered during the previous attempt to finalize the invoice. This field is cleared when the invoice is successfully finalized.
    sig { returns(T.nilable(LastFinalizationError)) }
    def last_finalization_error; end
    # The ID of the most recent non-draft revision of this invoice
    sig { returns(T.nilable(T.any(String, ::Stripe::Invoice))) }
    def latest_revision; end
    # The individual line items that make up the invoice. `lines` is sorted as follows: (1) pending invoice items (including prorations) in reverse chronological order, (2) subscription items in reverse chronological order, and (3) invoice items added after invoice creation in chronological order.
    sig { returns(::Stripe::ListObject) }
    def lines; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # The time at which payment will next be attempted. This value will be `null` for invoices where `collection_method=send_invoice`.
    sig { returns(T.nilable(Integer)) }
    def next_payment_attempt; end
    # A unique, identifying string that appears on emails sent to the customer for this invoice. This starts with the customer's unique invoice_prefix if it is specified.
    sig { returns(T.nilable(String)) }
    def number; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The account (if any) for which the funds of the invoice payment are intended. If set, the invoice will be presented with the branding and support information of the specified account. See the [Invoices with Connect](https://docs.stripe.com/billing/invoices/connect) documentation for details.
    sig { returns(T.nilable(T.any(String, ::Stripe::Account))) }
    def on_behalf_of; end
    # The parent that generated this invoice
    sig { returns(T.nilable(Parent)) }
    def parent; end
    # Attribute for field payment_settings
    sig { returns(PaymentSettings) }
    def payment_settings; end
    # Payments for this invoice
    sig { returns(T.nilable(::Stripe::ListObject)) }
    def payments; end
    # End of the usage period during which invoice items were added to this invoice. This looks back one period for a subscription invoice. Use the [line item period](/api/invoices/line_item#invoice_line_item_object-period) to get the service period for each price.
    sig { returns(Integer) }
    def period_end; end
    # Start of the usage period during which invoice items were added to this invoice. This looks back one period for a subscription invoice. Use the [line item period](/api/invoices/line_item#invoice_line_item_object-period) to get the service period for each price.
    sig { returns(Integer) }
    def period_start; end
    # Total amount of all post-payment credit notes issued for this invoice.
    sig { returns(Integer) }
    def post_payment_credit_notes_amount; end
    # Total amount of all pre-payment credit notes issued for this invoice.
    sig { returns(Integer) }
    def pre_payment_credit_notes_amount; end
    # This is the transaction number that appears on email receipts sent for this invoice.
    sig { returns(T.nilable(String)) }
    def receipt_number; end
    # The rendering-related settings that control how the invoice is displayed on customer-facing surfaces such as PDF and Hosted Invoice Page.
    sig { returns(T.nilable(Rendering)) }
    def rendering; end
    # The details of the cost of shipping, including the ShippingRate applied on the invoice.
    sig { returns(T.nilable(ShippingCost)) }
    def shipping_cost; end
    # Shipping details for the invoice. The Invoice PDF will use the `shipping_details` value if it is set, otherwise the PDF will render the shipping address from the customer.
    sig { returns(T.nilable(ShippingDetails)) }
    def shipping_details; end
    # Starting customer balance before the invoice is finalized. If the invoice has not been finalized yet, this will be the current customer balance. For revision invoices, this also includes any customer balance that was applied to the original invoice.
    sig { returns(Integer) }
    def starting_balance; end
    # Extra information about an invoice for the customer's credit card statement.
    sig { returns(T.nilable(String)) }
    def statement_descriptor; end
    # The status of the invoice, one of `draft`, `open`, `paid`, `uncollectible`, or `void`. [Learn more](https://docs.stripe.com/billing/invoices/workflow#workflow-overview)
    sig { returns(T.nilable(String)) }
    def status; end
    # Attribute for field status_transitions
    sig { returns(StatusTransitions) }
    def status_transitions; end
    # Total of all subscriptions, invoice items, and prorations on the invoice before any invoice level discount or exclusive tax is applied. Item discounts are already incorporated
    sig { returns(Integer) }
    def subtotal; end
    # The integer amount in cents (or local equivalent) representing the subtotal of the invoice before any invoice level discount or tax is applied. Item discounts are already incorporated
    sig { returns(T.nilable(Integer)) }
    def subtotal_excluding_tax; end
    # ID of the test clock this invoice belongs to.
    sig { returns(T.nilable(T.any(String, ::Stripe::TestHelpers::TestClock))) }
    def test_clock; end
    # Attribute for field threshold_reason
    sig { returns(T.nilable(ThresholdReason)) }
    def threshold_reason; end
    # Total after discounts and taxes.
    sig { returns(Integer) }
    def total; end
    # The aggregate amounts calculated per discount across all line items.
    sig { returns(T.nilable(T::Array[TotalDiscountAmount])) }
    def total_discount_amounts; end
    # The integer amount in cents (or local equivalent) representing the total amount of the invoice including all discounts but excluding all tax.
    sig { returns(T.nilable(Integer)) }
    def total_excluding_tax; end
    # Contains pretax credit amounts (ex: discount, credit grants, etc) that apply to this invoice. This is a combined list of total_pretax_credit_amounts across all invoice line items.
    sig { returns(T.nilable(T::Array[TotalPretaxCreditAmount])) }
    def total_pretax_credit_amounts; end
    # The aggregate tax information of all line items.
    sig { returns(T.nilable(T::Array[TotalTax])) }
    def total_taxes; end
    # Invoices are automatically paid or sent 1 hour after webhooks are delivered, or until all webhook delivery attempts have [been exhausted](https://docs.stripe.com/billing/webhooks#understand). This field tracks the time when webhooks for this invoice were successfully delivered. If the invoice had no webhooks to deliver, this will be set while the invoice is being created.
    sig { returns(T.nilable(Integer)) }
    def webhooks_delivered_at; end
    # Always true for a deleted object
    sig { returns(T.nilable(T::Boolean)) }
    def deleted; end
    # Adds multiple line items to an invoice. This is only possible when an invoice is still a draft.
    sig {
      params(params: T.any(::Stripe::InvoiceAddLinesParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def add_lines(params = {}, opts = {}); end

    # Adds multiple line items to an invoice. This is only possible when an invoice is still a draft.
    sig {
      params(invoice: String, params: T.any(::Stripe::InvoiceAddLinesParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def self.add_lines(invoice, params = {}, opts = {}); end

    # Attaches a PaymentIntent or an Out of Band Payment to the invoice, adding it to the list of payments.
    #
    # For the PaymentIntent, when the PaymentIntent's status changes to succeeded, the payment is credited
    # to the invoice, increasing its amount_paid. When the invoice is fully paid, the
    # invoice's status becomes paid.
    #
    # If the PaymentIntent's status is already succeeded when it's attached, it's
    # credited to the invoice immediately.
    #
    # See: [Partial payments](https://docs.stripe.com/docs/invoicing/partial-payments) to learn more.
    sig {
      params(params: T.any(::Stripe::InvoiceAttachPaymentParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def attach_payment(params = {}, opts = {}); end

    # Attaches a PaymentIntent or an Out of Band Payment to the invoice, adding it to the list of payments.
    #
    # For the PaymentIntent, when the PaymentIntent's status changes to succeeded, the payment is credited
    # to the invoice, increasing its amount_paid. When the invoice is fully paid, the
    # invoice's status becomes paid.
    #
    # If the PaymentIntent's status is already succeeded when it's attached, it's
    # credited to the invoice immediately.
    #
    # See: [Partial payments](https://docs.stripe.com/docs/invoicing/partial-payments) to learn more.
    sig {
      params(invoice: String, params: T.any(::Stripe::InvoiceAttachPaymentParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def self.attach_payment(invoice, params = {}, opts = {}); end

    # This endpoint creates a draft invoice for a given customer. The invoice remains a draft until you [finalize the invoice, which allows you to [pay](#pay_invoice) or <a href="#send_invoice">send](https://docs.stripe.com/api#finalize_invoice) the invoice to your customers.
    sig {
      params(params: T.any(::Stripe::InvoiceCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def self.create(params = {}, opts = {}); end

    # At any time, you can preview the upcoming invoice for a subscription or subscription schedule. This will show you all the charges that are pending, including subscription renewal charges, invoice item charges, etc. It will also show you any discounts that are applicable to the invoice.
    #
    # You can also preview the effects of creating or updating a subscription or subscription schedule, including a preview of any prorations that will take place. To ensure that the actual proration is calculated exactly the same as the previewed proration, you should pass the subscription_details.proration_date parameter when doing the actual subscription update.
    #
    # The recommended way to get only the prorations being previewed on the invoice is to consider line items where parent.subscription_item_details.proration is true.
    #
    # Note that when you are viewing an upcoming invoice, you are simply viewing a preview – the invoice has not yet been created. As such, the upcoming invoice will not show up in invoice listing calls, and you cannot use the API to pay or edit the invoice. If you want to change the amount that your customer will be billed, you can add, remove, or update pending invoice items, or update the customer's discount.
    #
    # Note: Currency conversion calculations use the latest exchange rates. Exchange rates may vary between the time of the preview and the time of the actual invoice creation. [Learn more](https://docs.stripe.com/currencies/conversions)
    sig {
      params(params: T.any(::Stripe::InvoiceCreatePreviewParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def self.create_preview(params = {}, opts = {}); end

    # Permanently deletes a one-off invoice draft. This cannot be undone. Attempts to delete invoices that are no longer in a draft state will fail; once an invoice has been finalized or if an invoice is for a subscription, it must be [voided](https://docs.stripe.com/api#void_invoice).
    sig {
      params(invoice: String, params: T.any(::Stripe::InvoiceDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def self.delete(invoice, params = {}, opts = {}); end

    # Permanently deletes a one-off invoice draft. This cannot be undone. Attempts to delete invoices that are no longer in a draft state will fail; once an invoice has been finalized or if an invoice is for a subscription, it must be [voided](https://docs.stripe.com/api#void_invoice).
    sig {
      params(params: T.any(::Stripe::InvoiceDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def delete(params = {}, opts = {}); end

    # Stripe automatically finalizes drafts before sending and attempting payment on invoices. However, if you'd like to finalize a draft invoice manually, you can do so using this method.
    sig {
      params(params: T.any(::Stripe::InvoiceFinalizeInvoiceParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def finalize_invoice(params = {}, opts = {}); end

    # Stripe automatically finalizes drafts before sending and attempting payment on invoices. However, if you'd like to finalize a draft invoice manually, you can do so using this method.
    sig {
      params(invoice: String, params: T.any(::Stripe::InvoiceFinalizeInvoiceParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def self.finalize_invoice(invoice, params = {}, opts = {}); end

    # You can list all invoices, or list the invoices for a specific customer. The invoices are returned sorted by creation date, with the most recently created invoices appearing first.
    sig {
      params(params: T.any(::Stripe::InvoiceListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Marking an invoice as uncollectible is useful for keeping track of bad debts that can be written off for accounting purposes.
    sig {
      params(params: T.any(::Stripe::InvoiceMarkUncollectibleParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def mark_uncollectible(params = {}, opts = {}); end

    # Marking an invoice as uncollectible is useful for keeping track of bad debts that can be written off for accounting purposes.
    sig {
      params(invoice: String, params: T.any(::Stripe::InvoiceMarkUncollectibleParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def self.mark_uncollectible(invoice, params = {}, opts = {}); end

    # Stripe automatically creates and then attempts to collect payment on invoices for customers on subscriptions according to your [subscriptions settings](https://dashboard.stripe.com/account/billing/automatic). However, if you'd like to attempt payment on an invoice out of the normal collection schedule or for some other reason, you can do so.
    sig {
      params(params: T.any(::Stripe::InvoicePayParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def pay(params = {}, opts = {}); end

    # Stripe automatically creates and then attempts to collect payment on invoices for customers on subscriptions according to your [subscriptions settings](https://dashboard.stripe.com/account/billing/automatic). However, if you'd like to attempt payment on an invoice out of the normal collection schedule or for some other reason, you can do so.
    sig {
      params(invoice: String, params: T.any(::Stripe::InvoicePayParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def self.pay(invoice, params = {}, opts = {}); end

    # Removes multiple line items from an invoice. This is only possible when an invoice is still a draft.
    sig {
      params(params: T.any(::Stripe::InvoiceRemoveLinesParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def remove_lines(params = {}, opts = {}); end

    # Removes multiple line items from an invoice. This is only possible when an invoice is still a draft.
    sig {
      params(invoice: String, params: T.any(::Stripe::InvoiceRemoveLinesParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def self.remove_lines(invoice, params = {}, opts = {}); end

    sig {
      params(params: T.any(::Stripe::InvoiceSearchParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SearchResultObject)
     }
    def self.search(params = {}, opts = {}); end

    sig {
      params(params: T.any(::Stripe::InvoiceSearchParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped, blk: T.untyped).returns(::Stripe::SearchResultObject)
     }
    def self.search_auto_paging_each(params = {}, opts = {}, &blk); end

    # Stripe will automatically send invoices to customers according to your [subscriptions settings](https://dashboard.stripe.com/account/billing/automatic). However, if you'd like to manually send an invoice to your customer out of the normal schedule, you can do so. When sending invoices that have already been paid, there will be no reference to the payment in the email.
    #
    # Requests made in test-mode result in no emails being sent, despite sending an invoice.sent event.
    sig {
      params(params: T.any(::Stripe::InvoiceSendInvoiceParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def send_invoice(params = {}, opts = {}); end

    # Stripe will automatically send invoices to customers according to your [subscriptions settings](https://dashboard.stripe.com/account/billing/automatic). However, if you'd like to manually send an invoice to your customer out of the normal schedule, you can do so. When sending invoices that have already been paid, there will be no reference to the payment in the email.
    #
    # Requests made in test-mode result in no emails being sent, despite sending an invoice.sent event.
    sig {
      params(invoice: String, params: T.any(::Stripe::InvoiceSendInvoiceParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def self.send_invoice(invoice, params = {}, opts = {}); end

    # Draft invoices are fully editable. Once an invoice is [finalized](https://docs.stripe.com/docs/billing/invoices/workflow#finalized),
    # monetary values, as well as collection_method, become uneditable.
    #
    # If you would like to stop the Stripe Billing engine from automatically finalizing, reattempting payments on,
    # sending reminders for, or [automatically reconciling](https://docs.stripe.com/docs/billing/invoices/reconciliation) invoices, pass
    # auto_advance=false.
    sig {
      params(invoice: String, params: T.any(::Stripe::InvoiceUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def self.update(invoice, params = {}, opts = {}); end

    # Updates multiple line items on an invoice. This is only possible when an invoice is still a draft.
    sig {
      params(params: T.any(::Stripe::InvoiceUpdateLinesParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def update_lines(params = {}, opts = {}); end

    # Updates multiple line items on an invoice. This is only possible when an invoice is still a draft.
    sig {
      params(invoice: String, params: T.any(::Stripe::InvoiceUpdateLinesParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def self.update_lines(invoice, params = {}, opts = {}); end

    # Mark a finalized invoice as void. This cannot be undone. Voiding an invoice is similar to [deletion](https://docs.stripe.com/api#delete_invoice), however it only applies to finalized invoices and maintains a papertrail where the invoice can still be found.
    #
    # Consult with local regulations to determine whether and how an invoice might be amended, canceled, or voided in the jurisdiction you're doing business in. You might need to [issue another invoice or <a href="#create_credit_note">credit note](https://docs.stripe.com/api#create_invoice) instead. Stripe recommends that you consult with your legal counsel for advice specific to your business.
    sig {
      params(params: T.any(::Stripe::InvoiceVoidInvoiceParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def void_invoice(params = {}, opts = {}); end

    # Mark a finalized invoice as void. This cannot be undone. Voiding an invoice is similar to [deletion](https://docs.stripe.com/api#delete_invoice), however it only applies to finalized invoices and maintains a papertrail where the invoice can still be found.
    #
    # Consult with local regulations to determine whether and how an invoice might be amended, canceled, or voided in the jurisdiction you're doing business in. You might need to [issue another invoice or <a href="#create_credit_note">credit note](https://docs.stripe.com/api#create_invoice) instead. Stripe recommends that you consult with your legal counsel for advice specific to your business.
    sig {
      params(invoice: String, params: T.any(::Stripe::InvoiceVoidInvoiceParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Invoice)
     }
    def self.void_invoice(invoice, params = {}, opts = {}); end
  end
end