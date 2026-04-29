# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Checkout
    class SessionCreateParams < ::Stripe::RequestParams
      class AdaptivePricing < ::Stripe::RequestParams
        # If set to `true`, Adaptive Pricing is available on [eligible sessions](https://docs.stripe.com/payments/currencies/localize-prices/adaptive-pricing?payment-ui=stripe-hosted#restrictions). Defaults to your [dashboard setting](https://dashboard.stripe.com/settings/adaptive-pricing).
        sig { returns(T.nilable(T::Boolean)) }
        def enabled; end
        sig { params(_enabled: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def enabled=(_enabled); end
        sig { params(enabled: T.nilable(T::Boolean)).void }
        def initialize(enabled: nil); end
      end
      class AfterExpiration < ::Stripe::RequestParams
        class Recovery < ::Stripe::RequestParams
          # Enables user redeemable promotion codes on the recovered Checkout Sessions. Defaults to `false`
          sig { returns(T.nilable(T::Boolean)) }
          def allow_promotion_codes; end
          sig {
            params(_allow_promotion_codes: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean))
           }
          def allow_promotion_codes=(_allow_promotion_codes); end
          # If `true`, a recovery URL will be generated to recover this Checkout Session if it
          # expires before a successful transaction is completed. It will be attached to the
          # Checkout Session object upon expiration.
          sig { returns(T::Boolean) }
          def enabled; end
          sig { params(_enabled: T::Boolean).returns(T::Boolean) }
          def enabled=(_enabled); end
          sig { params(allow_promotion_codes: T.nilable(T::Boolean), enabled: T::Boolean).void }
          def initialize(allow_promotion_codes: nil, enabled: nil); end
        end
        # Configure a Checkout Session that can be used to recover an expired session.
        sig { returns(T.nilable(Checkout::SessionCreateParams::AfterExpiration::Recovery)) }
        def recovery; end
        sig {
          params(_recovery: T.nilable(Checkout::SessionCreateParams::AfterExpiration::Recovery)).returns(T.nilable(Checkout::SessionCreateParams::AfterExpiration::Recovery))
         }
        def recovery=(_recovery); end
        sig {
          params(recovery: T.nilable(Checkout::SessionCreateParams::AfterExpiration::Recovery)).void
         }
        def initialize(recovery: nil); end
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
        # Enabling this parameter causes Checkout to collect any billing address information necessary for tax calculation.
        sig { returns(T::Boolean) }
        def enabled; end
        sig { params(_enabled: T::Boolean).returns(T::Boolean) }
        def enabled=(_enabled); end
        # The account that's liable for tax. If set, the business address and tax registrations required to perform the tax calculation are loaded from this account. The tax transaction is returned in the report of the connected account.
        sig { returns(T.nilable(Checkout::SessionCreateParams::AutomaticTax::Liability)) }
        def liability; end
        sig {
          params(_liability: T.nilable(Checkout::SessionCreateParams::AutomaticTax::Liability)).returns(T.nilable(Checkout::SessionCreateParams::AutomaticTax::Liability))
         }
        def liability=(_liability); end
        sig {
          params(enabled: T::Boolean, liability: T.nilable(Checkout::SessionCreateParams::AutomaticTax::Liability)).void
         }
        def initialize(enabled: nil, liability: nil); end
      end
      class BrandingSettings < ::Stripe::RequestParams
        class Icon < ::Stripe::RequestParams
          # The ID of a [File upload](https://stripe.com/docs/api/files) representing the icon. Purpose must be `business_icon`. Required if `type` is `file` and disallowed otherwise.
          sig { returns(T.nilable(String)) }
          def file; end
          sig { params(_file: T.nilable(String)).returns(T.nilable(String)) }
          def file=(_file); end
          # The type of image for the icon. Must be one of `file` or `url`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          # The URL of the image. Required if `type` is `url` and disallowed otherwise.
          sig { returns(T.nilable(String)) }
          def url; end
          sig { params(_url: T.nilable(String)).returns(T.nilable(String)) }
          def url=(_url); end
          sig { params(file: T.nilable(String), type: String, url: T.nilable(String)).void }
          def initialize(file: nil, type: nil, url: nil); end
        end
        class Logo < ::Stripe::RequestParams
          # The ID of a [File upload](https://stripe.com/docs/api/files) representing the logo. Purpose must be `business_logo`. Required if `type` is `file` and disallowed otherwise.
          sig { returns(T.nilable(String)) }
          def file; end
          sig { params(_file: T.nilable(String)).returns(T.nilable(String)) }
          def file=(_file); end
          # The type of image for the logo. Must be one of `file` or `url`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          # The URL of the image. Required if `type` is `url` and disallowed otherwise.
          sig { returns(T.nilable(String)) }
          def url; end
          sig { params(_url: T.nilable(String)).returns(T.nilable(String)) }
          def url=(_url); end
          sig { params(file: T.nilable(String), type: String, url: T.nilable(String)).void }
          def initialize(file: nil, type: nil, url: nil); end
        end
        # A hex color value starting with `#` representing the background color for the Checkout Session.
        sig { returns(T.nilable(String)) }
        def background_color; end
        sig { params(_background_color: T.nilable(String)).returns(T.nilable(String)) }
        def background_color=(_background_color); end
        # The border style for the Checkout Session.
        sig { returns(T.nilable(T.any(String, String))) }
        def border_style; end
        sig {
          params(_border_style: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def border_style=(_border_style); end
        # A hex color value starting with `#` representing the button color for the Checkout Session.
        sig { returns(T.nilable(String)) }
        def button_color; end
        sig { params(_button_color: T.nilable(String)).returns(T.nilable(String)) }
        def button_color=(_button_color); end
        # A string to override the business name shown on the Checkout Session. This only shows at the top of the Checkout page, and your business name still appears in terms, receipts, and other places.
        sig { returns(T.nilable(String)) }
        def display_name; end
        sig { params(_display_name: T.nilable(String)).returns(T.nilable(String)) }
        def display_name=(_display_name); end
        # The font family for the Checkout Session corresponding to one of the [supported font families](https://docs.stripe.com/payments/checkout/customization/appearance?payment-ui=stripe-hosted#font-compatibility).
        sig { returns(T.nilable(T.any(String, String))) }
        def font_family; end
        sig {
          params(_font_family: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def font_family=(_font_family); end
        # The icon for the Checkout Session. For best results, use a square image.
        sig { returns(T.nilable(Checkout::SessionCreateParams::BrandingSettings::Icon)) }
        def icon; end
        sig {
          params(_icon: T.nilable(Checkout::SessionCreateParams::BrandingSettings::Icon)).returns(T.nilable(Checkout::SessionCreateParams::BrandingSettings::Icon))
         }
        def icon=(_icon); end
        # The logo for the Checkout Session.
        sig { returns(T.nilable(Checkout::SessionCreateParams::BrandingSettings::Logo)) }
        def logo; end
        sig {
          params(_logo: T.nilable(Checkout::SessionCreateParams::BrandingSettings::Logo)).returns(T.nilable(Checkout::SessionCreateParams::BrandingSettings::Logo))
         }
        def logo=(_logo); end
        sig {
          params(background_color: T.nilable(String), border_style: T.nilable(T.any(String, String)), button_color: T.nilable(String), display_name: T.nilable(String), font_family: T.nilable(T.any(String, String)), icon: T.nilable(Checkout::SessionCreateParams::BrandingSettings::Icon), logo: T.nilable(Checkout::SessionCreateParams::BrandingSettings::Logo)).void
         }
        def initialize(
          background_color: nil,
          border_style: nil,
          button_color: nil,
          display_name: nil,
          font_family: nil,
          icon: nil,
          logo: nil
        ); end
      end
      class ConsentCollection < ::Stripe::RequestParams
        class PaymentMethodReuseAgreement < ::Stripe::RequestParams
          # Determines the position and visibility of the payment method reuse agreement in the UI. When set to `auto`, Stripe's
          # defaults will be used. When set to `hidden`, the payment method reuse agreement text will always be hidden in the UI.
          sig { returns(String) }
          def position; end
          sig { params(_position: String).returns(String) }
          def position=(_position); end
          sig { params(position: String).void }
          def initialize(position: nil); end
        end
        # Determines the display of payment method reuse agreement text in the UI. If set to `hidden`, it will hide legal text related to the reuse of a payment method.
        sig {
          returns(T.nilable(Checkout::SessionCreateParams::ConsentCollection::PaymentMethodReuseAgreement))
         }
        def payment_method_reuse_agreement; end
        sig {
          params(_payment_method_reuse_agreement: T.nilable(Checkout::SessionCreateParams::ConsentCollection::PaymentMethodReuseAgreement)).returns(T.nilable(Checkout::SessionCreateParams::ConsentCollection::PaymentMethodReuseAgreement))
         }
        def payment_method_reuse_agreement=(_payment_method_reuse_agreement); end
        # If set to `auto`, enables the collection of customer consent for promotional communications. The Checkout
        # Session will determine whether to display an option to opt into promotional communication
        # from the merchant depending on the customer's locale. Only available to US merchants.
        sig { returns(T.nilable(String)) }
        def promotions; end
        sig { params(_promotions: T.nilable(String)).returns(T.nilable(String)) }
        def promotions=(_promotions); end
        # If set to `required`, it requires customers to check a terms of service checkbox before being able to pay.
        # There must be a valid terms of service URL set in your [Dashboard settings](https://dashboard.stripe.com/settings/public).
        sig { returns(T.nilable(String)) }
        def terms_of_service; end
        sig { params(_terms_of_service: T.nilable(String)).returns(T.nilable(String)) }
        def terms_of_service=(_terms_of_service); end
        sig {
          params(payment_method_reuse_agreement: T.nilable(Checkout::SessionCreateParams::ConsentCollection::PaymentMethodReuseAgreement), promotions: T.nilable(String), terms_of_service: T.nilable(String)).void
         }
        def initialize(
          payment_method_reuse_agreement: nil,
          promotions: nil,
          terms_of_service: nil
        ); end
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
          sig { returns(T::Array[Checkout::SessionCreateParams::CustomField::Dropdown::Option]) }
          def options; end
          sig {
            params(_options: T::Array[Checkout::SessionCreateParams::CustomField::Dropdown::Option]).returns(T::Array[Checkout::SessionCreateParams::CustomField::Dropdown::Option])
           }
          def options=(_options); end
          sig {
            params(default_value: T.nilable(String), options: T::Array[Checkout::SessionCreateParams::CustomField::Dropdown::Option]).void
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
        sig { returns(T.nilable(Checkout::SessionCreateParams::CustomField::Dropdown)) }
        def dropdown; end
        sig {
          params(_dropdown: T.nilable(Checkout::SessionCreateParams::CustomField::Dropdown)).returns(T.nilable(Checkout::SessionCreateParams::CustomField::Dropdown))
         }
        def dropdown=(_dropdown); end
        # String of your choice that your integration can use to reconcile this field. Must be unique to this field, alphanumeric, and up to 200 characters.
        sig { returns(String) }
        def key; end
        sig { params(_key: String).returns(String) }
        def key=(_key); end
        # The label for the field, displayed to the customer.
        sig { returns(Checkout::SessionCreateParams::CustomField::Label) }
        def label; end
        sig {
          params(_label: Checkout::SessionCreateParams::CustomField::Label).returns(Checkout::SessionCreateParams::CustomField::Label)
         }
        def label=(_label); end
        # Configuration for `type=numeric` fields.
        sig { returns(T.nilable(Checkout::SessionCreateParams::CustomField::Numeric)) }
        def numeric; end
        sig {
          params(_numeric: T.nilable(Checkout::SessionCreateParams::CustomField::Numeric)).returns(T.nilable(Checkout::SessionCreateParams::CustomField::Numeric))
         }
        def numeric=(_numeric); end
        # Whether the customer is required to complete the field before completing the Checkout Session. Defaults to `false`.
        sig { returns(T.nilable(T::Boolean)) }
        def optional; end
        sig { params(_optional: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def optional=(_optional); end
        # Configuration for `type=text` fields.
        sig { returns(T.nilable(Checkout::SessionCreateParams::CustomField::Text)) }
        def text; end
        sig {
          params(_text: T.nilable(Checkout::SessionCreateParams::CustomField::Text)).returns(T.nilable(Checkout::SessionCreateParams::CustomField::Text))
         }
        def text=(_text); end
        # The type of the field.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        sig {
          params(dropdown: T.nilable(Checkout::SessionCreateParams::CustomField::Dropdown), key: String, label: Checkout::SessionCreateParams::CustomField::Label, numeric: T.nilable(Checkout::SessionCreateParams::CustomField::Numeric), optional: T.nilable(T::Boolean), text: T.nilable(Checkout::SessionCreateParams::CustomField::Text), type: String).void
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
        sig {
          returns(T.nilable(T.any(String, Checkout::SessionCreateParams::CustomText::AfterSubmit)))
         }
        def after_submit; end
        sig {
          params(_after_submit: T.nilable(T.any(String, Checkout::SessionCreateParams::CustomText::AfterSubmit))).returns(T.nilable(T.any(String, Checkout::SessionCreateParams::CustomText::AfterSubmit)))
         }
        def after_submit=(_after_submit); end
        # Custom text that should be displayed alongside shipping address collection.
        sig {
          returns(T.nilable(T.any(String, Checkout::SessionCreateParams::CustomText::ShippingAddress)))
         }
        def shipping_address; end
        sig {
          params(_shipping_address: T.nilable(T.any(String, Checkout::SessionCreateParams::CustomText::ShippingAddress))).returns(T.nilable(T.any(String, Checkout::SessionCreateParams::CustomText::ShippingAddress)))
         }
        def shipping_address=(_shipping_address); end
        # Custom text that should be displayed alongside the payment confirmation button.
        sig { returns(T.nilable(T.any(String, Checkout::SessionCreateParams::CustomText::Submit))) }
        def submit; end
        sig {
          params(_submit: T.nilable(T.any(String, Checkout::SessionCreateParams::CustomText::Submit))).returns(T.nilable(T.any(String, Checkout::SessionCreateParams::CustomText::Submit)))
         }
        def submit=(_submit); end
        # Custom text that should be displayed in place of the default terms of service agreement text.
        sig {
          returns(T.nilable(T.any(String, Checkout::SessionCreateParams::CustomText::TermsOfServiceAcceptance)))
         }
        def terms_of_service_acceptance; end
        sig {
          params(_terms_of_service_acceptance: T.nilable(T.any(String, Checkout::SessionCreateParams::CustomText::TermsOfServiceAcceptance))).returns(T.nilable(T.any(String, Checkout::SessionCreateParams::CustomText::TermsOfServiceAcceptance)))
         }
        def terms_of_service_acceptance=(_terms_of_service_acceptance); end
        sig {
          params(after_submit: T.nilable(T.any(String, Checkout::SessionCreateParams::CustomText::AfterSubmit)), shipping_address: T.nilable(T.any(String, Checkout::SessionCreateParams::CustomText::ShippingAddress)), submit: T.nilable(T.any(String, Checkout::SessionCreateParams::CustomText::Submit)), terms_of_service_acceptance: T.nilable(T.any(String, Checkout::SessionCreateParams::CustomText::TermsOfServiceAcceptance))).void
         }
        def initialize(
          after_submit: nil,
          shipping_address: nil,
          submit: nil,
          terms_of_service_acceptance: nil
        ); end
      end
      class CustomerUpdate < ::Stripe::RequestParams
        # Describes whether Checkout saves the billing address onto `customer.address`.
        # To always collect a full billing address, use `billing_address_collection`. Defaults to `never`.
        sig { returns(T.nilable(String)) }
        def address; end
        sig { params(_address: T.nilable(String)).returns(T.nilable(String)) }
        def address=(_address); end
        # Describes whether Checkout saves the name onto `customer.name`. Defaults to `never`.
        sig { returns(T.nilable(String)) }
        def name; end
        sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
        def name=(_name); end
        # Describes whether Checkout saves shipping information onto `customer.shipping`.
        # To collect shipping information, use `shipping_address_collection`. Defaults to `never`.
        sig { returns(T.nilable(String)) }
        def shipping; end
        sig { params(_shipping: T.nilable(String)).returns(T.nilable(String)) }
        def shipping=(_shipping); end
        sig {
          params(address: T.nilable(String), name: T.nilable(String), shipping: T.nilable(String)).void
         }
        def initialize(address: nil, name: nil, shipping: nil); end
      end
      class Discount < ::Stripe::RequestParams
        # The ID of the coupon to apply to this Session.
        sig { returns(T.nilable(String)) }
        def coupon; end
        sig { params(_coupon: T.nilable(String)).returns(T.nilable(String)) }
        def coupon=(_coupon); end
        # The ID of a promotion code to apply to this Session.
        sig { returns(T.nilable(String)) }
        def promotion_code; end
        sig { params(_promotion_code: T.nilable(String)).returns(T.nilable(String)) }
        def promotion_code=(_promotion_code); end
        sig { params(coupon: T.nilable(String), promotion_code: T.nilable(String)).void }
        def initialize(coupon: nil, promotion_code: nil); end
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
            returns(T.nilable(T.any(String, T::Array[Checkout::SessionCreateParams::InvoiceCreation::InvoiceData::CustomField])))
           }
          def custom_fields; end
          sig {
            params(_custom_fields: T.nilable(T.any(String, T::Array[Checkout::SessionCreateParams::InvoiceCreation::InvoiceData::CustomField]))).returns(T.nilable(T.any(String, T::Array[Checkout::SessionCreateParams::InvoiceCreation::InvoiceData::CustomField])))
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
          sig {
            returns(T.nilable(Checkout::SessionCreateParams::InvoiceCreation::InvoiceData::Issuer))
           }
          def issuer; end
          sig {
            params(_issuer: T.nilable(Checkout::SessionCreateParams::InvoiceCreation::InvoiceData::Issuer)).returns(T.nilable(Checkout::SessionCreateParams::InvoiceCreation::InvoiceData::Issuer))
           }
          def issuer=(_issuer); end
          # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
          sig { returns(T.nilable(T::Hash[String, String])) }
          def metadata; end
          sig {
            params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
           }
          def metadata=(_metadata); end
          # Default options for invoice PDF rendering for this customer.
          sig {
            returns(T.nilable(T.any(String, Checkout::SessionCreateParams::InvoiceCreation::InvoiceData::RenderingOptions)))
           }
          def rendering_options; end
          sig {
            params(_rendering_options: T.nilable(T.any(String, Checkout::SessionCreateParams::InvoiceCreation::InvoiceData::RenderingOptions))).returns(T.nilable(T.any(String, Checkout::SessionCreateParams::InvoiceCreation::InvoiceData::RenderingOptions)))
           }
          def rendering_options=(_rendering_options); end
          sig {
            params(account_tax_ids: T.nilable(T.any(String, T::Array[String])), custom_fields: T.nilable(T.any(String, T::Array[Checkout::SessionCreateParams::InvoiceCreation::InvoiceData::CustomField])), description: T.nilable(String), footer: T.nilable(String), issuer: T.nilable(Checkout::SessionCreateParams::InvoiceCreation::InvoiceData::Issuer), metadata: T.nilable(T::Hash[String, String]), rendering_options: T.nilable(T.any(String, Checkout::SessionCreateParams::InvoiceCreation::InvoiceData::RenderingOptions))).void
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
        # Set to `true` to enable invoice creation.
        sig { returns(T::Boolean) }
        def enabled; end
        sig { params(_enabled: T::Boolean).returns(T::Boolean) }
        def enabled=(_enabled); end
        # Parameters passed when creating invoices for payment-mode Checkout Sessions.
        sig { returns(T.nilable(Checkout::SessionCreateParams::InvoiceCreation::InvoiceData)) }
        def invoice_data; end
        sig {
          params(_invoice_data: T.nilable(Checkout::SessionCreateParams::InvoiceCreation::InvoiceData)).returns(T.nilable(Checkout::SessionCreateParams::InvoiceCreation::InvoiceData))
         }
        def invoice_data=(_invoice_data); end
        sig {
          params(enabled: T::Boolean, invoice_data: T.nilable(Checkout::SessionCreateParams::InvoiceCreation::InvoiceData)).void
         }
        def initialize(enabled: nil, invoice_data: nil); end
      end
      class LineItem < ::Stripe::RequestParams
        class AdjustableQuantity < ::Stripe::RequestParams
          # Set to true if the quantity can be adjusted to any non-negative integer.
          sig { returns(T::Boolean) }
          def enabled; end
          sig { params(_enabled: T::Boolean).returns(T::Boolean) }
          def enabled=(_enabled); end
          # The maximum quantity the customer can purchase for the Checkout Session. By default this value is 99. You can specify a value up to 999999.
          sig { returns(T.nilable(Integer)) }
          def maximum; end
          sig { params(_maximum: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def maximum=(_maximum); end
          # The minimum quantity the customer must purchase for the Checkout Session. By default this value is 0.
          sig { returns(T.nilable(Integer)) }
          def minimum; end
          sig { params(_minimum: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def minimum=(_minimum); end
          sig {
            params(enabled: T::Boolean, maximum: T.nilable(Integer), minimum: T.nilable(Integer)).void
           }
          def initialize(enabled: nil, maximum: nil, minimum: nil); end
        end
        class PriceData < ::Stripe::RequestParams
          class ProductData < ::Stripe::RequestParams
            # The product's description, meant to be displayable to the customer. Use this field to optionally store a long form explanation of the product being sold for your own rendering purposes.
            sig { returns(T.nilable(String)) }
            def description; end
            sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
            def description=(_description); end
            # A list of up to 8 URLs of images for this product, meant to be displayable to the customer.
            sig { returns(T.nilable(T::Array[String])) }
            def images; end
            sig {
              params(_images: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
             }
            def images=(_images); end
            # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
            sig { returns(T.nilable(T::Hash[String, String])) }
            def metadata; end
            sig {
              params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
             }
            def metadata=(_metadata); end
            # The product's name, meant to be displayable to the customer.
            sig { returns(String) }
            def name; end
            sig { params(_name: String).returns(String) }
            def name=(_name); end
            # A [tax code](https://docs.stripe.com/tax/tax-categories) ID.
            sig { returns(T.nilable(String)) }
            def tax_code; end
            sig { params(_tax_code: T.nilable(String)).returns(T.nilable(String)) }
            def tax_code=(_tax_code); end
            # A label that represents units of this product. When set, this will be included in customers' receipts, invoices, Checkout, and the customer portal.
            sig { returns(T.nilable(String)) }
            def unit_label; end
            sig { params(_unit_label: T.nilable(String)).returns(T.nilable(String)) }
            def unit_label=(_unit_label); end
            sig {
              params(description: T.nilable(String), images: T.nilable(T::Array[String]), metadata: T.nilable(T::Hash[String, String]), name: String, tax_code: T.nilable(String), unit_label: T.nilable(String)).void
             }
            def initialize(
              description: nil,
              images: nil,
              metadata: nil,
              name: nil,
              tax_code: nil,
              unit_label: nil
            ); end
          end
          class Recurring < ::Stripe::RequestParams
            # Specifies billing frequency. Either `day`, `week`, `month` or `year`.
            sig { returns(String) }
            def interval; end
            sig { params(_interval: String).returns(String) }
            def interval=(_interval); end
            # The number of intervals between subscription billings. For example, `interval=month` and `interval_count=3` bills every 3 months. Maximum of three years interval allowed (3 years, 36 months, or 156 weeks).
            sig { returns(T.nilable(Integer)) }
            def interval_count; end
            sig { params(_interval_count: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def interval_count=(_interval_count); end
            sig { params(interval: String, interval_count: T.nilable(Integer)).void }
            def initialize(interval: nil, interval_count: nil); end
          end
          # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
          sig { returns(String) }
          def currency; end
          sig { params(_currency: String).returns(String) }
          def currency=(_currency); end
          # The ID of the [Product](https://docs.stripe.com/api/products) that this [Price](https://docs.stripe.com/api/prices) will belong to. One of `product` or `product_data` is required.
          sig { returns(T.nilable(String)) }
          def product; end
          sig { params(_product: T.nilable(String)).returns(T.nilable(String)) }
          def product=(_product); end
          # Data used to generate a new [Product](https://docs.stripe.com/api/products) object inline. One of `product` or `product_data` is required.
          sig {
            returns(T.nilable(Checkout::SessionCreateParams::LineItem::PriceData::ProductData))
           }
          def product_data; end
          sig {
            params(_product_data: T.nilable(Checkout::SessionCreateParams::LineItem::PriceData::ProductData)).returns(T.nilable(Checkout::SessionCreateParams::LineItem::PriceData::ProductData))
           }
          def product_data=(_product_data); end
          # The recurring components of a price such as `interval` and `interval_count`.
          sig { returns(T.nilable(Checkout::SessionCreateParams::LineItem::PriceData::Recurring)) }
          def recurring; end
          sig {
            params(_recurring: T.nilable(Checkout::SessionCreateParams::LineItem::PriceData::Recurring)).returns(T.nilable(Checkout::SessionCreateParams::LineItem::PriceData::Recurring))
           }
          def recurring=(_recurring); end
          # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
          sig { returns(T.nilable(String)) }
          def tax_behavior; end
          sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
          def tax_behavior=(_tax_behavior); end
          # A non-negative integer in cents (or local equivalent) representing how much to charge. One of `unit_amount` or `unit_amount_decimal` is required.
          sig { returns(T.nilable(Integer)) }
          def unit_amount; end
          sig { params(_unit_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def unit_amount=(_unit_amount); end
          # Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places. Only one of `unit_amount` and `unit_amount_decimal` can be set.
          sig { returns(T.nilable(String)) }
          def unit_amount_decimal; end
          sig { params(_unit_amount_decimal: T.nilable(String)).returns(T.nilable(String)) }
          def unit_amount_decimal=(_unit_amount_decimal); end
          sig {
            params(currency: String, product: T.nilable(String), product_data: T.nilable(Checkout::SessionCreateParams::LineItem::PriceData::ProductData), recurring: T.nilable(Checkout::SessionCreateParams::LineItem::PriceData::Recurring), tax_behavior: T.nilable(String), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String)).void
           }
          def initialize(
            currency: nil,
            product: nil,
            product_data: nil,
            recurring: nil,
            tax_behavior: nil,
            unit_amount: nil,
            unit_amount_decimal: nil
          ); end
        end
        # When set, provides configuration for this item’s quantity to be adjusted by the customer during Checkout.
        sig { returns(T.nilable(Checkout::SessionCreateParams::LineItem::AdjustableQuantity)) }
        def adjustable_quantity; end
        sig {
          params(_adjustable_quantity: T.nilable(Checkout::SessionCreateParams::LineItem::AdjustableQuantity)).returns(T.nilable(Checkout::SessionCreateParams::LineItem::AdjustableQuantity))
         }
        def adjustable_quantity=(_adjustable_quantity); end
        # The [tax rates](https://docs.stripe.com/api/tax_rates) that will be applied to this line item depending on the customer's billing/shipping address. We currently support the following countries: US, GB, AU, and all countries in the EU.
        sig { returns(T.nilable(T::Array[String])) }
        def dynamic_tax_rates; end
        sig {
          params(_dynamic_tax_rates: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
         }
        def dynamic_tax_rates=(_dynamic_tax_rates); end
        # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
        sig { returns(T.nilable(T::Hash[String, String])) }
        def metadata; end
        sig {
          params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
         }
        def metadata=(_metadata); end
        # The ID of the [Price](https://docs.stripe.com/api/prices) or [Plan](https://docs.stripe.com/api/plans) object. One of `price` or `price_data` is required.
        sig { returns(T.nilable(String)) }
        def price; end
        sig { params(_price: T.nilable(String)).returns(T.nilable(String)) }
        def price=(_price); end
        # Data used to generate a new [Price](https://docs.stripe.com/api/prices) object inline. One of `price` or `price_data` is required.
        sig { returns(T.nilable(Checkout::SessionCreateParams::LineItem::PriceData)) }
        def price_data; end
        sig {
          params(_price_data: T.nilable(Checkout::SessionCreateParams::LineItem::PriceData)).returns(T.nilable(Checkout::SessionCreateParams::LineItem::PriceData))
         }
        def price_data=(_price_data); end
        # The quantity of the line item being purchased. Quantity should not be defined when `recurring.usage_type=metered`.
        sig { returns(T.nilable(Integer)) }
        def quantity; end
        sig { params(_quantity: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def quantity=(_quantity); end
        # The [tax rates](https://docs.stripe.com/api/tax_rates) which apply to this line item.
        sig { returns(T.nilable(T::Array[String])) }
        def tax_rates; end
        sig { params(_tax_rates: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
        def tax_rates=(_tax_rates); end
        sig {
          params(adjustable_quantity: T.nilable(Checkout::SessionCreateParams::LineItem::AdjustableQuantity), dynamic_tax_rates: T.nilable(T::Array[String]), metadata: T.nilable(T::Hash[String, String]), price: T.nilable(String), price_data: T.nilable(Checkout::SessionCreateParams::LineItem::PriceData), quantity: T.nilable(Integer), tax_rates: T.nilable(T::Array[String])).void
         }
        def initialize(
          adjustable_quantity: nil,
          dynamic_tax_rates: nil,
          metadata: nil,
          price: nil,
          price_data: nil,
          quantity: nil,
          tax_rates: nil
        ); end
      end
      class NameCollection < ::Stripe::RequestParams
        class Business < ::Stripe::RequestParams
          # Enable business name collection on the Checkout Session. Defaults to `false`.
          sig { returns(T::Boolean) }
          def enabled; end
          sig { params(_enabled: T::Boolean).returns(T::Boolean) }
          def enabled=(_enabled); end
          # Whether the customer is required to provide a business name before completing the Checkout Session. Defaults to `false`.
          sig { returns(T.nilable(T::Boolean)) }
          def optional; end
          sig { params(_optional: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
          def optional=(_optional); end
          sig { params(enabled: T::Boolean, optional: T.nilable(T::Boolean)).void }
          def initialize(enabled: nil, optional: nil); end
        end
        class Individual < ::Stripe::RequestParams
          # Enable individual name collection on the Checkout Session. Defaults to `false`.
          sig { returns(T::Boolean) }
          def enabled; end
          sig { params(_enabled: T::Boolean).returns(T::Boolean) }
          def enabled=(_enabled); end
          # Whether the customer is required to provide their name before completing the Checkout Session. Defaults to `false`.
          sig { returns(T.nilable(T::Boolean)) }
          def optional; end
          sig { params(_optional: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
          def optional=(_optional); end
          sig { params(enabled: T::Boolean, optional: T.nilable(T::Boolean)).void }
          def initialize(enabled: nil, optional: nil); end
        end
        # Controls settings applied for collecting the customer's business name on the session.
        sig { returns(T.nilable(Checkout::SessionCreateParams::NameCollection::Business)) }
        def business; end
        sig {
          params(_business: T.nilable(Checkout::SessionCreateParams::NameCollection::Business)).returns(T.nilable(Checkout::SessionCreateParams::NameCollection::Business))
         }
        def business=(_business); end
        # Controls settings applied for collecting the customer's individual name on the session.
        sig { returns(T.nilable(Checkout::SessionCreateParams::NameCollection::Individual)) }
        def individual; end
        sig {
          params(_individual: T.nilable(Checkout::SessionCreateParams::NameCollection::Individual)).returns(T.nilable(Checkout::SessionCreateParams::NameCollection::Individual))
         }
        def individual=(_individual); end
        sig {
          params(business: T.nilable(Checkout::SessionCreateParams::NameCollection::Business), individual: T.nilable(Checkout::SessionCreateParams::NameCollection::Individual)).void
         }
        def initialize(business: nil, individual: nil); end
      end
      class OptionalItem < ::Stripe::RequestParams
        class AdjustableQuantity < ::Stripe::RequestParams
          # Set to true if the quantity can be adjusted to any non-negative integer.
          sig { returns(T::Boolean) }
          def enabled; end
          sig { params(_enabled: T::Boolean).returns(T::Boolean) }
          def enabled=(_enabled); end
          # The maximum quantity of this item the customer can purchase. By default this value is 99. You can specify a value up to 999999.
          sig { returns(T.nilable(Integer)) }
          def maximum; end
          sig { params(_maximum: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def maximum=(_maximum); end
          # The minimum quantity of this item the customer must purchase, if they choose to purchase it. Because this item is optional, the customer will always be able to remove it from their order, even if the `minimum` configured here is greater than 0. By default this value is 0.
          sig { returns(T.nilable(Integer)) }
          def minimum; end
          sig { params(_minimum: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def minimum=(_minimum); end
          sig {
            params(enabled: T::Boolean, maximum: T.nilable(Integer), minimum: T.nilable(Integer)).void
           }
          def initialize(enabled: nil, maximum: nil, minimum: nil); end
        end
        # When set, provides configuration for the customer to adjust the quantity of the line item created when a customer chooses to add this optional item to their order.
        sig { returns(T.nilable(Checkout::SessionCreateParams::OptionalItem::AdjustableQuantity)) }
        def adjustable_quantity; end
        sig {
          params(_adjustable_quantity: T.nilable(Checkout::SessionCreateParams::OptionalItem::AdjustableQuantity)).returns(T.nilable(Checkout::SessionCreateParams::OptionalItem::AdjustableQuantity))
         }
        def adjustable_quantity=(_adjustable_quantity); end
        # The ID of the [Price](https://docs.stripe.com/api/prices) or [Plan](https://docs.stripe.com/api/plans) object.
        sig { returns(String) }
        def price; end
        sig { params(_price: String).returns(String) }
        def price=(_price); end
        # The initial quantity of the line item created when a customer chooses to add this optional item to their order.
        sig { returns(Integer) }
        def quantity; end
        sig { params(_quantity: Integer).returns(Integer) }
        def quantity=(_quantity); end
        sig {
          params(adjustable_quantity: T.nilable(Checkout::SessionCreateParams::OptionalItem::AdjustableQuantity), price: String, quantity: Integer).void
         }
        def initialize(adjustable_quantity: nil, price: nil, quantity: nil); end
      end
      class PaymentIntentData < ::Stripe::RequestParams
        class Shipping < ::Stripe::RequestParams
          class Address < ::Stripe::RequestParams
            # City, district, suburb, town, or village.
            sig { returns(T.nilable(String)) }
            def city; end
            sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
            def city=(_city); end
            # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
            sig { returns(T.nilable(String)) }
            def country; end
            sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
            def country=(_country); end
            # Address line 1, such as the street, PO Box, or company name.
            sig { returns(String) }
            def line1; end
            sig { params(_line1: String).returns(String) }
            def line1=(_line1); end
            # Address line 2, such as the apartment, suite, unit, or building.
            sig { returns(T.nilable(String)) }
            def line2; end
            sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
            def line2=(_line2); end
            # ZIP or postal code.
            sig { returns(T.nilable(String)) }
            def postal_code; end
            sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
            def postal_code=(_postal_code); end
            # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
            sig { returns(T.nilable(String)) }
            def state; end
            sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
            def state=(_state); end
            sig {
              params(city: T.nilable(String), country: T.nilable(String), line1: String, line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String)).void
             }
            def initialize(
              city: nil,
              country: nil,
              line1: nil,
              line2: nil,
              postal_code: nil,
              state: nil
            ); end
          end
          # Shipping address.
          sig { returns(Checkout::SessionCreateParams::PaymentIntentData::Shipping::Address) }
          def address; end
          sig {
            params(_address: Checkout::SessionCreateParams::PaymentIntentData::Shipping::Address).returns(Checkout::SessionCreateParams::PaymentIntentData::Shipping::Address)
           }
          def address=(_address); end
          # The delivery service that shipped a physical product, such as Fedex, UPS, USPS, etc.
          sig { returns(T.nilable(String)) }
          def carrier; end
          sig { params(_carrier: T.nilable(String)).returns(T.nilable(String)) }
          def carrier=(_carrier); end
          # Recipient name.
          sig { returns(String) }
          def name; end
          sig { params(_name: String).returns(String) }
          def name=(_name); end
          # Recipient phone (including extension).
          sig { returns(T.nilable(String)) }
          def phone; end
          sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
          def phone=(_phone); end
          # The tracking number for a physical product, obtained from the delivery service. If multiple tracking numbers were generated for this purchase, please separate them with commas.
          sig { returns(T.nilable(String)) }
          def tracking_number; end
          sig { params(_tracking_number: T.nilable(String)).returns(T.nilable(String)) }
          def tracking_number=(_tracking_number); end
          sig {
            params(address: Checkout::SessionCreateParams::PaymentIntentData::Shipping::Address, carrier: T.nilable(String), name: String, phone: T.nilable(String), tracking_number: T.nilable(String)).void
           }
          def initialize(
            address: nil,
            carrier: nil,
            name: nil,
            phone: nil,
            tracking_number: nil
          ); end
        end
        class TransferData < ::Stripe::RequestParams
          # The amount that will be transferred automatically when a charge succeeds.
          sig { returns(T.nilable(Integer)) }
          def amount; end
          sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def amount=(_amount); end
          # If specified, successful charges will be attributed to the destination
          # account for tax reporting, and the funds from charges will be transferred
          # to the destination account. The ID of the resulting transfer will be
          # returned on the successful charge's `transfer` field.
          sig { returns(String) }
          def destination; end
          sig { params(_destination: String).returns(String) }
          def destination=(_destination); end
          sig { params(amount: T.nilable(Integer), destination: String).void }
          def initialize(amount: nil, destination: nil); end
        end
        # The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the application owner's Stripe account. The amount of the application fee collected will be capped at the total amount captured. For more information, see the PaymentIntents [use case for connected accounts](https://docs.stripe.com/payments/connected-accounts).
        sig { returns(T.nilable(Integer)) }
        def application_fee_amount; end
        sig { params(_application_fee_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def application_fee_amount=(_application_fee_amount); end
        # Controls when the funds will be captured from the customer's account.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        # An arbitrary string attached to the object. Often useful for displaying to users.
        sig { returns(T.nilable(String)) }
        def description; end
        sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
        def description=(_description); end
        # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
        sig { returns(T.nilable(T::Hash[String, String])) }
        def metadata; end
        sig {
          params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
         }
        def metadata=(_metadata); end
        # The Stripe account ID for which these funds are intended. For details,
        # see the PaymentIntents [use case for connected
        # accounts](/docs/payments/connected-accounts).
        sig { returns(T.nilable(String)) }
        def on_behalf_of; end
        sig { params(_on_behalf_of: T.nilable(String)).returns(T.nilable(String)) }
        def on_behalf_of=(_on_behalf_of); end
        # Email address that the receipt for the resulting payment will be sent to. If `receipt_email` is specified for a payment in live mode, a receipt will be sent regardless of your [email settings](https://dashboard.stripe.com/account/emails).
        sig { returns(T.nilable(String)) }
        def receipt_email; end
        sig { params(_receipt_email: T.nilable(String)).returns(T.nilable(String)) }
        def receipt_email=(_receipt_email); end
        # Indicates that you intend to [make future payments](https://docs.stripe.com/payments/payment-intents#future-usage) with the payment
        # method collected by this Checkout Session.
        #
        # When setting this to `on_session`, Checkout will show a notice to the
        # customer that their payment details will be saved.
        #
        # When setting this to `off_session`, Checkout will show a notice to the
        # customer that their payment details will be saved and used for future
        # payments.
        #
        # If a Customer has been provided or Checkout creates a new Customer,
        # Checkout will attach the payment method to the Customer.
        #
        # If Checkout does not create a Customer, the payment method is not attached
        # to a Customer. To reuse the payment method, you can retrieve it from the
        # Checkout Session's PaymentIntent.
        #
        # When processing card payments, Checkout also uses `setup_future_usage`
        # to dynamically optimize your payment flow and comply with regional
        # legislation and network rules, such as SCA.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        # Shipping information for this payment.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentIntentData::Shipping)) }
        def shipping; end
        sig {
          params(_shipping: T.nilable(Checkout::SessionCreateParams::PaymentIntentData::Shipping)).returns(T.nilable(Checkout::SessionCreateParams::PaymentIntentData::Shipping))
         }
        def shipping=(_shipping); end
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
        # The parameters used to automatically create a Transfer when the payment succeeds.
        # For more information, see the PaymentIntents [use case for connected accounts](https://docs.stripe.com/payments/connected-accounts).
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentIntentData::TransferData)) }
        def transfer_data; end
        sig {
          params(_transfer_data: T.nilable(Checkout::SessionCreateParams::PaymentIntentData::TransferData)).returns(T.nilable(Checkout::SessionCreateParams::PaymentIntentData::TransferData))
         }
        def transfer_data=(_transfer_data); end
        # A string that identifies the resulting payment as part of a group. See the PaymentIntents [use case for connected accounts](https://docs.stripe.com/connect/separate-charges-and-transfers) for details.
        sig { returns(T.nilable(String)) }
        def transfer_group; end
        sig { params(_transfer_group: T.nilable(String)).returns(T.nilable(String)) }
        def transfer_group=(_transfer_group); end
        sig {
          params(application_fee_amount: T.nilable(Integer), capture_method: T.nilable(String), description: T.nilable(String), metadata: T.nilable(T::Hash[String, String]), on_behalf_of: T.nilable(String), receipt_email: T.nilable(String), setup_future_usage: T.nilable(String), shipping: T.nilable(Checkout::SessionCreateParams::PaymentIntentData::Shipping), statement_descriptor: T.nilable(String), statement_descriptor_suffix: T.nilable(String), transfer_data: T.nilable(Checkout::SessionCreateParams::PaymentIntentData::TransferData), transfer_group: T.nilable(String)).void
         }
        def initialize(
          application_fee_amount: nil,
          capture_method: nil,
          description: nil,
          metadata: nil,
          on_behalf_of: nil,
          receipt_email: nil,
          setup_future_usage: nil,
          shipping: nil,
          statement_descriptor: nil,
          statement_descriptor_suffix: nil,
          transfer_data: nil,
          transfer_group: nil
        ); end
      end
      class PaymentMethodData < ::Stripe::RequestParams
        # Allow redisplay will be set on the payment method on confirmation and indicates whether this payment method can be shown again to the customer in a checkout flow. Only set this field if you wish to override the allow_redisplay value determined by Checkout.
        sig { returns(T.nilable(String)) }
        def allow_redisplay; end
        sig { params(_allow_redisplay: T.nilable(String)).returns(T.nilable(String)) }
        def allow_redisplay=(_allow_redisplay); end
        sig { params(allow_redisplay: T.nilable(String)).void }
        def initialize(allow_redisplay: nil); end
      end
      class PaymentMethodOptions < ::Stripe::RequestParams
        class AcssDebit < ::Stripe::RequestParams
          class MandateOptions < ::Stripe::RequestParams
            # A URL for custom mandate text to render during confirmation step.
            # The URL will be rendered with additional GET parameters `payment_intent` and `payment_intent_client_secret` when confirming a Payment Intent,
            # or `setup_intent` and `setup_intent_client_secret` when confirming a Setup Intent.
            sig { returns(T.nilable(String)) }
            def custom_mandate_url; end
            sig { params(_custom_mandate_url: T.nilable(String)).returns(T.nilable(String)) }
            def custom_mandate_url=(_custom_mandate_url); end
            # List of Stripe products where this mandate can be selected automatically. Only usable in `setup` mode.
            sig { returns(T.nilable(T::Array[String])) }
            def default_for; end
            sig {
              params(_default_for: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
             }
            def default_for=(_default_for); end
            # Description of the mandate interval. Only required if 'payment_schedule' parameter is 'interval' or 'combined'.
            sig { returns(T.nilable(String)) }
            def interval_description; end
            sig { params(_interval_description: T.nilable(String)).returns(T.nilable(String)) }
            def interval_description=(_interval_description); end
            # Payment schedule for the mandate.
            sig { returns(T.nilable(String)) }
            def payment_schedule; end
            sig { params(_payment_schedule: T.nilable(String)).returns(T.nilable(String)) }
            def payment_schedule=(_payment_schedule); end
            # Transaction type of the mandate.
            sig { returns(T.nilable(String)) }
            def transaction_type; end
            sig { params(_transaction_type: T.nilable(String)).returns(T.nilable(String)) }
            def transaction_type=(_transaction_type); end
            sig {
              params(custom_mandate_url: T.nilable(String), default_for: T.nilable(T::Array[String]), interval_description: T.nilable(String), payment_schedule: T.nilable(String), transaction_type: T.nilable(String)).void
             }
            def initialize(
              custom_mandate_url: nil,
              default_for: nil,
              interval_description: nil,
              payment_schedule: nil,
              transaction_type: nil
            ); end
          end
          # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies). This is only accepted for Checkout Sessions in `setup` mode.
          sig { returns(T.nilable(String)) }
          def currency; end
          sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
          def currency=(_currency); end
          # Additional fields for Mandate creation
          sig {
            returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AcssDebit::MandateOptions))
           }
          def mandate_options; end
          sig {
            params(_mandate_options: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AcssDebit::MandateOptions)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AcssDebit::MandateOptions))
           }
          def mandate_options=(_mandate_options); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          # Controls when Stripe will attempt to debit the funds from the customer's account. The date must be a string in YYYY-MM-DD format. The date must be in the future and between 3 and 15 calendar days from now.
          sig { returns(T.nilable(String)) }
          def target_date; end
          sig { params(_target_date: T.nilable(String)).returns(T.nilable(String)) }
          def target_date=(_target_date); end
          # Verification method for the intent
          sig { returns(T.nilable(String)) }
          def verification_method; end
          sig { params(_verification_method: T.nilable(String)).returns(T.nilable(String)) }
          def verification_method=(_verification_method); end
          sig {
            params(currency: T.nilable(String), mandate_options: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AcssDebit::MandateOptions), setup_future_usage: T.nilable(String), target_date: T.nilable(String), verification_method: T.nilable(String)).void
           }
          def initialize(
            currency: nil,
            mandate_options: nil,
            setup_future_usage: nil,
            target_date: nil,
            verification_method: nil
          ); end
        end
        class Affirm < ::Stripe::RequestParams
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(capture_method: T.nilable(String), setup_future_usage: T.nilable(String)).void
           }
          def initialize(capture_method: nil, setup_future_usage: nil); end
        end
        class AfterpayClearpay < ::Stripe::RequestParams
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(capture_method: T.nilable(String), setup_future_usage: T.nilable(String)).void
           }
          def initialize(capture_method: nil, setup_future_usage: nil); end
        end
        class Alipay < ::Stripe::RequestParams
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig { params(setup_future_usage: T.nilable(String)).void }
          def initialize(setup_future_usage: nil); end
        end
        class Alma < ::Stripe::RequestParams
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          sig { params(capture_method: T.nilable(String)).void }
          def initialize(capture_method: nil); end
        end
        class AmazonPay < ::Stripe::RequestParams
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(capture_method: T.nilable(String), setup_future_usage: T.nilable(String)).void
           }
          def initialize(capture_method: nil, setup_future_usage: nil); end
        end
        class AuBecsDebit < ::Stripe::RequestParams
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          # Controls when Stripe will attempt to debit the funds from the customer's account. The date must be a string in YYYY-MM-DD format. The date must be in the future and between 3 and 15 calendar days from now.
          sig { returns(T.nilable(String)) }
          def target_date; end
          sig { params(_target_date: T.nilable(String)).returns(T.nilable(String)) }
          def target_date=(_target_date); end
          sig { params(setup_future_usage: T.nilable(String), target_date: T.nilable(String)).void }
          def initialize(setup_future_usage: nil, target_date: nil); end
        end
        class BacsDebit < ::Stripe::RequestParams
          class MandateOptions < ::Stripe::RequestParams
            # Prefix used to generate the Mandate reference. Must be at most 12 characters long. Must consist of only uppercase letters, numbers, spaces, or the following special characters: '/', '_', '-', '&', '.'. Cannot begin with 'DDIC' or 'STRIPE'.
            sig { returns(T.nilable(String)) }
            def reference_prefix; end
            sig { params(_reference_prefix: T.nilable(String)).returns(T.nilable(String)) }
            def reference_prefix=(_reference_prefix); end
            sig { params(reference_prefix: T.nilable(String)).void }
            def initialize(reference_prefix: nil); end
          end
          # Additional fields for Mandate creation
          sig {
            returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::BacsDebit::MandateOptions))
           }
          def mandate_options; end
          sig {
            params(_mandate_options: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::BacsDebit::MandateOptions)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::BacsDebit::MandateOptions))
           }
          def mandate_options=(_mandate_options); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          # Controls when Stripe will attempt to debit the funds from the customer's account. The date must be a string in YYYY-MM-DD format. The date must be in the future and between 3 and 15 calendar days from now.
          sig { returns(T.nilable(String)) }
          def target_date; end
          sig { params(_target_date: T.nilable(String)).returns(T.nilable(String)) }
          def target_date=(_target_date); end
          sig {
            params(mandate_options: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::BacsDebit::MandateOptions), setup_future_usage: T.nilable(String), target_date: T.nilable(String)).void
           }
          def initialize(mandate_options: nil, setup_future_usage: nil, target_date: nil); end
        end
        class Bancontact < ::Stripe::RequestParams
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig { params(setup_future_usage: T.nilable(String)).void }
          def initialize(setup_future_usage: nil); end
        end
        class Billie < ::Stripe::RequestParams
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          sig { params(capture_method: T.nilable(String)).void }
          def initialize(capture_method: nil); end
        end
        class Boleto < ::Stripe::RequestParams
          # The number of calendar days before a Boleto voucher expires. For example, if you create a Boleto voucher on Monday and you set expires_after_days to 2, the Boleto invoice will expire on Wednesday at 23:59 America/Sao_Paulo time.
          sig { returns(T.nilable(Integer)) }
          def expires_after_days; end
          sig { params(_expires_after_days: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def expires_after_days=(_expires_after_days); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(expires_after_days: T.nilable(Integer), setup_future_usage: T.nilable(String)).void
           }
          def initialize(expires_after_days: nil, setup_future_usage: nil); end
        end
        class Card < ::Stripe::RequestParams
          class Installments < ::Stripe::RequestParams
            # Setting to true enables installments for this Checkout Session.
            # Setting to false will prevent any installment plan from applying to a payment.
            sig { returns(T.nilable(T::Boolean)) }
            def enabled; end
            sig { params(_enabled: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
            def enabled=(_enabled); end
            sig { params(enabled: T.nilable(T::Boolean)).void }
            def initialize(enabled: nil); end
          end
          class Restrictions < ::Stripe::RequestParams
            # Specify the card brands to block in the Checkout Session. If a customer enters or selects a card belonging to a blocked brand, they can't complete the Session.
            sig { returns(T.nilable(T::Array[String])) }
            def brands_blocked; end
            sig {
              params(_brands_blocked: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
             }
            def brands_blocked=(_brands_blocked); end
            sig { params(brands_blocked: T.nilable(T::Array[String])).void }
            def initialize(brands_blocked: nil); end
          end
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          # Installment options for card payments
          sig {
            returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Card::Installments))
           }
          def installments; end
          sig {
            params(_installments: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Card::Installments)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Card::Installments))
           }
          def installments=(_installments); end
          # Request ability to [capture beyond the standard authorization validity window](/payments/extended-authorization) for this CheckoutSession.
          sig { returns(T.nilable(String)) }
          def request_extended_authorization; end
          sig {
            params(_request_extended_authorization: T.nilable(String)).returns(T.nilable(String))
           }
          def request_extended_authorization=(_request_extended_authorization); end
          # Request ability to [increment the authorization](/payments/incremental-authorization) for this CheckoutSession.
          sig { returns(T.nilable(String)) }
          def request_incremental_authorization; end
          sig {
            params(_request_incremental_authorization: T.nilable(String)).returns(T.nilable(String))
           }
          def request_incremental_authorization=(_request_incremental_authorization); end
          # Request ability to make [multiple captures](/payments/multicapture) for this CheckoutSession.
          sig { returns(T.nilable(String)) }
          def request_multicapture; end
          sig { params(_request_multicapture: T.nilable(String)).returns(T.nilable(String)) }
          def request_multicapture=(_request_multicapture); end
          # Request ability to [overcapture](/payments/overcapture) for this CheckoutSession.
          sig { returns(T.nilable(String)) }
          def request_overcapture; end
          sig { params(_request_overcapture: T.nilable(String)).returns(T.nilable(String)) }
          def request_overcapture=(_request_overcapture); end
          # We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and [other requirements](https://docs.stripe.com/strong-customer-authentication). However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. If not provided, this value defaults to `automatic`. Read our guide on [manually requesting 3D Secure](https://docs.stripe.com/payments/3d-secure/authentication-flow#manual-three-ds) for more information on how this configuration interacts with Radar and our SCA Engine.
          sig { returns(T.nilable(String)) }
          def request_three_d_secure; end
          sig { params(_request_three_d_secure: T.nilable(String)).returns(T.nilable(String)) }
          def request_three_d_secure=(_request_three_d_secure); end
          # Restrictions to apply to the card payment method. For example, you can block specific card brands.
          sig {
            returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Card::Restrictions))
           }
          def restrictions; end
          sig {
            params(_restrictions: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Card::Restrictions)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Card::Restrictions))
           }
          def restrictions=(_restrictions); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          # Provides information about a card payment that customers see on their statements. Concatenated with the Kana prefix (shortened Kana descriptor) or Kana statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters. On card statements, the *concatenation* of both prefix and suffix (including separators) will appear truncated to 22 characters.
          sig { returns(T.nilable(String)) }
          def statement_descriptor_suffix_kana; end
          sig {
            params(_statement_descriptor_suffix_kana: T.nilable(String)).returns(T.nilable(String))
           }
          def statement_descriptor_suffix_kana=(_statement_descriptor_suffix_kana); end
          # Provides information about a card payment that customers see on their statements. Concatenated with the Kanji prefix (shortened Kanji descriptor) or Kanji statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 17 characters. On card statements, the *concatenation* of both prefix and suffix (including separators) will appear truncated to 17 characters.
          sig { returns(T.nilable(String)) }
          def statement_descriptor_suffix_kanji; end
          sig {
            params(_statement_descriptor_suffix_kanji: T.nilable(String)).returns(T.nilable(String))
           }
          def statement_descriptor_suffix_kanji=(_statement_descriptor_suffix_kanji); end
          sig {
            params(capture_method: T.nilable(String), installments: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Card::Installments), request_extended_authorization: T.nilable(String), request_incremental_authorization: T.nilable(String), request_multicapture: T.nilable(String), request_overcapture: T.nilable(String), request_three_d_secure: T.nilable(String), restrictions: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Card::Restrictions), setup_future_usage: T.nilable(String), statement_descriptor_suffix_kana: T.nilable(String), statement_descriptor_suffix_kanji: T.nilable(String)).void
           }
          def initialize(
            capture_method: nil,
            installments: nil,
            request_extended_authorization: nil,
            request_incremental_authorization: nil,
            request_multicapture: nil,
            request_overcapture: nil,
            request_three_d_secure: nil,
            restrictions: nil,
            setup_future_usage: nil,
            statement_descriptor_suffix_kana: nil,
            statement_descriptor_suffix_kanji: nil
          ); end
        end
        class Cashapp < ::Stripe::RequestParams
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(capture_method: T.nilable(String), setup_future_usage: T.nilable(String)).void
           }
          def initialize(capture_method: nil, setup_future_usage: nil); end
        end
        class CustomerBalance < ::Stripe::RequestParams
          class BankTransfer < ::Stripe::RequestParams
            class EuBankTransfer < ::Stripe::RequestParams
              # The desired country code of the bank account information. Permitted values include: `BE`, `DE`, `ES`, `FR`, `IE`, or `NL`.
              sig { returns(String) }
              def country; end
              sig { params(_country: String).returns(String) }
              def country=(_country); end
              sig { params(country: String).void }
              def initialize(country: nil); end
            end
            # Configuration for eu_bank_transfer funding type.
            sig {
              returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::CustomerBalance::BankTransfer::EuBankTransfer))
             }
            def eu_bank_transfer; end
            sig {
              params(_eu_bank_transfer: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::CustomerBalance::BankTransfer::EuBankTransfer)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::CustomerBalance::BankTransfer::EuBankTransfer))
             }
            def eu_bank_transfer=(_eu_bank_transfer); end
            # List of address types that should be returned in the financial_addresses response. If not specified, all valid types will be returned.
            #
            # Permitted values include: `sort_code`, `zengin`, `iban`, or `spei`.
            sig { returns(T.nilable(T::Array[String])) }
            def requested_address_types; end
            sig {
              params(_requested_address_types: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
             }
            def requested_address_types=(_requested_address_types); end
            # The list of bank transfer types that this PaymentIntent is allowed to use for funding.
            sig { returns(String) }
            def type; end
            sig { params(_type: String).returns(String) }
            def type=(_type); end
            sig {
              params(eu_bank_transfer: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::CustomerBalance::BankTransfer::EuBankTransfer), requested_address_types: T.nilable(T::Array[String]), type: String).void
             }
            def initialize(eu_bank_transfer: nil, requested_address_types: nil, type: nil); end
          end
          # Configuration for the bank transfer funding type, if the `funding_type` is set to `bank_transfer`.
          sig {
            returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::CustomerBalance::BankTransfer))
           }
          def bank_transfer; end
          sig {
            params(_bank_transfer: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::CustomerBalance::BankTransfer)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::CustomerBalance::BankTransfer))
           }
          def bank_transfer=(_bank_transfer); end
          # The funding method type to be used when there are not enough funds in the customer balance. Permitted values include: `bank_transfer`.
          sig { returns(T.nilable(String)) }
          def funding_type; end
          sig { params(_funding_type: T.nilable(String)).returns(T.nilable(String)) }
          def funding_type=(_funding_type); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(bank_transfer: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::CustomerBalance::BankTransfer), funding_type: T.nilable(String), setup_future_usage: T.nilable(String)).void
           }
          def initialize(bank_transfer: nil, funding_type: nil, setup_future_usage: nil); end
        end
        class DemoPay < ::Stripe::RequestParams
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig { params(setup_future_usage: T.nilable(String)).void }
          def initialize(setup_future_usage: nil); end
        end
        class Eps < ::Stripe::RequestParams
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig { params(setup_future_usage: T.nilable(String)).void }
          def initialize(setup_future_usage: nil); end
        end
        class Fpx < ::Stripe::RequestParams
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig { params(setup_future_usage: T.nilable(String)).void }
          def initialize(setup_future_usage: nil); end
        end
        class Giropay < ::Stripe::RequestParams
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig { params(setup_future_usage: T.nilable(String)).void }
          def initialize(setup_future_usage: nil); end
        end
        class Grabpay < ::Stripe::RequestParams
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig { params(setup_future_usage: T.nilable(String)).void }
          def initialize(setup_future_usage: nil); end
        end
        class Ideal < ::Stripe::RequestParams
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig { params(setup_future_usage: T.nilable(String)).void }
          def initialize(setup_future_usage: nil); end
        end
        class KakaoPay < ::Stripe::RequestParams
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(capture_method: T.nilable(String), setup_future_usage: T.nilable(String)).void
           }
          def initialize(capture_method: nil, setup_future_usage: nil); end
        end
        class Klarna < ::Stripe::RequestParams
          class Subscription < ::Stripe::RequestParams
            class NextBilling < ::Stripe::RequestParams
              # The amount of the next charge for the subscription.
              sig { returns(Integer) }
              def amount; end
              sig { params(_amount: Integer).returns(Integer) }
              def amount=(_amount); end
              # The date of the next charge for the subscription in YYYY-MM-DD format.
              sig { returns(String) }
              def date; end
              sig { params(_date: String).returns(String) }
              def date=(_date); end
              sig { params(amount: Integer, date: String).void }
              def initialize(amount: nil, date: nil); end
            end
            # Unit of time between subscription charges.
            sig { returns(String) }
            def interval; end
            sig { params(_interval: String).returns(String) }
            def interval=(_interval); end
            # The number of intervals (specified in the `interval` attribute) between subscription charges. For example, `interval=month` and `interval_count=3` charges every 3 months.
            sig { returns(T.nilable(Integer)) }
            def interval_count; end
            sig { params(_interval_count: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def interval_count=(_interval_count); end
            # Name for subscription.
            sig { returns(T.nilable(String)) }
            def name; end
            sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
            def name=(_name); end
            # Describes the upcoming charge for this subscription.
            sig {
              returns(Checkout::SessionCreateParams::PaymentMethodOptions::Klarna::Subscription::NextBilling)
             }
            def next_billing; end
            sig {
              params(_next_billing: Checkout::SessionCreateParams::PaymentMethodOptions::Klarna::Subscription::NextBilling).returns(Checkout::SessionCreateParams::PaymentMethodOptions::Klarna::Subscription::NextBilling)
             }
            def next_billing=(_next_billing); end
            # A non-customer-facing reference to correlate subscription charges in the Klarna app. Use a value that persists across subscription charges.
            sig { returns(String) }
            def reference; end
            sig { params(_reference: String).returns(String) }
            def reference=(_reference); end
            sig {
              params(interval: String, interval_count: T.nilable(Integer), name: T.nilable(String), next_billing: Checkout::SessionCreateParams::PaymentMethodOptions::Klarna::Subscription::NextBilling, reference: String).void
             }
            def initialize(
              interval: nil,
              interval_count: nil,
              name: nil,
              next_billing: nil,
              reference: nil
            ); end
          end
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          # Subscription details if the Checkout Session sets up a future subscription.
          sig {
            returns(T.nilable(T.any(String, T::Array[Checkout::SessionCreateParams::PaymentMethodOptions::Klarna::Subscription])))
           }
          def subscriptions; end
          sig {
            params(_subscriptions: T.nilable(T.any(String, T::Array[Checkout::SessionCreateParams::PaymentMethodOptions::Klarna::Subscription]))).returns(T.nilable(T.any(String, T::Array[Checkout::SessionCreateParams::PaymentMethodOptions::Klarna::Subscription])))
           }
          def subscriptions=(_subscriptions); end
          sig {
            params(capture_method: T.nilable(String), setup_future_usage: T.nilable(String), subscriptions: T.nilable(T.any(String, T::Array[Checkout::SessionCreateParams::PaymentMethodOptions::Klarna::Subscription]))).void
           }
          def initialize(capture_method: nil, setup_future_usage: nil, subscriptions: nil); end
        end
        class Konbini < ::Stripe::RequestParams
          # The number of calendar days (between 1 and 60) after which Konbini payment instructions will expire. For example, if a PaymentIntent is confirmed with Konbini and `expires_after_days` set to 2 on Monday JST, the instructions will expire on Wednesday 23:59:59 JST. Defaults to 3 days.
          sig { returns(T.nilable(Integer)) }
          def expires_after_days; end
          sig { params(_expires_after_days: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def expires_after_days=(_expires_after_days); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(expires_after_days: T.nilable(Integer), setup_future_usage: T.nilable(String)).void
           }
          def initialize(expires_after_days: nil, setup_future_usage: nil); end
        end
        class KrCard < ::Stripe::RequestParams
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(capture_method: T.nilable(String), setup_future_usage: T.nilable(String)).void
           }
          def initialize(capture_method: nil, setup_future_usage: nil); end
        end
        class Link < ::Stripe::RequestParams
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(capture_method: T.nilable(String), setup_future_usage: T.nilable(String)).void
           }
          def initialize(capture_method: nil, setup_future_usage: nil); end
        end
        class Mobilepay < ::Stripe::RequestParams
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(capture_method: T.nilable(String), setup_future_usage: T.nilable(String)).void
           }
          def initialize(capture_method: nil, setup_future_usage: nil); end
        end
        class Multibanco < ::Stripe::RequestParams
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig { params(setup_future_usage: T.nilable(String)).void }
          def initialize(setup_future_usage: nil); end
        end
        class NaverPay < ::Stripe::RequestParams
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(capture_method: T.nilable(String), setup_future_usage: T.nilable(String)).void
           }
          def initialize(capture_method: nil, setup_future_usage: nil); end
        end
        class Oxxo < ::Stripe::RequestParams
          # The number of calendar days before an OXXO voucher expires. For example, if you create an OXXO voucher on Monday and you set expires_after_days to 2, the OXXO invoice will expire on Wednesday at 23:59 America/Mexico_City time.
          sig { returns(T.nilable(Integer)) }
          def expires_after_days; end
          sig { params(_expires_after_days: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def expires_after_days=(_expires_after_days); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(expires_after_days: T.nilable(Integer), setup_future_usage: T.nilable(String)).void
           }
          def initialize(expires_after_days: nil, setup_future_usage: nil); end
        end
        class P24 < ::Stripe::RequestParams
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          # Confirm that the payer has accepted the P24 terms and conditions.
          sig { returns(T.nilable(T::Boolean)) }
          def tos_shown_and_accepted; end
          sig {
            params(_tos_shown_and_accepted: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean))
           }
          def tos_shown_and_accepted=(_tos_shown_and_accepted); end
          sig {
            params(setup_future_usage: T.nilable(String), tos_shown_and_accepted: T.nilable(T::Boolean)).void
           }
          def initialize(setup_future_usage: nil, tos_shown_and_accepted: nil); end
        end
        class PayByBank < ::Stripe::RequestParams; end
        class Payco < ::Stripe::RequestParams
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          sig { params(capture_method: T.nilable(String)).void }
          def initialize(capture_method: nil); end
        end
        class Paynow < ::Stripe::RequestParams
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig { params(setup_future_usage: T.nilable(String)).void }
          def initialize(setup_future_usage: nil); end
        end
        class Paypal < ::Stripe::RequestParams
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          # [Preferred locale](https://docs.stripe.com/payments/paypal/supported-locales) of the PayPal checkout page that the customer is redirected to.
          sig { returns(T.nilable(String)) }
          def preferred_locale; end
          sig { params(_preferred_locale: T.nilable(String)).returns(T.nilable(String)) }
          def preferred_locale=(_preferred_locale); end
          # A reference of the PayPal transaction visible to customer which is mapped to PayPal's invoice ID. This must be a globally unique ID if you have configured in your PayPal settings to block multiple payments per invoice ID.
          sig { returns(T.nilable(String)) }
          def reference; end
          sig { params(_reference: T.nilable(String)).returns(T.nilable(String)) }
          def reference=(_reference); end
          # The risk correlation ID for an on-session payment using a saved PayPal payment method.
          sig { returns(T.nilable(String)) }
          def risk_correlation_id; end
          sig { params(_risk_correlation_id: T.nilable(String)).returns(T.nilable(String)) }
          def risk_correlation_id=(_risk_correlation_id); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          #
          # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
          sig { returns(T.nilable(T.any(String, String))) }
          def setup_future_usage; end
          sig {
            params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
           }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(capture_method: T.nilable(String), preferred_locale: T.nilable(String), reference: T.nilable(String), risk_correlation_id: T.nilable(String), setup_future_usage: T.nilable(T.any(String, String))).void
           }
          def initialize(
            capture_method: nil,
            preferred_locale: nil,
            reference: nil,
            risk_correlation_id: nil,
            setup_future_usage: nil
          ); end
        end
        class Payto < ::Stripe::RequestParams
          class MandateOptions < ::Stripe::RequestParams
            # Amount that will be collected. It is required when `amount_type` is `fixed`.
            sig { returns(T.nilable(T.any(String, Integer))) }
            def amount; end
            sig {
              params(_amount: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
             }
            def amount=(_amount); end
            # The type of amount that will be collected. The amount charged must be exact or up to the value of `amount` param for `fixed` or `maximum` type respectively. Defaults to `maximum`.
            sig { returns(T.nilable(T.any(String, String))) }
            def amount_type; end
            sig {
              params(_amount_type: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
             }
            def amount_type=(_amount_type); end
            # Date, in YYYY-MM-DD format, after which payments will not be collected. Defaults to no end date.
            sig { returns(T.nilable(String)) }
            def end_date; end
            sig { params(_end_date: T.nilable(String)).returns(T.nilable(String)) }
            def end_date=(_end_date); end
            # The periodicity at which payments will be collected. Defaults to `adhoc`.
            sig { returns(T.nilable(T.any(String, String))) }
            def payment_schedule; end
            sig {
              params(_payment_schedule: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
             }
            def payment_schedule=(_payment_schedule); end
            # The number of payments that will be made during a payment period. Defaults to 1 except for when `payment_schedule` is `adhoc`. In that case, it defaults to no limit.
            sig { returns(T.nilable(T.any(String, Integer))) }
            def payments_per_period; end
            sig {
              params(_payments_per_period: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
             }
            def payments_per_period=(_payments_per_period); end
            # The purpose for which payments are made. Has a default value based on your merchant category code.
            sig { returns(T.nilable(T.any(String, String))) }
            def purpose; end
            sig {
              params(_purpose: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
             }
            def purpose=(_purpose); end
            # Date, in YYYY-MM-DD format, from which payments will be collected. Defaults to confirmation time.
            sig { returns(T.nilable(String)) }
            def start_date; end
            sig { params(_start_date: T.nilable(String)).returns(T.nilable(String)) }
            def start_date=(_start_date); end
            sig {
              params(amount: T.nilable(T.any(String, Integer)), amount_type: T.nilable(T.any(String, String)), end_date: T.nilable(String), payment_schedule: T.nilable(T.any(String, String)), payments_per_period: T.nilable(T.any(String, Integer)), purpose: T.nilable(T.any(String, String)), start_date: T.nilable(String)).void
             }
            def initialize(
              amount: nil,
              amount_type: nil,
              end_date: nil,
              payment_schedule: nil,
              payments_per_period: nil,
              purpose: nil,
              start_date: nil
            ); end
          end
          # Additional fields for Mandate creation
          sig {
            returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Payto::MandateOptions))
           }
          def mandate_options; end
          sig {
            params(_mandate_options: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Payto::MandateOptions)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Payto::MandateOptions))
           }
          def mandate_options=(_mandate_options); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(mandate_options: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Payto::MandateOptions), setup_future_usage: T.nilable(String)).void
           }
          def initialize(mandate_options: nil, setup_future_usage: nil); end
        end
        class Pix < ::Stripe::RequestParams
          # Determines if the amount includes the IOF tax. Defaults to `never`.
          sig { returns(T.nilable(String)) }
          def amount_includes_iof; end
          sig { params(_amount_includes_iof: T.nilable(String)).returns(T.nilable(String)) }
          def amount_includes_iof=(_amount_includes_iof); end
          # The number of seconds (between 10 and 1209600) after which Pix payment will expire. Defaults to 86400 seconds.
          sig { returns(T.nilable(Integer)) }
          def expires_after_seconds; end
          sig { params(_expires_after_seconds: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def expires_after_seconds=(_expires_after_seconds); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(amount_includes_iof: T.nilable(String), expires_after_seconds: T.nilable(Integer), setup_future_usage: T.nilable(String)).void
           }
          def initialize(
            amount_includes_iof: nil,
            expires_after_seconds: nil,
            setup_future_usage: nil
          ); end
        end
        class RevolutPay < ::Stripe::RequestParams
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(capture_method: T.nilable(String), setup_future_usage: T.nilable(String)).void
           }
          def initialize(capture_method: nil, setup_future_usage: nil); end
        end
        class SamsungPay < ::Stripe::RequestParams
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          sig { params(capture_method: T.nilable(String)).void }
          def initialize(capture_method: nil); end
        end
        class Satispay < ::Stripe::RequestParams
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
          def capture_method=(_capture_method); end
          sig { params(capture_method: T.nilable(String)).void }
          def initialize(capture_method: nil); end
        end
        class SepaDebit < ::Stripe::RequestParams
          class MandateOptions < ::Stripe::RequestParams
            # Prefix used to generate the Mandate reference. Must be at most 12 characters long. Must consist of only uppercase letters, numbers, spaces, or the following special characters: '/', '_', '-', '&', '.'. Cannot begin with 'STRIPE'.
            sig { returns(T.nilable(String)) }
            def reference_prefix; end
            sig { params(_reference_prefix: T.nilable(String)).returns(T.nilable(String)) }
            def reference_prefix=(_reference_prefix); end
            sig { params(reference_prefix: T.nilable(String)).void }
            def initialize(reference_prefix: nil); end
          end
          # Additional fields for Mandate creation
          sig {
            returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::SepaDebit::MandateOptions))
           }
          def mandate_options; end
          sig {
            params(_mandate_options: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::SepaDebit::MandateOptions)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::SepaDebit::MandateOptions))
           }
          def mandate_options=(_mandate_options); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          # Controls when Stripe will attempt to debit the funds from the customer's account. The date must be a string in YYYY-MM-DD format. The date must be in the future and between 3 and 15 calendar days from now.
          sig { returns(T.nilable(String)) }
          def target_date; end
          sig { params(_target_date: T.nilable(String)).returns(T.nilable(String)) }
          def target_date=(_target_date); end
          sig {
            params(mandate_options: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::SepaDebit::MandateOptions), setup_future_usage: T.nilable(String), target_date: T.nilable(String)).void
           }
          def initialize(mandate_options: nil, setup_future_usage: nil, target_date: nil); end
        end
        class Sofort < ::Stripe::RequestParams
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig { params(setup_future_usage: T.nilable(String)).void }
          def initialize(setup_future_usage: nil); end
        end
        class Swish < ::Stripe::RequestParams
          # The order reference that will be displayed to customers in the Swish application. Defaults to the `id` of the Payment Intent.
          sig { returns(T.nilable(String)) }
          def reference; end
          sig { params(_reference: T.nilable(String)).returns(T.nilable(String)) }
          def reference=(_reference); end
          sig { params(reference: T.nilable(String)).void }
          def initialize(reference: nil); end
        end
        class Twint < ::Stripe::RequestParams
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig { params(setup_future_usage: T.nilable(String)).void }
          def initialize(setup_future_usage: nil); end
        end
        class UsBankAccount < ::Stripe::RequestParams
          class FinancialConnections < ::Stripe::RequestParams
            # The list of permissions to request. If this parameter is passed, the `payment_method` permission must be included. Valid permissions include: `balances`, `ownership`, `payment_method`, and `transactions`.
            sig { returns(T.nilable(T::Array[String])) }
            def permissions; end
            sig {
              params(_permissions: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
             }
            def permissions=(_permissions); end
            # List of data features that you would like to retrieve upon account creation.
            sig { returns(T.nilable(T::Array[String])) }
            def prefetch; end
            sig {
              params(_prefetch: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
             }
            def prefetch=(_prefetch); end
            sig {
              params(permissions: T.nilable(T::Array[String]), prefetch: T.nilable(T::Array[String])).void
             }
            def initialize(permissions: nil, prefetch: nil); end
          end
          # Additional fields for Financial Connections Session creation
          sig {
            returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::UsBankAccount::FinancialConnections))
           }
          def financial_connections; end
          sig {
            params(_financial_connections: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::UsBankAccount::FinancialConnections)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::UsBankAccount::FinancialConnections))
           }
          def financial_connections=(_financial_connections); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          # Controls when Stripe will attempt to debit the funds from the customer's account. The date must be a string in YYYY-MM-DD format. The date must be in the future and between 3 and 15 calendar days from now.
          sig { returns(T.nilable(String)) }
          def target_date; end
          sig { params(_target_date: T.nilable(String)).returns(T.nilable(String)) }
          def target_date=(_target_date); end
          # Verification method for the intent
          sig { returns(T.nilable(String)) }
          def verification_method; end
          sig { params(_verification_method: T.nilable(String)).returns(T.nilable(String)) }
          def verification_method=(_verification_method); end
          sig {
            params(financial_connections: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::UsBankAccount::FinancialConnections), setup_future_usage: T.nilable(String), target_date: T.nilable(String), verification_method: T.nilable(String)).void
           }
          def initialize(
            financial_connections: nil,
            setup_future_usage: nil,
            target_date: nil,
            verification_method: nil
          ); end
        end
        class WechatPay < ::Stripe::RequestParams
          # The app ID registered with WeChat Pay. Only required when client is ios or android.
          sig { returns(T.nilable(String)) }
          def app_id; end
          sig { params(_app_id: T.nilable(String)).returns(T.nilable(String)) }
          def app_id=(_app_id); end
          # The client type that the end customer will pay from
          sig { returns(String) }
          def client; end
          sig { params(_client: String).returns(String) }
          def client=(_client); end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
          def setup_future_usage=(_setup_future_usage); end
          sig {
            params(app_id: T.nilable(String), client: String, setup_future_usage: T.nilable(String)).void
           }
          def initialize(app_id: nil, client: nil, setup_future_usage: nil); end
        end
        # contains details about the ACSS Debit payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AcssDebit)) }
        def acss_debit; end
        sig {
          params(_acss_debit: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AcssDebit)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AcssDebit))
         }
        def acss_debit=(_acss_debit); end
        # contains details about the Affirm payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Affirm)) }
        def affirm; end
        sig {
          params(_affirm: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Affirm)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Affirm))
         }
        def affirm=(_affirm); end
        # contains details about the Afterpay Clearpay payment method options.
        sig {
          returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AfterpayClearpay))
         }
        def afterpay_clearpay; end
        sig {
          params(_afterpay_clearpay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AfterpayClearpay)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AfterpayClearpay))
         }
        def afterpay_clearpay=(_afterpay_clearpay); end
        # contains details about the Alipay payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Alipay)) }
        def alipay; end
        sig {
          params(_alipay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Alipay)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Alipay))
         }
        def alipay=(_alipay); end
        # contains details about the Alma payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Alma)) }
        def alma; end
        sig {
          params(_alma: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Alma)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Alma))
         }
        def alma=(_alma); end
        # contains details about the AmazonPay payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AmazonPay)) }
        def amazon_pay; end
        sig {
          params(_amazon_pay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AmazonPay)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AmazonPay))
         }
        def amazon_pay=(_amazon_pay); end
        # contains details about the AU Becs Debit payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AuBecsDebit)) }
        def au_becs_debit; end
        sig {
          params(_au_becs_debit: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AuBecsDebit)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AuBecsDebit))
         }
        def au_becs_debit=(_au_becs_debit); end
        # contains details about the Bacs Debit payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::BacsDebit)) }
        def bacs_debit; end
        sig {
          params(_bacs_debit: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::BacsDebit)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::BacsDebit))
         }
        def bacs_debit=(_bacs_debit); end
        # contains details about the Bancontact payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Bancontact)) }
        def bancontact; end
        sig {
          params(_bancontact: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Bancontact)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Bancontact))
         }
        def bancontact=(_bancontact); end
        # contains details about the Billie payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Billie)) }
        def billie; end
        sig {
          params(_billie: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Billie)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Billie))
         }
        def billie=(_billie); end
        # contains details about the Boleto payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Boleto)) }
        def boleto; end
        sig {
          params(_boleto: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Boleto)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Boleto))
         }
        def boleto=(_boleto); end
        # contains details about the Card payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Card)) }
        def card; end
        sig {
          params(_card: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Card)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Card))
         }
        def card=(_card); end
        # contains details about the Cashapp Pay payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Cashapp)) }
        def cashapp; end
        sig {
          params(_cashapp: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Cashapp)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Cashapp))
         }
        def cashapp=(_cashapp); end
        # contains details about the Customer Balance payment method options.
        sig {
          returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::CustomerBalance))
         }
        def customer_balance; end
        sig {
          params(_customer_balance: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::CustomerBalance)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::CustomerBalance))
         }
        def customer_balance=(_customer_balance); end
        # contains details about the DemoPay payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::DemoPay)) }
        def demo_pay; end
        sig {
          params(_demo_pay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::DemoPay)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::DemoPay))
         }
        def demo_pay=(_demo_pay); end
        # contains details about the EPS payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Eps)) }
        def eps; end
        sig {
          params(_eps: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Eps)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Eps))
         }
        def eps=(_eps); end
        # contains details about the FPX payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Fpx)) }
        def fpx; end
        sig {
          params(_fpx: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Fpx)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Fpx))
         }
        def fpx=(_fpx); end
        # contains details about the Giropay payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Giropay)) }
        def giropay; end
        sig {
          params(_giropay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Giropay)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Giropay))
         }
        def giropay=(_giropay); end
        # contains details about the Grabpay payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Grabpay)) }
        def grabpay; end
        sig {
          params(_grabpay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Grabpay)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Grabpay))
         }
        def grabpay=(_grabpay); end
        # contains details about the Ideal payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Ideal)) }
        def ideal; end
        sig {
          params(_ideal: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Ideal)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Ideal))
         }
        def ideal=(_ideal); end
        # contains details about the Kakao Pay payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::KakaoPay)) }
        def kakao_pay; end
        sig {
          params(_kakao_pay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::KakaoPay)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::KakaoPay))
         }
        def kakao_pay=(_kakao_pay); end
        # contains details about the Klarna payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Klarna)) }
        def klarna; end
        sig {
          params(_klarna: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Klarna)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Klarna))
         }
        def klarna=(_klarna); end
        # contains details about the Konbini payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Konbini)) }
        def konbini; end
        sig {
          params(_konbini: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Konbini)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Konbini))
         }
        def konbini=(_konbini); end
        # contains details about the Korean card payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::KrCard)) }
        def kr_card; end
        sig {
          params(_kr_card: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::KrCard)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::KrCard))
         }
        def kr_card=(_kr_card); end
        # contains details about the Link payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Link)) }
        def link; end
        sig {
          params(_link: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Link)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Link))
         }
        def link=(_link); end
        # contains details about the Mobilepay payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Mobilepay)) }
        def mobilepay; end
        sig {
          params(_mobilepay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Mobilepay)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Mobilepay))
         }
        def mobilepay=(_mobilepay); end
        # contains details about the Multibanco payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Multibanco)) }
        def multibanco; end
        sig {
          params(_multibanco: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Multibanco)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Multibanco))
         }
        def multibanco=(_multibanco); end
        # contains details about the Naver Pay payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::NaverPay)) }
        def naver_pay; end
        sig {
          params(_naver_pay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::NaverPay)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::NaverPay))
         }
        def naver_pay=(_naver_pay); end
        # contains details about the OXXO payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Oxxo)) }
        def oxxo; end
        sig {
          params(_oxxo: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Oxxo)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Oxxo))
         }
        def oxxo=(_oxxo); end
        # contains details about the P24 payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::P24)) }
        def p24; end
        sig {
          params(_p24: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::P24)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::P24))
         }
        def p24=(_p24); end
        # contains details about the Pay By Bank payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::PayByBank)) }
        def pay_by_bank; end
        sig {
          params(_pay_by_bank: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::PayByBank)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::PayByBank))
         }
        def pay_by_bank=(_pay_by_bank); end
        # contains details about the PAYCO payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Payco)) }
        def payco; end
        sig {
          params(_payco: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Payco)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Payco))
         }
        def payco=(_payco); end
        # contains details about the PayNow payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Paynow)) }
        def paynow; end
        sig {
          params(_paynow: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Paynow)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Paynow))
         }
        def paynow=(_paynow); end
        # contains details about the PayPal payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Paypal)) }
        def paypal; end
        sig {
          params(_paypal: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Paypal)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Paypal))
         }
        def paypal=(_paypal); end
        # contains details about the PayTo payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Payto)) }
        def payto; end
        sig {
          params(_payto: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Payto)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Payto))
         }
        def payto=(_payto); end
        # contains details about the Pix payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Pix)) }
        def pix; end
        sig {
          params(_pix: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Pix)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Pix))
         }
        def pix=(_pix); end
        # contains details about the RevolutPay payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::RevolutPay)) }
        def revolut_pay; end
        sig {
          params(_revolut_pay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::RevolutPay)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::RevolutPay))
         }
        def revolut_pay=(_revolut_pay); end
        # contains details about the Samsung Pay payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::SamsungPay)) }
        def samsung_pay; end
        sig {
          params(_samsung_pay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::SamsungPay)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::SamsungPay))
         }
        def samsung_pay=(_samsung_pay); end
        # contains details about the Satispay payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Satispay)) }
        def satispay; end
        sig {
          params(_satispay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Satispay)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Satispay))
         }
        def satispay=(_satispay); end
        # contains details about the Sepa Debit payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::SepaDebit)) }
        def sepa_debit; end
        sig {
          params(_sepa_debit: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::SepaDebit)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::SepaDebit))
         }
        def sepa_debit=(_sepa_debit); end
        # contains details about the Sofort payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Sofort)) }
        def sofort; end
        sig {
          params(_sofort: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Sofort)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Sofort))
         }
        def sofort=(_sofort); end
        # contains details about the Swish payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Swish)) }
        def swish; end
        sig {
          params(_swish: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Swish)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Swish))
         }
        def swish=(_swish); end
        # contains details about the TWINT payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Twint)) }
        def twint; end
        sig {
          params(_twint: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Twint)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Twint))
         }
        def twint=(_twint); end
        # contains details about the Us Bank Account payment method options.
        sig {
          returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::UsBankAccount))
         }
        def us_bank_account; end
        sig {
          params(_us_bank_account: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::UsBankAccount)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::UsBankAccount))
         }
        def us_bank_account=(_us_bank_account); end
        # contains details about the WeChat Pay payment method options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::WechatPay)) }
        def wechat_pay; end
        sig {
          params(_wechat_pay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::WechatPay)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::WechatPay))
         }
        def wechat_pay=(_wechat_pay); end
        sig {
          params(acss_debit: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AcssDebit), affirm: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Affirm), afterpay_clearpay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AfterpayClearpay), alipay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Alipay), alma: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Alma), amazon_pay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AmazonPay), au_becs_debit: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::AuBecsDebit), bacs_debit: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::BacsDebit), bancontact: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Bancontact), billie: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Billie), boleto: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Boleto), card: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Card), cashapp: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Cashapp), customer_balance: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::CustomerBalance), demo_pay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::DemoPay), eps: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Eps), fpx: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Fpx), giropay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Giropay), grabpay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Grabpay), ideal: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Ideal), kakao_pay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::KakaoPay), klarna: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Klarna), konbini: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Konbini), kr_card: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::KrCard), link: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Link), mobilepay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Mobilepay), multibanco: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Multibanco), naver_pay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::NaverPay), oxxo: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Oxxo), p24: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::P24), pay_by_bank: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::PayByBank), payco: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Payco), paynow: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Paynow), paypal: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Paypal), payto: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Payto), pix: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Pix), revolut_pay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::RevolutPay), samsung_pay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::SamsungPay), satispay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Satispay), sepa_debit: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::SepaDebit), sofort: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Sofort), swish: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Swish), twint: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::Twint), us_bank_account: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::UsBankAccount), wechat_pay: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions::WechatPay)).void
         }
        def initialize(
          acss_debit: nil,
          affirm: nil,
          afterpay_clearpay: nil,
          alipay: nil,
          alma: nil,
          amazon_pay: nil,
          au_becs_debit: nil,
          bacs_debit: nil,
          bancontact: nil,
          billie: nil,
          boleto: nil,
          card: nil,
          cashapp: nil,
          customer_balance: nil,
          demo_pay: nil,
          eps: nil,
          fpx: nil,
          giropay: nil,
          grabpay: nil,
          ideal: nil,
          kakao_pay: nil,
          klarna: nil,
          konbini: nil,
          kr_card: nil,
          link: nil,
          mobilepay: nil,
          multibanco: nil,
          naver_pay: nil,
          oxxo: nil,
          p24: nil,
          pay_by_bank: nil,
          payco: nil,
          paynow: nil,
          paypal: nil,
          payto: nil,
          pix: nil,
          revolut_pay: nil,
          samsung_pay: nil,
          satispay: nil,
          sepa_debit: nil,
          sofort: nil,
          swish: nil,
          twint: nil,
          us_bank_account: nil,
          wechat_pay: nil
        ); end
      end
      class Permissions < ::Stripe::RequestParams
        # Determines which entity is allowed to update the shipping details.
        #
        # Default is `client_only`. Stripe Checkout client will automatically update the shipping details. If set to `server_only`, only your server is allowed to update the shipping details.
        #
        # When set to `server_only`, you must add the onShippingDetailsChange event handler when initializing the Stripe Checkout client and manually update the shipping details from your server using the Stripe API.
        sig { returns(T.nilable(String)) }
        def update_shipping_details; end
        sig { params(_update_shipping_details: T.nilable(String)).returns(T.nilable(String)) }
        def update_shipping_details=(_update_shipping_details); end
        sig { params(update_shipping_details: T.nilable(String)).void }
        def initialize(update_shipping_details: nil); end
      end
      class PhoneNumberCollection < ::Stripe::RequestParams
        # Set to `true` to enable phone number collection.
        #
        # Can only be set in `payment` and `subscription` mode.
        sig { returns(T::Boolean) }
        def enabled; end
        sig { params(_enabled: T::Boolean).returns(T::Boolean) }
        def enabled=(_enabled); end
        sig { params(enabled: T::Boolean).void }
        def initialize(enabled: nil); end
      end
      class SavedPaymentMethodOptions < ::Stripe::RequestParams
        # Uses the `allow_redisplay` value of each saved payment method to filter the set presented to a returning customer. By default, only saved payment methods with ’allow_redisplay: ‘always’ are shown in Checkout.
        sig { returns(T.nilable(T::Array[String])) }
        def allow_redisplay_filters; end
        sig {
          params(_allow_redisplay_filters: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
         }
        def allow_redisplay_filters=(_allow_redisplay_filters); end
        # Enable customers to choose if they wish to remove their saved payment methods. Disabled by default.
        sig { returns(T.nilable(String)) }
        def payment_method_remove; end
        sig { params(_payment_method_remove: T.nilable(String)).returns(T.nilable(String)) }
        def payment_method_remove=(_payment_method_remove); end
        # Enable customers to choose if they wish to save their payment method for future use. Disabled by default.
        sig { returns(T.nilable(String)) }
        def payment_method_save; end
        sig { params(_payment_method_save: T.nilable(String)).returns(T.nilable(String)) }
        def payment_method_save=(_payment_method_save); end
        sig {
          params(allow_redisplay_filters: T.nilable(T::Array[String]), payment_method_remove: T.nilable(String), payment_method_save: T.nilable(String)).void
         }
        def initialize(
          allow_redisplay_filters: nil,
          payment_method_remove: nil,
          payment_method_save: nil
        ); end
      end
      class SetupIntentData < ::Stripe::RequestParams
        # An arbitrary string attached to the object. Often useful for displaying to users.
        sig { returns(T.nilable(String)) }
        def description; end
        sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
        def description=(_description); end
        # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
        sig { returns(T.nilable(T::Hash[String, String])) }
        def metadata; end
        sig {
          params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
         }
        def metadata=(_metadata); end
        # The Stripe account for which the setup is intended.
        sig { returns(T.nilable(String)) }
        def on_behalf_of; end
        sig { params(_on_behalf_of: T.nilable(String)).returns(T.nilable(String)) }
        def on_behalf_of=(_on_behalf_of); end
        sig {
          params(description: T.nilable(String), metadata: T.nilable(T::Hash[String, String]), on_behalf_of: T.nilable(String)).void
         }
        def initialize(description: nil, metadata: nil, on_behalf_of: nil); end
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
      class ShippingOption < ::Stripe::RequestParams
        class ShippingRateData < ::Stripe::RequestParams
          class DeliveryEstimate < ::Stripe::RequestParams
            class Maximum < ::Stripe::RequestParams
              # A unit of time.
              sig { returns(String) }
              def unit; end
              sig { params(_unit: String).returns(String) }
              def unit=(_unit); end
              # Must be greater than 0.
              sig { returns(Integer) }
              def value; end
              sig { params(_value: Integer).returns(Integer) }
              def value=(_value); end
              sig { params(unit: String, value: Integer).void }
              def initialize(unit: nil, value: nil); end
            end
            class Minimum < ::Stripe::RequestParams
              # A unit of time.
              sig { returns(String) }
              def unit; end
              sig { params(_unit: String).returns(String) }
              def unit=(_unit); end
              # Must be greater than 0.
              sig { returns(Integer) }
              def value; end
              sig { params(_value: Integer).returns(Integer) }
              def value=(_value); end
              sig { params(unit: String, value: Integer).void }
              def initialize(unit: nil, value: nil); end
            end
            # The upper bound of the estimated range. If empty, represents no upper bound i.e., infinite.
            sig {
              returns(T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData::DeliveryEstimate::Maximum))
             }
            def maximum; end
            sig {
              params(_maximum: T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData::DeliveryEstimate::Maximum)).returns(T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData::DeliveryEstimate::Maximum))
             }
            def maximum=(_maximum); end
            # The lower bound of the estimated range. If empty, represents no lower bound.
            sig {
              returns(T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData::DeliveryEstimate::Minimum))
             }
            def minimum; end
            sig {
              params(_minimum: T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData::DeliveryEstimate::Minimum)).returns(T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData::DeliveryEstimate::Minimum))
             }
            def minimum=(_minimum); end
            sig {
              params(maximum: T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData::DeliveryEstimate::Maximum), minimum: T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData::DeliveryEstimate::Minimum)).void
             }
            def initialize(maximum: nil, minimum: nil); end
          end
          class FixedAmount < ::Stripe::RequestParams
            class CurrencyOptions < ::Stripe::RequestParams
              # A non-negative integer in cents representing how much to charge.
              sig { returns(Integer) }
              def amount; end
              sig { params(_amount: Integer).returns(Integer) }
              def amount=(_amount); end
              # Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`.
              sig { returns(T.nilable(String)) }
              def tax_behavior; end
              sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
              def tax_behavior=(_tax_behavior); end
              sig { params(amount: Integer, tax_behavior: T.nilable(String)).void }
              def initialize(amount: nil, tax_behavior: nil); end
            end
            # A non-negative integer in cents representing how much to charge.
            sig { returns(Integer) }
            def amount; end
            sig { params(_amount: Integer).returns(Integer) }
            def amount=(_amount); end
            # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
            sig { returns(String) }
            def currency; end
            sig { params(_currency: String).returns(String) }
            def currency=(_currency); end
            # Shipping rates defined in each available currency option. Each key must be a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) and a [supported currency](https://stripe.com/docs/currencies).
            sig {
              returns(T.nilable(T::Hash[String, Checkout::SessionCreateParams::ShippingOption::ShippingRateData::FixedAmount::CurrencyOptions]))
             }
            def currency_options; end
            sig {
              params(_currency_options: T.nilable(T::Hash[String, Checkout::SessionCreateParams::ShippingOption::ShippingRateData::FixedAmount::CurrencyOptions])).returns(T.nilable(T::Hash[String, Checkout::SessionCreateParams::ShippingOption::ShippingRateData::FixedAmount::CurrencyOptions]))
             }
            def currency_options=(_currency_options); end
            sig {
              params(amount: Integer, currency: String, currency_options: T.nilable(T::Hash[String, Checkout::SessionCreateParams::ShippingOption::ShippingRateData::FixedAmount::CurrencyOptions])).void
             }
            def initialize(amount: nil, currency: nil, currency_options: nil); end
          end
          # The estimated range for how long shipping will take, meant to be displayable to the customer. This will appear on CheckoutSessions.
          sig {
            returns(T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData::DeliveryEstimate))
           }
          def delivery_estimate; end
          sig {
            params(_delivery_estimate: T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData::DeliveryEstimate)).returns(T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData::DeliveryEstimate))
           }
          def delivery_estimate=(_delivery_estimate); end
          # The name of the shipping rate, meant to be displayable to the customer. This will appear on CheckoutSessions.
          sig { returns(String) }
          def display_name; end
          sig { params(_display_name: String).returns(String) }
          def display_name=(_display_name); end
          # Describes a fixed amount to charge for shipping. Must be present if type is `fixed_amount`.
          sig {
            returns(T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData::FixedAmount))
           }
          def fixed_amount; end
          sig {
            params(_fixed_amount: T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData::FixedAmount)).returns(T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData::FixedAmount))
           }
          def fixed_amount=(_fixed_amount); end
          # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
          sig { returns(T.nilable(T::Hash[String, String])) }
          def metadata; end
          sig {
            params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
           }
          def metadata=(_metadata); end
          # Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`.
          sig { returns(T.nilable(String)) }
          def tax_behavior; end
          sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
          def tax_behavior=(_tax_behavior); end
          # A [tax code](https://docs.stripe.com/tax/tax-categories) ID. The Shipping tax code is `txcd_92010001`.
          sig { returns(T.nilable(String)) }
          def tax_code; end
          sig { params(_tax_code: T.nilable(String)).returns(T.nilable(String)) }
          def tax_code=(_tax_code); end
          # The type of calculation to use on the shipping rate.
          sig { returns(T.nilable(String)) }
          def type; end
          sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
          def type=(_type); end
          sig {
            params(delivery_estimate: T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData::DeliveryEstimate), display_name: String, fixed_amount: T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData::FixedAmount), metadata: T.nilable(T::Hash[String, String]), tax_behavior: T.nilable(String), tax_code: T.nilable(String), type: T.nilable(String)).void
           }
          def initialize(
            delivery_estimate: nil,
            display_name: nil,
            fixed_amount: nil,
            metadata: nil,
            tax_behavior: nil,
            tax_code: nil,
            type: nil
          ); end
        end
        # The ID of the Shipping Rate to use for this shipping option.
        sig { returns(T.nilable(String)) }
        def shipping_rate; end
        sig { params(_shipping_rate: T.nilable(String)).returns(T.nilable(String)) }
        def shipping_rate=(_shipping_rate); end
        # Parameters to be passed to Shipping Rate creation for this shipping option.
        sig { returns(T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData)) }
        def shipping_rate_data; end
        sig {
          params(_shipping_rate_data: T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData)).returns(T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData))
         }
        def shipping_rate_data=(_shipping_rate_data); end
        sig {
          params(shipping_rate: T.nilable(String), shipping_rate_data: T.nilable(Checkout::SessionCreateParams::ShippingOption::ShippingRateData)).void
         }
        def initialize(shipping_rate: nil, shipping_rate_data: nil); end
      end
      class SubscriptionData < ::Stripe::RequestParams
        class BillingMode < ::Stripe::RequestParams
          class Flexible < ::Stripe::RequestParams
            # Controls how invoices and invoice items display proration amounts and discount amounts.
            sig { returns(T.nilable(String)) }
            def proration_discounts; end
            sig { params(_proration_discounts: T.nilable(String)).returns(T.nilable(String)) }
            def proration_discounts=(_proration_discounts); end
            sig { params(proration_discounts: T.nilable(String)).void }
            def initialize(proration_discounts: nil); end
          end
          # Configure behavior for flexible billing mode.
          sig {
            returns(T.nilable(Checkout::SessionCreateParams::SubscriptionData::BillingMode::Flexible))
           }
          def flexible; end
          sig {
            params(_flexible: T.nilable(Checkout::SessionCreateParams::SubscriptionData::BillingMode::Flexible)).returns(T.nilable(Checkout::SessionCreateParams::SubscriptionData::BillingMode::Flexible))
           }
          def flexible=(_flexible); end
          # Controls the calculation and orchestration of prorations and invoices for subscriptions. If no value is passed, the default is `flexible`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(flexible: T.nilable(Checkout::SessionCreateParams::SubscriptionData::BillingMode::Flexible), type: String).void
           }
          def initialize(flexible: nil, type: nil); end
        end
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
            returns(T.nilable(Checkout::SessionCreateParams::SubscriptionData::InvoiceSettings::Issuer))
           }
          def issuer; end
          sig {
            params(_issuer: T.nilable(Checkout::SessionCreateParams::SubscriptionData::InvoiceSettings::Issuer)).returns(T.nilable(Checkout::SessionCreateParams::SubscriptionData::InvoiceSettings::Issuer))
           }
          def issuer=(_issuer); end
          sig {
            params(issuer: T.nilable(Checkout::SessionCreateParams::SubscriptionData::InvoiceSettings::Issuer)).void
           }
          def initialize(issuer: nil); end
        end
        class TransferData < ::Stripe::RequestParams
          # A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice total that will be transferred to the destination account. By default, the entire amount is transferred to the destination.
          sig { returns(T.nilable(Float)) }
          def amount_percent; end
          sig { params(_amount_percent: T.nilable(Float)).returns(T.nilable(Float)) }
          def amount_percent=(_amount_percent); end
          # ID of an existing, connected Stripe account.
          sig { returns(String) }
          def destination; end
          sig { params(_destination: String).returns(String) }
          def destination=(_destination); end
          sig { params(amount_percent: T.nilable(Float), destination: String).void }
          def initialize(amount_percent: nil, destination: nil); end
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
          sig {
            returns(Checkout::SessionCreateParams::SubscriptionData::TrialSettings::EndBehavior)
           }
          def end_behavior; end
          sig {
            params(_end_behavior: Checkout::SessionCreateParams::SubscriptionData::TrialSettings::EndBehavior).returns(Checkout::SessionCreateParams::SubscriptionData::TrialSettings::EndBehavior)
           }
          def end_behavior=(_end_behavior); end
          sig {
            params(end_behavior: Checkout::SessionCreateParams::SubscriptionData::TrialSettings::EndBehavior).void
           }
          def initialize(end_behavior: nil); end
        end
        # A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice total that will be transferred to the application owner's Stripe account. To use an application fee percent, the request must be made on behalf of another account, using the `Stripe-Account` header or an OAuth key. For more information, see the application fees [documentation](https://stripe.com/docs/connect/subscriptions#collecting-fees-on-subscriptions).
        sig { returns(T.nilable(Float)) }
        def application_fee_percent; end
        sig { params(_application_fee_percent: T.nilable(Float)).returns(T.nilable(Float)) }
        def application_fee_percent=(_application_fee_percent); end
        # A future timestamp to anchor the subscription's billing cycle for new subscriptions.
        sig { returns(T.nilable(Integer)) }
        def billing_cycle_anchor; end
        sig { params(_billing_cycle_anchor: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def billing_cycle_anchor=(_billing_cycle_anchor); end
        # Controls how prorations and invoices for subscriptions are calculated and orchestrated.
        sig { returns(T.nilable(Checkout::SessionCreateParams::SubscriptionData::BillingMode)) }
        def billing_mode; end
        sig {
          params(_billing_mode: T.nilable(Checkout::SessionCreateParams::SubscriptionData::BillingMode)).returns(T.nilable(Checkout::SessionCreateParams::SubscriptionData::BillingMode))
         }
        def billing_mode=(_billing_mode); end
        # The tax rates that will apply to any subscription item that does not have
        # `tax_rates` set. Invoices created will have their `default_tax_rates` populated
        # from the subscription.
        sig { returns(T.nilable(T::Array[String])) }
        def default_tax_rates; end
        sig {
          params(_default_tax_rates: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
         }
        def default_tax_rates=(_default_tax_rates); end
        # The subscription's description, meant to be displayable to the customer.
        # Use this field to optionally store an explanation of the subscription
        # for rendering in the [customer portal](https://docs.stripe.com/customer-management).
        sig { returns(T.nilable(String)) }
        def description; end
        sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
        def description=(_description); end
        # All invoices will be billed using the specified settings.
        sig { returns(T.nilable(Checkout::SessionCreateParams::SubscriptionData::InvoiceSettings)) }
        def invoice_settings; end
        sig {
          params(_invoice_settings: T.nilable(Checkout::SessionCreateParams::SubscriptionData::InvoiceSettings)).returns(T.nilable(Checkout::SessionCreateParams::SubscriptionData::InvoiceSettings))
         }
        def invoice_settings=(_invoice_settings); end
        # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
        sig { returns(T.nilable(T::Hash[String, String])) }
        def metadata; end
        sig {
          params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
         }
        def metadata=(_metadata); end
        # The account on behalf of which to charge, for each of the subscription's invoices.
        sig { returns(T.nilable(String)) }
        def on_behalf_of; end
        sig { params(_on_behalf_of: T.nilable(String)).returns(T.nilable(String)) }
        def on_behalf_of=(_on_behalf_of); end
        # Determines how to handle prorations resulting from the `billing_cycle_anchor`. If no value is passed, the default is `create_prorations`.
        sig { returns(T.nilable(String)) }
        def proration_behavior; end
        sig { params(_proration_behavior: T.nilable(String)).returns(T.nilable(String)) }
        def proration_behavior=(_proration_behavior); end
        # If specified, the funds from the subscription's invoices will be transferred to the destination and the ID of the resulting transfers will be found on the resulting charges.
        sig { returns(T.nilable(Checkout::SessionCreateParams::SubscriptionData::TransferData)) }
        def transfer_data; end
        sig {
          params(_transfer_data: T.nilable(Checkout::SessionCreateParams::SubscriptionData::TransferData)).returns(T.nilable(Checkout::SessionCreateParams::SubscriptionData::TransferData))
         }
        def transfer_data=(_transfer_data); end
        # Unix timestamp representing the end of the trial period the customer will get before being charged for the first time. Has to be at least 48 hours in the future.
        sig { returns(T.nilable(Integer)) }
        def trial_end; end
        sig { params(_trial_end: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def trial_end=(_trial_end); end
        # Integer representing the number of trial period days before the customer is charged for the first time. Has to be at least 1.
        sig { returns(T.nilable(Integer)) }
        def trial_period_days; end
        sig { params(_trial_period_days: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def trial_period_days=(_trial_period_days); end
        # Settings related to subscription trials.
        sig { returns(T.nilable(Checkout::SessionCreateParams::SubscriptionData::TrialSettings)) }
        def trial_settings; end
        sig {
          params(_trial_settings: T.nilable(Checkout::SessionCreateParams::SubscriptionData::TrialSettings)).returns(T.nilable(Checkout::SessionCreateParams::SubscriptionData::TrialSettings))
         }
        def trial_settings=(_trial_settings); end
        sig {
          params(application_fee_percent: T.nilable(Float), billing_cycle_anchor: T.nilable(Integer), billing_mode: T.nilable(Checkout::SessionCreateParams::SubscriptionData::BillingMode), default_tax_rates: T.nilable(T::Array[String]), description: T.nilable(String), invoice_settings: T.nilable(Checkout::SessionCreateParams::SubscriptionData::InvoiceSettings), metadata: T.nilable(T::Hash[String, String]), on_behalf_of: T.nilable(String), proration_behavior: T.nilable(String), transfer_data: T.nilable(Checkout::SessionCreateParams::SubscriptionData::TransferData), trial_end: T.nilable(Integer), trial_period_days: T.nilable(Integer), trial_settings: T.nilable(Checkout::SessionCreateParams::SubscriptionData::TrialSettings)).void
         }
        def initialize(
          application_fee_percent: nil,
          billing_cycle_anchor: nil,
          billing_mode: nil,
          default_tax_rates: nil,
          description: nil,
          invoice_settings: nil,
          metadata: nil,
          on_behalf_of: nil,
          proration_behavior: nil,
          transfer_data: nil,
          trial_end: nil,
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
      class WalletOptions < ::Stripe::RequestParams
        class Link < ::Stripe::RequestParams
          # Specifies whether Checkout should display Link as a payment option. By default, Checkout will display all the supported wallets that the Checkout Session was created with. This is the `auto` behavior, and it is the default choice.
          sig { returns(T.nilable(String)) }
          def display; end
          sig { params(_display: T.nilable(String)).returns(T.nilable(String)) }
          def display=(_display); end
          sig { params(display: T.nilable(String)).void }
          def initialize(display: nil); end
        end
        # contains details about the Link wallet options.
        sig { returns(T.nilable(Checkout::SessionCreateParams::WalletOptions::Link)) }
        def link; end
        sig {
          params(_link: T.nilable(Checkout::SessionCreateParams::WalletOptions::Link)).returns(T.nilable(Checkout::SessionCreateParams::WalletOptions::Link))
         }
        def link=(_link); end
        sig { params(link: T.nilable(Checkout::SessionCreateParams::WalletOptions::Link)).void }
        def initialize(link: nil); end
      end
      # Settings for price localization with [Adaptive Pricing](https://docs.stripe.com/payments/checkout/adaptive-pricing).
      sig { returns(T.nilable(Checkout::SessionCreateParams::AdaptivePricing)) }
      def adaptive_pricing; end
      sig {
        params(_adaptive_pricing: T.nilable(Checkout::SessionCreateParams::AdaptivePricing)).returns(T.nilable(Checkout::SessionCreateParams::AdaptivePricing))
       }
      def adaptive_pricing=(_adaptive_pricing); end
      # Configure actions after a Checkout Session has expired.
      sig { returns(T.nilable(Checkout::SessionCreateParams::AfterExpiration)) }
      def after_expiration; end
      sig {
        params(_after_expiration: T.nilable(Checkout::SessionCreateParams::AfterExpiration)).returns(T.nilable(Checkout::SessionCreateParams::AfterExpiration))
       }
      def after_expiration=(_after_expiration); end
      # Enables user redeemable promotion codes.
      sig { returns(T.nilable(T::Boolean)) }
      def allow_promotion_codes; end
      sig { params(_allow_promotion_codes: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def allow_promotion_codes=(_allow_promotion_codes); end
      # Settings for automatic tax lookup for this session and resulting payments, invoices, and subscriptions.
      sig { returns(T.nilable(Checkout::SessionCreateParams::AutomaticTax)) }
      def automatic_tax; end
      sig {
        params(_automatic_tax: T.nilable(Checkout::SessionCreateParams::AutomaticTax)).returns(T.nilable(Checkout::SessionCreateParams::AutomaticTax))
       }
      def automatic_tax=(_automatic_tax); end
      # Specify whether Checkout should collect the customer's billing address. Defaults to `auto`.
      sig { returns(T.nilable(String)) }
      def billing_address_collection; end
      sig { params(_billing_address_collection: T.nilable(String)).returns(T.nilable(String)) }
      def billing_address_collection=(_billing_address_collection); end
      # The branding settings for the Checkout Session. This parameter is not allowed if ui_mode is `custom`.
      sig { returns(T.nilable(Checkout::SessionCreateParams::BrandingSettings)) }
      def branding_settings; end
      sig {
        params(_branding_settings: T.nilable(Checkout::SessionCreateParams::BrandingSettings)).returns(T.nilable(Checkout::SessionCreateParams::BrandingSettings))
       }
      def branding_settings=(_branding_settings); end
      # If set, Checkout displays a back button and customers will be directed to this URL if they decide to cancel payment and return to your website. This parameter is not allowed if ui_mode is `embedded` or `custom`.
      sig { returns(T.nilable(String)) }
      def cancel_url; end
      sig { params(_cancel_url: T.nilable(String)).returns(T.nilable(String)) }
      def cancel_url=(_cancel_url); end
      # A unique string to reference the Checkout Session. This can be a
      # customer ID, a cart ID, or similar, and can be used to reconcile the
      # session with your internal systems.
      sig { returns(T.nilable(String)) }
      def client_reference_id; end
      sig { params(_client_reference_id: T.nilable(String)).returns(T.nilable(String)) }
      def client_reference_id=(_client_reference_id); end
      # Configure fields for the Checkout Session to gather active consent from customers.
      sig { returns(T.nilable(Checkout::SessionCreateParams::ConsentCollection)) }
      def consent_collection; end
      sig {
        params(_consent_collection: T.nilable(Checkout::SessionCreateParams::ConsentCollection)).returns(T.nilable(Checkout::SessionCreateParams::ConsentCollection))
       }
      def consent_collection=(_consent_collection); end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies). Required in `setup` mode when `payment_method_types` is not set.
      sig { returns(T.nilable(String)) }
      def currency; end
      sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
      def currency=(_currency); end
      # Collect additional information from your customer using custom fields. Up to 3 fields are supported.
      sig { returns(T.nilable(T::Array[Checkout::SessionCreateParams::CustomField])) }
      def custom_fields; end
      sig {
        params(_custom_fields: T.nilable(T::Array[Checkout::SessionCreateParams::CustomField])).returns(T.nilable(T::Array[Checkout::SessionCreateParams::CustomField]))
       }
      def custom_fields=(_custom_fields); end
      # Display additional text for your customers using custom text.
      sig { returns(T.nilable(Checkout::SessionCreateParams::CustomText)) }
      def custom_text; end
      sig {
        params(_custom_text: T.nilable(Checkout::SessionCreateParams::CustomText)).returns(T.nilable(Checkout::SessionCreateParams::CustomText))
       }
      def custom_text=(_custom_text); end
      # ID of an existing Customer, if one exists. In `payment` mode, the customer’s most recently saved card
      # payment method will be used to prefill the email, name, card details, and billing address
      # on the Checkout page. In `subscription` mode, the customer’s [default payment method](https://docs.stripe.com/api/customers/update#update_customer-invoice_settings-default_payment_method)
      # will be used if it’s a card, otherwise the most recently saved card will be used. A valid billing address, billing name and billing email are required on the payment method for Checkout to prefill the customer's card details.
      #
      # If the Customer already has a valid [email](https://docs.stripe.com/api/customers/object#customer_object-email) set, the email will be prefilled and not editable in Checkout.
      # If the Customer does not have a valid `email`, Checkout will set the email entered during the session on the Customer.
      #
      # If blank for Checkout Sessions in `subscription` mode or with `customer_creation` set as `always` in `payment` mode, Checkout will create a new Customer object based on information provided during the payment flow.
      #
      # You can set [`payment_intent_data.setup_future_usage`](https://docs.stripe.com/api/checkout/sessions/create#create_checkout_session-payment_intent_data-setup_future_usage) to have Checkout automatically attach the payment method to the Customer you pass in for future reuse.
      sig { returns(T.nilable(String)) }
      def customer; end
      sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
      def customer=(_customer); end
      # ID of an existing Account, if one exists. Has the same behavior as `customer`.
      sig { returns(T.nilable(String)) }
      def customer_account; end
      sig { params(_customer_account: T.nilable(String)).returns(T.nilable(String)) }
      def customer_account=(_customer_account); end
      # Configure whether a Checkout Session creates a [Customer](https://docs.stripe.com/api/customers) during Session confirmation.
      #
      # When a Customer is not created, you can still retrieve email, address, and other customer data entered in Checkout
      # with [customer_details](https://docs.stripe.com/api/checkout/sessions/object#checkout_session_object-customer_details).
      #
      # Sessions that don't create Customers instead are grouped by [guest customers](https://docs.stripe.com/payments/checkout/guest-customers)
      # in the Dashboard. Promotion codes limited to first time customers will return invalid for these Sessions.
      #
      # Can only be set in `payment` and `setup` mode.
      sig { returns(T.nilable(String)) }
      def customer_creation; end
      sig { params(_customer_creation: T.nilable(String)).returns(T.nilable(String)) }
      def customer_creation=(_customer_creation); end
      # If provided, this value will be used when the Customer object is created.
      # If not provided, customers will be asked to enter their email address.
      # Use this parameter to prefill customer data if you already have an email
      # on file. To access information about the customer once a session is
      # complete, use the `customer` field.
      sig { returns(T.nilable(String)) }
      def customer_email; end
      sig { params(_customer_email: T.nilable(String)).returns(T.nilable(String)) }
      def customer_email=(_customer_email); end
      # Controls what fields on Customer can be updated by the Checkout Session. Can only be provided when `customer` is provided.
      sig { returns(T.nilable(Checkout::SessionCreateParams::CustomerUpdate)) }
      def customer_update; end
      sig {
        params(_customer_update: T.nilable(Checkout::SessionCreateParams::CustomerUpdate)).returns(T.nilable(Checkout::SessionCreateParams::CustomerUpdate))
       }
      def customer_update=(_customer_update); end
      # The coupon or promotion code to apply to this Session. Currently, only up to one may be specified.
      sig { returns(T.nilable(T::Array[Checkout::SessionCreateParams::Discount])) }
      def discounts; end
      sig {
        params(_discounts: T.nilable(T::Array[Checkout::SessionCreateParams::Discount])).returns(T.nilable(T::Array[Checkout::SessionCreateParams::Discount]))
       }
      def discounts=(_discounts); end
      # A list of the types of payment methods (e.g., `card`) that should be excluded from this Checkout Session. This should only be used when payment methods for this Checkout Session are managed through the [Stripe Dashboard](https://dashboard.stripe.com/settings/payment_methods).
      sig { returns(T.nilable(T::Array[String])) }
      def excluded_payment_method_types; end
      sig {
        params(_excluded_payment_method_types: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
       }
      def excluded_payment_method_types=(_excluded_payment_method_types); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # The Epoch time in seconds at which the Checkout Session will expire. It can be anywhere from 30 minutes to 24 hours after Checkout Session creation. By default, this value is 24 hours from creation.
      sig { returns(T.nilable(Integer)) }
      def expires_at; end
      sig { params(_expires_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def expires_at=(_expires_at); end
      # Generate a post-purchase Invoice for one-time payments.
      sig { returns(T.nilable(Checkout::SessionCreateParams::InvoiceCreation)) }
      def invoice_creation; end
      sig {
        params(_invoice_creation: T.nilable(Checkout::SessionCreateParams::InvoiceCreation)).returns(T.nilable(Checkout::SessionCreateParams::InvoiceCreation))
       }
      def invoice_creation=(_invoice_creation); end
      # A list of items the customer is purchasing. Use this parameter to pass one-time or recurring [Prices](https://docs.stripe.com/api/prices). The parameter is required for `payment` and `subscription` mode.
      #
      # For `payment` mode, there is a maximum of 100 line items, however it is recommended to consolidate line items if there are more than a few dozen.
      #
      # For `subscription` mode, there is a maximum of 20 line items with recurring Prices and 20 line items with one-time Prices. Line items with one-time Prices will be on the initial invoice only.
      sig { returns(T.nilable(T::Array[Checkout::SessionCreateParams::LineItem])) }
      def line_items; end
      sig {
        params(_line_items: T.nilable(T::Array[Checkout::SessionCreateParams::LineItem])).returns(T.nilable(T::Array[Checkout::SessionCreateParams::LineItem]))
       }
      def line_items=(_line_items); end
      # The IETF language tag of the locale Checkout is displayed in. If blank or `auto`, the browser's locale is used.
      sig { returns(T.nilable(String)) }
      def locale; end
      sig { params(_locale: T.nilable(String)).returns(T.nilable(String)) }
      def locale=(_locale); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # The mode of the Checkout Session. Pass `subscription` if the Checkout Session includes at least one recurring item.
      sig { returns(T.nilable(String)) }
      def mode; end
      sig { params(_mode: T.nilable(String)).returns(T.nilable(String)) }
      def mode=(_mode); end
      # Controls name collection settings for the session.
      #
      # You can configure Checkout to collect your customers' business names, individual names, or both. Each name field can be either required or optional.
      #
      # If a [Customer](https://docs.stripe.com/api/customers) is created or provided, the names can be saved to the Customer object as well.
      sig { returns(T.nilable(Checkout::SessionCreateParams::NameCollection)) }
      def name_collection; end
      sig {
        params(_name_collection: T.nilable(Checkout::SessionCreateParams::NameCollection)).returns(T.nilable(Checkout::SessionCreateParams::NameCollection))
       }
      def name_collection=(_name_collection); end
      # A list of optional items the customer can add to their order at checkout. Use this parameter to pass one-time or recurring [Prices](https://docs.stripe.com/api/prices).
      #
      # There is a maximum of 10 optional items allowed on a Checkout Session, and the existing limits on the number of line items allowed on a Checkout Session apply to the combined number of line items and optional items.
      #
      # For `payment` mode, there is a maximum of 100 combined line items and optional items, however it is recommended to consolidate items if there are more than a few dozen.
      #
      # For `subscription` mode, there is a maximum of 20 line items and optional items with recurring Prices and 20 line items and optional items with one-time Prices.
      sig { returns(T.nilable(T::Array[Checkout::SessionCreateParams::OptionalItem])) }
      def optional_items; end
      sig {
        params(_optional_items: T.nilable(T::Array[Checkout::SessionCreateParams::OptionalItem])).returns(T.nilable(T::Array[Checkout::SessionCreateParams::OptionalItem]))
       }
      def optional_items=(_optional_items); end
      # Where the user is coming from. This informs the optimizations that are applied to the session.
      sig { returns(T.nilable(String)) }
      def origin_context; end
      sig { params(_origin_context: T.nilable(String)).returns(T.nilable(String)) }
      def origin_context=(_origin_context); end
      # A subset of parameters to be passed to PaymentIntent creation for Checkout Sessions in `payment` mode.
      sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentIntentData)) }
      def payment_intent_data; end
      sig {
        params(_payment_intent_data: T.nilable(Checkout::SessionCreateParams::PaymentIntentData)).returns(T.nilable(Checkout::SessionCreateParams::PaymentIntentData))
       }
      def payment_intent_data=(_payment_intent_data); end
      # Specify whether Checkout should collect a payment method. When set to `if_required`, Checkout will not collect a payment method when the total due for the session is 0.
      # This may occur if the Checkout Session includes a free trial or a discount.
      #
      # Can only be set in `subscription` mode. Defaults to `always`.
      #
      # If you'd like information on how to collect a payment method outside of Checkout, read the guide on configuring [subscriptions with a free trial](https://docs.stripe.com/payments/checkout/free-trials).
      sig { returns(T.nilable(String)) }
      def payment_method_collection; end
      sig { params(_payment_method_collection: T.nilable(String)).returns(T.nilable(String)) }
      def payment_method_collection=(_payment_method_collection); end
      # The ID of the payment method configuration to use with this Checkout session.
      sig { returns(T.nilable(String)) }
      def payment_method_configuration; end
      sig { params(_payment_method_configuration: T.nilable(String)).returns(T.nilable(String)) }
      def payment_method_configuration=(_payment_method_configuration); end
      # This parameter allows you to set some attributes on the payment method created during a Checkout session.
      sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodData)) }
      def payment_method_data; end
      sig {
        params(_payment_method_data: T.nilable(Checkout::SessionCreateParams::PaymentMethodData)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodData))
       }
      def payment_method_data=(_payment_method_data); end
      # Payment-method-specific configuration.
      sig { returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions)) }
      def payment_method_options; end
      sig {
        params(_payment_method_options: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions)).returns(T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions))
       }
      def payment_method_options=(_payment_method_options); end
      # A list of the types of payment methods (e.g., `card`) this Checkout Session can accept.
      #
      # You can omit this attribute to manage your payment methods from the [Stripe Dashboard](https://dashboard.stripe.com/settings/payment_methods).
      # See [Dynamic Payment Methods](https://docs.stripe.com/payments/payment-methods/integration-options#using-dynamic-payment-methods) for more details.
      #
      # Read more about the supported payment methods and their requirements in our [payment
      # method details guide](/docs/payments/checkout/payment-methods).
      #
      # If multiple payment methods are passed, Checkout will dynamically reorder them to
      # prioritize the most relevant payment methods based on the customer's location and
      # other characteristics.
      sig { returns(T.nilable(T::Array[String])) }
      def payment_method_types; end
      sig {
        params(_payment_method_types: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
       }
      def payment_method_types=(_payment_method_types); end
      # This property is used to set up permissions for various actions (e.g., update) on the CheckoutSession object. Can only be set when creating `embedded` or `custom` sessions.
      #
      # For specific permissions, please refer to their dedicated subsections, such as `permissions.update_shipping_details`.
      sig { returns(T.nilable(Checkout::SessionCreateParams::Permissions)) }
      def permissions; end
      sig {
        params(_permissions: T.nilable(Checkout::SessionCreateParams::Permissions)).returns(T.nilable(Checkout::SessionCreateParams::Permissions))
       }
      def permissions=(_permissions); end
      # Controls phone number collection settings for the session.
      #
      # We recommend that you review your privacy policy and check with your legal contacts
      # before using this feature. Learn more about [collecting phone numbers with Checkout](https://docs.stripe.com/payments/checkout/phone-numbers).
      sig { returns(T.nilable(Checkout::SessionCreateParams::PhoneNumberCollection)) }
      def phone_number_collection; end
      sig {
        params(_phone_number_collection: T.nilable(Checkout::SessionCreateParams::PhoneNumberCollection)).returns(T.nilable(Checkout::SessionCreateParams::PhoneNumberCollection))
       }
      def phone_number_collection=(_phone_number_collection); end
      # This parameter applies to `ui_mode: embedded`. Learn more about the [redirect behavior](https://docs.stripe.com/payments/checkout/custom-success-page?payment-ui=embedded-form) of embedded sessions. Defaults to `always`.
      sig { returns(T.nilable(String)) }
      def redirect_on_completion; end
      sig { params(_redirect_on_completion: T.nilable(String)).returns(T.nilable(String)) }
      def redirect_on_completion=(_redirect_on_completion); end
      # The URL to redirect your customer back to after they authenticate or cancel their payment on the
      # payment method's app or site. This parameter is required if `ui_mode` is `embedded` or `custom`
      # and redirect-based payment methods are enabled on the session.
      sig { returns(T.nilable(String)) }
      def return_url; end
      sig { params(_return_url: T.nilable(String)).returns(T.nilable(String)) }
      def return_url=(_return_url); end
      # Controls saved payment method settings for the session. Only available in `payment` and `subscription` mode.
      sig { returns(T.nilable(Checkout::SessionCreateParams::SavedPaymentMethodOptions)) }
      def saved_payment_method_options; end
      sig {
        params(_saved_payment_method_options: T.nilable(Checkout::SessionCreateParams::SavedPaymentMethodOptions)).returns(T.nilable(Checkout::SessionCreateParams::SavedPaymentMethodOptions))
       }
      def saved_payment_method_options=(_saved_payment_method_options); end
      # A subset of parameters to be passed to SetupIntent creation for Checkout Sessions in `setup` mode.
      sig { returns(T.nilable(Checkout::SessionCreateParams::SetupIntentData)) }
      def setup_intent_data; end
      sig {
        params(_setup_intent_data: T.nilable(Checkout::SessionCreateParams::SetupIntentData)).returns(T.nilable(Checkout::SessionCreateParams::SetupIntentData))
       }
      def setup_intent_data=(_setup_intent_data); end
      # When set, provides configuration for Checkout to collect a shipping address from a customer.
      sig { returns(T.nilable(Checkout::SessionCreateParams::ShippingAddressCollection)) }
      def shipping_address_collection; end
      sig {
        params(_shipping_address_collection: T.nilable(Checkout::SessionCreateParams::ShippingAddressCollection)).returns(T.nilable(Checkout::SessionCreateParams::ShippingAddressCollection))
       }
      def shipping_address_collection=(_shipping_address_collection); end
      # The shipping rate options to apply to this Session. Up to a maximum of 5.
      sig { returns(T.nilable(T::Array[Checkout::SessionCreateParams::ShippingOption])) }
      def shipping_options; end
      sig {
        params(_shipping_options: T.nilable(T::Array[Checkout::SessionCreateParams::ShippingOption])).returns(T.nilable(T::Array[Checkout::SessionCreateParams::ShippingOption]))
       }
      def shipping_options=(_shipping_options); end
      # Describes the type of transaction being performed by Checkout in order
      # to customize relevant text on the page, such as the submit button.
      #  `submit_type` can only be specified on Checkout Sessions in
      # `payment` or `subscription` mode. If blank or `auto`, `pay` is used.
      sig { returns(T.nilable(String)) }
      def submit_type; end
      sig { params(_submit_type: T.nilable(String)).returns(T.nilable(String)) }
      def submit_type=(_submit_type); end
      # A subset of parameters to be passed to subscription creation for Checkout Sessions in `subscription` mode.
      sig { returns(T.nilable(Checkout::SessionCreateParams::SubscriptionData)) }
      def subscription_data; end
      sig {
        params(_subscription_data: T.nilable(Checkout::SessionCreateParams::SubscriptionData)).returns(T.nilable(Checkout::SessionCreateParams::SubscriptionData))
       }
      def subscription_data=(_subscription_data); end
      # The URL to which Stripe should send customers when payment or setup
      # is complete.
      # This parameter is not allowed if ui_mode is `embedded` or `custom`. If you'd like to use
      # information from the successful Checkout Session on your page, read the
      # guide on [customizing your success page](https://docs.stripe.com/payments/checkout/custom-success-page).
      sig { returns(T.nilable(String)) }
      def success_url; end
      sig { params(_success_url: T.nilable(String)).returns(T.nilable(String)) }
      def success_url=(_success_url); end
      # Controls tax ID collection during checkout.
      sig { returns(T.nilable(Checkout::SessionCreateParams::TaxIdCollection)) }
      def tax_id_collection; end
      sig {
        params(_tax_id_collection: T.nilable(Checkout::SessionCreateParams::TaxIdCollection)).returns(T.nilable(Checkout::SessionCreateParams::TaxIdCollection))
       }
      def tax_id_collection=(_tax_id_collection); end
      # The UI mode of the Session. Defaults to `hosted`.
      sig { returns(T.nilable(String)) }
      def ui_mode; end
      sig { params(_ui_mode: T.nilable(String)).returns(T.nilable(String)) }
      def ui_mode=(_ui_mode); end
      # Wallet-specific configuration.
      sig { returns(T.nilable(Checkout::SessionCreateParams::WalletOptions)) }
      def wallet_options; end
      sig {
        params(_wallet_options: T.nilable(Checkout::SessionCreateParams::WalletOptions)).returns(T.nilable(Checkout::SessionCreateParams::WalletOptions))
       }
      def wallet_options=(_wallet_options); end
      sig {
        params(adaptive_pricing: T.nilable(Checkout::SessionCreateParams::AdaptivePricing), after_expiration: T.nilable(Checkout::SessionCreateParams::AfterExpiration), allow_promotion_codes: T.nilable(T::Boolean), automatic_tax: T.nilable(Checkout::SessionCreateParams::AutomaticTax), billing_address_collection: T.nilable(String), branding_settings: T.nilable(Checkout::SessionCreateParams::BrandingSettings), cancel_url: T.nilable(String), client_reference_id: T.nilable(String), consent_collection: T.nilable(Checkout::SessionCreateParams::ConsentCollection), currency: T.nilable(String), custom_fields: T.nilable(T::Array[Checkout::SessionCreateParams::CustomField]), custom_text: T.nilable(Checkout::SessionCreateParams::CustomText), customer: T.nilable(String), customer_account: T.nilable(String), customer_creation: T.nilable(String), customer_email: T.nilable(String), customer_update: T.nilable(Checkout::SessionCreateParams::CustomerUpdate), discounts: T.nilable(T::Array[Checkout::SessionCreateParams::Discount]), excluded_payment_method_types: T.nilable(T::Array[String]), expand: T.nilable(T::Array[String]), expires_at: T.nilable(Integer), invoice_creation: T.nilable(Checkout::SessionCreateParams::InvoiceCreation), line_items: T.nilable(T::Array[Checkout::SessionCreateParams::LineItem]), locale: T.nilable(String), metadata: T.nilable(T::Hash[String, String]), mode: T.nilable(String), name_collection: T.nilable(Checkout::SessionCreateParams::NameCollection), optional_items: T.nilable(T::Array[Checkout::SessionCreateParams::OptionalItem]), origin_context: T.nilable(String), payment_intent_data: T.nilable(Checkout::SessionCreateParams::PaymentIntentData), payment_method_collection: T.nilable(String), payment_method_configuration: T.nilable(String), payment_method_data: T.nilable(Checkout::SessionCreateParams::PaymentMethodData), payment_method_options: T.nilable(Checkout::SessionCreateParams::PaymentMethodOptions), payment_method_types: T.nilable(T::Array[String]), permissions: T.nilable(Checkout::SessionCreateParams::Permissions), phone_number_collection: T.nilable(Checkout::SessionCreateParams::PhoneNumberCollection), redirect_on_completion: T.nilable(String), return_url: T.nilable(String), saved_payment_method_options: T.nilable(Checkout::SessionCreateParams::SavedPaymentMethodOptions), setup_intent_data: T.nilable(Checkout::SessionCreateParams::SetupIntentData), shipping_address_collection: T.nilable(Checkout::SessionCreateParams::ShippingAddressCollection), shipping_options: T.nilable(T::Array[Checkout::SessionCreateParams::ShippingOption]), submit_type: T.nilable(String), subscription_data: T.nilable(Checkout::SessionCreateParams::SubscriptionData), success_url: T.nilable(String), tax_id_collection: T.nilable(Checkout::SessionCreateParams::TaxIdCollection), ui_mode: T.nilable(String), wallet_options: T.nilable(Checkout::SessionCreateParams::WalletOptions)).void
       }
      def initialize(
        adaptive_pricing: nil,
        after_expiration: nil,
        allow_promotion_codes: nil,
        automatic_tax: nil,
        billing_address_collection: nil,
        branding_settings: nil,
        cancel_url: nil,
        client_reference_id: nil,
        consent_collection: nil,
        currency: nil,
        custom_fields: nil,
        custom_text: nil,
        customer: nil,
        customer_account: nil,
        customer_creation: nil,
        customer_email: nil,
        customer_update: nil,
        discounts: nil,
        excluded_payment_method_types: nil,
        expand: nil,
        expires_at: nil,
        invoice_creation: nil,
        line_items: nil,
        locale: nil,
        metadata: nil,
        mode: nil,
        name_collection: nil,
        optional_items: nil,
        origin_context: nil,
        payment_intent_data: nil,
        payment_method_collection: nil,
        payment_method_configuration: nil,
        payment_method_data: nil,
        payment_method_options: nil,
        payment_method_types: nil,
        permissions: nil,
        phone_number_collection: nil,
        redirect_on_completion: nil,
        return_url: nil,
        saved_payment_method_options: nil,
        setup_intent_data: nil,
        shipping_address_collection: nil,
        shipping_options: nil,
        submit_type: nil,
        subscription_data: nil,
        success_url: nil,
        tax_id_collection: nil,
        ui_mode: nil,
        wallet_options: nil
      ); end
    end
  end
end