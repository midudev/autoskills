# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # A payment link is a shareable URL that will take your customers to a hosted payment page. A payment link can be shared and used multiple times.
  #
  # When a customer opens a payment link it will open a new [checkout session](https://docs.stripe.com/api/checkout/sessions) to render the payment page. You can use [checkout session events](https://docs.stripe.com/api/events/types#event_types-checkout.session.completed) to track payments through payment links.
  #
  # Related guide: [Payment Links API](https://docs.stripe.com/payment-links)
  class PaymentLink < APIResource
    class AfterCompletion < ::Stripe::StripeObject
      class HostedConfirmation < ::Stripe::StripeObject
        # The custom message that is displayed to the customer after the purchase is complete.
        sig { returns(T.nilable(String)) }
        def custom_message; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Redirect < ::Stripe::StripeObject
        # The URL the customer will be redirected to after the purchase is complete.
        sig { returns(String) }
        def url; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field hosted_confirmation
      sig { returns(T.nilable(HostedConfirmation)) }
      def hosted_confirmation; end
      # Attribute for field redirect
      sig { returns(T.nilable(Redirect)) }
      def redirect; end
      # The specified behavior after the purchase is complete.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {hosted_confirmation: HostedConfirmation, redirect: Redirect}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
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
      # If `true`, tax will be calculated automatically using the customer's location.
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
    class ConsentCollection < ::Stripe::StripeObject
      class PaymentMethodReuseAgreement < ::Stripe::StripeObject
        # Determines the position and visibility of the payment method reuse agreement in the UI. When set to `auto`, Stripe's defaults will be used.
        #
        # When set to `hidden`, the payment method reuse agreement text will always be hidden in the UI.
        sig { returns(String) }
        def position; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Settings related to the payment method reuse text shown in the Checkout UI.
      sig { returns(T.nilable(PaymentMethodReuseAgreement)) }
      def payment_method_reuse_agreement; end
      # If set to `auto`, enables the collection of customer consent for promotional communications.
      sig { returns(T.nilable(String)) }
      def promotions; end
      # If set to `required`, it requires cutomers to accept the terms of service before being able to pay. If set to `none`, customers won't be shown a checkbox to accept the terms of service.
      sig { returns(T.nilable(String)) }
      def terms_of_service; end
      def self.inner_class_types
        @inner_class_types = {payment_method_reuse_agreement: PaymentMethodReuseAgreement}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class CustomField < ::Stripe::StripeObject
      class Dropdown < ::Stripe::StripeObject
        class Option < ::Stripe::StripeObject
          # The label for the option, displayed to the customer. Up to 100 characters.
          sig { returns(String) }
          def label; end
          # The value for this option, not displayed to the customer, used by your integration to reconcile the option selected by the customer. Must be unique to this option, alphanumeric, and up to 100 characters.
          sig { returns(String) }
          def value; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The value that will pre-fill on the payment page.
        sig { returns(T.nilable(String)) }
        def default_value; end
        # The options available for the customer to select. Up to 200 options allowed.
        sig { returns(T::Array[Option]) }
        def options; end
        def self.inner_class_types
          @inner_class_types = {options: Option}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Label < ::Stripe::StripeObject
        # Custom text for the label, displayed to the customer. Up to 50 characters.
        sig { returns(T.nilable(String)) }
        def custom; end
        # The type of the label.
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Numeric < ::Stripe::StripeObject
        # The value that will pre-fill the field on the payment page.
        sig { returns(T.nilable(String)) }
        def default_value; end
        # The maximum character length constraint for the customer's input.
        sig { returns(T.nilable(Integer)) }
        def maximum_length; end
        # The minimum character length requirement for the customer's input.
        sig { returns(T.nilable(Integer)) }
        def minimum_length; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Text < ::Stripe::StripeObject
        # The value that will pre-fill the field on the payment page.
        sig { returns(T.nilable(String)) }
        def default_value; end
        # The maximum character length constraint for the customer's input.
        sig { returns(T.nilable(Integer)) }
        def maximum_length; end
        # The minimum character length requirement for the customer's input.
        sig { returns(T.nilable(Integer)) }
        def minimum_length; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field dropdown
      sig { returns(T.nilable(Dropdown)) }
      def dropdown; end
      # String of your choice that your integration can use to reconcile this field. Must be unique to this field, alphanumeric, and up to 200 characters.
      sig { returns(String) }
      def key; end
      # Attribute for field label
      sig { returns(Label) }
      def label; end
      # Attribute for field numeric
      sig { returns(T.nilable(Numeric)) }
      def numeric; end
      # Whether the customer is required to complete the field before completing the Checkout Session. Defaults to `false`.
      sig { returns(T::Boolean) }
      def optional; end
      # Attribute for field text
      sig { returns(T.nilable(Text)) }
      def text; end
      # The type of the field.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {dropdown: Dropdown, label: Label, numeric: Numeric, text: Text}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class CustomText < ::Stripe::StripeObject
      class AfterSubmit < ::Stripe::StripeObject
        # Text may be up to 1200 characters in length.
        sig { returns(String) }
        def message; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class ShippingAddress < ::Stripe::StripeObject
        # Text may be up to 1200 characters in length.
        sig { returns(String) }
        def message; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Submit < ::Stripe::StripeObject
        # Text may be up to 1200 characters in length.
        sig { returns(String) }
        def message; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class TermsOfServiceAcceptance < ::Stripe::StripeObject
        # Text may be up to 1200 characters in length.
        sig { returns(String) }
        def message; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Custom text that should be displayed after the payment confirmation button.
      sig { returns(T.nilable(AfterSubmit)) }
      def after_submit; end
      # Custom text that should be displayed alongside shipping address collection.
      sig { returns(T.nilable(ShippingAddress)) }
      def shipping_address; end
      # Custom text that should be displayed alongside the payment confirmation button.
      sig { returns(T.nilable(Submit)) }
      def submit; end
      # Custom text that should be displayed in place of the default terms of service agreement text.
      sig { returns(T.nilable(TermsOfServiceAcceptance)) }
      def terms_of_service_acceptance; end
      def self.inner_class_types
        @inner_class_types = {
          after_submit: AfterSubmit,
          shipping_address: ShippingAddress,
          submit: Submit,
          terms_of_service_acceptance: TermsOfServiceAcceptance,
        }
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class InvoiceCreation < ::Stripe::StripeObject
      class InvoiceData < ::Stripe::StripeObject
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
        class RenderingOptions < ::Stripe::StripeObject
          # How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
          sig { returns(T.nilable(String)) }
          def amount_tax_display; end
          # ID of the invoice rendering template to be used for the generated invoice.
          sig { returns(T.nilable(String)) }
          def template; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The account tax IDs associated with the invoice.
        sig { returns(T.nilable(T::Array[T.any(String, ::Stripe::TaxId)])) }
        def account_tax_ids; end
        # A list of up to 4 custom fields to be displayed on the invoice.
        sig { returns(T.nilable(T::Array[CustomField])) }
        def custom_fields; end
        # An arbitrary string attached to the object. Often useful for displaying to users.
        sig { returns(T.nilable(String)) }
        def description; end
        # Footer to be displayed on the invoice.
        sig { returns(T.nilable(String)) }
        def footer; end
        # The connected account that issues the invoice. The invoice is presented with the branding and support information of the specified account.
        sig { returns(T.nilable(Issuer)) }
        def issuer; end
        # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        sig { returns(T.nilable(T::Hash[String, String])) }
        def metadata; end
        # Options for invoice PDF rendering.
        sig { returns(T.nilable(RenderingOptions)) }
        def rendering_options; end
        def self.inner_class_types
          @inner_class_types = {
            custom_fields: CustomField,
            issuer: Issuer,
            rendering_options: RenderingOptions,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Enable creating an invoice on successful payment.
      sig { returns(T::Boolean) }
      def enabled; end
      # Configuration for the invoice. Default invoice values will be used if unspecified.
      sig { returns(T.nilable(InvoiceData)) }
      def invoice_data; end
      def self.inner_class_types
        @inner_class_types = {invoice_data: InvoiceData}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class NameCollection < ::Stripe::StripeObject
      class Business < ::Stripe::StripeObject
        # Indicates whether business name collection is enabled for the payment link.
        sig { returns(T::Boolean) }
        def enabled; end
        # Whether the customer is required to complete the field before checking out. Defaults to `false`.
        sig { returns(T::Boolean) }
        def optional; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Individual < ::Stripe::StripeObject
        # Indicates whether individual name collection is enabled for the payment link.
        sig { returns(T::Boolean) }
        def enabled; end
        # Whether the customer is required to complete the field before checking out. Defaults to `false`.
        sig { returns(T::Boolean) }
        def optional; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field business
      sig { returns(T.nilable(Business)) }
      def business; end
      # Attribute for field individual
      sig { returns(T.nilable(Individual)) }
      def individual; end
      def self.inner_class_types
        @inner_class_types = {business: Business, individual: Individual}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class OptionalItem < ::Stripe::StripeObject
      class AdjustableQuantity < ::Stripe::StripeObject
        # Set to true if the quantity can be adjusted to any non-negative integer.
        sig { returns(T::Boolean) }
        def enabled; end
        # The maximum quantity of this item the customer can purchase. By default this value is 99.
        sig { returns(T.nilable(Integer)) }
        def maximum; end
        # The minimum quantity of this item the customer must purchase, if they choose to purchase it. Because this item is optional, the customer will always be able to remove it from their order, even if the `minimum` configured here is greater than 0. By default this value is 0.
        sig { returns(T.nilable(Integer)) }
        def minimum; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field adjustable_quantity
      sig { returns(T.nilable(AdjustableQuantity)) }
      def adjustable_quantity; end
      # Attribute for field price
      sig { returns(String) }
      def price; end
      # Attribute for field quantity
      sig { returns(Integer) }
      def quantity; end
      def self.inner_class_types
        @inner_class_types = {adjustable_quantity: AdjustableQuantity}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class PaymentIntentData < ::Stripe::StripeObject
      # Indicates when the funds will be captured from the customer's account.
      sig { returns(T.nilable(String)) }
      def capture_method; end
      # An arbitrary string attached to the object. Often useful for displaying to users.
      sig { returns(T.nilable(String)) }
      def description; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that will set metadata on [Payment Intents](https://docs.stripe.com/api/payment_intents) generated from this payment link.
      sig { returns(T::Hash[String, String]) }
      def metadata; end
      # Indicates that you intend to make future payments with the payment method collected during checkout.
      sig { returns(T.nilable(String)) }
      def setup_future_usage; end
      # For a non-card payment, information about the charge that appears on the customer's statement when this payment succeeds in creating a charge.
      sig { returns(T.nilable(String)) }
      def statement_descriptor; end
      # For a card payment, information about the charge that appears on the customer's statement when this payment succeeds in creating a charge. Concatenated with the account's statement descriptor prefix to form the complete statement descriptor.
      sig { returns(T.nilable(String)) }
      def statement_descriptor_suffix; end
      # A string that identifies the resulting payment as part of a group. See the PaymentIntents [use case for connected accounts](https://docs.stripe.com/connect/separate-charges-and-transfers) for details.
      sig { returns(T.nilable(String)) }
      def transfer_group; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class PhoneNumberCollection < ::Stripe::StripeObject
      # If `true`, a phone number will be collected during checkout.
      sig { returns(T::Boolean) }
      def enabled; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Restrictions < ::Stripe::StripeObject
      class CompletedSessions < ::Stripe::StripeObject
        # The current number of checkout sessions that have been completed on the payment link which count towards the `completed_sessions` restriction to be met.
        sig { returns(Integer) }
        def count; end
        # The maximum number of checkout sessions that can be completed for the `completed_sessions` restriction to be met.
        sig { returns(Integer) }
        def limit; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field completed_sessions
      sig { returns(CompletedSessions) }
      def completed_sessions; end
      def self.inner_class_types
        @inner_class_types = {completed_sessions: CompletedSessions}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class ShippingAddressCollection < ::Stripe::StripeObject
      # An array of two-letter ISO country codes representing which countries Checkout should provide as options for shipping locations. Unsupported country codes: `AS, CX, CC, CU, HM, IR, KP, MH, FM, NF, MP, PW, SD, SY, UM, VI`.
      sig { returns(T::Array[String]) }
      def allowed_countries; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class ShippingOption < ::Stripe::StripeObject
      # A non-negative integer in cents representing how much to charge.
      sig { returns(Integer) }
      def shipping_amount; end
      # The ID of the Shipping Rate to use for this shipping option.
      sig { returns(T.any(String, ::Stripe::ShippingRate)) }
      def shipping_rate; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class SubscriptionData < ::Stripe::StripeObject
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
      # The subscription's description, meant to be displayable to the customer. Use this field to optionally store an explanation of the subscription for rendering in Stripe surfaces and certain local payment methods UIs.
      sig { returns(T.nilable(String)) }
      def description; end
      # Attribute for field invoice_settings
      sig { returns(InvoiceSettings) }
      def invoice_settings; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that will set metadata on [Subscriptions](https://docs.stripe.com/api/subscriptions) generated from this payment link.
      sig { returns(T::Hash[String, String]) }
      def metadata; end
      # Integer representing the number of trial period days before the customer is charged for the first time.
      sig { returns(T.nilable(Integer)) }
      def trial_period_days; end
      # Settings related to subscription trials.
      sig { returns(T.nilable(TrialSettings)) }
      def trial_settings; end
      def self.inner_class_types
        @inner_class_types = {invoice_settings: InvoiceSettings, trial_settings: TrialSettings}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class TaxIdCollection < ::Stripe::StripeObject
      # Indicates whether tax ID collection is enabled for the session.
      sig { returns(T::Boolean) }
      def enabled; end
      # Attribute for field required
      sig { returns(String) }
      def required; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class TransferData < ::Stripe::StripeObject
      # The amount in cents (or local equivalent) that will be transferred to the destination account. By default, the entire amount is transferred to the destination.
      sig { returns(T.nilable(Integer)) }
      def amount; end
      # The connected account receiving the transfer.
      sig { returns(T.any(String, ::Stripe::Account)) }
      def destination; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Whether the payment link's `url` is active. If `false`, customers visiting the URL will be shown a page saying that the link has been deactivated.
    sig { returns(T::Boolean) }
    def active; end
    # Attribute for field after_completion
    sig { returns(AfterCompletion) }
    def after_completion; end
    # Whether user redeemable promotion codes are enabled.
    sig { returns(T::Boolean) }
    def allow_promotion_codes; end
    # The ID of the Connect application that created the Payment Link.
    sig { returns(T.nilable(T.any(String, ::Stripe::Application))) }
    def application; end
    # The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the application owner's Stripe account.
    sig { returns(T.nilable(Integer)) }
    def application_fee_amount; end
    # This represents the percentage of the subscription invoice total that will be transferred to the application owner's Stripe account.
    sig { returns(T.nilable(Float)) }
    def application_fee_percent; end
    # Attribute for field automatic_tax
    sig { returns(AutomaticTax) }
    def automatic_tax; end
    # Configuration for collecting the customer's billing address. Defaults to `auto`.
    sig { returns(String) }
    def billing_address_collection; end
    # When set, provides configuration to gather active consent from customers.
    sig { returns(T.nilable(ConsentCollection)) }
    def consent_collection; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # Collect additional information from your customer using custom fields. Up to 3 fields are supported.
    sig { returns(T::Array[CustomField]) }
    def custom_fields; end
    # Attribute for field custom_text
    sig { returns(CustomText) }
    def custom_text; end
    # Configuration for Customer creation during checkout.
    sig { returns(String) }
    def customer_creation; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # The custom message to be displayed to a customer when a payment link is no longer active.
    sig { returns(T.nilable(String)) }
    def inactive_message; end
    # Configuration for creating invoice for payment mode payment links.
    sig { returns(T.nilable(InvoiceCreation)) }
    def invoice_creation; end
    # The line items representing what is being sold.
    sig { returns(T.nilable(::Stripe::ListObject)) }
    def line_items; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T::Hash[String, String]) }
    def metadata; end
    # Attribute for field name_collection
    sig { returns(T.nilable(NameCollection)) }
    def name_collection; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The account on behalf of which to charge. See the [Connect documentation](https://support.stripe.com/questions/sending-invoices-on-behalf-of-connected-accounts) for details.
    sig { returns(T.nilable(T.any(String, ::Stripe::Account))) }
    def on_behalf_of; end
    # The optional items presented to the customer at checkout.
    sig { returns(T.nilable(T::Array[OptionalItem])) }
    def optional_items; end
    # Indicates the parameters to be passed to PaymentIntent creation during checkout.
    sig { returns(T.nilable(PaymentIntentData)) }
    def payment_intent_data; end
    # Configuration for collecting a payment method during checkout. Defaults to `always`.
    sig { returns(String) }
    def payment_method_collection; end
    # The list of payment method types that customers can use. When `null`, Stripe will dynamically show relevant payment methods you've enabled in your [payment method settings](https://dashboard.stripe.com/settings/payment_methods).
    sig { returns(T.nilable(T::Array[String])) }
    def payment_method_types; end
    # Attribute for field phone_number_collection
    sig { returns(PhoneNumberCollection) }
    def phone_number_collection; end
    # Settings that restrict the usage of a payment link.
    sig { returns(T.nilable(Restrictions)) }
    def restrictions; end
    # Configuration for collecting the customer's shipping address.
    sig { returns(T.nilable(ShippingAddressCollection)) }
    def shipping_address_collection; end
    # The shipping rate options applied to the session.
    sig { returns(T::Array[ShippingOption]) }
    def shipping_options; end
    # Indicates the type of transaction being performed which customizes relevant text on the page, such as the submit button.
    sig { returns(String) }
    def submit_type; end
    # When creating a subscription, the specified configuration data will be used. There must be at least one line item with a recurring price to use `subscription_data`.
    sig { returns(T.nilable(SubscriptionData)) }
    def subscription_data; end
    # Attribute for field tax_id_collection
    sig { returns(TaxIdCollection) }
    def tax_id_collection; end
    # The account (if any) the payments will be attributed to for tax reporting, and where funds from each payment will be transferred to.
    sig { returns(T.nilable(TransferData)) }
    def transfer_data; end
    # The public URL that can be shared with customers.
    sig { returns(String) }
    def url; end
    # Creates a payment link.
    sig {
      params(params: T.any(::Stripe::PaymentLinkCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentLink)
     }
    def self.create(params = {}, opts = {}); end

    # Returns a list of your payment links.
    sig {
      params(params: T.any(::Stripe::PaymentLinkListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # When retrieving a payment link, there is an includable line_items property containing the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
    sig {
      params(params: T.any(::Stripe::PaymentLinkListLineItemsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list_line_items(params = {}, opts = {}); end

    # When retrieving a payment link, there is an includable line_items property containing the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
    sig {
      params(payment_link: String, params: T.any(::Stripe::PaymentLinkListLineItemsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list_line_items(payment_link, params = {}, opts = {}); end

    # Updates a payment link.
    sig {
      params(payment_link: String, params: T.any(::Stripe::PaymentLinkUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentLink)
     }
    def self.update(payment_link, params = {}, opts = {}); end
  end
end