# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Subscriptions allow you to charge a customer on a recurring basis.
  #
  # Related guide: [Creating subscriptions](https://docs.stripe.com/billing/subscriptions/creating)
  class Subscription < APIResource
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
      # Whether Stripe automatically computes tax on this subscription.
      sig { returns(T::Boolean) }
      def enabled; end
      # The account that's liable for tax. If set, the business address and tax registrations required to perform the tax calculation are loaded from this account. The tax transaction is returned in the report of the connected account.
      sig { returns(T.nilable(Liability)) }
      def liability; end
      def self.inner_class_types
        @inner_class_types = {liability: Liability}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class BillingCycleAnchorConfig < ::Stripe::StripeObject
      # The day of the month of the billing_cycle_anchor.
      sig { returns(Integer) }
      def day_of_month; end
      # The hour of the day of the billing_cycle_anchor.
      sig { returns(T.nilable(Integer)) }
      def hour; end
      # The minute of the hour of the billing_cycle_anchor.
      sig { returns(T.nilable(Integer)) }
      def minute; end
      # The month to start full cycle billing periods.
      sig { returns(T.nilable(Integer)) }
      def month; end
      # The second of the minute of the billing_cycle_anchor.
      sig { returns(T.nilable(Integer)) }
      def second; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class BillingMode < ::Stripe::StripeObject
      class Flexible < ::Stripe::StripeObject
        # Controls how invoices and invoice items display proration amounts and discount amounts.
        sig { returns(T.nilable(String)) }
        def proration_discounts; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Configure behavior for flexible billing mode
      sig { returns(T.nilable(Flexible)) }
      def flexible; end
      # Controls how prorations and invoices for subscriptions are calculated and orchestrated.
      sig { returns(String) }
      def type; end
      # Details on when the current billing_mode was adopted.
      sig { returns(T.nilable(Integer)) }
      def updated_at; end
      def self.inner_class_types
        @inner_class_types = {flexible: Flexible}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class BillingThresholds < ::Stripe::StripeObject
      # Monetary threshold that triggers the subscription to create an invoice
      sig { returns(T.nilable(Integer)) }
      def amount_gte; end
      # Indicates if the `billing_cycle_anchor` should be reset when a threshold is reached. If true, `billing_cycle_anchor` will be updated to the date/time the threshold was last reached; otherwise, the value will remain unchanged. This value may not be `true` if the subscription contains items with plans that have `aggregate_usage=last_ever`.
      sig { returns(T.nilable(T::Boolean)) }
      def reset_billing_cycle_anchor; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class CancellationDetails < ::Stripe::StripeObject
      # Additional comments about why the user canceled the subscription, if the subscription was canceled explicitly by the user.
      sig { returns(T.nilable(String)) }
      def comment; end
      # The customer submitted reason for why they canceled, if the subscription was canceled explicitly by the user.
      sig { returns(T.nilable(String)) }
      def feedback; end
      # Why this subscription was canceled.
      sig { returns(T.nilable(String)) }
      def reason; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class InvoiceSettings < ::Stripe::StripeObject
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
      # The account tax IDs associated with the subscription. Will be set on invoices generated by the subscription.
      sig { returns(T.nilable(T::Array[T.any(String, ::Stripe::TaxId)])) }
      def account_tax_ids; end
      # Attribute for field issuer
      sig { returns(Issuer) }
      def issuer; end
      def self.inner_class_types
        @inner_class_types = {issuer: Issuer}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class PauseCollection < ::Stripe::StripeObject
      # The payment collection behavior for this subscription while paused. One of `keep_as_draft`, `mark_uncollectible`, or `void`.
      sig { returns(String) }
      def behavior; end
      # The time after which the subscription will resume collecting payments.
      sig { returns(T.nilable(Integer)) }
      def resumes_at; end
      def self.inner_class_types
        @inner_class_types = {}
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
          class MandateOptions < ::Stripe::StripeObject
            # Amount to be charged for future payments.
            sig { returns(T.nilable(Integer)) }
            def amount; end
            # One of `fixed` or `maximum`. If `fixed`, the `amount` param refers to the exact amount to be charged in future payments. If `maximum`, the amount charged can be up to the value passed for the `amount` param.
            sig { returns(T.nilable(String)) }
            def amount_type; end
            # A description of the mandate or subscription that is meant to be displayed to the customer.
            sig { returns(T.nilable(String)) }
            def description; end
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
          # Selected network to process this Subscription on. Depends on the available networks of the card attached to the Subscription. Can be only set confirm-time.
          sig { returns(T.nilable(String)) }
          def network; end
          # We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and [other requirements](https://docs.stripe.com/strong-customer-authentication). However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. Read our guide on [manually requesting 3D Secure](https://docs.stripe.com/payments/3d-secure/authentication-flow#manual-three-ds) for more information on how this configuration interacts with Radar and our SCA Engine.
          sig { returns(T.nilable(String)) }
          def request_three_d_secure; end
          def self.inner_class_types
            @inner_class_types = {mandate_options: MandateOptions}
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
        # This sub-hash contains details about the Canadian pre-authorized debit payment method options to pass to invoices created by the subscription.
        sig { returns(T.nilable(AcssDebit)) }
        def acss_debit; end
        # This sub-hash contains details about the Bancontact payment method options to pass to invoices created by the subscription.
        sig { returns(T.nilable(Bancontact)) }
        def bancontact; end
        # This sub-hash contains details about the Card payment method options to pass to invoices created by the subscription.
        sig { returns(T.nilable(Card)) }
        def card; end
        # This sub-hash contains details about the Bank transfer payment method options to pass to invoices created by the subscription.
        sig { returns(T.nilable(CustomerBalance)) }
        def customer_balance; end
        # This sub-hash contains details about the Konbini payment method options to pass to invoices created by the subscription.
        sig { returns(T.nilable(Konbini)) }
        def konbini; end
        # This sub-hash contains details about the PayTo payment method options to pass to invoices created by the subscription.
        sig { returns(T.nilable(Payto)) }
        def payto; end
        # This sub-hash contains details about the SEPA Direct Debit payment method options to pass to invoices created by the subscription.
        sig { returns(T.nilable(SepaDebit)) }
        def sepa_debit; end
        # This sub-hash contains details about the ACH direct debit payment method options to pass to invoices created by the subscription.
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
      # Payment-method-specific configuration to provide to invoices created by the subscription.
      sig { returns(T.nilable(PaymentMethodOptions)) }
      def payment_method_options; end
      # The list of payment method types to provide to every invoice created by the subscription. If not set, Stripe attempts to automatically determine the types to use by looking at the invoice’s default payment method, the subscription’s default payment method, the customer’s default payment method, and your [invoice template settings](https://dashboard.stripe.com/settings/billing/invoice).
      sig { returns(T.nilable(T::Array[String])) }
      def payment_method_types; end
      # Configure whether Stripe updates `subscription.default_payment_method` when payment succeeds. Defaults to `off`.
      sig { returns(T.nilable(String)) }
      def save_default_payment_method; end
      def self.inner_class_types
        @inner_class_types = {payment_method_options: PaymentMethodOptions}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class PendingInvoiceItemInterval < ::Stripe::StripeObject
      # Specifies invoicing frequency. Either `day`, `week`, `month` or `year`.
      sig { returns(String) }
      def interval; end
      # The number of intervals between invoices. For example, `interval=month` and `interval_count=3` bills every 3 months. Maximum of one year interval allowed (1 year, 12 months, or 52 weeks).
      sig { returns(Integer) }
      def interval_count; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class PendingUpdate < ::Stripe::StripeObject
      # If the update is applied, determines the date of the first full invoice, and, for plans with `month` or `year` intervals, the day of the month for subsequent invoices. The timestamp is in UTC format.
      sig { returns(T.nilable(Integer)) }
      def billing_cycle_anchor; end
      # The point after which the changes reflected by this update will be discarded and no longer applied.
      sig { returns(Integer) }
      def expires_at; end
      # List of subscription items, each with an attached plan, that will be set if the update is applied.
      sig { returns(T.nilable(T::Array[::Stripe::SubscriptionItem])) }
      def subscription_items; end
      # Unix timestamp representing the end of the trial period the customer will get before being charged for the first time, if the update is applied.
      sig { returns(T.nilable(Integer)) }
      def trial_end; end
      # Indicates if a plan's `trial_period_days` should be applied to the subscription. Setting `trial_end` per subscription is preferred, and this defaults to `false`. Setting this flag to `true` together with `trial_end` is not allowed. See [Using trial periods on subscriptions](https://docs.stripe.com/billing/subscriptions/trials) to learn more.
      sig { returns(T.nilable(T::Boolean)) }
      def trial_from_plan; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class TransferData < ::Stripe::StripeObject
      # A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice total that will be transferred to the destination account. By default, the entire amount is transferred to the destination.
      sig { returns(T.nilable(Float)) }
      def amount_percent; end
      # The account where funds from the payment will be transferred to upon payment success.
      sig { returns(T.any(String, ::Stripe::Account)) }
      def destination; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class TrialSettings < ::Stripe::StripeObject
      class EndBehavior < ::Stripe::StripeObject
        # Indicates how the subscription should change when the trial ends if the user did not provide a payment method.
        sig { returns(String) }
        def missing_payment_method; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Defines how a subscription behaves when a free trial ends.
      sig { returns(EndBehavior) }
      def end_behavior; end
      def self.inner_class_types
        @inner_class_types = {end_behavior: EndBehavior}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # ID of the Connect Application that created the subscription.
    sig { returns(T.nilable(T.any(String, ::Stripe::Application))) }
    def application; end
    # A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice total that will be transferred to the application owner's Stripe account.
    sig { returns(T.nilable(Float)) }
    def application_fee_percent; end
    # Attribute for field automatic_tax
    sig { returns(AutomaticTax) }
    def automatic_tax; end
    # The reference point that aligns future [billing cycle](https://docs.stripe.com/subscriptions/billing-cycle) dates. It sets the day of week for `week` intervals, the day of month for `month` and `year` intervals, and the month of year for `year` intervals. The timestamp is in UTC format.
    sig { returns(Integer) }
    def billing_cycle_anchor; end
    # The fixed values used to calculate the `billing_cycle_anchor`.
    sig { returns(T.nilable(BillingCycleAnchorConfig)) }
    def billing_cycle_anchor_config; end
    # The billing mode of the subscription.
    sig { returns(BillingMode) }
    def billing_mode; end
    # Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period
    sig { returns(T.nilable(BillingThresholds)) }
    def billing_thresholds; end
    # A date in the future at which the subscription will automatically get canceled
    sig { returns(T.nilable(Integer)) }
    def cancel_at; end
    # Whether this subscription will (if `status=active`) or did (if `status=canceled`) cancel at the end of the current billing period.
    sig { returns(T::Boolean) }
    def cancel_at_period_end; end
    # If the subscription has been canceled, the date of that cancellation. If the subscription was canceled with `cancel_at_period_end`, `canceled_at` will reflect the time of the most recent update request, not the end of the subscription period when the subscription is automatically moved to a canceled state.
    sig { returns(T.nilable(Integer)) }
    def canceled_at; end
    # Details about why this subscription was cancelled
    sig { returns(T.nilable(CancellationDetails)) }
    def cancellation_details; end
    # Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay this subscription at the end of the cycle using the default source attached to the customer. When sending an invoice, Stripe will email your customer an invoice with payment instructions and mark the subscription as `active`.
    sig { returns(String) }
    def collection_method; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # ID of the customer who owns the subscription.
    sig { returns(T.any(String, ::Stripe::Customer)) }
    def customer; end
    # ID of the account representing the customer who owns the subscription.
    sig { returns(T.nilable(String)) }
    def customer_account; end
    # Number of days a customer has to pay invoices generated by this subscription. This value will be `null` for subscriptions where `collection_method=charge_automatically`.
    sig { returns(T.nilable(Integer)) }
    def days_until_due; end
    # ID of the default payment method for the subscription. It must belong to the customer associated with the subscription. This takes precedence over `default_source`. If neither are set, invoices will use the customer's [invoice_settings.default_payment_method](https://docs.stripe.com/api/customers/object#customer_object-invoice_settings-default_payment_method) or [default_source](https://docs.stripe.com/api/customers/object#customer_object-default_source).
    sig { returns(T.nilable(T.any(String, ::Stripe::PaymentMethod))) }
    def default_payment_method; end
    # ID of the default payment source for the subscription. It must belong to the customer associated with the subscription and be in a chargeable state. If `default_payment_method` is also set, `default_payment_method` will take precedence. If neither are set, invoices will use the customer's [invoice_settings.default_payment_method](https://docs.stripe.com/api/customers/object#customer_object-invoice_settings-default_payment_method) or [default_source](https://docs.stripe.com/api/customers/object#customer_object-default_source).
    sig {
      returns(T.nilable(T.any(String, T.any(::Stripe::Account, ::Stripe::BankAccount, ::Stripe::Card, ::Stripe::Source))))
     }
    def default_source; end
    # The tax rates that will apply to any subscription item that does not have `tax_rates` set. Invoices created will have their `default_tax_rates` populated from the subscription.
    sig { returns(T.nilable(T::Array[::Stripe::TaxRate])) }
    def default_tax_rates; end
    # The subscription's description, meant to be displayable to the customer. Use this field to optionally store an explanation of the subscription for rendering in Stripe surfaces and certain local payment methods UIs.
    sig { returns(T.nilable(String)) }
    def description; end
    # The discounts applied to the subscription. Subscription item discounts are applied before subscription discounts. Use `expand[]=discounts` to expand each discount.
    sig { returns(T::Array[T.any(String, ::Stripe::Discount)]) }
    def discounts; end
    # If the subscription has ended, the date the subscription ended.
    sig { returns(T.nilable(Integer)) }
    def ended_at; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Attribute for field invoice_settings
    sig { returns(InvoiceSettings) }
    def invoice_settings; end
    # List of subscription items, each with an attached price.
    sig { returns(::Stripe::ListObject) }
    def items; end
    # The most recent invoice this subscription has generated.
    sig { returns(T.nilable(T.any(String, ::Stripe::Invoice))) }
    def latest_invoice; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T::Hash[String, String]) }
    def metadata; end
    # Specifies the approximate timestamp on which any pending invoice items will be billed according to the schedule provided at `pending_invoice_item_interval`.
    sig { returns(T.nilable(Integer)) }
    def next_pending_invoice_item_invoice; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The account (if any) the charge was made on behalf of for charges associated with this subscription. See the [Connect documentation](https://docs.stripe.com/connect/subscriptions#on-behalf-of) for details.
    sig { returns(T.nilable(T.any(String, ::Stripe::Account))) }
    def on_behalf_of; end
    # If specified, payment collection for this subscription will be paused. Note that the subscription status will be unchanged and will not be updated to `paused`. Learn more about [pausing collection](https://docs.stripe.com/billing/subscriptions/pause-payment).
    sig { returns(T.nilable(PauseCollection)) }
    def pause_collection; end
    # Payment settings passed on to invoices created by the subscription.
    sig { returns(T.nilable(PaymentSettings)) }
    def payment_settings; end
    # Specifies an interval for how often to bill for any pending invoice items. It is analogous to calling [Create an invoice](https://docs.stripe.com/api#create_invoice) for the given subscription at the specified interval.
    sig { returns(T.nilable(PendingInvoiceItemInterval)) }
    def pending_invoice_item_interval; end
    # You can use this [SetupIntent](https://docs.stripe.com/api/setup_intents) to collect user authentication when creating a subscription without immediate payment or updating a subscription's payment method, allowing you to optimize for off-session payments. Learn more in the [SCA Migration Guide](https://docs.stripe.com/billing/migration/strong-customer-authentication#scenario-2).
    sig { returns(T.nilable(T.any(String, ::Stripe::SetupIntent))) }
    def pending_setup_intent; end
    # If specified, [pending updates](https://docs.stripe.com/billing/subscriptions/pending-updates) that will be applied to the subscription once the `latest_invoice` has been paid.
    sig { returns(T.nilable(PendingUpdate)) }
    def pending_update; end
    # The schedule attached to the subscription
    sig { returns(T.nilable(T.any(String, ::Stripe::SubscriptionSchedule))) }
    def schedule; end
    # Date when the subscription was first created. The date might differ from the `created` date due to backdating.
    sig { returns(Integer) }
    def start_date; end
    # Possible values are `incomplete`, `incomplete_expired`, `trialing`, `active`, `past_due`, `canceled`, `unpaid`, or `paused`.
    #
    # For `collection_method=charge_automatically` a subscription moves into `incomplete` if the initial payment attempt fails. A subscription in this status can only have metadata and default_source updated. Once the first invoice is paid, the subscription moves into an `active` status. If the first invoice is not paid within 23 hours, the subscription transitions to `incomplete_expired`. This is a terminal status, the open invoice will be voided and no further invoices will be generated.
    #
    # A subscription that is currently in a trial period is `trialing` and moves to `active` when the trial period is over.
    #
    # A subscription can only enter a `paused` status [when a trial ends without a payment method](https://docs.stripe.com/billing/subscriptions/trials#create-free-trials-without-payment). A `paused` subscription doesn't generate invoices and can be resumed after your customer adds their payment method. The `paused` status is different from [pausing collection](https://docs.stripe.com/billing/subscriptions/pause-payment), which still generates invoices and leaves the subscription's status unchanged.
    #
    # If subscription `collection_method=charge_automatically`, it becomes `past_due` when payment is required but cannot be paid (due to failed payment or awaiting additional user actions). Once Stripe has exhausted all payment retry attempts, the subscription will become `canceled` or `unpaid` (depending on your subscriptions settings).
    #
    # If subscription `collection_method=send_invoice` it becomes `past_due` when its invoice is not paid by the due date, and `canceled` or `unpaid` if it is still not paid by an additional deadline after that. Note that when a subscription has a status of `unpaid`, no subsequent invoices will be attempted (invoices will be created, but then immediately automatically closed). After receiving updated payment information from a customer, you may choose to reopen and pay their closed invoices.
    sig { returns(String) }
    def status; end
    # ID of the test clock this subscription belongs to.
    sig { returns(T.nilable(T.any(String, ::Stripe::TestHelpers::TestClock))) }
    def test_clock; end
    # The account (if any) the subscription's payments will be attributed to for tax reporting, and where funds from each payment will be transferred to for each of the subscription's invoices.
    sig { returns(T.nilable(TransferData)) }
    def transfer_data; end
    # If the subscription has a trial, the end of that trial.
    sig { returns(T.nilable(Integer)) }
    def trial_end; end
    # Settings related to subscription trials.
    sig { returns(T.nilable(TrialSettings)) }
    def trial_settings; end
    # If the subscription has a trial, the beginning of that trial.
    sig { returns(T.nilable(Integer)) }
    def trial_start; end
    # Cancels a customer's subscription immediately. The customer won't be charged again for the subscription. After it's canceled, you can no longer update the subscription or its [metadata](https://docs.stripe.com/metadata).
    #
    # Any pending invoice items that you've created are still charged at the end of the period, unless manually [deleted](https://docs.stripe.com/api#delete_invoiceitem). If you've set the subscription to cancel at the end of the period, any pending prorations are also left in place and collected at the end of the period. But if the subscription is set to cancel immediately, pending prorations are removed if invoice_now and prorate are both set to true.
    #
    # By default, upon subscription cancellation, Stripe stops automatic collection of all finalized invoices for the customer. This is intended to prevent unexpected payment attempts after the customer has canceled a subscription. However, you can resume automatic collection of the invoices manually after subscription cancellation to have us proceed. Or, you could check for unpaid invoices before allowing the customer to cancel the subscription at all.
    sig {
      params(params: T.any(::Stripe::SubscriptionCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Subscription)
     }
    def cancel(params = {}, opts = {}); end

    # Cancels a customer's subscription immediately. The customer won't be charged again for the subscription. After it's canceled, you can no longer update the subscription or its [metadata](https://docs.stripe.com/metadata).
    #
    # Any pending invoice items that you've created are still charged at the end of the period, unless manually [deleted](https://docs.stripe.com/api#delete_invoiceitem). If you've set the subscription to cancel at the end of the period, any pending prorations are also left in place and collected at the end of the period. But if the subscription is set to cancel immediately, pending prorations are removed if invoice_now and prorate are both set to true.
    #
    # By default, upon subscription cancellation, Stripe stops automatic collection of all finalized invoices for the customer. This is intended to prevent unexpected payment attempts after the customer has canceled a subscription. However, you can resume automatic collection of the invoices manually after subscription cancellation to have us proceed. Or, you could check for unpaid invoices before allowing the customer to cancel the subscription at all.
    sig {
      params(subscription_exposed_id: String, params: T.any(::Stripe::SubscriptionCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Subscription)
     }
    def self.cancel(subscription_exposed_id, params = {}, opts = {}); end

    # Creates a new subscription on an existing customer. Each customer can have up to 500 active or scheduled subscriptions.
    #
    # When you create a subscription with collection_method=charge_automatically, the first invoice is finalized as part of the request.
    # The payment_behavior parameter determines the exact behavior of the initial payment.
    #
    # To start subscriptions where the first invoice always begins in a draft status, use [subscription schedules](https://docs.stripe.com/docs/billing/subscriptions/subscription-schedules#managing) instead.
    # Schedules provide the flexibility to model more complex billing configurations that change over time.
    sig {
      params(params: T.any(::Stripe::SubscriptionCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Subscription)
     }
    def self.create(params = {}, opts = {}); end

    # Removes the currently applied discount on a subscription.
    sig {
      params(params: T.any(::Stripe::SubscriptionDeleteDiscountParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Discount)
     }
    def delete_discount(params = {}, opts = {}); end

    # Removes the currently applied discount on a subscription.
    sig {
      params(subscription_exposed_id: String, params: T.any(::Stripe::SubscriptionDeleteDiscountParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Discount)
     }
    def self.delete_discount(subscription_exposed_id, params = {}, opts = {}); end

    # By default, returns a list of subscriptions that have not been canceled. In order to list canceled subscriptions, specify status=canceled.
    sig {
      params(params: T.any(::Stripe::SubscriptionListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Upgrade the billing_mode of an existing subscription.
    sig {
      params(params: T.any(::Stripe::SubscriptionMigrateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Subscription)
     }
    def migrate(params = {}, opts = {}); end

    # Upgrade the billing_mode of an existing subscription.
    sig {
      params(subscription: String, params: T.any(::Stripe::SubscriptionMigrateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Subscription)
     }
    def self.migrate(subscription, params = {}, opts = {}); end

    # Initiates resumption of a paused subscription, optionally resetting the billing cycle anchor and creating prorations. If a resumption invoice is generated, it must be paid or marked uncollectible before the subscription will be unpaused. If payment succeeds the subscription will become active, and if payment fails the subscription will be past_due. The resumption invoice will void automatically if not paid by the expiration date.
    sig {
      params(params: T.any(::Stripe::SubscriptionResumeParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Subscription)
     }
    def resume(params = {}, opts = {}); end

    # Initiates resumption of a paused subscription, optionally resetting the billing cycle anchor and creating prorations. If a resumption invoice is generated, it must be paid or marked uncollectible before the subscription will be unpaused. If payment succeeds the subscription will become active, and if payment fails the subscription will be past_due. The resumption invoice will void automatically if not paid by the expiration date.
    sig {
      params(subscription: String, params: T.any(::Stripe::SubscriptionResumeParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Subscription)
     }
    def self.resume(subscription, params = {}, opts = {}); end

    sig {
      params(params: T.any(::Stripe::SubscriptionSearchParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SearchResultObject)
     }
    def self.search(params = {}, opts = {}); end

    sig {
      params(params: T.any(::Stripe::SubscriptionSearchParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped, blk: T.untyped).returns(::Stripe::SearchResultObject)
     }
    def self.search_auto_paging_each(params = {}, opts = {}, &blk); end

    # Updates an existing subscription to match the specified parameters.
    # When changing prices or quantities, we optionally prorate the price we charge next month to make up for any price changes.
    # To preview how the proration is calculated, use the [create preview](https://docs.stripe.com/docs/api/invoices/create_preview) endpoint.
    #
    # By default, we prorate subscription changes. For example, if a customer signs up on May 1 for a 100 price, they'll be billed 100 immediately. If on May 15 they switch to a 200 price, then on June 1 they'll be billed 250 (200 for a renewal of her subscription, plus a 50 prorating adjustment for half of the previous month's 100 difference). Similarly, a downgrade generates a credit that is applied to the next invoice. We also prorate when you make quantity changes.
    #
    # Switching prices does not normally change the billing date or generate an immediate charge unless:
    #
    #
    # The billing interval is changed (for example, from monthly to yearly).
    # The subscription moves from free to paid.
    # A trial starts or ends.
    #
    #
    # In these cases, we apply a credit for the unused time on the previous price, immediately charge the customer using the new price, and reset the billing date. Learn about how [Stripe immediately attempts payment for subscription changes](https://docs.stripe.com/docs/billing/subscriptions/upgrade-downgrade#immediate-payment).
    #
    # If you want to charge for an upgrade immediately, pass proration_behavior as always_invoice to create prorations, automatically invoice the customer for those proration adjustments, and attempt to collect payment. If you pass create_prorations, the prorations are created but not automatically invoiced. If you want to bill the customer for the prorations before the subscription's renewal date, you need to manually [invoice the customer](https://docs.stripe.com/docs/api/invoices/create).
    #
    # If you don't want to prorate, set the proration_behavior option to none. With this option, the customer is billed 100 on May 1 and 200 on June 1. Similarly, if you set proration_behavior to none when switching between different billing intervals (for example, from monthly to yearly), we don't generate any credits for the old subscription's unused time. We still reset the billing date and bill immediately for the new subscription.
    #
    # Updating the quantity on a subscription many times in an hour may result in [rate limiting. If you need to bill for a frequently changing quantity, consider integrating <a href="/docs/billing/subscriptions/usage-based">usage-based billing](https://docs.stripe.com/docs/rate-limits) instead.
    sig {
      params(subscription_exposed_id: String, params: T.any(::Stripe::SubscriptionUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Subscription)
     }
    def self.update(subscription_exposed_id, params = {}, opts = {}); end
  end
end