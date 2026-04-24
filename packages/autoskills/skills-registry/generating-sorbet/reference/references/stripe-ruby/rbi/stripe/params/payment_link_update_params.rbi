# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentLinkUpdateParams < ::Stripe::RequestParams
    class AfterCompletion < ::Stripe::RequestParams
      class HostedConfirmation < ::Stripe::RequestParams
        # A custom message to display to the customer after the purchase is complete.
        sig { returns(T.nilable(String)) }
        def custom_message; end
        sig { params(_custom_message: T.nilable(String)).returns(T.nilable(String)) }
        def custom_message=(_custom_message); end
        sig { params(custom_message: T.nilable(String)).void }
        def initialize(custom_message: nil); end
      end
      class Redirect < ::Stripe::RequestParams
        # The URL the customer will be redirected to after the purchase is complete. You can embed `{CHECKOUT_SESSION_ID}` into the URL to have the `id` of the completed [checkout session](https://docs.stripe.com/api/checkout/sessions/object#checkout_session_object-id) included.
        sig { returns(String) }
        def url; end
        sig { params(_url: String).returns(String) }
        def url=(_url); end
        sig { params(url: String).void }
        def initialize(url: nil); end
      end
      # Configuration when `type=hosted_confirmation`.
      sig { returns(T.nilable(PaymentLinkUpdateParams::AfterCompletion::HostedConfirmation)) }
      def hosted_confirmation; end
      sig {
        params(_hosted_confirmation: T.nilable(PaymentLinkUpdateParams::AfterCompletion::HostedConfirmation)).returns(T.nilable(PaymentLinkUpdateParams::AfterCompletion::HostedConfirmation))
       }
      def hosted_confirmation=(_hosted_confirmation); end
      # Configuration when `type=redirect`.
      sig { returns(T.nilable(PaymentLinkUpdateParams::AfterCompletion::Redirect)) }
      def redirect; end
      sig {
        params(_redirect: T.nilable(PaymentLinkUpdateParams::AfterCompletion::Redirect)).returns(T.nilable(PaymentLinkUpdateParams::AfterCompletion::Redirect))
       }
      def redirect=(_redirect); end
      # The specified behavior after the purchase is complete. Either `redirect` or `hosted_confirmation`.
      sig { returns(String) }
      def type; end
      sig { params(_type: String).returns(String) }
      def type=(_type); end
      sig {
        params(hosted_confirmation: T.nilable(PaymentLinkUpdateParams::AfterCompletion::HostedConfirmation), redirect: T.nilable(PaymentLinkUpdateParams::AfterCompletion::Redirect), type: String).void
       }
      def initialize(hosted_confirmation: nil, redirect: nil, type: nil); end
    end
    class AutomaticTax < ::Stripe::RequestParams
      class Liability < ::Stripe::RequestParams
        # The connected account being referenced when `type` is `account`.
        sig { returns(T.nilable(String)) }
        def account; end
        sig { params(_account: T.nilable(String)).returns(T.nilable(String)) }
        def account=(_account); end
        # Type of the account referenced in the request.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        sig { params(account: T.nilable(String), type: String).void }
        def initialize(account: nil, type: nil); end
      end
      # Set to `true` to [calculate tax automatically](https://docs.stripe.com/tax) using the customer's location.
      #
      # Enabling this parameter causes the payment link to collect any billing address information necessary for tax calculation.
      sig { returns(T::Boolean) }
      def enabled; end
      sig { params(_enabled: T::Boolean).returns(T::Boolean) }
      def enabled=(_enabled); end
      # The account that's liable for tax. If set, the business address and tax registrations required to perform the tax calculation are loaded from this account. The tax transaction is returned in the report of the connected account.
      sig { returns(T.nilable(PaymentLinkUpdateParams::AutomaticTax::Liability)) }
      def liability; end
      sig {
        params(_liability: T.nilable(PaymentLinkUpdateParams::AutomaticTax::Liability)).returns(T.nilable(PaymentLinkUpdateParams::AutomaticTax::Liability))
       }
      def liability=(_liability); end
      sig {
        params(enabled: T::Boolean, liability: T.nilable(PaymentLinkUpdateParams::AutomaticTax::Liability)).void
       }
      def initialize(enabled: nil, liability: nil); end
    end
    class CustomField < ::Stripe::RequestParams
      class Dropdown < ::Stripe::RequestParams
        class Option < ::Stripe::RequestParams
          # The label for the option, displayed to the customer. Up to 100 characters.
          sig { returns(String) }
          def label; end
          sig { params(_label: String).returns(String) }
          def label=(_label); end
          # The value for this option, not displayed to the customer, used by your integration to reconcile the option selected by the customer. Must be unique to this option, alphanumeric, and up to 100 characters.
          sig { returns(String) }
          def value; end
          sig { params(_value: String).returns(String) }
          def value=(_value); end
          sig { params(label: String, value: String).void }
          def initialize(label: nil, value: nil); end
        end
        # The value that will pre-fill the field on the payment page.Must match a `value` in the `options` array.
        sig { returns(T.nilable(String)) }
        def default_value; end
        sig { params(_default_value: T.nilable(String)).returns(T.nilable(String)) }
        def default_value=(_default_value); end
        # The options available for the customer to select. Up to 200 options allowed.
        sig { returns(T::Array[PaymentLinkUpdateParams::CustomField::Dropdown::Option]) }
        def options; end
        sig {
          params(_options: T::Array[PaymentLinkUpdateParams::CustomField::Dropdown::Option]).returns(T::Array[PaymentLinkUpdateParams::CustomField::Dropdown::Option])
         }
        def options=(_options); end
        sig {
          params(default_value: T.nilable(String), options: T::Array[PaymentLinkUpdateParams::CustomField::Dropdown::Option]).void
         }
        def initialize(default_value: nil, options: nil); end
      end
      class Label < ::Stripe::RequestParams
        # Custom text for the label, displayed to the customer. Up to 50 characters.
        sig { returns(String) }
        def custom; end
        sig { params(_custom: String).returns(String) }
        def custom=(_custom); end
        # The type of the label.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        sig { params(custom: String, type: String).void }
        def initialize(custom: nil, type: nil); end
      end
      class Numeric < ::Stripe::RequestParams
        # The value that will pre-fill the field on the payment page.
        sig { returns(T.nilable(String)) }
        def default_value; end
        sig { params(_default_value: T.nilable(String)).returns(T.nilable(String)) }
        def default_value=(_default_value); end
        # The maximum character length constraint for the customer's input.
        sig { returns(T.nilable(Integer)) }
        def maximum_length; end
        sig { params(_maximum_length: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def maximum_length=(_maximum_length); end
        # The minimum character length requirement for the customer's input.
        sig { returns(T.nilable(Integer)) }
        def minimum_length; end
        sig { params(_minimum_length: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def minimum_length=(_minimum_length); end
        sig {
          params(default_value: T.nilable(String), maximum_length: T.nilable(Integer), minimum_length: T.nilable(Integer)).void
         }
        def initialize(default_value: nil, maximum_length: nil, minimum_length: nil); end
      end
      class Text < ::Stripe::RequestParams
        # The value that will pre-fill the field on the payment page.
        sig { returns(T.nilable(String)) }
        def default_value; end
        sig { params(_default_value: T.nilable(String)).returns(T.nilable(String)) }
        def default_value=(_default_value); end
        # The maximum character length constraint for the customer's input.
        sig { returns(T.nilable(Integer)) }
        def maximum_length; end
        sig { params(_maximum_length: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def maximum_length=(_maximum_length); end
        # The minimum character length requirement for the customer's input.
        sig { returns(T.nilable(Integer)) }
        def minimum_length; end
        sig { params(_minimum_length: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def minimum_length=(_minimum_length); end
        sig {
          params(default_value: T.nilable(String), maximum_length: T.nilable(Integer), minimum_length: T.nilable(Integer)).void
         }
        def initialize(default_value: nil, maximum_length: nil, minimum_length: nil); end
      end
      # Configuration for `type=dropdown` fields.
      sig { returns(T.nilable(PaymentLinkUpdateParams::CustomField::Dropdown)) }
      def dropdown; end
      sig {
        params(_dropdown: T.nilable(PaymentLinkUpdateParams::CustomField::Dropdown)).returns(T.nilable(PaymentLinkUpdateParams::CustomField::Dropdown))
       }
      def dropdown=(_dropdown); end
      # String of your choice that your integration can use to reconcile this field. Must be unique to this field, alphanumeric, and up to 200 characters.
      sig { returns(String) }
      def key; end
      sig { params(_key: String).returns(String) }
      def key=(_key); end
      # The label for the field, displayed to the customer.
      sig { returns(PaymentLinkUpdateParams::CustomField::Label) }
      def label; end
      sig {
        params(_label: PaymentLinkUpdateParams::CustomField::Label).returns(PaymentLinkUpdateParams::CustomField::Label)
       }
      def label=(_label); end
      # Configuration for `type=numeric` fields.
      sig { returns(T.nilable(PaymentLinkUpdateParams::CustomField::Numeric)) }
      def numeric; end
      sig {
        params(_numeric: T.nilable(PaymentLinkUpdateParams::CustomField::Numeric)).returns(T.nilable(PaymentLinkUpdateParams::CustomField::Numeric))
       }
      def numeric=(_numeric); end
      # Whether the customer is required to complete the field before completing the Checkout Session. Defaults to `false`.
      sig { returns(T.nilable(T::Boolean)) }
      def optional; end
      sig { params(_optional: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def optional=(_optional); end
      # Configuration for `type=text` fields.
      sig { returns(T.nilable(PaymentLinkUpdateParams::CustomField::Text)) }
      def text; end
      sig {
        params(_text: T.nilable(PaymentLinkUpdateParams::CustomField::Text)).returns(T.nilable(PaymentLinkUpdateParams::CustomField::Text))
       }
      def text=(_text); end
      # The type of the field.
      sig { returns(String) }
      def type; end
      sig { params(_type: String).returns(String) }
      def type=(_type); end
      sig {
        params(dropdown: T.nilable(PaymentLinkUpdateParams::CustomField::Dropdown), key: String, label: PaymentLinkUpdateParams::CustomField::Label, numeric: T.nilable(PaymentLinkUpdateParams::CustomField::Numeric), optional: T.nilable(T::Boolean), text: T.nilable(PaymentLinkUpdateParams::CustomField::Text), type: String).void
       }
      def initialize(
        dropdown: nil,
        key: nil,
        label: nil,
        numeric: nil,
        optional: nil,
        text: nil,
        type: nil
      ); end
    end
    class CustomText < ::Stripe::RequestParams
      class AfterSubmit < ::Stripe::RequestParams
        # Text may be up to 1200 characters in length.
        sig { returns(String) }
        def message; end
        sig { params(_message: String).returns(String) }
        def message=(_message); end
        sig { params(message: String).void }
        def initialize(message: nil); end
      end
      class ShippingAddress < ::Stripe::RequestParams
        # Text may be up to 1200 characters in length.
        sig { returns(String) }
        def message; end
        sig { params(_message: String).returns(String) }
        def message=(_message); end
        sig { params(message: String).void }
        def initialize(message: nil); end
      end
      class Submit < ::Stripe::RequestParams
        # Text may be up to 1200 characters in length.
        sig { returns(String) }
        def message; end
        sig { params(_message: String).returns(String) }
        def message=(_message); end
        sig { params(message: String).void }
        def initialize(message: nil); end
      end
      class TermsOfServiceAcceptance < ::Stripe::RequestParams
        # Text may be up to 1200 characters in length.
        sig { returns(String) }
        def message; end
        sig { params(_message: String).returns(String) }
        def message=(_message); end
        sig { params(message: String).void }
        def initialize(message: nil); end
      end
      # Custom text that should be displayed after the payment confirmation button.
      sig { returns(T.nilable(T.any(String, PaymentLinkUpdateParams::CustomText::AfterSubmit))) }
      def after_submit; end
      sig {
        params(_after_submit: T.nilable(T.any(String, PaymentLinkUpdateParams::CustomText::AfterSubmit))).returns(T.nilable(T.any(String, PaymentLinkUpdateParams::CustomText::AfterSubmit)))
       }
      def after_submit=(_after_submit); end
      # Custom text that should be displayed alongside shipping address collection.
      sig {
        returns(T.nilable(T.any(String, PaymentLinkUpdateParams::CustomText::ShippingAddress)))
       }
      def shipping_address; end
      sig {
        params(_shipping_address: T.nilable(T.any(String, PaymentLinkUpdateParams::CustomText::ShippingAddress))).returns(T.nilable(T.any(String, PaymentLinkUpdateParams::CustomText::ShippingAddress)))
       }
      def shipping_address=(_shipping_address); end
      # Custom text that should be displayed alongside the payment confirmation button.
      sig { returns(T.nilable(T.any(String, PaymentLinkUpdateParams::CustomText::Submit))) }
      def submit; end
      sig {
        params(_submit: T.nilable(T.any(String, PaymentLinkUpdateParams::CustomText::Submit))).returns(T.nilable(T.any(String, PaymentLinkUpdateParams::CustomText::Submit)))
       }
      def submit=(_submit); end
      # Custom text that should be displayed in place of the default terms of service agreement text.
      sig {
        returns(T.nilable(T.any(String, PaymentLinkUpdateParams::CustomText::TermsOfServiceAcceptance)))
       }
      def terms_of_service_acceptance; end
      sig {
        params(_terms_of_service_acceptance: T.nilable(T.any(String, PaymentLinkUpdateParams::CustomText::TermsOfServiceAcceptance))).returns(T.nilable(T.any(String, PaymentLinkUpdateParams::CustomText::TermsOfServiceAcceptance)))
       }
      def terms_of_service_acceptance=(_terms_of_service_acceptance); end
      sig {
        params(after_submit: T.nilable(T.any(String, PaymentLinkUpdateParams::CustomText::AfterSubmit)), shipping_address: T.nilable(T.any(String, PaymentLinkUpdateParams::CustomText::ShippingAddress)), submit: T.nilable(T.any(String, PaymentLinkUpdateParams::CustomText::Submit)), terms_of_service_acceptance: T.nilable(T.any(String, PaymentLinkUpdateParams::CustomText::TermsOfServiceAcceptance))).void
       }
      def initialize(
        after_submit: nil,
        shipping_address: nil,
        submit: nil,
        terms_of_service_acceptance: nil
      ); end
    end
    class InvoiceCreation < ::Stripe::RequestParams
      class InvoiceData < ::Stripe::RequestParams
        class CustomField < ::Stripe::RequestParams
          # The name of the custom field. This may be up to 40 characters.
          sig { returns(String) }
          def name; end
          sig { params(_name: String).returns(String) }
          def name=(_name); end
          # The value of the custom field. This may be up to 140 characters.
          sig { returns(String) }
          def value; end
          sig { params(_value: String).returns(String) }
          def value=(_value); end
          sig { params(name: String, value: String).void }
          def initialize(name: nil, value: nil); end
        end
        class Issuer < ::Stripe::RequestParams
          # The connected account being referenced when `type` is `account`.
          sig { returns(T.nilable(String)) }
          def account; end
          sig { params(_account: T.nilable(String)).returns(T.nilable(String)) }
          def account=(_account); end
          # Type of the account referenced in the request.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(account: T.nilable(String), type: String).void }
          def initialize(account: nil, type: nil); end
        end
        class RenderingOptions < ::Stripe::RequestParams
          # How line-item prices and amounts will be displayed with respect to tax on invoice PDFs. One of `exclude_tax` or `include_inclusive_tax`. `include_inclusive_tax` will include inclusive tax (and exclude exclusive tax) in invoice PDF amounts. `exclude_tax` will exclude all tax (inclusive and exclusive alike) from invoice PDF amounts.
          sig { returns(T.nilable(T.any(String, String))) }
          def amount_tax_display; end
          sig {
            params(_amount_tax_display: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
           }
          def amount_tax_display=(_amount_tax_display); end
          # ID of the invoice rendering template to use for this invoice.
          sig { returns(T.nilable(String)) }
          def template; end
          sig { params(_template: T.nilable(String)).returns(T.nilable(String)) }
          def template=(_template); end
          sig {
            params(amount_tax_display: T.nilable(T.any(String, String)), template: T.nilable(String)).void
           }
          def initialize(amount_tax_display: nil, template: nil); end
        end
        # The account tax IDs associated with the invoice.
        sig { returns(T.nilable(T.any(String, T::Array[String]))) }
        def account_tax_ids; end
        sig {
          params(_account_tax_ids: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
         }
        def account_tax_ids=(_account_tax_ids); end
        # Default custom fields to be displayed on invoices for this customer.
        sig {
          returns(T.nilable(T.any(String, T::Array[PaymentLinkUpdateParams::InvoiceCreation::InvoiceData::CustomField])))
         }
        def custom_fields; end
        sig {
          params(_custom_fields: T.nilable(T.any(String, T::Array[PaymentLinkUpdateParams::InvoiceCreation::InvoiceData::CustomField]))).returns(T.nilable(T.any(String, T::Array[PaymentLinkUpdateParams::InvoiceCreation::InvoiceData::CustomField])))
         }
        def custom_fields=(_custom_fields); end
        # An arbitrary string attached to the object. Often useful for displaying to users.
        sig { returns(T.nilable(String)) }
        def description; end
        sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
        def description=(_description); end
        # Default footer to be displayed on invoices for this customer.
        sig { returns(T.nilable(String)) }
        def footer; end
        sig { params(_footer: T.nilable(String)).returns(T.nilable(String)) }
        def footer=(_footer); end
        # The connected account that issues the invoice. The invoice is presented with the branding and support information of the specified account.
        sig { returns(T.nilable(PaymentLinkUpdateParams::InvoiceCreation::InvoiceData::Issuer)) }
        def issuer; end
        sig {
          params(_issuer: T.nilable(PaymentLinkUpdateParams::InvoiceCreation::InvoiceData::Issuer)).returns(T.nilable(PaymentLinkUpdateParams::InvoiceCreation::InvoiceData::Issuer))
         }
        def issuer=(_issuer); end
        # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
        sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
        def metadata; end
        sig {
          params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
         }
        def metadata=(_metadata); end
        # Default options for invoice PDF rendering for this customer.
        sig {
          returns(T.nilable(T.any(String, PaymentLinkUpdateParams::InvoiceCreation::InvoiceData::RenderingOptions)))
         }
        def rendering_options; end
        sig {
          params(_rendering_options: T.nilable(T.any(String, PaymentLinkUpdateParams::InvoiceCreation::InvoiceData::RenderingOptions))).returns(T.nilable(T.any(String, PaymentLinkUpdateParams::InvoiceCreation::InvoiceData::RenderingOptions)))
         }
        def rendering_options=(_rendering_options); end
        sig {
          params(account_tax_ids: T.nilable(T.any(String, T::Array[String])), custom_fields: T.nilable(T.any(String, T::Array[PaymentLinkUpdateParams::InvoiceCreation::InvoiceData::CustomField])), description: T.nilable(String), footer: T.nilable(String), issuer: T.nilable(PaymentLinkUpdateParams::InvoiceCreation::InvoiceData::Issuer), metadata: T.nilable(T.any(String, T::Hash[String, String])), rendering_options: T.nilable(T.any(String, PaymentLinkUpdateParams::InvoiceCreation::InvoiceData::RenderingOptions))).void
         }
        def initialize(
          account_tax_ids: nil,
          custom_fields: nil,
          description: nil,
          footer: nil,
          issuer: nil,
          metadata: nil,
          rendering_options: nil
        ); end
      end
      # Whether the feature is enabled
      sig { returns(T::Boolean) }
      def enabled; end
      sig { params(_enabled: T::Boolean).returns(T::Boolean) }
      def enabled=(_enabled); end
      # Invoice PDF configuration.
      sig { returns(T.nilable(PaymentLinkUpdateParams::InvoiceCreation::InvoiceData)) }
      def invoice_data; end
      sig {
        params(_invoice_data: T.nilable(PaymentLinkUpdateParams::InvoiceCreation::InvoiceData)).returns(T.nilable(PaymentLinkUpdateParams::InvoiceCreation::InvoiceData))
       }
      def invoice_data=(_invoice_data); end
      sig {
        params(enabled: T::Boolean, invoice_data: T.nilable(PaymentLinkUpdateParams::InvoiceCreation::InvoiceData)).void
       }
      def initialize(enabled: nil, invoice_data: nil); end
    end
    class LineItem < ::Stripe::RequestParams
      class AdjustableQuantity < ::Stripe::RequestParams
        # Set to true if the quantity can be adjusted to any non-negative Integer.
        sig { returns(T::Boolean) }
        def enabled; end
        sig { params(_enabled: T::Boolean).returns(T::Boolean) }
        def enabled=(_enabled); end
        # The maximum quantity the customer can purchase. By default this value is 99. You can specify a value up to 999999.
        sig { returns(T.nilable(Integer)) }
        def maximum; end
        sig { params(_maximum: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def maximum=(_maximum); end
        # The minimum quantity the customer can purchase. By default this value is 0. If there is only one item in the cart then that item's quantity cannot go down to 0.
        sig { returns(T.nilable(Integer)) }
        def minimum; end
        sig { params(_minimum: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def minimum=(_minimum); end
        sig {
          params(enabled: T::Boolean, maximum: T.nilable(Integer), minimum: T.nilable(Integer)).void
         }
        def initialize(enabled: nil, maximum: nil, minimum: nil); end
      end
      # When set, provides configuration for this item’s quantity to be adjusted by the customer during checkout.
      sig { returns(T.nilable(PaymentLinkUpdateParams::LineItem::AdjustableQuantity)) }
      def adjustable_quantity; end
      sig {
        params(_adjustable_quantity: T.nilable(PaymentLinkUpdateParams::LineItem::AdjustableQuantity)).returns(T.nilable(PaymentLinkUpdateParams::LineItem::AdjustableQuantity))
       }
      def adjustable_quantity=(_adjustable_quantity); end
      # The ID of an existing line item on the payment link.
      sig { returns(String) }
      def id; end
      sig { params(_id: String).returns(String) }
      def id=(_id); end
      # The quantity of the line item being purchased.
      sig { returns(T.nilable(Integer)) }
      def quantity; end
      sig { params(_quantity: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def quantity=(_quantity); end
      sig {
        params(adjustable_quantity: T.nilable(PaymentLinkUpdateParams::LineItem::AdjustableQuantity), id: String, quantity: T.nilable(Integer)).void
       }
      def initialize(adjustable_quantity: nil, id: nil, quantity: nil); end
    end
    class NameCollection < ::Stripe::RequestParams
      class Business < ::Stripe::RequestParams
        # Enable business name collection on the payment link. Defaults to `false`.
        sig { returns(T::Boolean) }
        def enabled; end
        sig { params(_enabled: T::Boolean).returns(T::Boolean) }
        def enabled=(_enabled); end
        # Whether the customer is required to provide their business name before checking out. Defaults to `false`.
        sig { returns(T.nilable(T::Boolean)) }
        def optional; end
        sig { params(_optional: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def optional=(_optional); end
        sig { params(enabled: T::Boolean, optional: T.nilable(T::Boolean)).void }
        def initialize(enabled: nil, optional: nil); end
      end
      class Individual < ::Stripe::RequestParams
        # Enable individual name collection on the payment link. Defaults to `false`.
        sig { returns(T::Boolean) }
        def enabled; end
        sig { params(_enabled: T::Boolean).returns(T::Boolean) }
        def enabled=(_enabled); end
        # Whether the customer is required to provide their full name before checking out. Defaults to `false`.
        sig { returns(T.nilable(T::Boolean)) }
        def optional; end
        sig { params(_optional: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def optional=(_optional); end
        sig { params(enabled: T::Boolean, optional: T.nilable(T::Boolean)).void }
        def initialize(enabled: nil, optional: nil); end
      end
      # Controls settings applied for collecting the customer's business name.
      sig { returns(T.nilable(PaymentLinkUpdateParams::NameCollection::Business)) }
      def business; end
      sig {
        params(_business: T.nilable(PaymentLinkUpdateParams::NameCollection::Business)).returns(T.nilable(PaymentLinkUpdateParams::NameCollection::Business))
       }
      def business=(_business); end
      # Controls settings applied for collecting the customer's individual name.
      sig { returns(T.nilable(PaymentLinkUpdateParams::NameCollection::Individual)) }
      def individual; end
      sig {
        params(_individual: T.nilable(PaymentLinkUpdateParams::NameCollection::Individual)).returns(T.nilable(PaymentLinkUpdateParams::NameCollection::Individual))
       }
      def individual=(_individual); end
      sig {
        params(business: T.nilable(PaymentLinkUpdateParams::NameCollection::Business), individual: T.nilable(PaymentLinkUpdateParams::NameCollection::Individual)).void
       }
      def initialize(business: nil, individual: nil); end
    end
    class PaymentIntentData < ::Stripe::RequestParams
      # An arbitrary string attached to the object. Often useful for displaying to users.
      sig { returns(T.nilable(String)) }
      def description; end
      sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
      def description=(_description); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that will declaratively set metadata on [Payment Intents](https://docs.stripe.com/api/payment_intents) generated from this payment link. Unlike object-level metadata, this field is declarative. Updates will clear prior values.
      sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
       }
      def metadata=(_metadata); end
      # Text that appears on the customer's statement as the statement descriptor for a non-card charge. This value overrides the account's default statement descriptor. For information about requirements, including the 22-character limit, see [the Statement Descriptor docs](https://docs.stripe.com/get-started/account/statement-descriptors).
      #
      # Setting this value for a card charge returns an error. For card charges, set the [statement_descriptor_suffix](https://docs.stripe.com/get-started/account/statement-descriptors#dynamic) instead.
      sig { returns(T.nilable(String)) }
      def statement_descriptor; end
      sig { params(_statement_descriptor: T.nilable(String)).returns(T.nilable(String)) }
      def statement_descriptor=(_statement_descriptor); end
      # Provides information about a card charge. Concatenated to the account's [statement descriptor prefix](https://docs.stripe.com/get-started/account/statement-descriptors#static) to form the complete statement descriptor that appears on the customer's statement.
      sig { returns(T.nilable(String)) }
      def statement_descriptor_suffix; end
      sig { params(_statement_descriptor_suffix: T.nilable(String)).returns(T.nilable(String)) }
      def statement_descriptor_suffix=(_statement_descriptor_suffix); end
      # A string that identifies the resulting payment as part of a group. See the PaymentIntents [use case for connected accounts](https://docs.stripe.com/connect/separate-charges-and-transfers) for details.
      sig { returns(T.nilable(String)) }
      def transfer_group; end
      sig { params(_transfer_group: T.nilable(String)).returns(T.nilable(String)) }
      def transfer_group=(_transfer_group); end
      sig {
        params(description: T.nilable(String), metadata: T.nilable(T.any(String, T::Hash[String, String])), statement_descriptor: T.nilable(String), statement_descriptor_suffix: T.nilable(String), transfer_group: T.nilable(String)).void
       }
      def initialize(
        description: nil,
        metadata: nil,
        statement_descriptor: nil,
        statement_descriptor_suffix: nil,
        transfer_group: nil
      ); end
    end
    class PhoneNumberCollection < ::Stripe::RequestParams
      # Set to `true` to enable phone number collection.
      sig { returns(T::Boolean) }
      def enabled; end
      sig { params(_enabled: T::Boolean).returns(T::Boolean) }
      def enabled=(_enabled); end
      sig { params(enabled: T::Boolean).void }
      def initialize(enabled: nil); end
    end
    class Restrictions < ::Stripe::RequestParams
      class CompletedSessions < ::Stripe::RequestParams
        # The maximum number of checkout sessions that can be completed for the `completed_sessions` restriction to be met.
        sig { returns(Integer) }
        def limit; end
        sig { params(_limit: Integer).returns(Integer) }
        def limit=(_limit); end
        sig { params(limit: Integer).void }
        def initialize(limit: nil); end
      end
      # Configuration for the `completed_sessions` restriction type.
      sig { returns(PaymentLinkUpdateParams::Restrictions::CompletedSessions) }
      def completed_sessions; end
      sig {
        params(_completed_sessions: PaymentLinkUpdateParams::Restrictions::CompletedSessions).returns(PaymentLinkUpdateParams::Restrictions::CompletedSessions)
       }
      def completed_sessions=(_completed_sessions); end
      sig {
        params(completed_sessions: PaymentLinkUpdateParams::Restrictions::CompletedSessions).void
       }
      def initialize(completed_sessions: nil); end
    end
    class ShippingAddressCollection < ::Stripe::RequestParams
      # An array of two-letter ISO country codes representing which countries Checkout should provide as options for
      # shipping locations.
      sig { returns(T::Array[String]) }
      def allowed_countries; end
      sig { params(_allowed_countries: T::Array[String]).returns(T::Array[String]) }
      def allowed_countries=(_allowed_countries); end
      sig { params(allowed_countries: T::Array[String]).void }
      def initialize(allowed_countries: nil); end
    end
    class SubscriptionData < ::Stripe::RequestParams
      class InvoiceSettings < ::Stripe::RequestParams
        class Issuer < ::Stripe::RequestParams
          # The connected account being referenced when `type` is `account`.
          sig { returns(T.nilable(String)) }
          def account; end
          sig { params(_account: T.nilable(String)).returns(T.nilable(String)) }
          def account=(_account); end
          # Type of the account referenced in the request.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(account: T.nilable(String), type: String).void }
          def initialize(account: nil, type: nil); end
        end
        # The connected account that issues the invoice. The invoice is presented with the branding and support information of the specified account.
        sig {
          returns(T.nilable(PaymentLinkUpdateParams::SubscriptionData::InvoiceSettings::Issuer))
         }
        def issuer; end
        sig {
          params(_issuer: T.nilable(PaymentLinkUpdateParams::SubscriptionData::InvoiceSettings::Issuer)).returns(T.nilable(PaymentLinkUpdateParams::SubscriptionData::InvoiceSettings::Issuer))
         }
        def issuer=(_issuer); end
        sig {
          params(issuer: T.nilable(PaymentLinkUpdateParams::SubscriptionData::InvoiceSettings::Issuer)).void
         }
        def initialize(issuer: nil); end
      end
      class TrialSettings < ::Stripe::RequestParams
        class EndBehavior < ::Stripe::RequestParams
          # Indicates how the subscription should change when the trial ends if the user did not provide a payment method.
          sig { returns(String) }
          def missing_payment_method; end
          sig { params(_missing_payment_method: String).returns(String) }
          def missing_payment_method=(_missing_payment_method); end
          sig { params(missing_payment_method: String).void }
          def initialize(missing_payment_method: nil); end
        end
        # Defines how the subscription should behave when the user's free trial ends.
        sig { returns(PaymentLinkUpdateParams::SubscriptionData::TrialSettings::EndBehavior) }
        def end_behavior; end
        sig {
          params(_end_behavior: PaymentLinkUpdateParams::SubscriptionData::TrialSettings::EndBehavior).returns(PaymentLinkUpdateParams::SubscriptionData::TrialSettings::EndBehavior)
         }
        def end_behavior=(_end_behavior); end
        sig {
          params(end_behavior: PaymentLinkUpdateParams::SubscriptionData::TrialSettings::EndBehavior).void
         }
        def initialize(end_behavior: nil); end
      end
      # All invoices will be billed using the specified settings.
      sig { returns(T.nilable(PaymentLinkUpdateParams::SubscriptionData::InvoiceSettings)) }
      def invoice_settings; end
      sig {
        params(_invoice_settings: T.nilable(PaymentLinkUpdateParams::SubscriptionData::InvoiceSettings)).returns(T.nilable(PaymentLinkUpdateParams::SubscriptionData::InvoiceSettings))
       }
      def invoice_settings=(_invoice_settings); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that will declaratively set metadata on [Subscriptions](https://docs.stripe.com/api/subscriptions) generated from this payment link. Unlike object-level metadata, this field is declarative. Updates will clear prior values.
      sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
       }
      def metadata=(_metadata); end
      # Integer representing the number of trial period days before the customer is charged for the first time. Has to be at least 1.
      sig { returns(T.nilable(T.any(String, Integer))) }
      def trial_period_days; end
      sig {
        params(_trial_period_days: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
       }
      def trial_period_days=(_trial_period_days); end
      # Settings related to subscription trials.
      sig {
        returns(T.nilable(T.any(String, PaymentLinkUpdateParams::SubscriptionData::TrialSettings)))
       }
      def trial_settings; end
      sig {
        params(_trial_settings: T.nilable(T.any(String, PaymentLinkUpdateParams::SubscriptionData::TrialSettings))).returns(T.nilable(T.any(String, PaymentLinkUpdateParams::SubscriptionData::TrialSettings)))
       }
      def trial_settings=(_trial_settings); end
      sig {
        params(invoice_settings: T.nilable(PaymentLinkUpdateParams::SubscriptionData::InvoiceSettings), metadata: T.nilable(T.any(String, T::Hash[String, String])), trial_period_days: T.nilable(T.any(String, Integer)), trial_settings: T.nilable(T.any(String, PaymentLinkUpdateParams::SubscriptionData::TrialSettings))).void
       }
      def initialize(
        invoice_settings: nil,
        metadata: nil,
        trial_period_days: nil,
        trial_settings: nil
      ); end
    end
    class TaxIdCollection < ::Stripe::RequestParams
      # Enable tax ID collection during checkout. Defaults to `false`.
      sig { returns(T::Boolean) }
      def enabled; end
      sig { params(_enabled: T::Boolean).returns(T::Boolean) }
      def enabled=(_enabled); end
      # Describes whether a tax ID is required during checkout. Defaults to `never`.
      sig { returns(T.nilable(String)) }
      def required; end
      sig { params(_required: T.nilable(String)).returns(T.nilable(String)) }
      def required=(_required); end
      sig { params(enabled: T::Boolean, required: T.nilable(String)).void }
      def initialize(enabled: nil, required: nil); end
    end
    # Whether the payment link's `url` is active. If `false`, customers visiting the URL will be shown a page saying that the link has been deactivated.
    sig { returns(T.nilable(T::Boolean)) }
    def active; end
    sig { params(_active: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def active=(_active); end
    # Behavior after the purchase is complete.
    sig { returns(T.nilable(PaymentLinkUpdateParams::AfterCompletion)) }
    def after_completion; end
    sig {
      params(_after_completion: T.nilable(PaymentLinkUpdateParams::AfterCompletion)).returns(T.nilable(PaymentLinkUpdateParams::AfterCompletion))
     }
    def after_completion=(_after_completion); end
    # Enables user redeemable promotion codes.
    sig { returns(T.nilable(T::Boolean)) }
    def allow_promotion_codes; end
    sig { params(_allow_promotion_codes: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def allow_promotion_codes=(_allow_promotion_codes); end
    # Configuration for automatic tax collection.
    sig { returns(T.nilable(PaymentLinkUpdateParams::AutomaticTax)) }
    def automatic_tax; end
    sig {
      params(_automatic_tax: T.nilable(PaymentLinkUpdateParams::AutomaticTax)).returns(T.nilable(PaymentLinkUpdateParams::AutomaticTax))
     }
    def automatic_tax=(_automatic_tax); end
    # Configuration for collecting the customer's billing address. Defaults to `auto`.
    sig { returns(T.nilable(String)) }
    def billing_address_collection; end
    sig { params(_billing_address_collection: T.nilable(String)).returns(T.nilable(String)) }
    def billing_address_collection=(_billing_address_collection); end
    # Collect additional information from your customer using custom fields. Up to 3 fields are supported.
    sig { returns(T.nilable(T.any(String, T::Array[PaymentLinkUpdateParams::CustomField]))) }
    def custom_fields; end
    sig {
      params(_custom_fields: T.nilable(T.any(String, T::Array[PaymentLinkUpdateParams::CustomField]))).returns(T.nilable(T.any(String, T::Array[PaymentLinkUpdateParams::CustomField])))
     }
    def custom_fields=(_custom_fields); end
    # Display additional text for your customers using custom text.
    sig { returns(T.nilable(PaymentLinkUpdateParams::CustomText)) }
    def custom_text; end
    sig {
      params(_custom_text: T.nilable(PaymentLinkUpdateParams::CustomText)).returns(T.nilable(PaymentLinkUpdateParams::CustomText))
     }
    def custom_text=(_custom_text); end
    # Configures whether [checkout sessions](https://docs.stripe.com/api/checkout/sessions) created by this payment link create a [Customer](https://docs.stripe.com/api/customers).
    sig { returns(T.nilable(String)) }
    def customer_creation; end
    sig { params(_customer_creation: T.nilable(String)).returns(T.nilable(String)) }
    def customer_creation=(_customer_creation); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # The custom message to be displayed to a customer when a payment link is no longer active.
    sig { returns(T.nilable(String)) }
    def inactive_message; end
    sig { params(_inactive_message: T.nilable(String)).returns(T.nilable(String)) }
    def inactive_message=(_inactive_message); end
    # Generate a post-purchase Invoice for one-time payments.
    sig { returns(T.nilable(PaymentLinkUpdateParams::InvoiceCreation)) }
    def invoice_creation; end
    sig {
      params(_invoice_creation: T.nilable(PaymentLinkUpdateParams::InvoiceCreation)).returns(T.nilable(PaymentLinkUpdateParams::InvoiceCreation))
     }
    def invoice_creation=(_invoice_creation); end
    # The line items representing what is being sold. Each line item represents an item being sold. Up to 20 line items are supported.
    sig { returns(T.nilable(T::Array[PaymentLinkUpdateParams::LineItem])) }
    def line_items; end
    sig {
      params(_line_items: T.nilable(T::Array[PaymentLinkUpdateParams::LineItem])).returns(T.nilable(T::Array[PaymentLinkUpdateParams::LineItem]))
     }
    def line_items=(_line_items); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`. Metadata associated with this Payment Link will automatically be copied to [checkout sessions](https://docs.stripe.com/api/checkout/sessions) created by this payment link.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
     }
    def metadata=(_metadata); end
    # Controls settings applied for collecting the customer's name.
    sig { returns(T.nilable(T.any(String, PaymentLinkUpdateParams::NameCollection))) }
    def name_collection; end
    sig {
      params(_name_collection: T.nilable(T.any(String, PaymentLinkUpdateParams::NameCollection))).returns(T.nilable(T.any(String, PaymentLinkUpdateParams::NameCollection)))
     }
    def name_collection=(_name_collection); end
    # A subset of parameters to be passed to PaymentIntent creation for Checkout Sessions in `payment` mode.
    sig { returns(T.nilable(PaymentLinkUpdateParams::PaymentIntentData)) }
    def payment_intent_data; end
    sig {
      params(_payment_intent_data: T.nilable(PaymentLinkUpdateParams::PaymentIntentData)).returns(T.nilable(PaymentLinkUpdateParams::PaymentIntentData))
     }
    def payment_intent_data=(_payment_intent_data); end
    # Specify whether Checkout should collect a payment method. When set to `if_required`, Checkout will not collect a payment method when the total due for the session is 0.This may occur if the Checkout Session includes a free trial or a discount.
    #
    # Can only be set in `subscription` mode. Defaults to `always`.
    #
    # If you'd like information on how to collect a payment method outside of Checkout, read the guide on [configuring subscriptions with a free trial](https://docs.stripe.com/payments/checkout/free-trials).
    sig { returns(T.nilable(String)) }
    def payment_method_collection; end
    sig { params(_payment_method_collection: T.nilable(String)).returns(T.nilable(String)) }
    def payment_method_collection=(_payment_method_collection); end
    # The list of payment method types that customers can use. Pass an empty string to enable dynamic payment methods that use your [payment method settings](https://dashboard.stripe.com/settings/payment_methods).
    sig { returns(T.nilable(T.any(String, T::Array[String]))) }
    def payment_method_types; end
    sig {
      params(_payment_method_types: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
     }
    def payment_method_types=(_payment_method_types); end
    # Controls phone number collection settings during checkout.
    #
    # We recommend that you review your privacy policy and check with your legal contacts.
    sig { returns(T.nilable(PaymentLinkUpdateParams::PhoneNumberCollection)) }
    def phone_number_collection; end
    sig {
      params(_phone_number_collection: T.nilable(PaymentLinkUpdateParams::PhoneNumberCollection)).returns(T.nilable(PaymentLinkUpdateParams::PhoneNumberCollection))
     }
    def phone_number_collection=(_phone_number_collection); end
    # Settings that restrict the usage of a payment link.
    sig { returns(T.nilable(T.any(String, PaymentLinkUpdateParams::Restrictions))) }
    def restrictions; end
    sig {
      params(_restrictions: T.nilable(T.any(String, PaymentLinkUpdateParams::Restrictions))).returns(T.nilable(T.any(String, PaymentLinkUpdateParams::Restrictions)))
     }
    def restrictions=(_restrictions); end
    # Configuration for collecting the customer's shipping address.
    sig { returns(T.nilable(T.any(String, PaymentLinkUpdateParams::ShippingAddressCollection))) }
    def shipping_address_collection; end
    sig {
      params(_shipping_address_collection: T.nilable(T.any(String, PaymentLinkUpdateParams::ShippingAddressCollection))).returns(T.nilable(T.any(String, PaymentLinkUpdateParams::ShippingAddressCollection)))
     }
    def shipping_address_collection=(_shipping_address_collection); end
    # Describes the type of transaction being performed in order to customize relevant text on the page, such as the submit button. Changing this value will also affect the hostname in the [url](https://docs.stripe.com/api/payment_links/payment_links/object#url) property (example: `donate.stripe.com`).
    sig { returns(T.nilable(String)) }
    def submit_type; end
    sig { params(_submit_type: T.nilable(String)).returns(T.nilable(String)) }
    def submit_type=(_submit_type); end
    # When creating a subscription, the specified configuration data will be used. There must be at least one line item with a recurring price to use `subscription_data`.
    sig { returns(T.nilable(PaymentLinkUpdateParams::SubscriptionData)) }
    def subscription_data; end
    sig {
      params(_subscription_data: T.nilable(PaymentLinkUpdateParams::SubscriptionData)).returns(T.nilable(PaymentLinkUpdateParams::SubscriptionData))
     }
    def subscription_data=(_subscription_data); end
    # Controls tax ID collection during checkout.
    sig { returns(T.nilable(PaymentLinkUpdateParams::TaxIdCollection)) }
    def tax_id_collection; end
    sig {
      params(_tax_id_collection: T.nilable(PaymentLinkUpdateParams::TaxIdCollection)).returns(T.nilable(PaymentLinkUpdateParams::TaxIdCollection))
     }
    def tax_id_collection=(_tax_id_collection); end
    sig {
      params(active: T.nilable(T::Boolean), after_completion: T.nilable(PaymentLinkUpdateParams::AfterCompletion), allow_promotion_codes: T.nilable(T::Boolean), automatic_tax: T.nilable(PaymentLinkUpdateParams::AutomaticTax), billing_address_collection: T.nilable(String), custom_fields: T.nilable(T.any(String, T::Array[PaymentLinkUpdateParams::CustomField])), custom_text: T.nilable(PaymentLinkUpdateParams::CustomText), customer_creation: T.nilable(String), expand: T.nilable(T::Array[String]), inactive_message: T.nilable(String), invoice_creation: T.nilable(PaymentLinkUpdateParams::InvoiceCreation), line_items: T.nilable(T::Array[PaymentLinkUpdateParams::LineItem]), metadata: T.nilable(T::Hash[String, String]), name_collection: T.nilable(T.any(String, PaymentLinkUpdateParams::NameCollection)), payment_intent_data: T.nilable(PaymentLinkUpdateParams::PaymentIntentData), payment_method_collection: T.nilable(String), payment_method_types: T.nilable(T.any(String, T::Array[String])), phone_number_collection: T.nilable(PaymentLinkUpdateParams::PhoneNumberCollection), restrictions: T.nilable(T.any(String, PaymentLinkUpdateParams::Restrictions)), shipping_address_collection: T.nilable(T.any(String, PaymentLinkUpdateParams::ShippingAddressCollection)), submit_type: T.nilable(String), subscription_data: T.nilable(PaymentLinkUpdateParams::SubscriptionData), tax_id_collection: T.nilable(PaymentLinkUpdateParams::TaxIdCollection)).void
     }
    def initialize(
      active: nil,
      after_completion: nil,
      allow_promotion_codes: nil,
      automatic_tax: nil,
      billing_address_collection: nil,
      custom_fields: nil,
      custom_text: nil,
      customer_creation: nil,
      expand: nil,
      inactive_message: nil,
      invoice_creation: nil,
      line_items: nil,
      metadata: nil,
      name_collection: nil,
      payment_intent_data: nil,
      payment_method_collection: nil,
      payment_method_types: nil,
      phone_number_collection: nil,
      restrictions: nil,
      shipping_address_collection: nil,
      submit_type: nil,
      subscription_data: nil,
      tax_id_collection: nil
    ); end
  end
end