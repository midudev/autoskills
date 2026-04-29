# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class InvoiceCreatePreviewParams < ::Stripe::RequestParams
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
      # Whether Stripe automatically computes tax on this invoice. Note that incompatible invoice items (invoice items with manually specified [tax rates](https://docs.stripe.com/api/tax_rates), negative amounts, or `tax_behavior=unspecified`) cannot be added to automatic tax invoices.
      sig { returns(T::Boolean) }
      def enabled; end
      sig { params(_enabled: T::Boolean).returns(T::Boolean) }
      def enabled=(_enabled); end
      # The account that's liable for tax. If set, the business address and tax registrations required to perform the tax calculation are loaded from this account. The tax transaction is returned in the report of the connected account.
      sig { returns(T.nilable(InvoiceCreatePreviewParams::AutomaticTax::Liability)) }
      def liability; end
      sig {
        params(_liability: T.nilable(InvoiceCreatePreviewParams::AutomaticTax::Liability)).returns(T.nilable(InvoiceCreatePreviewParams::AutomaticTax::Liability))
       }
      def liability=(_liability); end
      sig {
        params(enabled: T::Boolean, liability: T.nilable(InvoiceCreatePreviewParams::AutomaticTax::Liability)).void
       }
      def initialize(enabled: nil, liability: nil); end
    end
    class CustomerDetails < ::Stripe::RequestParams
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
        sig { returns(T.nilable(String)) }
        def line1; end
        sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
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
          params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String)).void
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
      class Shipping < ::Stripe::RequestParams
        class Address < ::Stripe::RequestParams
          # City, district, suburb, town, or village.
          sig { returns(T.nilable(String)) }
          def city; end
          sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
          def city=(_city); end
          # A freeform text field for the country. However, in order to activate some tax features, the format should be a two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(T.nilable(String)) }
          def country; end
          sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
          def country=(_country); end
          # Address line 1, such as the street, PO Box, or company name.
          sig { returns(T.nilable(String)) }
          def line1; end
          sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
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
            params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String)).void
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
        # Customer shipping address.
        sig { returns(InvoiceCreatePreviewParams::CustomerDetails::Shipping::Address) }
        def address; end
        sig {
          params(_address: InvoiceCreatePreviewParams::CustomerDetails::Shipping::Address).returns(InvoiceCreatePreviewParams::CustomerDetails::Shipping::Address)
         }
        def address=(_address); end
        # Customer name.
        sig { returns(String) }
        def name; end
        sig { params(_name: String).returns(String) }
        def name=(_name); end
        # Customer phone (including extension).
        sig { returns(T.nilable(String)) }
        def phone; end
        sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
        def phone=(_phone); end
        sig {
          params(address: InvoiceCreatePreviewParams::CustomerDetails::Shipping::Address, name: String, phone: T.nilable(String)).void
         }
        def initialize(address: nil, name: nil, phone: nil); end
      end
      class Tax < ::Stripe::RequestParams
        # A recent IP address of the customer used for tax reporting and tax location inference. Stripe recommends updating the IP address when a new PaymentMethod is attached or the address field on the customer is updated. We recommend against updating this field more frequently since it could result in unexpected tax location/reporting outcomes.
        sig { returns(T.nilable(String)) }
        def ip_address; end
        sig { params(_ip_address: T.nilable(String)).returns(T.nilable(String)) }
        def ip_address=(_ip_address); end
        sig { params(ip_address: T.nilable(String)).void }
        def initialize(ip_address: nil); end
      end
      class TaxId < ::Stripe::RequestParams
        # Type of the tax ID, one of `ad_nrt`, `ae_trn`, `al_tin`, `am_tin`, `ao_tin`, `ar_cuit`, `au_abn`, `au_arn`, `aw_tin`, `az_tin`, `ba_tin`, `bb_tin`, `bd_bin`, `bf_ifu`, `bg_uic`, `bh_vat`, `bj_ifu`, `bo_tin`, `br_cnpj`, `br_cpf`, `bs_tin`, `by_tin`, `ca_bn`, `ca_gst_hst`, `ca_pst_bc`, `ca_pst_mb`, `ca_pst_sk`, `ca_qst`, `cd_nif`, `ch_uid`, `ch_vat`, `cl_tin`, `cm_niu`, `cn_tin`, `co_nit`, `cr_tin`, `cv_nif`, `de_stn`, `do_rcn`, `ec_ruc`, `eg_tin`, `es_cif`, `et_tin`, `eu_oss_vat`, `eu_vat`, `gb_vat`, `ge_vat`, `gn_nif`, `hk_br`, `hr_oib`, `hu_tin`, `id_npwp`, `il_vat`, `in_gst`, `is_vat`, `jp_cn`, `jp_rn`, `jp_trn`, `ke_pin`, `kg_tin`, `kh_tin`, `kr_brn`, `kz_bin`, `la_tin`, `li_uid`, `li_vat`, `ma_vat`, `md_vat`, `me_pib`, `mk_vat`, `mr_nif`, `mx_rfc`, `my_frp`, `my_itn`, `my_sst`, `ng_tin`, `no_vat`, `no_voec`, `np_pan`, `nz_gst`, `om_vat`, `pe_ruc`, `ph_tin`, `ro_tin`, `rs_pib`, `ru_inn`, `ru_kpp`, `sa_vat`, `sg_gst`, `sg_uen`, `si_tin`, `sn_ninea`, `sr_fin`, `sv_nit`, `th_vat`, `tj_tin`, `tr_tin`, `tw_vat`, `tz_vat`, `ua_vat`, `ug_tin`, `us_ein`, `uy_ruc`, `uz_tin`, `uz_vat`, `ve_rif`, `vn_tin`, `za_vat`, `zm_tin`, or `zw_tin`
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        # Value of the tax ID.
        sig { returns(String) }
        def value; end
        sig { params(_value: String).returns(String) }
        def value=(_value); end
        sig { params(type: String, value: String).void }
        def initialize(type: nil, value: nil); end
      end
      # The customer's address. Learn about [country-specific requirements for calculating tax](/invoicing/taxes?dashboard-or-api=dashboard#set-up-customer).
      sig {
        returns(T.nilable(T.any(String, InvoiceCreatePreviewParams::CustomerDetails::Address)))
       }
      def address; end
      sig {
        params(_address: T.nilable(T.any(String, InvoiceCreatePreviewParams::CustomerDetails::Address))).returns(T.nilable(T.any(String, InvoiceCreatePreviewParams::CustomerDetails::Address)))
       }
      def address=(_address); end
      # The customer's shipping information. Appears on invoices emailed to this customer.
      sig {
        returns(T.nilable(T.any(String, InvoiceCreatePreviewParams::CustomerDetails::Shipping)))
       }
      def shipping; end
      sig {
        params(_shipping: T.nilable(T.any(String, InvoiceCreatePreviewParams::CustomerDetails::Shipping))).returns(T.nilable(T.any(String, InvoiceCreatePreviewParams::CustomerDetails::Shipping)))
       }
      def shipping=(_shipping); end
      # Tax details about the customer.
      sig { returns(T.nilable(InvoiceCreatePreviewParams::CustomerDetails::Tax)) }
      def tax; end
      sig {
        params(_tax: T.nilable(InvoiceCreatePreviewParams::CustomerDetails::Tax)).returns(T.nilable(InvoiceCreatePreviewParams::CustomerDetails::Tax))
       }
      def tax=(_tax); end
      # The customer's tax exemption. One of `none`, `exempt`, or `reverse`.
      sig { returns(T.nilable(T.any(String, String))) }
      def tax_exempt; end
      sig {
        params(_tax_exempt: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
       }
      def tax_exempt=(_tax_exempt); end
      # The customer's tax IDs.
      sig { returns(T.nilable(T::Array[InvoiceCreatePreviewParams::CustomerDetails::TaxId])) }
      def tax_ids; end
      sig {
        params(_tax_ids: T.nilable(T::Array[InvoiceCreatePreviewParams::CustomerDetails::TaxId])).returns(T.nilable(T::Array[InvoiceCreatePreviewParams::CustomerDetails::TaxId]))
       }
      def tax_ids=(_tax_ids); end
      sig {
        params(address: T.nilable(T.any(String, InvoiceCreatePreviewParams::CustomerDetails::Address)), shipping: T.nilable(T.any(String, InvoiceCreatePreviewParams::CustomerDetails::Shipping)), tax: T.nilable(InvoiceCreatePreviewParams::CustomerDetails::Tax), tax_exempt: T.nilable(T.any(String, String)), tax_ids: T.nilable(T::Array[InvoiceCreatePreviewParams::CustomerDetails::TaxId])).void
       }
      def initialize(address: nil, shipping: nil, tax: nil, tax_exempt: nil, tax_ids: nil); end
    end
    class Discount < ::Stripe::RequestParams
      # ID of the coupon to create a new discount for.
      sig { returns(T.nilable(String)) }
      def coupon; end
      sig { params(_coupon: T.nilable(String)).returns(T.nilable(String)) }
      def coupon=(_coupon); end
      # ID of an existing discount on the object (or one of its ancestors) to reuse.
      sig { returns(T.nilable(String)) }
      def discount; end
      sig { params(_discount: T.nilable(String)).returns(T.nilable(String)) }
      def discount=(_discount); end
      # ID of the promotion code to create a new discount for.
      sig { returns(T.nilable(String)) }
      def promotion_code; end
      sig { params(_promotion_code: T.nilable(String)).returns(T.nilable(String)) }
      def promotion_code=(_promotion_code); end
      sig {
        params(coupon: T.nilable(String), discount: T.nilable(String), promotion_code: T.nilable(String)).void
       }
      def initialize(coupon: nil, discount: nil, promotion_code: nil); end
    end
    class InvoiceItem < ::Stripe::RequestParams
      class Discount < ::Stripe::RequestParams
        # ID of the coupon to create a new discount for.
        sig { returns(T.nilable(String)) }
        def coupon; end
        sig { params(_coupon: T.nilable(String)).returns(T.nilable(String)) }
        def coupon=(_coupon); end
        # ID of an existing discount on the object (or one of its ancestors) to reuse.
        sig { returns(T.nilable(String)) }
        def discount; end
        sig { params(_discount: T.nilable(String)).returns(T.nilable(String)) }
        def discount=(_discount); end
        # ID of the promotion code to create a new discount for.
        sig { returns(T.nilable(String)) }
        def promotion_code; end
        sig { params(_promotion_code: T.nilable(String)).returns(T.nilable(String)) }
        def promotion_code=(_promotion_code); end
        sig {
          params(coupon: T.nilable(String), discount: T.nilable(String), promotion_code: T.nilable(String)).void
         }
        def initialize(coupon: nil, discount: nil, promotion_code: nil); end
      end
      class Period < ::Stripe::RequestParams
        # The end of the period, which must be greater than or equal to the start. This value is inclusive.
        sig { returns(Integer) }
        def end; end
        sig { params(_end: Integer).returns(Integer) }
        def end=(_end); end
        # The start of the period. This value is inclusive.
        sig { returns(Integer) }
        def start; end
        sig { params(_start: Integer).returns(Integer) }
        def start=(_start); end
        sig { params(end_: Integer, start: Integer).void }
        def initialize(end_: nil, start: nil); end
      end
      class PriceData < ::Stripe::RequestParams
        # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
        sig { returns(String) }
        def currency; end
        sig { params(_currency: String).returns(String) }
        def currency=(_currency); end
        # The ID of the [Product](https://docs.stripe.com/api/products) that this [Price](https://docs.stripe.com/api/prices) will belong to.
        sig { returns(String) }
        def product; end
        sig { params(_product: String).returns(String) }
        def product=(_product); end
        # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
        sig { returns(T.nilable(String)) }
        def tax_behavior; end
        sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
        def tax_behavior=(_tax_behavior); end
        # A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge.
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
          params(currency: String, product: String, tax_behavior: T.nilable(String), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String)).void
         }
        def initialize(
          currency: nil,
          product: nil,
          tax_behavior: nil,
          unit_amount: nil,
          unit_amount_decimal: nil
        ); end
      end
      # The integer amount in cents (or local equivalent) of previewed invoice item.
      sig { returns(T.nilable(Integer)) }
      def amount; end
      sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def amount=(_amount); end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies). Only applicable to new invoice items.
      sig { returns(T.nilable(String)) }
      def currency; end
      sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
      def currency=(_currency); end
      # An arbitrary string which you can attach to the invoice item. The description is displayed in the invoice for easy tracking.
      sig { returns(T.nilable(String)) }
      def description; end
      sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
      def description=(_description); end
      # Explicitly controls whether discounts apply to this invoice item. Defaults to true, except for negative invoice items.
      sig { returns(T.nilable(T::Boolean)) }
      def discountable; end
      sig { params(_discountable: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def discountable=(_discountable); end
      # The coupons to redeem into discounts for the invoice item in the preview.
      sig {
        returns(T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::InvoiceItem::Discount])))
       }
      def discounts; end
      sig {
        params(_discounts: T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::InvoiceItem::Discount]))).returns(T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::InvoiceItem::Discount])))
       }
      def discounts=(_discounts); end
      # The ID of the invoice item to update in preview. If not specified, a new invoice item will be added to the preview of the upcoming invoice.
      sig { returns(T.nilable(String)) }
      def invoiceitem; end
      sig { params(_invoiceitem: T.nilable(String)).returns(T.nilable(String)) }
      def invoiceitem=(_invoiceitem); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
       }
      def metadata=(_metadata); end
      # The period associated with this invoice item. When set to different values, the period will be rendered on the invoice. If you have [Stripe Revenue Recognition](https://docs.stripe.com/revenue-recognition) enabled, the period will be used to recognize and defer revenue. See the [Revenue Recognition documentation](https://docs.stripe.com/revenue-recognition/methodology/subscriptions-and-invoicing) for details.
      sig { returns(T.nilable(InvoiceCreatePreviewParams::InvoiceItem::Period)) }
      def period; end
      sig {
        params(_period: T.nilable(InvoiceCreatePreviewParams::InvoiceItem::Period)).returns(T.nilable(InvoiceCreatePreviewParams::InvoiceItem::Period))
       }
      def period=(_period); end
      # The ID of the price object. One of `price` or `price_data` is required.
      sig { returns(T.nilable(String)) }
      def price; end
      sig { params(_price: T.nilable(String)).returns(T.nilable(String)) }
      def price=(_price); end
      # Data used to generate a new [Price](https://docs.stripe.com/api/prices) object inline. One of `price` or `price_data` is required.
      sig { returns(T.nilable(InvoiceCreatePreviewParams::InvoiceItem::PriceData)) }
      def price_data; end
      sig {
        params(_price_data: T.nilable(InvoiceCreatePreviewParams::InvoiceItem::PriceData)).returns(T.nilable(InvoiceCreatePreviewParams::InvoiceItem::PriceData))
       }
      def price_data=(_price_data); end
      # Non-negative integer. The quantity of units for the invoice item.
      sig { returns(T.nilable(Integer)) }
      def quantity; end
      sig { params(_quantity: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def quantity=(_quantity); end
      # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
      sig { returns(T.nilable(String)) }
      def tax_behavior; end
      sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
      def tax_behavior=(_tax_behavior); end
      # A [tax code](https://docs.stripe.com/tax/tax-categories) ID.
      sig { returns(T.nilable(String)) }
      def tax_code; end
      sig { params(_tax_code: T.nilable(String)).returns(T.nilable(String)) }
      def tax_code=(_tax_code); end
      # The tax rates that apply to the item. When set, any `default_tax_rates` do not apply to this item.
      sig { returns(T.nilable(T.any(String, T::Array[String]))) }
      def tax_rates; end
      sig {
        params(_tax_rates: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
       }
      def tax_rates=(_tax_rates); end
      # The integer unit amount in cents (or local equivalent) of the charge to be applied to the upcoming invoice. This unit_amount will be multiplied by the quantity to get the full amount. If you want to apply a credit to the customer's account, pass a negative unit_amount.
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
        params(amount: T.nilable(Integer), currency: T.nilable(String), description: T.nilable(String), discountable: T.nilable(T::Boolean), discounts: T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::InvoiceItem::Discount])), invoiceitem: T.nilable(String), metadata: T.nilable(T.any(String, T::Hash[String, String])), period: T.nilable(InvoiceCreatePreviewParams::InvoiceItem::Period), price: T.nilable(String), price_data: T.nilable(InvoiceCreatePreviewParams::InvoiceItem::PriceData), quantity: T.nilable(Integer), tax_behavior: T.nilable(String), tax_code: T.nilable(String), tax_rates: T.nilable(T.any(String, T::Array[String])), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String)).void
       }
      def initialize(
        amount: nil,
        currency: nil,
        description: nil,
        discountable: nil,
        discounts: nil,
        invoiceitem: nil,
        metadata: nil,
        period: nil,
        price: nil,
        price_data: nil,
        quantity: nil,
        tax_behavior: nil,
        tax_code: nil,
        tax_rates: nil,
        unit_amount: nil,
        unit_amount_decimal: nil
      ); end
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
    class ScheduleDetails < ::Stripe::RequestParams
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
          returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::BillingMode::Flexible))
         }
        def flexible; end
        sig {
          params(_flexible: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::BillingMode::Flexible)).returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::BillingMode::Flexible))
         }
        def flexible=(_flexible); end
        # Controls the calculation and orchestration of prorations and invoices for subscriptions. If no value is passed, the default is `flexible`.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        sig {
          params(flexible: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::BillingMode::Flexible), type: String).void
         }
        def initialize(flexible: nil, type: nil); end
      end
      class Phase < ::Stripe::RequestParams
        class AddInvoiceItem < ::Stripe::RequestParams
          class Discount < ::Stripe::RequestParams
            # ID of the coupon to create a new discount for.
            sig { returns(T.nilable(String)) }
            def coupon; end
            sig { params(_coupon: T.nilable(String)).returns(T.nilable(String)) }
            def coupon=(_coupon); end
            # ID of an existing discount on the object (or one of its ancestors) to reuse.
            sig { returns(T.nilable(String)) }
            def discount; end
            sig { params(_discount: T.nilable(String)).returns(T.nilable(String)) }
            def discount=(_discount); end
            # ID of the promotion code to create a new discount for.
            sig { returns(T.nilable(String)) }
            def promotion_code; end
            sig { params(_promotion_code: T.nilable(String)).returns(T.nilable(String)) }
            def promotion_code=(_promotion_code); end
            sig {
              params(coupon: T.nilable(String), discount: T.nilable(String), promotion_code: T.nilable(String)).void
             }
            def initialize(coupon: nil, discount: nil, promotion_code: nil); end
          end
          class Period < ::Stripe::RequestParams
            class End < ::Stripe::RequestParams
              # A precise Unix timestamp for the end of the invoice item period. Must be greater than or equal to `period.start`.
              sig { returns(T.nilable(Integer)) }
              def timestamp; end
              sig { params(_timestamp: T.nilable(Integer)).returns(T.nilable(Integer)) }
              def timestamp=(_timestamp); end
              # Select how to calculate the end of the invoice item period.
              sig { returns(String) }
              def type; end
              sig { params(_type: String).returns(String) }
              def type=(_type); end
              sig { params(timestamp: T.nilable(Integer), type: String).void }
              def initialize(timestamp: nil, type: nil); end
            end
            class Start < ::Stripe::RequestParams
              # A precise Unix timestamp for the start of the invoice item period. Must be less than or equal to `period.end`.
              sig { returns(T.nilable(Integer)) }
              def timestamp; end
              sig { params(_timestamp: T.nilable(Integer)).returns(T.nilable(Integer)) }
              def timestamp=(_timestamp); end
              # Select how to calculate the start of the invoice item period.
              sig { returns(String) }
              def type; end
              sig { params(_type: String).returns(String) }
              def type=(_type); end
              sig { params(timestamp: T.nilable(Integer), type: String).void }
              def initialize(timestamp: nil, type: nil); end
            end
            # End of the invoice item period.
            sig {
              returns(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::Period::End)
             }
            def end; end
            sig {
              params(_end: InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::Period::End).returns(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::Period::End)
             }
            def end=(_end); end
            # Start of the invoice item period.
            sig {
              returns(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::Period::Start)
             }
            def start; end
            sig {
              params(_start: InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::Period::Start).returns(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::Period::Start)
             }
            def start=(_start); end
            sig {
              params(end_: InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::Period::End, start: InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::Period::Start).void
             }
            def initialize(end_: nil, start: nil); end
          end
          class PriceData < ::Stripe::RequestParams
            # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
            sig { returns(String) }
            def currency; end
            sig { params(_currency: String).returns(String) }
            def currency=(_currency); end
            # The ID of the [Product](https://docs.stripe.com/api/products) that this [Price](https://docs.stripe.com/api/prices) will belong to.
            sig { returns(String) }
            def product; end
            sig { params(_product: String).returns(String) }
            def product=(_product); end
            # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
            sig { returns(T.nilable(String)) }
            def tax_behavior; end
            sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
            def tax_behavior=(_tax_behavior); end
            # A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge or a negative integer representing the amount to credit to the customer.
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
              params(currency: String, product: String, tax_behavior: T.nilable(String), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String)).void
             }
            def initialize(
              currency: nil,
              product: nil,
              tax_behavior: nil,
              unit_amount: nil,
              unit_amount_decimal: nil
            ); end
          end
          # The coupons to redeem into discounts for the item.
          sig {
            returns(T.nilable(T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::Discount]))
           }
          def discounts; end
          sig {
            params(_discounts: T.nilable(T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::Discount])).returns(T.nilable(T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::Discount]))
           }
          def discounts=(_discounts); end
          # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
          sig { returns(T.nilable(T::Hash[String, String])) }
          def metadata; end
          sig {
            params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
           }
          def metadata=(_metadata); end
          # The period associated with this invoice item. If not set, `period.start.type` defaults to `max_item_period_start` and `period.end.type` defaults to `min_item_period_end`.
          sig {
            returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::Period))
           }
          def period; end
          sig {
            params(_period: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::Period)).returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::Period))
           }
          def period=(_period); end
          # The ID of the price object. One of `price` or `price_data` is required.
          sig { returns(T.nilable(String)) }
          def price; end
          sig { params(_price: T.nilable(String)).returns(T.nilable(String)) }
          def price=(_price); end
          # Data used to generate a new [Price](https://docs.stripe.com/api/prices) object inline. One of `price` or `price_data` is required.
          sig {
            returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::PriceData))
           }
          def price_data; end
          sig {
            params(_price_data: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::PriceData)).returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::PriceData))
           }
          def price_data=(_price_data); end
          # Quantity for this item. Defaults to 1.
          sig { returns(T.nilable(Integer)) }
          def quantity; end
          sig { params(_quantity: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def quantity=(_quantity); end
          # The tax rates which apply to the item. When set, the `default_tax_rates` do not apply to this item.
          sig { returns(T.nilable(T.any(String, T::Array[String]))) }
          def tax_rates; end
          sig {
            params(_tax_rates: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
           }
          def tax_rates=(_tax_rates); end
          sig {
            params(discounts: T.nilable(T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::Discount]), metadata: T.nilable(T::Hash[String, String]), period: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::Period), price: T.nilable(String), price_data: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem::PriceData), quantity: T.nilable(Integer), tax_rates: T.nilable(T.any(String, T::Array[String]))).void
           }
          def initialize(
            discounts: nil,
            metadata: nil,
            period: nil,
            price: nil,
            price_data: nil,
            quantity: nil,
            tax_rates: nil
          ); end
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
          # Enabled automatic tax calculation which will automatically compute tax rates on all invoices generated by the subscription.
          sig { returns(T::Boolean) }
          def enabled; end
          sig { params(_enabled: T::Boolean).returns(T::Boolean) }
          def enabled=(_enabled); end
          # The account that's liable for tax. If set, the business address and tax registrations required to perform the tax calculation are loaded from this account. The tax transaction is returned in the report of the connected account.
          sig {
            returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AutomaticTax::Liability))
           }
          def liability; end
          sig {
            params(_liability: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AutomaticTax::Liability)).returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AutomaticTax::Liability))
           }
          def liability=(_liability); end
          sig {
            params(enabled: T::Boolean, liability: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AutomaticTax::Liability)).void
           }
          def initialize(enabled: nil, liability: nil); end
        end
        class BillingThresholds < ::Stripe::RequestParams
          # Monetary threshold that triggers the subscription to advance to a new billing period
          sig { returns(T.nilable(Integer)) }
          def amount_gte; end
          sig { params(_amount_gte: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def amount_gte=(_amount_gte); end
          # Indicates if the `billing_cycle_anchor` should be reset when a threshold is reached. If true, `billing_cycle_anchor` will be updated to the date/time the threshold was last reached; otherwise, the value will remain unchanged.
          sig { returns(T.nilable(T::Boolean)) }
          def reset_billing_cycle_anchor; end
          sig {
            params(_reset_billing_cycle_anchor: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean))
           }
          def reset_billing_cycle_anchor=(_reset_billing_cycle_anchor); end
          sig {
            params(amount_gte: T.nilable(Integer), reset_billing_cycle_anchor: T.nilable(T::Boolean)).void
           }
          def initialize(amount_gte: nil, reset_billing_cycle_anchor: nil); end
        end
        class Discount < ::Stripe::RequestParams
          # ID of the coupon to create a new discount for.
          sig { returns(T.nilable(String)) }
          def coupon; end
          sig { params(_coupon: T.nilable(String)).returns(T.nilable(String)) }
          def coupon=(_coupon); end
          # ID of an existing discount on the object (or one of its ancestors) to reuse.
          sig { returns(T.nilable(String)) }
          def discount; end
          sig { params(_discount: T.nilable(String)).returns(T.nilable(String)) }
          def discount=(_discount); end
          # ID of the promotion code to create a new discount for.
          sig { returns(T.nilable(String)) }
          def promotion_code; end
          sig { params(_promotion_code: T.nilable(String)).returns(T.nilable(String)) }
          def promotion_code=(_promotion_code); end
          sig {
            params(coupon: T.nilable(String), discount: T.nilable(String), promotion_code: T.nilable(String)).void
           }
          def initialize(coupon: nil, discount: nil, promotion_code: nil); end
        end
        class Duration < ::Stripe::RequestParams
          # Specifies phase duration. Either `day`, `week`, `month` or `year`.
          sig { returns(String) }
          def interval; end
          sig { params(_interval: String).returns(String) }
          def interval=(_interval); end
          # The multiplier applied to the interval.
          sig { returns(T.nilable(Integer)) }
          def interval_count; end
          sig { params(_interval_count: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def interval_count=(_interval_count); end
          sig { params(interval: String, interval_count: T.nilable(Integer)).void }
          def initialize(interval: nil, interval_count: nil); end
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
          # The account tax IDs associated with this phase of the subscription schedule. Will be set on invoices generated by this phase of the subscription schedule.
          sig { returns(T.nilable(T.any(String, T::Array[String]))) }
          def account_tax_ids; end
          sig {
            params(_account_tax_ids: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
           }
          def account_tax_ids=(_account_tax_ids); end
          # Number of days within which a customer must pay invoices generated by this subscription schedule. This value will be `null` for subscription schedules where `billing=charge_automatically`.
          sig { returns(T.nilable(Integer)) }
          def days_until_due; end
          sig { params(_days_until_due: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def days_until_due=(_days_until_due); end
          # The connected account that issues the invoice. The invoice is presented with the branding and support information of the specified account.
          sig {
            returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::InvoiceSettings::Issuer))
           }
          def issuer; end
          sig {
            params(_issuer: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::InvoiceSettings::Issuer)).returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::InvoiceSettings::Issuer))
           }
          def issuer=(_issuer); end
          sig {
            params(account_tax_ids: T.nilable(T.any(String, T::Array[String])), days_until_due: T.nilable(Integer), issuer: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::InvoiceSettings::Issuer)).void
           }
          def initialize(account_tax_ids: nil, days_until_due: nil, issuer: nil); end
        end
        class Item < ::Stripe::RequestParams
          class BillingThresholds < ::Stripe::RequestParams
            # Number of units that meets the billing threshold to advance the subscription to a new billing period (e.g., it takes 10 $5 units to meet a $50 [monetary threshold](https://docs.stripe.com/api/subscriptions/update#update_subscription-billing_thresholds-amount_gte))
            sig { returns(Integer) }
            def usage_gte; end
            sig { params(_usage_gte: Integer).returns(Integer) }
            def usage_gte=(_usage_gte); end
            sig { params(usage_gte: Integer).void }
            def initialize(usage_gte: nil); end
          end
          class Discount < ::Stripe::RequestParams
            # ID of the coupon to create a new discount for.
            sig { returns(T.nilable(String)) }
            def coupon; end
            sig { params(_coupon: T.nilable(String)).returns(T.nilable(String)) }
            def coupon=(_coupon); end
            # ID of an existing discount on the object (or one of its ancestors) to reuse.
            sig { returns(T.nilable(String)) }
            def discount; end
            sig { params(_discount: T.nilable(String)).returns(T.nilable(String)) }
            def discount=(_discount); end
            # ID of the promotion code to create a new discount for.
            sig { returns(T.nilable(String)) }
            def promotion_code; end
            sig { params(_promotion_code: T.nilable(String)).returns(T.nilable(String)) }
            def promotion_code=(_promotion_code); end
            sig {
              params(coupon: T.nilable(String), discount: T.nilable(String), promotion_code: T.nilable(String)).void
             }
            def initialize(coupon: nil, discount: nil, promotion_code: nil); end
          end
          class PriceData < ::Stripe::RequestParams
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
            # The ID of the [Product](https://docs.stripe.com/api/products) that this [Price](https://docs.stripe.com/api/prices) will belong to.
            sig { returns(String) }
            def product; end
            sig { params(_product: String).returns(String) }
            def product=(_product); end
            # The recurring components of a price such as `interval` and `interval_count`.
            sig {
              returns(InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item::PriceData::Recurring)
             }
            def recurring; end
            sig {
              params(_recurring: InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item::PriceData::Recurring).returns(InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item::PriceData::Recurring)
             }
            def recurring=(_recurring); end
            # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
            sig { returns(T.nilable(String)) }
            def tax_behavior; end
            sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
            def tax_behavior=(_tax_behavior); end
            # A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge.
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
              params(currency: String, product: String, recurring: InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item::PriceData::Recurring, tax_behavior: T.nilable(String), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String)).void
             }
            def initialize(
              currency: nil,
              product: nil,
              recurring: nil,
              tax_behavior: nil,
              unit_amount: nil,
              unit_amount_decimal: nil
            ); end
          end
          # Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period. Pass an empty string to remove previously-defined thresholds.
          sig {
            returns(T.nilable(T.any(String, InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item::BillingThresholds)))
           }
          def billing_thresholds; end
          sig {
            params(_billing_thresholds: T.nilable(T.any(String, InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item::BillingThresholds))).returns(T.nilable(T.any(String, InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item::BillingThresholds)))
           }
          def billing_thresholds=(_billing_thresholds); end
          # The coupons to redeem into discounts for the subscription item.
          sig {
            returns(T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item::Discount])))
           }
          def discounts; end
          sig {
            params(_discounts: T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item::Discount]))).returns(T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item::Discount])))
           }
          def discounts=(_discounts); end
          # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to a configuration item. Metadata on a configuration item will update the underlying subscription item's `metadata` when the phase is entered, adding new keys and replacing existing keys. Individual keys in the subscription item's `metadata` can be unset by posting an empty value to them in the configuration item's `metadata`. To unset all keys in the subscription item's `metadata`, update the subscription item directly or unset every key individually from the configuration item's `metadata`.
          sig { returns(T.nilable(T::Hash[String, String])) }
          def metadata; end
          sig {
            params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
           }
          def metadata=(_metadata); end
          # The plan ID to subscribe to. You may specify the same ID in `plan` and `price`.
          sig { returns(T.nilable(String)) }
          def plan; end
          sig { params(_plan: T.nilable(String)).returns(T.nilable(String)) }
          def plan=(_plan); end
          # The ID of the price object.
          sig { returns(T.nilable(String)) }
          def price; end
          sig { params(_price: T.nilable(String)).returns(T.nilable(String)) }
          def price=(_price); end
          # Data used to generate a new [Price](https://docs.stripe.com/api/prices) object inline.
          sig {
            returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item::PriceData))
           }
          def price_data; end
          sig {
            params(_price_data: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item::PriceData)).returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item::PriceData))
           }
          def price_data=(_price_data); end
          # Quantity for the given price. Can be set only if the price's `usage_type` is `licensed` and not `metered`.
          sig { returns(T.nilable(Integer)) }
          def quantity; end
          sig { params(_quantity: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def quantity=(_quantity); end
          # A list of [Tax Rate](https://docs.stripe.com/api/tax_rates) ids. These Tax Rates will override the [`default_tax_rates`](https://docs.stripe.com/api/subscriptions/create#create_subscription-default_tax_rates) on the Subscription. When updating, pass an empty string to remove previously-defined tax rates.
          sig { returns(T.nilable(T.any(String, T::Array[String]))) }
          def tax_rates; end
          sig {
            params(_tax_rates: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
           }
          def tax_rates=(_tax_rates); end
          sig {
            params(billing_thresholds: T.nilable(T.any(String, InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item::BillingThresholds)), discounts: T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item::Discount])), metadata: T.nilable(T::Hash[String, String]), plan: T.nilable(String), price: T.nilable(String), price_data: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item::PriceData), quantity: T.nilable(Integer), tax_rates: T.nilable(T.any(String, T::Array[String]))).void
           }
          def initialize(
            billing_thresholds: nil,
            discounts: nil,
            metadata: nil,
            plan: nil,
            price: nil,
            price_data: nil,
            quantity: nil,
            tax_rates: nil
          ); end
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
        # A list of prices and quantities that will generate invoice items appended to the next invoice for this phase. You may pass up to 20 items.
        sig {
          returns(T.nilable(T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem]))
         }
        def add_invoice_items; end
        sig {
          params(_add_invoice_items: T.nilable(T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem])).returns(T.nilable(T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem]))
         }
        def add_invoice_items=(_add_invoice_items); end
        # A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice total that will be transferred to the application owner's Stripe account. The request must be made by a platform account on a connected account in order to set an application fee percentage. For more information, see the application fees [documentation](https://stripe.com/docs/connect/subscriptions#collecting-fees-on-subscriptions).
        sig { returns(T.nilable(Float)) }
        def application_fee_percent; end
        sig { params(_application_fee_percent: T.nilable(Float)).returns(T.nilable(Float)) }
        def application_fee_percent=(_application_fee_percent); end
        # Automatic tax settings for this phase.
        sig { returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AutomaticTax)) }
        def automatic_tax; end
        sig {
          params(_automatic_tax: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AutomaticTax)).returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AutomaticTax))
         }
        def automatic_tax=(_automatic_tax); end
        # Can be set to `phase_start` to set the anchor to the start of the phase or `automatic` to automatically change it if needed. Cannot be set to `phase_start` if this phase specifies a trial. For more information, see the billing cycle [documentation](https://docs.stripe.com/billing/subscriptions/billing-cycle).
        sig { returns(T.nilable(String)) }
        def billing_cycle_anchor; end
        sig { params(_billing_cycle_anchor: T.nilable(String)).returns(T.nilable(String)) }
        def billing_cycle_anchor=(_billing_cycle_anchor); end
        # Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period. Pass an empty string to remove previously-defined thresholds.
        sig {
          returns(T.nilable(T.any(String, InvoiceCreatePreviewParams::ScheduleDetails::Phase::BillingThresholds)))
         }
        def billing_thresholds; end
        sig {
          params(_billing_thresholds: T.nilable(T.any(String, InvoiceCreatePreviewParams::ScheduleDetails::Phase::BillingThresholds))).returns(T.nilable(T.any(String, InvoiceCreatePreviewParams::ScheduleDetails::Phase::BillingThresholds)))
         }
        def billing_thresholds=(_billing_thresholds); end
        # Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay the underlying subscription at the end of each billing cycle using the default source attached to the customer. When sending an invoice, Stripe will email your customer an invoice with payment instructions and mark the subscription as `active`. Defaults to `charge_automatically` on creation.
        sig { returns(T.nilable(String)) }
        def collection_method; end
        sig { params(_collection_method: T.nilable(String)).returns(T.nilable(String)) }
        def collection_method=(_collection_method); end
        # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
        sig { returns(T.nilable(String)) }
        def currency; end
        sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
        def currency=(_currency); end
        # ID of the default payment method for the subscription schedule. It must belong to the customer associated with the subscription schedule. If not set, invoices will use the default payment method in the customer's invoice settings.
        sig { returns(T.nilable(String)) }
        def default_payment_method; end
        sig { params(_default_payment_method: T.nilable(String)).returns(T.nilable(String)) }
        def default_payment_method=(_default_payment_method); end
        # A list of [Tax Rate](https://docs.stripe.com/api/tax_rates) ids. These Tax Rates will set the Subscription's [`default_tax_rates`](https://docs.stripe.com/api/subscriptions/create#create_subscription-default_tax_rates), which means they will be the Invoice's [`default_tax_rates`](https://docs.stripe.com/api/invoices/create#create_invoice-default_tax_rates) for any Invoices issued by the Subscription during this Phase.
        sig { returns(T.nilable(T.any(String, T::Array[String]))) }
        def default_tax_rates; end
        sig {
          params(_default_tax_rates: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
         }
        def default_tax_rates=(_default_tax_rates); end
        # Subscription description, meant to be displayable to the customer. Use this field to optionally store an explanation of the subscription for rendering in Stripe surfaces and certain local payment methods UIs.
        sig { returns(T.nilable(String)) }
        def description; end
        sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
        def description=(_description); end
        # The coupons to redeem into discounts for the schedule phase. If not specified, inherits the discount from the subscription's customer. Pass an empty string to avoid inheriting any discounts.
        sig {
          returns(T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::Discount])))
         }
        def discounts; end
        sig {
          params(_discounts: T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::Discount]))).returns(T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::Discount])))
         }
        def discounts=(_discounts); end
        # The number of intervals the phase should last. If set, `end_date` must not be set.
        sig { returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::Duration)) }
        def duration; end
        sig {
          params(_duration: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::Duration)).returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::Duration))
         }
        def duration=(_duration); end
        # The date at which this phase of the subscription schedule ends. If set, `duration` must not be set.
        sig { returns(T.nilable(T.any(Integer, String))) }
        def end_date; end
        sig {
          params(_end_date: T.nilable(T.any(Integer, String))).returns(T.nilable(T.any(Integer, String)))
         }
        def end_date=(_end_date); end
        # All invoices will be billed using the specified settings.
        sig {
          returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::InvoiceSettings))
         }
        def invoice_settings; end
        sig {
          params(_invoice_settings: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::InvoiceSettings)).returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::InvoiceSettings))
         }
        def invoice_settings=(_invoice_settings); end
        # List of configuration items, each with an attached price, to apply during this phase of the subscription schedule.
        sig { returns(T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item]) }
        def items; end
        sig {
          params(_items: T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item]).returns(T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item])
         }
        def items=(_items); end
        # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to a phase. Metadata on a schedule's phase will update the underlying subscription's `metadata` when the phase is entered, adding new keys and replacing existing keys in the subscription's `metadata`. Individual keys in the subscription's `metadata` can be unset by posting an empty value to them in the phase's `metadata`. To unset all keys in the subscription's `metadata`, update the subscription directly or unset every key individually from the phase's `metadata`.
        sig { returns(T.nilable(T::Hash[String, String])) }
        def metadata; end
        sig {
          params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
         }
        def metadata=(_metadata); end
        # The account on behalf of which to charge, for each of the associated subscription's invoices.
        sig { returns(T.nilable(String)) }
        def on_behalf_of; end
        sig { params(_on_behalf_of: T.nilable(String)).returns(T.nilable(String)) }
        def on_behalf_of=(_on_behalf_of); end
        # Controls whether the subscription schedule should create [prorations](https://docs.stripe.com/billing/subscriptions/prorations) when transitioning to this phase if there is a difference in billing configuration. It's different from the request-level [proration_behavior](https://docs.stripe.com/api/subscription_schedules/update#update_subscription_schedule-proration_behavior) parameter which controls what happens if the update request affects the billing configuration (item price, quantity, etc.) of the current phase.
        sig { returns(T.nilable(String)) }
        def proration_behavior; end
        sig { params(_proration_behavior: T.nilable(String)).returns(T.nilable(String)) }
        def proration_behavior=(_proration_behavior); end
        # The date at which this phase of the subscription schedule starts or `now`. Must be set on the first phase.
        sig { returns(T.nilable(T.any(Integer, String))) }
        def start_date; end
        sig {
          params(_start_date: T.nilable(T.any(Integer, String))).returns(T.nilable(T.any(Integer, String)))
         }
        def start_date=(_start_date); end
        # The data with which to automatically create a Transfer for each of the associated subscription's invoices.
        sig { returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::TransferData)) }
        def transfer_data; end
        sig {
          params(_transfer_data: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::TransferData)).returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::TransferData))
         }
        def transfer_data=(_transfer_data); end
        # If set to true the entire phase is counted as a trial and the customer will not be charged for any fees.
        sig { returns(T.nilable(T::Boolean)) }
        def trial; end
        sig { params(_trial: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def trial=(_trial); end
        # Sets the phase to trialing from the start date to this date. Must be before the phase end date, can not be combined with `trial`
        sig { returns(T.nilable(T.any(Integer, String))) }
        def trial_end; end
        sig {
          params(_trial_end: T.nilable(T.any(Integer, String))).returns(T.nilable(T.any(Integer, String)))
         }
        def trial_end=(_trial_end); end
        sig {
          params(add_invoice_items: T.nilable(T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::AddInvoiceItem]), application_fee_percent: T.nilable(Float), automatic_tax: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::AutomaticTax), billing_cycle_anchor: T.nilable(String), billing_thresholds: T.nilable(T.any(String, InvoiceCreatePreviewParams::ScheduleDetails::Phase::BillingThresholds)), collection_method: T.nilable(String), currency: T.nilable(String), default_payment_method: T.nilable(String), default_tax_rates: T.nilable(T.any(String, T::Array[String])), description: T.nilable(String), discounts: T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::Discount])), duration: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::Duration), end_date: T.nilable(T.any(Integer, String)), invoice_settings: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::InvoiceSettings), items: T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase::Item], metadata: T.nilable(T::Hash[String, String]), on_behalf_of: T.nilable(String), proration_behavior: T.nilable(String), start_date: T.nilable(T.any(Integer, String)), transfer_data: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::Phase::TransferData), trial: T.nilable(T::Boolean), trial_end: T.nilable(T.any(Integer, String))).void
         }
        def initialize(
          add_invoice_items: nil,
          application_fee_percent: nil,
          automatic_tax: nil,
          billing_cycle_anchor: nil,
          billing_thresholds: nil,
          collection_method: nil,
          currency: nil,
          default_payment_method: nil,
          default_tax_rates: nil,
          description: nil,
          discounts: nil,
          duration: nil,
          end_date: nil,
          invoice_settings: nil,
          items: nil,
          metadata: nil,
          on_behalf_of: nil,
          proration_behavior: nil,
          start_date: nil,
          transfer_data: nil,
          trial: nil,
          trial_end: nil
        ); end
      end
      # Controls how prorations and invoices for subscriptions are calculated and orchestrated.
      sig { returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::BillingMode)) }
      def billing_mode; end
      sig {
        params(_billing_mode: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::BillingMode)).returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::BillingMode))
       }
      def billing_mode=(_billing_mode); end
      # Behavior of the subscription schedule and underlying subscription when it ends. Possible values are `release` or `cancel` with the default being `release`. `release` will end the subscription schedule and keep the underlying subscription running. `cancel` will end the subscription schedule and cancel the underlying subscription.
      sig { returns(T.nilable(String)) }
      def end_behavior; end
      sig { params(_end_behavior: T.nilable(String)).returns(T.nilable(String)) }
      def end_behavior=(_end_behavior); end
      # List representing phases of the subscription schedule. Each phase can be customized to have different durations, plans, and coupons. If there are multiple phases, the `end_date` of one phase will always equal the `start_date` of the next phase.
      sig { returns(T.nilable(T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase])) }
      def phases; end
      sig {
        params(_phases: T.nilable(T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase])).returns(T.nilable(T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase]))
       }
      def phases=(_phases); end
      # In cases where the `schedule_details` params update the currently active phase, specifies if and how to prorate at the time of the request.
      sig { returns(T.nilable(String)) }
      def proration_behavior; end
      sig { params(_proration_behavior: T.nilable(String)).returns(T.nilable(String)) }
      def proration_behavior=(_proration_behavior); end
      sig {
        params(billing_mode: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails::BillingMode), end_behavior: T.nilable(String), phases: T.nilable(T::Array[InvoiceCreatePreviewParams::ScheduleDetails::Phase]), proration_behavior: T.nilable(String)).void
       }
      def initialize(
        billing_mode: nil,
        end_behavior: nil,
        phases: nil,
        proration_behavior: nil
      ); end
    end
    class SubscriptionDetails < ::Stripe::RequestParams
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
          returns(T.nilable(InvoiceCreatePreviewParams::SubscriptionDetails::BillingMode::Flexible))
         }
        def flexible; end
        sig {
          params(_flexible: T.nilable(InvoiceCreatePreviewParams::SubscriptionDetails::BillingMode::Flexible)).returns(T.nilable(InvoiceCreatePreviewParams::SubscriptionDetails::BillingMode::Flexible))
         }
        def flexible=(_flexible); end
        # Controls the calculation and orchestration of prorations and invoices for subscriptions. If no value is passed, the default is `flexible`.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        sig {
          params(flexible: T.nilable(InvoiceCreatePreviewParams::SubscriptionDetails::BillingMode::Flexible), type: String).void
         }
        def initialize(flexible: nil, type: nil); end
      end
      class Item < ::Stripe::RequestParams
        class BillingThresholds < ::Stripe::RequestParams
          # Number of units that meets the billing threshold to advance the subscription to a new billing period (e.g., it takes 10 $5 units to meet a $50 [monetary threshold](https://docs.stripe.com/api/subscriptions/update#update_subscription-billing_thresholds-amount_gte))
          sig { returns(Integer) }
          def usage_gte; end
          sig { params(_usage_gte: Integer).returns(Integer) }
          def usage_gte=(_usage_gte); end
          sig { params(usage_gte: Integer).void }
          def initialize(usage_gte: nil); end
        end
        class Discount < ::Stripe::RequestParams
          # ID of the coupon to create a new discount for.
          sig { returns(T.nilable(String)) }
          def coupon; end
          sig { params(_coupon: T.nilable(String)).returns(T.nilable(String)) }
          def coupon=(_coupon); end
          # ID of an existing discount on the object (or one of its ancestors) to reuse.
          sig { returns(T.nilable(String)) }
          def discount; end
          sig { params(_discount: T.nilable(String)).returns(T.nilable(String)) }
          def discount=(_discount); end
          # ID of the promotion code to create a new discount for.
          sig { returns(T.nilable(String)) }
          def promotion_code; end
          sig { params(_promotion_code: T.nilable(String)).returns(T.nilable(String)) }
          def promotion_code=(_promotion_code); end
          sig {
            params(coupon: T.nilable(String), discount: T.nilable(String), promotion_code: T.nilable(String)).void
           }
          def initialize(coupon: nil, discount: nil, promotion_code: nil); end
        end
        class PriceData < ::Stripe::RequestParams
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
          # The ID of the [Product](https://docs.stripe.com/api/products) that this [Price](https://docs.stripe.com/api/prices) will belong to.
          sig { returns(String) }
          def product; end
          sig { params(_product: String).returns(String) }
          def product=(_product); end
          # The recurring components of a price such as `interval` and `interval_count`.
          sig {
            returns(InvoiceCreatePreviewParams::SubscriptionDetails::Item::PriceData::Recurring)
           }
          def recurring; end
          sig {
            params(_recurring: InvoiceCreatePreviewParams::SubscriptionDetails::Item::PriceData::Recurring).returns(InvoiceCreatePreviewParams::SubscriptionDetails::Item::PriceData::Recurring)
           }
          def recurring=(_recurring); end
          # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
          sig { returns(T.nilable(String)) }
          def tax_behavior; end
          sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
          def tax_behavior=(_tax_behavior); end
          # A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge.
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
            params(currency: String, product: String, recurring: InvoiceCreatePreviewParams::SubscriptionDetails::Item::PriceData::Recurring, tax_behavior: T.nilable(String), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String)).void
           }
          def initialize(
            currency: nil,
            product: nil,
            recurring: nil,
            tax_behavior: nil,
            unit_amount: nil,
            unit_amount_decimal: nil
          ); end
        end
        # Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period. Pass an empty string to remove previously-defined thresholds.
        sig {
          returns(T.nilable(T.any(String, InvoiceCreatePreviewParams::SubscriptionDetails::Item::BillingThresholds)))
         }
        def billing_thresholds; end
        sig {
          params(_billing_thresholds: T.nilable(T.any(String, InvoiceCreatePreviewParams::SubscriptionDetails::Item::BillingThresholds))).returns(T.nilable(T.any(String, InvoiceCreatePreviewParams::SubscriptionDetails::Item::BillingThresholds)))
         }
        def billing_thresholds=(_billing_thresholds); end
        # Delete all usage for a given subscription item. You must pass this when deleting a usage records subscription item. `clear_usage` has no effect if the plan has a billing meter attached.
        sig { returns(T.nilable(T::Boolean)) }
        def clear_usage; end
        sig { params(_clear_usage: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def clear_usage=(_clear_usage); end
        # A flag that, if set to `true`, will delete the specified item.
        sig { returns(T.nilable(T::Boolean)) }
        def deleted; end
        sig { params(_deleted: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def deleted=(_deleted); end
        # The coupons to redeem into discounts for the subscription item.
        sig {
          returns(T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::SubscriptionDetails::Item::Discount])))
         }
        def discounts; end
        sig {
          params(_discounts: T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::SubscriptionDetails::Item::Discount]))).returns(T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::SubscriptionDetails::Item::Discount])))
         }
        def discounts=(_discounts); end
        # Subscription item to update.
        sig { returns(T.nilable(String)) }
        def id; end
        sig { params(_id: T.nilable(String)).returns(T.nilable(String)) }
        def id=(_id); end
        # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
        sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
        def metadata; end
        sig {
          params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
         }
        def metadata=(_metadata); end
        # Plan ID for this item, as a string.
        sig { returns(T.nilable(String)) }
        def plan; end
        sig { params(_plan: T.nilable(String)).returns(T.nilable(String)) }
        def plan=(_plan); end
        # The ID of the price object. One of `price` or `price_data` is required. When changing a subscription item's price, `quantity` is set to 1 unless a `quantity` parameter is provided.
        sig { returns(T.nilable(String)) }
        def price; end
        sig { params(_price: T.nilable(String)).returns(T.nilable(String)) }
        def price=(_price); end
        # Data used to generate a new [Price](https://docs.stripe.com/api/prices) object inline. One of `price` or `price_data` is required.
        sig { returns(T.nilable(InvoiceCreatePreviewParams::SubscriptionDetails::Item::PriceData)) }
        def price_data; end
        sig {
          params(_price_data: T.nilable(InvoiceCreatePreviewParams::SubscriptionDetails::Item::PriceData)).returns(T.nilable(InvoiceCreatePreviewParams::SubscriptionDetails::Item::PriceData))
         }
        def price_data=(_price_data); end
        # Quantity for this item.
        sig { returns(T.nilable(Integer)) }
        def quantity; end
        sig { params(_quantity: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def quantity=(_quantity); end
        # A list of [Tax Rate](https://docs.stripe.com/api/tax_rates) ids. These Tax Rates will override the [`default_tax_rates`](https://docs.stripe.com/api/subscriptions/create#create_subscription-default_tax_rates) on the Subscription. When updating, pass an empty string to remove previously-defined tax rates.
        sig { returns(T.nilable(T.any(String, T::Array[String]))) }
        def tax_rates; end
        sig {
          params(_tax_rates: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
         }
        def tax_rates=(_tax_rates); end
        sig {
          params(billing_thresholds: T.nilable(T.any(String, InvoiceCreatePreviewParams::SubscriptionDetails::Item::BillingThresholds)), clear_usage: T.nilable(T::Boolean), deleted: T.nilable(T::Boolean), discounts: T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::SubscriptionDetails::Item::Discount])), id: T.nilable(String), metadata: T.nilable(T.any(String, T::Hash[String, String])), plan: T.nilable(String), price: T.nilable(String), price_data: T.nilable(InvoiceCreatePreviewParams::SubscriptionDetails::Item::PriceData), quantity: T.nilable(Integer), tax_rates: T.nilable(T.any(String, T::Array[String]))).void
         }
        def initialize(
          billing_thresholds: nil,
          clear_usage: nil,
          deleted: nil,
          discounts: nil,
          id: nil,
          metadata: nil,
          plan: nil,
          price: nil,
          price_data: nil,
          quantity: nil,
          tax_rates: nil
        ); end
      end
      # For new subscriptions, a future timestamp to anchor the subscription's [billing cycle](https://docs.stripe.com/subscriptions/billing-cycle). This is used to determine the date of the first full invoice, and, for plans with `month` or `year` intervals, the day of the month for subsequent invoices. For existing subscriptions, the value can only be set to `now` or `unchanged`.
      sig { returns(T.nilable(T.any(String, Integer))) }
      def billing_cycle_anchor; end
      sig {
        params(_billing_cycle_anchor: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
       }
      def billing_cycle_anchor=(_billing_cycle_anchor); end
      # Controls how prorations and invoices for subscriptions are calculated and orchestrated.
      sig { returns(T.nilable(InvoiceCreatePreviewParams::SubscriptionDetails::BillingMode)) }
      def billing_mode; end
      sig {
        params(_billing_mode: T.nilable(InvoiceCreatePreviewParams::SubscriptionDetails::BillingMode)).returns(T.nilable(InvoiceCreatePreviewParams::SubscriptionDetails::BillingMode))
       }
      def billing_mode=(_billing_mode); end
      # A timestamp at which the subscription should cancel. If set to a date before the current period ends, this will cause a proration if prorations have been enabled using `proration_behavior`. If set during a future period, this will always cause a proration for that period.
      sig { returns(T.nilable(T.any(String, T.any(Integer, String)))) }
      def cancel_at; end
      sig {
        params(_cancel_at: T.nilable(T.any(String, T.any(Integer, String)))).returns(T.nilable(T.any(String, T.any(Integer, String))))
       }
      def cancel_at=(_cancel_at); end
      # Indicate whether this subscription should cancel at the end of the current period (`current_period_end`). Defaults to `false`.
      sig { returns(T.nilable(T::Boolean)) }
      def cancel_at_period_end; end
      sig { params(_cancel_at_period_end: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def cancel_at_period_end=(_cancel_at_period_end); end
      # This simulates the subscription being canceled or expired immediately.
      sig { returns(T.nilable(T::Boolean)) }
      def cancel_now; end
      sig { params(_cancel_now: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def cancel_now=(_cancel_now); end
      # If provided, the invoice returned will preview updating or creating a subscription with these default tax rates. The default tax rates will apply to any line item that does not have `tax_rates` set.
      sig { returns(T.nilable(T.any(String, T::Array[String]))) }
      def default_tax_rates; end
      sig {
        params(_default_tax_rates: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
       }
      def default_tax_rates=(_default_tax_rates); end
      # A list of up to 20 subscription items, each with an attached price.
      sig { returns(T.nilable(T::Array[InvoiceCreatePreviewParams::SubscriptionDetails::Item])) }
      def items; end
      sig {
        params(_items: T.nilable(T::Array[InvoiceCreatePreviewParams::SubscriptionDetails::Item])).returns(T.nilable(T::Array[InvoiceCreatePreviewParams::SubscriptionDetails::Item]))
       }
      def items=(_items); end
      # Determines how to handle [prorations](https://docs.stripe.com/billing/subscriptions/prorations) when the billing cycle changes (e.g., when switching plans, resetting `billing_cycle_anchor=now`, or starting a trial), or if an item's `quantity` changes. The default value is `create_prorations`.
      sig { returns(T.nilable(String)) }
      def proration_behavior; end
      sig { params(_proration_behavior: T.nilable(String)).returns(T.nilable(String)) }
      def proration_behavior=(_proration_behavior); end
      # If previewing an update to a subscription, and doing proration, `subscription_details.proration_date` forces the proration to be calculated as though the update was done at the specified time. The time given must be within the current subscription period and within the current phase of the schedule backing this subscription, if the schedule exists. If set, `subscription`, and one of `subscription_details.items`, or `subscription_details.trial_end` are required. Also, `subscription_details.proration_behavior` cannot be set to 'none'.
      sig { returns(T.nilable(Integer)) }
      def proration_date; end
      sig { params(_proration_date: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def proration_date=(_proration_date); end
      # For paused subscriptions, setting `subscription_details.resume_at` to `now` will preview the invoice that will be generated if the subscription is resumed.
      sig { returns(T.nilable(String)) }
      def resume_at; end
      sig { params(_resume_at: T.nilable(String)).returns(T.nilable(String)) }
      def resume_at=(_resume_at); end
      # Date a subscription is intended to start (can be future or past).
      sig { returns(T.nilable(Integer)) }
      def start_date; end
      sig { params(_start_date: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def start_date=(_start_date); end
      # If provided, the invoice returned will preview updating or creating a subscription with that trial end. If set, one of `subscription_details.items` or `subscription` is required.
      sig { returns(T.nilable(T.any(String, Integer))) }
      def trial_end; end
      sig {
        params(_trial_end: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
       }
      def trial_end=(_trial_end); end
      sig {
        params(billing_cycle_anchor: T.nilable(T.any(String, Integer)), billing_mode: T.nilable(InvoiceCreatePreviewParams::SubscriptionDetails::BillingMode), cancel_at: T.nilable(T.any(String, T.any(Integer, String))), cancel_at_period_end: T.nilable(T::Boolean), cancel_now: T.nilable(T::Boolean), default_tax_rates: T.nilable(T.any(String, T::Array[String])), items: T.nilable(T::Array[InvoiceCreatePreviewParams::SubscriptionDetails::Item]), proration_behavior: T.nilable(String), proration_date: T.nilable(Integer), resume_at: T.nilable(String), start_date: T.nilable(Integer), trial_end: T.nilable(T.any(String, Integer))).void
       }
      def initialize(
        billing_cycle_anchor: nil,
        billing_mode: nil,
        cancel_at: nil,
        cancel_at_period_end: nil,
        cancel_now: nil,
        default_tax_rates: nil,
        items: nil,
        proration_behavior: nil,
        proration_date: nil,
        resume_at: nil,
        start_date: nil,
        trial_end: nil
      ); end
    end
    # Settings for automatic tax lookup for this invoice preview.
    sig { returns(T.nilable(InvoiceCreatePreviewParams::AutomaticTax)) }
    def automatic_tax; end
    sig {
      params(_automatic_tax: T.nilable(InvoiceCreatePreviewParams::AutomaticTax)).returns(T.nilable(InvoiceCreatePreviewParams::AutomaticTax))
     }
    def automatic_tax=(_automatic_tax); end
    # The currency to preview this invoice in. Defaults to that of `customer` if not specified.
    sig { returns(T.nilable(String)) }
    def currency; end
    sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
    def currency=(_currency); end
    # The identifier of the customer whose upcoming invoice you're retrieving. If `automatic_tax` is enabled then one of `customer`, `customer_details`, `subscription`, or `schedule` must be set.
    sig { returns(T.nilable(String)) }
    def customer; end
    sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
    def customer=(_customer); end
    # The identifier of the account representing the customer whose upcoming invoice you're retrieving. If `automatic_tax` is enabled then one of `customer`, `customer_account`, `customer_details`, `subscription`, or `schedule` must be set.
    sig { returns(T.nilable(String)) }
    def customer_account; end
    sig { params(_customer_account: T.nilable(String)).returns(T.nilable(String)) }
    def customer_account=(_customer_account); end
    # Details about the customer you want to invoice or overrides for an existing customer. If `automatic_tax` is enabled then one of `customer`, `customer_details`, `subscription`, or `schedule` must be set.
    sig { returns(T.nilable(InvoiceCreatePreviewParams::CustomerDetails)) }
    def customer_details; end
    sig {
      params(_customer_details: T.nilable(InvoiceCreatePreviewParams::CustomerDetails)).returns(T.nilable(InvoiceCreatePreviewParams::CustomerDetails))
     }
    def customer_details=(_customer_details); end
    # The coupons to redeem into discounts for the invoice preview. If not specified, inherits the discount from the subscription or customer. This works for both coupons directly applied to an invoice and coupons applied to a subscription. Pass an empty string to avoid inheriting any discounts.
    sig { returns(T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::Discount]))) }
    def discounts; end
    sig {
      params(_discounts: T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::Discount]))).returns(T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::Discount])))
     }
    def discounts=(_discounts); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # List of invoice items to add or update in the upcoming invoice preview (up to 250).
    sig { returns(T.nilable(T::Array[InvoiceCreatePreviewParams::InvoiceItem])) }
    def invoice_items; end
    sig {
      params(_invoice_items: T.nilable(T::Array[InvoiceCreatePreviewParams::InvoiceItem])).returns(T.nilable(T::Array[InvoiceCreatePreviewParams::InvoiceItem]))
     }
    def invoice_items=(_invoice_items); end
    # The connected account that issues the invoice. The invoice is presented with the branding and support information of the specified account.
    sig { returns(T.nilable(InvoiceCreatePreviewParams::Issuer)) }
    def issuer; end
    sig {
      params(_issuer: T.nilable(InvoiceCreatePreviewParams::Issuer)).returns(T.nilable(InvoiceCreatePreviewParams::Issuer))
     }
    def issuer=(_issuer); end
    # The account (if any) for which the funds of the invoice payment are intended. If set, the invoice will be presented with the branding and support information of the specified account. See the [Invoices with Connect](https://docs.stripe.com/billing/invoices/connect) documentation for details.
    sig { returns(T.nilable(String)) }
    def on_behalf_of; end
    sig { params(_on_behalf_of: T.nilable(String)).returns(T.nilable(String)) }
    def on_behalf_of=(_on_behalf_of); end
    # Customizes the types of values to include when calculating the invoice. Defaults to `next` if unspecified.
    sig { returns(T.nilable(String)) }
    def preview_mode; end
    sig { params(_preview_mode: T.nilable(String)).returns(T.nilable(String)) }
    def preview_mode=(_preview_mode); end
    # The identifier of the schedule whose upcoming invoice you'd like to retrieve. Cannot be used with subscription or subscription fields.
    sig { returns(T.nilable(String)) }
    def schedule; end
    sig { params(_schedule: T.nilable(String)).returns(T.nilable(String)) }
    def schedule=(_schedule); end
    # The schedule creation or modification params to apply as a preview. Cannot be used with `subscription` or `subscription_` prefixed fields.
    sig { returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails)) }
    def schedule_details; end
    sig {
      params(_schedule_details: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails)).returns(T.nilable(InvoiceCreatePreviewParams::ScheduleDetails))
     }
    def schedule_details=(_schedule_details); end
    # The identifier of the subscription for which you'd like to retrieve the upcoming invoice. If not provided, but a `subscription_details.items` is provided, you will preview creating a subscription with those items. If neither `subscription` nor `subscription_details.items` is provided, you will retrieve the next upcoming invoice from among the customer's subscriptions.
    sig { returns(T.nilable(String)) }
    def subscription; end
    sig { params(_subscription: T.nilable(String)).returns(T.nilable(String)) }
    def subscription=(_subscription); end
    # The subscription creation or modification params to apply as a preview. Cannot be used with `schedule` or `schedule_details` fields.
    sig { returns(T.nilable(InvoiceCreatePreviewParams::SubscriptionDetails)) }
    def subscription_details; end
    sig {
      params(_subscription_details: T.nilable(InvoiceCreatePreviewParams::SubscriptionDetails)).returns(T.nilable(InvoiceCreatePreviewParams::SubscriptionDetails))
     }
    def subscription_details=(_subscription_details); end
    sig {
      params(automatic_tax: T.nilable(InvoiceCreatePreviewParams::AutomaticTax), currency: T.nilable(String), customer: T.nilable(String), customer_account: T.nilable(String), customer_details: T.nilable(InvoiceCreatePreviewParams::CustomerDetails), discounts: T.nilable(T.any(String, T::Array[InvoiceCreatePreviewParams::Discount])), expand: T.nilable(T::Array[String]), invoice_items: T.nilable(T::Array[InvoiceCreatePreviewParams::InvoiceItem]), issuer: T.nilable(InvoiceCreatePreviewParams::Issuer), on_behalf_of: T.nilable(String), preview_mode: T.nilable(String), schedule: T.nilable(String), schedule_details: T.nilable(InvoiceCreatePreviewParams::ScheduleDetails), subscription: T.nilable(String), subscription_details: T.nilable(InvoiceCreatePreviewParams::SubscriptionDetails)).void
     }
    def initialize(
      automatic_tax: nil,
      currency: nil,
      customer: nil,
      customer_account: nil,
      customer_details: nil,
      discounts: nil,
      expand: nil,
      invoice_items: nil,
      issuer: nil,
      on_behalf_of: nil,
      preview_mode: nil,
      schedule: nil,
      schedule_details: nil,
      subscription: nil,
      subscription_details: nil
    ); end
  end
end