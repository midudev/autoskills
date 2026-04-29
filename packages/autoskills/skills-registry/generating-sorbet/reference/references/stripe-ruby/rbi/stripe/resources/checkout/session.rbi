# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Checkout
    # A Checkout Session represents your customer's session as they pay for
    # one-time purchases or subscriptions through [Checkout](https://docs.stripe.com/payments/checkout)
    # or [Payment Links](https://docs.stripe.com/payments/payment-links). We recommend creating a
    # new Session each time your customer attempts to pay.
    #
    # Once payment is successful, the Checkout Session will contain a reference
    # to the [Customer](https://docs.stripe.com/api/customers), and either the successful
    # [PaymentIntent](https://docs.stripe.com/api/payment_intents) or an active
    # [Subscription](https://docs.stripe.com/api/subscriptions).
    #
    # You can create a Checkout Session on your server and redirect to its URL
    # to begin Checkout.
    #
    # Related guide: [Checkout quickstart](https://docs.stripe.com/checkout/quickstart)
    class Session < APIResource
      class AdaptivePricing < ::Stripe::StripeObject
        # If enabled, Adaptive Pricing is available on [eligible sessions](https://docs.stripe.com/payments/currencies/localize-prices/adaptive-pricing?payment-ui=stripe-hosted#restrictions).
        sig { returns(T::Boolean) }
        def enabled; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class AfterExpiration < ::Stripe::StripeObject
        class Recovery < ::Stripe::StripeObject
          # Enables user redeemable promotion codes on the recovered Checkout Sessions. Defaults to `false`
          sig { returns(T::Boolean) }
          def allow_promotion_codes; end
          # If `true`, a recovery url will be generated to recover this Checkout Session if it
          # expires before a transaction is completed. It will be attached to the
          # Checkout Session object upon expiration.
          sig { returns(T::Boolean) }
          def enabled; end
          # The timestamp at which the recovery URL will expire.
          sig { returns(T.nilable(Integer)) }
          def expires_at; end
          # URL that creates a new Checkout Session when clicked that is a copy of this expired Checkout Session
          sig { returns(T.nilable(String)) }
          def url; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # When set, configuration used to recover the Checkout Session on expiry.
        sig { returns(T.nilable(Recovery)) }
        def recovery; end
        def self.inner_class_types
          @inner_class_types = {recovery: Recovery}
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
        # Indicates whether automatic tax is enabled for the session
        sig { returns(T::Boolean) }
        def enabled; end
        # The account that's liable for tax. If set, the business address and tax registrations required to perform the tax calculation are loaded from this account. The tax transaction is returned in the report of the connected account.
        sig { returns(T.nilable(Liability)) }
        def liability; end
        # The tax provider powering automatic tax.
        sig { returns(T.nilable(String)) }
        def provider; end
        # The status of the most recent automated tax calculation for this session.
        sig { returns(T.nilable(String)) }
        def status; end
        def self.inner_class_types
          @inner_class_types = {liability: Liability}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class BrandingSettings < ::Stripe::StripeObject
        class Icon < ::Stripe::StripeObject
          # The ID of a [File upload](https://stripe.com/docs/api/files) representing the icon. Purpose must be `business_icon`. Required if `type` is `file` and disallowed otherwise.
          sig { returns(T.nilable(String)) }
          def file; end
          # The type of image for the icon. Must be one of `file` or `url`.
          sig { returns(String) }
          def type; end
          # The URL of the image. Present when `type` is `url`.
          sig { returns(T.nilable(String)) }
          def url; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Logo < ::Stripe::StripeObject
          # The ID of a [File upload](https://stripe.com/docs/api/files) representing the logo. Purpose must be `business_logo`. Required if `type` is `file` and disallowed otherwise.
          sig { returns(T.nilable(String)) }
          def file; end
          # The type of image for the logo. Must be one of `file` or `url`.
          sig { returns(String) }
          def type; end
          # The URL of the image. Present when `type` is `url`.
          sig { returns(T.nilable(String)) }
          def url; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # A hex color value starting with `#` representing the background color for the Checkout Session.
        sig { returns(String) }
        def background_color; end
        # The border style for the Checkout Session. Must be one of `rounded`, `rectangular`, or `pill`.
        sig { returns(String) }
        def border_style; end
        # A hex color value starting with `#` representing the button color for the Checkout Session.
        sig { returns(String) }
        def button_color; end
        # The display name shown on the Checkout Session.
        sig { returns(String) }
        def display_name; end
        # The font family for the Checkout Session. Must be one of the [supported font families](https://docs.stripe.com/payments/checkout/customization/appearance?payment-ui=stripe-hosted#font-compatibility).
        sig { returns(String) }
        def font_family; end
        # The icon for the Checkout Session. You cannot set both `logo` and `icon`.
        sig { returns(T.nilable(Icon)) }
        def icon; end
        # The logo for the Checkout Session. You cannot set both `logo` and `icon`.
        sig { returns(T.nilable(Logo)) }
        def logo; end
        def self.inner_class_types
          @inner_class_types = {icon: Icon, logo: Logo}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class CollectedInformation < ::Stripe::StripeObject
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
          sig { returns(Address) }
          def address; end
          # Customer name.
          sig { returns(String) }
          def name; end
          def self.inner_class_types
            @inner_class_types = {address: Address}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Customer’s business name for this Checkout Session
        sig { returns(T.nilable(String)) }
        def business_name; end
        # Customer’s individual name for this Checkout Session
        sig { returns(T.nilable(String)) }
        def individual_name; end
        # Shipping information for this Checkout Session.
        sig { returns(T.nilable(ShippingDetails)) }
        def shipping_details; end
        def self.inner_class_types
          @inner_class_types = {shipping_details: ShippingDetails}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Consent < ::Stripe::StripeObject
        # If `opt_in`, the customer consents to receiving promotional communications
        # from the merchant about this Checkout Session.
        sig { returns(T.nilable(String)) }
        def promotions; end
        # If `accepted`, the customer in this Checkout Session has agreed to the merchant's terms of service.
        sig { returns(T.nilable(String)) }
        def terms_of_service; end
        def self.inner_class_types
          @inner_class_types = {}
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
        # If set to `hidden`, it will hide legal text related to the reuse of a payment method.
        sig { returns(T.nilable(PaymentMethodReuseAgreement)) }
        def payment_method_reuse_agreement; end
        # If set to `auto`, enables the collection of customer consent for promotional communications. The Checkout
        # Session will determine whether to display an option to opt into promotional communication
        # from the merchant depending on the customer's locale. Only available to US merchants.
        sig { returns(T.nilable(String)) }
        def promotions; end
        # If set to `required`, it requires customers to accept the terms of service before being able to pay.
        sig { returns(T.nilable(String)) }
        def terms_of_service; end
        def self.inner_class_types
          @inner_class_types = {payment_method_reuse_agreement: PaymentMethodReuseAgreement}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class CurrencyConversion < ::Stripe::StripeObject
        # Total of all items in source currency before discounts or taxes are applied.
        sig { returns(Integer) }
        def amount_subtotal; end
        # Total of all items in source currency after discounts and taxes are applied.
        sig { returns(Integer) }
        def amount_total; end
        # Exchange rate used to convert source currency amounts to customer currency amounts
        sig { returns(String) }
        def fx_rate; end
        # Creation currency of the CheckoutSession before localization
        sig { returns(String) }
        def source_currency; end
        def self.inner_class_types
          @inner_class_types = {}
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
          # The option selected by the customer. This will be the `value` for the option.
          sig { returns(T.nilable(String)) }
          def value; end
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
          # The value entered by the customer, containing only digits.
          sig { returns(T.nilable(String)) }
          def value; end
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
          # The value entered by the customer.
          sig { returns(T.nilable(String)) }
          def value; end
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
      class CustomerDetails < ::Stripe::StripeObject
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
        class TaxId < ::Stripe::StripeObject
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
        # The customer's address after a completed Checkout Session. Note: This property is populated only for sessions on or after March 30, 2022.
        sig { returns(T.nilable(Address)) }
        def address; end
        # The customer's business name after a completed Checkout Session.
        sig { returns(T.nilable(String)) }
        def business_name; end
        # The email associated with the Customer, if one exists, on the Checkout Session after a completed Checkout Session or at time of session expiry.
        # Otherwise, if the customer has consented to promotional content, this value is the most recent valid email provided by the customer on the Checkout form.
        sig { returns(T.nilable(String)) }
        def email; end
        # The customer's individual name after a completed Checkout Session.
        sig { returns(T.nilable(String)) }
        def individual_name; end
        # The customer's name after a completed Checkout Session. Note: This property is populated only for sessions on or after March 30, 2022.
        sig { returns(T.nilable(String)) }
        def name; end
        # The customer's phone number after a completed Checkout Session.
        sig { returns(T.nilable(String)) }
        def phone; end
        # The customer’s tax exempt status after a completed Checkout Session.
        sig { returns(T.nilable(String)) }
        def tax_exempt; end
        # The customer’s tax IDs after a completed Checkout Session.
        sig { returns(T.nilable(T::Array[TaxId])) }
        def tax_ids; end
        def self.inner_class_types
          @inner_class_types = {address: Address, tax_ids: TaxId}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Discount < ::Stripe::StripeObject
        # Coupon attached to the Checkout Session.
        sig { returns(T.nilable(T.any(String, ::Stripe::Coupon))) }
        def coupon; end
        # Promotion code attached to the Checkout Session.
        sig { returns(T.nilable(T.any(String, ::Stripe::PromotionCode))) }
        def promotion_code; end
        def self.inner_class_types
          @inner_class_types = {}
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
          # Custom fields displayed on the invoice.
          sig { returns(T.nilable(T::Array[CustomField])) }
          def custom_fields; end
          # An arbitrary string attached to the object. Often useful for displaying to users.
          sig { returns(T.nilable(String)) }
          def description; end
          # Footer displayed on the invoice.
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
        # Indicates whether invoice creation is enabled for the Checkout Session.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field invoice_data
        sig { returns(InvoiceData) }
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
          # Indicates whether business name collection is enabled for the session
          sig { returns(T::Boolean) }
          def enabled; end
          # Whether the customer is required to complete the field before completing the Checkout Session. Defaults to `false`.
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
          # Indicates whether individual name collection is enabled for the session
          sig { returns(T::Boolean) }
          def enabled; end
          # Whether the customer is required to complete the field before completing the Checkout Session. Defaults to `false`.
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
          # The maximum quantity of this item the customer can purchase. By default this value is 99. You can specify a value up to 999999.
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
      class PaymentMethodConfigurationDetails < ::Stripe::StripeObject
        # ID of the payment method configuration used.
        sig { returns(String) }
        def id; end
        # ID of the parent payment method configuration used.
        sig { returns(T.nilable(String)) }
        def parent; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class PaymentMethodOptions < ::Stripe::StripeObject
        class AcssDebit < ::Stripe::StripeObject
          class MandateOptions < ::Stripe::StripeObject
            # A URL for custom mandate text
            sig { returns(T.nilable(String)) }
            def custom_mandate_url; end
            # List of Stripe products where this mandate can be selected automatically. Returned when the Session is in `setup` mode.
            sig { returns(T.nilable(T::Array[String])) }
            def default_for; end
            # Description of the interval. Only required if the 'payment_schedule' parameter is 'interval' or 'combined'.
            sig { returns(T.nilable(String)) }
            def interval_description; end
            # Payment schedule for the mandate.
            sig { returns(T.nilable(String)) }
            def payment_schedule; end
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
          # Currency supported by the bank account. Returned when the Session is in `setup` mode.
          sig { returns(T.nilable(String)) }
          def currency; end
          # Attribute for field mandate_options
          sig { returns(T.nilable(MandateOptions)) }
          def mandate_options; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          # Controls when Stripe will attempt to debit the funds from the customer's account. The date must be a string in YYYY-MM-DD format. The date must be in the future and between 3 and 15 calendar days from now.
          sig { returns(T.nilable(String)) }
          def target_date; end
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
        class Affirm < ::Stripe::StripeObject
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class AfterpayClearpay < ::Stripe::StripeObject
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Alipay < ::Stripe::StripeObject
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Alma < ::Stripe::StripeObject
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class AmazonPay < ::Stripe::StripeObject
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class AuBecsDebit < ::Stripe::StripeObject
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          # Controls when Stripe will attempt to debit the funds from the customer's account. The date must be a string in YYYY-MM-DD format. The date must be in the future and between 3 and 15 calendar days from now.
          sig { returns(T.nilable(String)) }
          def target_date; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class BacsDebit < ::Stripe::StripeObject
          class MandateOptions < ::Stripe::StripeObject
            # Prefix used to generate the Mandate reference. Must be at most 12 characters long. Must consist of only uppercase letters, numbers, spaces, or the following special characters: '/', '_', '-', '&', '.'. Cannot begin with 'DDIC' or 'STRIPE'.
            sig { returns(T.nilable(String)) }
            def reference_prefix; end
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
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          # Controls when Stripe will attempt to debit the funds from the customer's account. The date must be a string in YYYY-MM-DD format. The date must be in the future and between 3 and 15 calendar days from now.
          sig { returns(T.nilable(String)) }
          def target_date; end
          def self.inner_class_types
            @inner_class_types = {mandate_options: MandateOptions}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Bancontact < ::Stripe::StripeObject
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Billie < ::Stripe::StripeObject
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Boleto < ::Stripe::StripeObject
          # The number of calendar days before a Boleto voucher expires. For example, if you create a Boleto voucher on Monday and you set expires_after_days to 2, the Boleto voucher will expire on Wednesday at 23:59 America/Sao_Paulo time.
          sig { returns(Integer) }
          def expires_after_days; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Card < ::Stripe::StripeObject
          class Installments < ::Stripe::StripeObject
            # Indicates if installments are enabled
            sig { returns(T.nilable(T::Boolean)) }
            def enabled; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class Restrictions < ::Stripe::StripeObject
            # Specify the card brands to block in the Checkout Session. If a customer enters or selects a card belonging to a blocked brand, they can't complete the Session.
            sig { returns(T.nilable(T::Array[String])) }
            def brands_blocked; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          # Attribute for field installments
          sig { returns(T.nilable(Installments)) }
          def installments; end
          # Request ability to [capture beyond the standard authorization validity window](/payments/extended-authorization) for this CheckoutSession.
          sig { returns(T.nilable(String)) }
          def request_extended_authorization; end
          # Request ability to [increment the authorization](/payments/incremental-authorization) for this CheckoutSession.
          sig { returns(T.nilable(String)) }
          def request_incremental_authorization; end
          # Request ability to make [multiple captures](/payments/multicapture) for this CheckoutSession.
          sig { returns(T.nilable(String)) }
          def request_multicapture; end
          # Request ability to [overcapture](/payments/overcapture) for this CheckoutSession.
          sig { returns(T.nilable(String)) }
          def request_overcapture; end
          # We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and [other requirements](https://docs.stripe.com/strong-customer-authentication). However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. If not provided, this value defaults to `automatic`. Read our guide on [manually requesting 3D Secure](https://docs.stripe.com/payments/3d-secure/authentication-flow#manual-three-ds) for more information on how this configuration interacts with Radar and our SCA Engine.
          sig { returns(String) }
          def request_three_d_secure; end
          # Attribute for field restrictions
          sig { returns(T.nilable(Restrictions)) }
          def restrictions; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          # Provides information about a card payment that customers see on their statements. Concatenated with the Kana prefix (shortened Kana descriptor) or Kana statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters. On card statements, the *concatenation* of both prefix and suffix (including separators) will appear truncated to 22 characters.
          sig { returns(T.nilable(String)) }
          def statement_descriptor_suffix_kana; end
          # Provides information about a card payment that customers see on their statements. Concatenated with the Kanji prefix (shortened Kanji descriptor) or Kanji statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 17 characters. On card statements, the *concatenation* of both prefix and suffix (including separators) will appear truncated to 17 characters.
          sig { returns(T.nilable(String)) }
          def statement_descriptor_suffix_kanji; end
          def self.inner_class_types
            @inner_class_types = {installments: Installments, restrictions: Restrictions}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Cashapp < ::Stripe::StripeObject
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
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
            # List of address types that should be returned in the financial_addresses response. If not specified, all valid types will be returned.
            #
            # Permitted values include: `sort_code`, `zengin`, `iban`, or `spei`.
            sig { returns(T.nilable(T::Array[String])) }
            def requested_address_types; end
            # The bank transfer type that this PaymentIntent is allowed to use for funding Permitted values include: `eu_bank_transfer`, `gb_bank_transfer`, `jp_bank_transfer`, `mx_bank_transfer`, or `us_bank_transfer`.
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
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {bank_transfer: BankTransfer}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Eps < ::Stripe::StripeObject
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Fpx < ::Stripe::StripeObject
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Giropay < ::Stripe::StripeObject
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Grabpay < ::Stripe::StripeObject
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ideal < ::Stripe::StripeObject
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class KakaoPay < ::Stripe::StripeObject
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Klarna < ::Stripe::StripeObject
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Konbini < ::Stripe::StripeObject
          # The number of calendar days (between 1 and 60) after which Konbini payment instructions will expire. For example, if a PaymentIntent is confirmed with Konbini and `expires_after_days` set to 2 on Monday JST, the instructions will expire on Wednesday 23:59:59 JST.
          sig { returns(T.nilable(Integer)) }
          def expires_after_days; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class KrCard < ::Stripe::StripeObject
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Link < ::Stripe::StripeObject
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Mobilepay < ::Stripe::StripeObject
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Multibanco < ::Stripe::StripeObject
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class NaverPay < ::Stripe::StripeObject
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Oxxo < ::Stripe::StripeObject
          # The number of calendar days before an OXXO invoice expires. For example, if you create an OXXO invoice on Monday and you set expires_after_days to 2, the OXXO invoice will expire on Wednesday at 23:59 America/Mexico_City time.
          sig { returns(Integer) }
          def expires_after_days; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class P24 < ::Stripe::StripeObject
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Payco < ::Stripe::StripeObject
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Paynow < ::Stripe::StripeObject
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Paypal < ::Stripe::StripeObject
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          # Preferred locale of the PayPal checkout page that the customer is redirected to.
          sig { returns(T.nilable(String)) }
          def preferred_locale; end
          # A reference of the PayPal transaction visible to customer which is mapped to PayPal's invoice ID. This must be a globally unique ID if you have configured in your PayPal settings to block multiple payments per invoice ID.
          sig { returns(T.nilable(String)) }
          def reference; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Payto < ::Stripe::StripeObject
          class MandateOptions < ::Stripe::StripeObject
            # Amount that will be collected. It is required when `amount_type` is `fixed`.
            sig { returns(T.nilable(Integer)) }
            def amount; end
            # The type of amount that will be collected. The amount charged must be exact or up to the value of `amount` param for `fixed` or `maximum` type respectively. Defaults to `maximum`.
            sig { returns(T.nilable(String)) }
            def amount_type; end
            # Date, in YYYY-MM-DD format, after which payments will not be collected. Defaults to no end date.
            sig { returns(T.nilable(String)) }
            def end_date; end
            # The periodicity at which payments will be collected. Defaults to `adhoc`.
            sig { returns(T.nilable(String)) }
            def payment_schedule; end
            # The number of payments that will be made during a payment period. Defaults to 1 except for when `payment_schedule` is `adhoc`. In that case, it defaults to no limit.
            sig { returns(T.nilable(Integer)) }
            def payments_per_period; end
            # The purpose for which payments are made. Has a default value based on your merchant category code.
            sig { returns(T.nilable(String)) }
            def purpose; end
            # Date, in YYYY-MM-DD format, from which payments will be collected. Defaults to confirmation time.
            sig { returns(T.nilable(String)) }
            def start_date; end
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
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {mandate_options: MandateOptions}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Pix < ::Stripe::StripeObject
          # Determines if the amount includes the IOF tax.
          sig { returns(T.nilable(String)) }
          def amount_includes_iof; end
          # The number of seconds after which Pix payment will expire.
          sig { returns(T.nilable(Integer)) }
          def expires_after_seconds; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class RevolutPay < ::Stripe::StripeObject
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class SamsungPay < ::Stripe::StripeObject
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Satispay < ::Stripe::StripeObject
          # Controls when the funds will be captured from the customer's account.
          sig { returns(T.nilable(String)) }
          def capture_method; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class SepaDebit < ::Stripe::StripeObject
          class MandateOptions < ::Stripe::StripeObject
            # Prefix used to generate the Mandate reference. Must be at most 12 characters long. Must consist of only uppercase letters, numbers, spaces, or the following special characters: '/', '_', '-', '&', '.'. Cannot begin with 'STRIPE'.
            sig { returns(T.nilable(String)) }
            def reference_prefix; end
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
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          # Controls when Stripe will attempt to debit the funds from the customer's account. The date must be a string in YYYY-MM-DD format. The date must be in the future and between 3 and 15 calendar days from now.
          sig { returns(T.nilable(String)) }
          def target_date; end
          def self.inner_class_types
            @inner_class_types = {mandate_options: MandateOptions}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Sofort < ::Stripe::StripeObject
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Swish < ::Stripe::StripeObject
          # The order reference that will be displayed to customers in the Swish application. Defaults to the `id` of the Payment Intent.
          sig { returns(T.nilable(String)) }
          def reference; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Twint < ::Stripe::StripeObject
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
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
            # For webview integrations only. Upon completing OAuth login in the native browser, the user will be redirected to this URL to return to your app.
            sig { returns(T.nilable(String)) }
            def return_url; end
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
          # Indicates that you intend to make future payments with this PaymentIntent's payment method.
          #
          # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
          #
          # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
          #
          # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
          sig { returns(T.nilable(String)) }
          def setup_future_usage; end
          # Controls when Stripe will attempt to debit the funds from the customer's account. The date must be a string in YYYY-MM-DD format. The date must be in the future and between 3 and 15 calendar days from now.
          sig { returns(T.nilable(String)) }
          def target_date; end
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
        # Attribute for field acss_debit
        sig { returns(T.nilable(AcssDebit)) }
        def acss_debit; end
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
        # Attribute for field au_becs_debit
        sig { returns(T.nilable(AuBecsDebit)) }
        def au_becs_debit; end
        # Attribute for field bacs_debit
        sig { returns(T.nilable(BacsDebit)) }
        def bacs_debit; end
        # Attribute for field bancontact
        sig { returns(T.nilable(Bancontact)) }
        def bancontact; end
        # Attribute for field billie
        sig { returns(T.nilable(Billie)) }
        def billie; end
        # Attribute for field boleto
        sig { returns(T.nilable(Boleto)) }
        def boleto; end
        # Attribute for field card
        sig { returns(T.nilable(Card)) }
        def card; end
        # Attribute for field cashapp
        sig { returns(T.nilable(Cashapp)) }
        def cashapp; end
        # Attribute for field customer_balance
        sig { returns(T.nilable(CustomerBalance)) }
        def customer_balance; end
        # Attribute for field eps
        sig { returns(T.nilable(Eps)) }
        def eps; end
        # Attribute for field fpx
        sig { returns(T.nilable(Fpx)) }
        def fpx; end
        # Attribute for field giropay
        sig { returns(T.nilable(Giropay)) }
        def giropay; end
        # Attribute for field grabpay
        sig { returns(T.nilable(Grabpay)) }
        def grabpay; end
        # Attribute for field ideal
        sig { returns(T.nilable(Ideal)) }
        def ideal; end
        # Attribute for field kakao_pay
        sig { returns(T.nilable(KakaoPay)) }
        def kakao_pay; end
        # Attribute for field klarna
        sig { returns(T.nilable(Klarna)) }
        def klarna; end
        # Attribute for field konbini
        sig { returns(T.nilable(Konbini)) }
        def konbini; end
        # Attribute for field kr_card
        sig { returns(T.nilable(KrCard)) }
        def kr_card; end
        # Attribute for field link
        sig { returns(T.nilable(Link)) }
        def link; end
        # Attribute for field mobilepay
        sig { returns(T.nilable(Mobilepay)) }
        def mobilepay; end
        # Attribute for field multibanco
        sig { returns(T.nilable(Multibanco)) }
        def multibanco; end
        # Attribute for field naver_pay
        sig { returns(T.nilable(NaverPay)) }
        def naver_pay; end
        # Attribute for field oxxo
        sig { returns(T.nilable(Oxxo)) }
        def oxxo; end
        # Attribute for field p24
        sig { returns(T.nilable(P24)) }
        def p24; end
        # Attribute for field payco
        sig { returns(T.nilable(Payco)) }
        def payco; end
        # Attribute for field paynow
        sig { returns(T.nilable(Paynow)) }
        def paynow; end
        # Attribute for field paypal
        sig { returns(T.nilable(Paypal)) }
        def paypal; end
        # Attribute for field payto
        sig { returns(T.nilable(Payto)) }
        def payto; end
        # Attribute for field pix
        sig { returns(T.nilable(Pix)) }
        def pix; end
        # Attribute for field revolut_pay
        sig { returns(T.nilable(RevolutPay)) }
        def revolut_pay; end
        # Attribute for field samsung_pay
        sig { returns(T.nilable(SamsungPay)) }
        def samsung_pay; end
        # Attribute for field satispay
        sig { returns(T.nilable(Satispay)) }
        def satispay; end
        # Attribute for field sepa_debit
        sig { returns(T.nilable(SepaDebit)) }
        def sepa_debit; end
        # Attribute for field sofort
        sig { returns(T.nilable(Sofort)) }
        def sofort; end
        # Attribute for field swish
        sig { returns(T.nilable(Swish)) }
        def swish; end
        # Attribute for field twint
        sig { returns(T.nilable(Twint)) }
        def twint; end
        # Attribute for field us_bank_account
        sig { returns(T.nilable(UsBankAccount)) }
        def us_bank_account; end
        def self.inner_class_types
          @inner_class_types = {
            acss_debit: AcssDebit,
            affirm: Affirm,
            afterpay_clearpay: AfterpayClearpay,
            alipay: Alipay,
            alma: Alma,
            amazon_pay: AmazonPay,
            au_becs_debit: AuBecsDebit,
            bacs_debit: BacsDebit,
            bancontact: Bancontact,
            billie: Billie,
            boleto: Boleto,
            card: Card,
            cashapp: Cashapp,
            customer_balance: CustomerBalance,
            eps: Eps,
            fpx: Fpx,
            giropay: Giropay,
            grabpay: Grabpay,
            ideal: Ideal,
            kakao_pay: KakaoPay,
            klarna: Klarna,
            konbini: Konbini,
            kr_card: KrCard,
            link: Link,
            mobilepay: Mobilepay,
            multibanco: Multibanco,
            naver_pay: NaverPay,
            oxxo: Oxxo,
            p24: P24,
            payco: Payco,
            paynow: Paynow,
            paypal: Paypal,
            payto: Payto,
            pix: Pix,
            revolut_pay: RevolutPay,
            samsung_pay: SamsungPay,
            satispay: Satispay,
            sepa_debit: SepaDebit,
            sofort: Sofort,
            swish: Swish,
            twint: Twint,
            us_bank_account: UsBankAccount,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Permissions < ::Stripe::StripeObject
        # Determines which entity is allowed to update the shipping details.
        #
        # Default is `client_only`. Stripe Checkout client will automatically update the shipping details. If set to `server_only`, only your server is allowed to update the shipping details.
        #
        # When set to `server_only`, you must add the onShippingDetailsChange event handler when initializing the Stripe Checkout client and manually update the shipping details from your server using the Stripe API.
        sig { returns(T.nilable(String)) }
        def update_shipping_details; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class PhoneNumberCollection < ::Stripe::StripeObject
        # Indicates whether phone number collection is enabled for the session
        sig { returns(T::Boolean) }
        def enabled; end
        def self.inner_class_types
          @inner_class_types = {}
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
      class SavedPaymentMethodOptions < ::Stripe::StripeObject
        # Uses the `allow_redisplay` value of each saved payment method to filter the set presented to a returning customer. By default, only saved payment methods with ’allow_redisplay: ‘always’ are shown in Checkout.
        sig { returns(T.nilable(T::Array[String])) }
        def allow_redisplay_filters; end
        # Enable customers to choose if they wish to remove their saved payment methods. Disabled by default.
        sig { returns(T.nilable(String)) }
        def payment_method_remove; end
        # Enable customers to choose if they wish to save their payment method for future use. Disabled by default.
        sig { returns(T.nilable(String)) }
        def payment_method_save; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class ShippingAddressCollection < ::Stripe::StripeObject
        # An array of two-letter ISO country codes representing which countries Checkout should provide as options for
        # shipping locations. Unsupported country codes: `AS, CX, CC, CU, HM, IR, KP, MH, FM, NF, MP, PW, SY, UM, VI`.
        sig { returns(T::Array[String]) }
        def allowed_countries; end
        def self.inner_class_types
          @inner_class_types = {}
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
        # Total shipping cost before any discounts or taxes are applied.
        sig { returns(Integer) }
        def amount_subtotal; end
        # Total tax amount applied due to shipping costs. If no tax was applied, defaults to 0.
        sig { returns(Integer) }
        def amount_tax; end
        # Total shipping cost after discounts and taxes are applied.
        sig { returns(Integer) }
        def amount_total; end
        # The ID of the ShippingRate for this order.
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
      class ShippingOption < ::Stripe::StripeObject
        # A non-negative integer in cents representing how much to charge.
        sig { returns(Integer) }
        def shipping_amount; end
        # The shipping rate.
        sig { returns(T.any(String, ::Stripe::ShippingRate)) }
        def shipping_rate; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class TaxIdCollection < ::Stripe::StripeObject
        # Indicates whether tax ID collection is enabled for the session
        sig { returns(T::Boolean) }
        def enabled; end
        # Indicates whether a tax ID is required on the payment page
        sig { returns(String) }
        def required; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class TotalDetails < ::Stripe::StripeObject
        class Breakdown < ::Stripe::StripeObject
          class Discount < ::Stripe::StripeObject
            # The amount discounted.
            sig { returns(Integer) }
            def amount; end
            # A discount represents the actual application of a [coupon](https://api.stripe.com#coupons) or [promotion code](https://api.stripe.com#promotion_codes).
            # It contains information about when the discount began, when it will end, and what it is applied to.
            #
            # Related guide: [Applying discounts to subscriptions](https://docs.stripe.com/billing/subscriptions/discounts)
            sig { returns(::Stripe::Discount) }
            def discount; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
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
          # The aggregated discounts.
          sig { returns(T::Array[Discount]) }
          def discounts; end
          # The aggregated tax amounts by rate.
          sig { returns(T::Array[Tax]) }
          def taxes; end
          def self.inner_class_types
            @inner_class_types = {discounts: Discount, taxes: Tax}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # This is the sum of all the discounts.
        sig { returns(Integer) }
        def amount_discount; end
        # This is the sum of all the shipping amounts.
        sig { returns(T.nilable(Integer)) }
        def amount_shipping; end
        # This is the sum of all the tax amounts.
        sig { returns(Integer) }
        def amount_tax; end
        # Attribute for field breakdown
        sig { returns(T.nilable(Breakdown)) }
        def breakdown; end
        def self.inner_class_types
          @inner_class_types = {breakdown: Breakdown}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class WalletOptions < ::Stripe::StripeObject
        class Link < ::Stripe::StripeObject
          # Describes whether Checkout should display Link. Defaults to `auto`.
          sig { returns(T.nilable(String)) }
          def display; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field link
        sig { returns(T.nilable(Link)) }
        def link; end
        def self.inner_class_types
          @inner_class_types = {link: Link}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Settings for price localization with [Adaptive Pricing](https://docs.stripe.com/payments/checkout/adaptive-pricing).
      sig { returns(T.nilable(AdaptivePricing)) }
      def adaptive_pricing; end
      # When set, provides configuration for actions to take if this Checkout Session expires.
      sig { returns(T.nilable(AfterExpiration)) }
      def after_expiration; end
      # Enables user redeemable promotion codes.
      sig { returns(T.nilable(T::Boolean)) }
      def allow_promotion_codes; end
      # Total of all items before discounts or taxes are applied.
      sig { returns(T.nilable(Integer)) }
      def amount_subtotal; end
      # Total of all items after discounts and taxes are applied.
      sig { returns(T.nilable(Integer)) }
      def amount_total; end
      # Attribute for field automatic_tax
      sig { returns(AutomaticTax) }
      def automatic_tax; end
      # Describes whether Checkout should collect the customer's billing address. Defaults to `auto`.
      sig { returns(T.nilable(String)) }
      def billing_address_collection; end
      # Attribute for field branding_settings
      sig { returns(T.nilable(BrandingSettings)) }
      def branding_settings; end
      # If set, Checkout displays a back button and customers will be directed to this URL if they decide to cancel payment and return to your website.
      sig { returns(T.nilable(String)) }
      def cancel_url; end
      # A unique string to reference the Checkout Session. This can be a
      # customer ID, a cart ID, or similar, and can be used to reconcile the
      # Session with your internal systems.
      sig { returns(T.nilable(String)) }
      def client_reference_id; end
      # The client secret of your Checkout Session. Applies to Checkout Sessions with `ui_mode: embedded` or `ui_mode: custom`. For `ui_mode: embedded`, the client secret is to be used when initializing Stripe.js embedded checkout.
      #  For `ui_mode: custom`, use the client secret with [initCheckout](https://docs.stripe.com/js/custom_checkout/init) on your front end.
      sig { returns(T.nilable(String)) }
      def client_secret; end
      # Information about the customer collected within the Checkout Session.
      sig { returns(T.nilable(CollectedInformation)) }
      def collected_information; end
      # Results of `consent_collection` for this session.
      sig { returns(T.nilable(Consent)) }
      def consent; end
      # When set, provides configuration for the Checkout Session to gather active consent from customers.
      sig { returns(T.nilable(ConsentCollection)) }
      def consent_collection; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(T.nilable(String)) }
      def currency; end
      # Currency conversion details for [Adaptive Pricing](https://docs.stripe.com/payments/checkout/adaptive-pricing) sessions created before 2025-03-31.
      sig { returns(T.nilable(CurrencyConversion)) }
      def currency_conversion; end
      # Collect additional information from your customer using custom fields. Up to 3 fields are supported.
      sig { returns(T::Array[CustomField]) }
      def custom_fields; end
      # Attribute for field custom_text
      sig { returns(CustomText) }
      def custom_text; end
      # The ID of the customer for this Session.
      # For Checkout Sessions in `subscription` mode or Checkout Sessions with `customer_creation` set as `always` in `payment` mode, Checkout
      # will create a new customer object based on information provided
      # during the payment flow unless an existing customer was provided when
      # the Session was created.
      sig { returns(T.nilable(T.any(String, ::Stripe::Customer))) }
      def customer; end
      # The ID of the account for this Session.
      sig { returns(T.nilable(String)) }
      def customer_account; end
      # Configure whether a Checkout Session creates a Customer when the Checkout Session completes.
      sig { returns(T.nilable(String)) }
      def customer_creation; end
      # The customer details including the customer's tax exempt status and the customer's tax IDs. Customer's address details are not present on Sessions in `setup` mode.
      sig { returns(T.nilable(CustomerDetails)) }
      def customer_details; end
      # If provided, this value will be used when the Customer object is created.
      # If not provided, customers will be asked to enter their email address.
      # Use this parameter to prefill customer data if you already have an email
      # on file. To access information about the customer once the payment flow is
      # complete, use the `customer` attribute.
      sig { returns(T.nilable(String)) }
      def customer_email; end
      # List of coupons and promotion codes attached to the Checkout Session.
      sig { returns(T.nilable(T::Array[Discount])) }
      def discounts; end
      # A list of the types of payment methods (e.g., `card`) that should be excluded from this Checkout Session. This should only be used when payment methods for this Checkout Session are managed through the [Stripe Dashboard](https://dashboard.stripe.com/settings/payment_methods).
      sig { returns(T.nilable(T::Array[String])) }
      def excluded_payment_method_types; end
      # The timestamp at which the Checkout Session will expire.
      sig { returns(Integer) }
      def expires_at; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # ID of the invoice created by the Checkout Session, if it exists.
      sig { returns(T.nilable(T.any(String, ::Stripe::Invoice))) }
      def invoice; end
      # Details on the state of invoice creation for the Checkout Session.
      sig { returns(T.nilable(InvoiceCreation)) }
      def invoice_creation; end
      # The line items purchased by the customer.
      sig { returns(T.nilable(::Stripe::ListObject)) }
      def line_items; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # The IETF language tag of the locale Checkout is displayed in. If blank or `auto`, the browser's locale is used.
      sig { returns(T.nilable(String)) }
      def locale; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      # The mode of the Checkout Session.
      sig { returns(String) }
      def mode; end
      # Attribute for field name_collection
      sig { returns(T.nilable(NameCollection)) }
      def name_collection; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The optional items presented to the customer at checkout.
      sig { returns(T.nilable(T::Array[OptionalItem])) }
      def optional_items; end
      # Where the user is coming from. This informs the optimizations that are applied to the session.
      sig { returns(T.nilable(String)) }
      def origin_context; end
      # The ID of the PaymentIntent for Checkout Sessions in `payment` mode. You can't confirm or cancel the PaymentIntent for a Checkout Session. To cancel, [expire the Checkout Session](https://docs.stripe.com/api/checkout/sessions/expire) instead.
      sig { returns(T.nilable(T.any(String, ::Stripe::PaymentIntent))) }
      def payment_intent; end
      # The ID of the Payment Link that created this Session.
      sig { returns(T.nilable(T.any(String, ::Stripe::PaymentLink))) }
      def payment_link; end
      # Configure whether a Checkout Session should collect a payment method. Defaults to `always`.
      sig { returns(T.nilable(String)) }
      def payment_method_collection; end
      # Information about the payment method configuration used for this Checkout session if using dynamic payment methods.
      sig { returns(T.nilable(PaymentMethodConfigurationDetails)) }
      def payment_method_configuration_details; end
      # Payment-method-specific configuration for the PaymentIntent or SetupIntent of this CheckoutSession.
      sig { returns(T.nilable(PaymentMethodOptions)) }
      def payment_method_options; end
      # A list of the types of payment methods (e.g. card) this Checkout
      # Session is allowed to accept.
      sig { returns(T::Array[String]) }
      def payment_method_types; end
      # The payment status of the Checkout Session, one of `paid`, `unpaid`, or `no_payment_required`.
      # You can use this value to decide when to fulfill your customer's order.
      sig { returns(String) }
      def payment_status; end
      # This property is used to set up permissions for various actions (e.g., update) on the CheckoutSession object.
      #
      # For specific permissions, please refer to their dedicated subsections, such as `permissions.update_shipping_details`.
      sig { returns(T.nilable(Permissions)) }
      def permissions; end
      # Attribute for field phone_number_collection
      sig { returns(T.nilable(PhoneNumberCollection)) }
      def phone_number_collection; end
      # Attribute for field presentment_details
      sig { returns(T.nilable(PresentmentDetails)) }
      def presentment_details; end
      # The ID of the original expired Checkout Session that triggered the recovery flow.
      sig { returns(T.nilable(String)) }
      def recovered_from; end
      # This parameter applies to `ui_mode: embedded`. Learn more about the [redirect behavior](https://docs.stripe.com/payments/checkout/custom-success-page?payment-ui=embedded-form) of embedded sessions. Defaults to `always`.
      sig { returns(T.nilable(String)) }
      def redirect_on_completion; end
      # Applies to Checkout Sessions with `ui_mode: embedded` or `ui_mode: custom`. The URL to redirect your customer back to after they authenticate or cancel their payment on the payment method's app or site.
      sig { returns(T.nilable(String)) }
      def return_url; end
      # Controls saved payment method settings for the session. Only available in `payment` and `subscription` mode.
      sig { returns(T.nilable(SavedPaymentMethodOptions)) }
      def saved_payment_method_options; end
      # The ID of the SetupIntent for Checkout Sessions in `setup` mode. You can't confirm or cancel the SetupIntent for a Checkout Session. To cancel, [expire the Checkout Session](https://docs.stripe.com/api/checkout/sessions/expire) instead.
      sig { returns(T.nilable(T.any(String, ::Stripe::SetupIntent))) }
      def setup_intent; end
      # When set, provides configuration for Checkout to collect a shipping address from a customer.
      sig { returns(T.nilable(ShippingAddressCollection)) }
      def shipping_address_collection; end
      # The details of the customer cost of shipping, including the customer chosen ShippingRate.
      sig { returns(T.nilable(ShippingCost)) }
      def shipping_cost; end
      # The shipping rate options applied to this Session.
      sig { returns(T::Array[ShippingOption]) }
      def shipping_options; end
      # The status of the Checkout Session, one of `open`, `complete`, or `expired`.
      sig { returns(T.nilable(String)) }
      def status; end
      # Describes the type of transaction being performed by Checkout in order to customize
      # relevant text on the page, such as the submit button. `submit_type` can only be
      # specified on Checkout Sessions in `payment` mode. If blank or `auto`, `pay` is used.
      sig { returns(T.nilable(String)) }
      def submit_type; end
      # The ID of the [Subscription](https://docs.stripe.com/api/subscriptions) for Checkout Sessions in `subscription` mode.
      sig { returns(T.nilable(T.any(String, ::Stripe::Subscription))) }
      def subscription; end
      # The URL the customer will be directed to after the payment or
      # subscription creation is successful.
      sig { returns(T.nilable(String)) }
      def success_url; end
      # Attribute for field tax_id_collection
      sig { returns(T.nilable(TaxIdCollection)) }
      def tax_id_collection; end
      # Tax and discount details for the computed total amount.
      sig { returns(T.nilable(TotalDetails)) }
      def total_details; end
      # The UI mode of the Session. Defaults to `hosted`.
      sig { returns(T.nilable(String)) }
      def ui_mode; end
      # The URL to the Checkout Session. Applies to Checkout Sessions with `ui_mode: hosted`. Redirect customers to this URL to take them to Checkout. If you’re using [Custom Domains](https://docs.stripe.com/payments/checkout/custom-domains), the URL will use your subdomain. Otherwise, it’ll use `checkout.stripe.com.`
      # This value is only present when the session is active.
      sig { returns(T.nilable(String)) }
      def url; end
      # Wallet-specific configuration for this Checkout Session.
      sig { returns(T.nilable(WalletOptions)) }
      def wallet_options; end
      # Creates a Checkout Session object.
      sig {
        params(params: T.any(::Stripe::Checkout::SessionCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Checkout::Session)
       }
      def self.create(params = {}, opts = {}); end

      # A Checkout Session can be expired when it is in one of these statuses: open
      #
      # After it expires, a customer can't complete a Checkout Session and customers loading the Checkout Session see a message saying the Checkout Session is expired.
      sig {
        params(params: T.any(::Stripe::Checkout::SessionExpireParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Checkout::Session)
       }
      def expire(params = {}, opts = {}); end

      # A Checkout Session can be expired when it is in one of these statuses: open
      #
      # After it expires, a customer can't complete a Checkout Session and customers loading the Checkout Session see a message saying the Checkout Session is expired.
      sig {
        params(session: String, params: T.any(::Stripe::Checkout::SessionExpireParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Checkout::Session)
       }
      def self.expire(session, params = {}, opts = {}); end

      # Returns a list of Checkout Sessions.
      sig {
        params(params: T.any(::Stripe::Checkout::SessionListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # When retrieving a Checkout Session, there is an includable line_items property containing the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
      sig {
        params(params: T.any(::Stripe::Checkout::SessionListLineItemsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list_line_items(params = {}, opts = {}); end

      # When retrieving a Checkout Session, there is an includable line_items property containing the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
      sig {
        params(session: String, params: T.any(::Stripe::Checkout::SessionListLineItemsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list_line_items(session, params = {}, opts = {}); end

      # Updates a Checkout Session object.
      #
      # Related guide: [Dynamically update Checkout](https://docs.stripe.com/payments/checkout/dynamic-updates)
      sig {
        params(session: String, params: T.any(::Stripe::Checkout::SessionUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Checkout::Session)
       }
      def self.update(session, params = {}, opts = {}); end
    end
  end
end