# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    # A Tax Calculation allows you to calculate the tax to collect from your customer.
    #
    # Related guide: [Calculate tax in your custom payment flow](https://docs.stripe.com/tax/custom)
    class Calculation < APIResource
      class CustomerDetails < ::Stripe::StripeObject
        class Address < ::Stripe::StripeObject
          # City, district, suburb, town, or village.
          sig { returns(T.nilable(String)) }
          def city; end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(String) }
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
          # State/province as an [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2) subdivision code, without country prefix, such as "NY" or "TX".
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
          sig { returns(String) }
          def value; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The customer's postal address (for example, home or business location).
        sig { returns(T.nilable(Address)) }
        def address; end
        # The type of customer address provided.
        sig { returns(T.nilable(String)) }
        def address_source; end
        # The customer's IP address (IPv4 or IPv6).
        sig { returns(T.nilable(String)) }
        def ip_address; end
        # The customer's tax IDs (for example, EU VAT numbers).
        sig { returns(T::Array[TaxId]) }
        def tax_ids; end
        # The taxability override used for taxation.
        sig { returns(String) }
        def taxability_override; end
        def self.inner_class_types
          @inner_class_types = {address: Address, tax_ids: TaxId}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class ShipFromDetails < ::Stripe::StripeObject
        class Address < ::Stripe::StripeObject
          # City, district, suburb, town, or village.
          sig { returns(T.nilable(String)) }
          def city; end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(String) }
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
          # State/province as an [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2) subdivision code, without country prefix, such as "NY" or "TX".
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
        def self.inner_class_types
          @inner_class_types = {address: Address}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class ShippingCost < ::Stripe::StripeObject
        class TaxBreakdown < ::Stripe::StripeObject
          class Jurisdiction < ::Stripe::StripeObject
            # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
            sig { returns(String) }
            def country; end
            # A human-readable name for the jurisdiction imposing the tax.
            sig { returns(String) }
            def display_name; end
            # Indicates the level of the jurisdiction imposing the tax.
            sig { returns(String) }
            def level; end
            # [ISO 3166-2 subdivision code](https://en.wikipedia.org/wiki/ISO_3166-2), without country prefix. For example, "NY" for New York, United States.
            sig { returns(T.nilable(String)) }
            def state; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class TaxRateDetails < ::Stripe::StripeObject
            # A localized display name for tax type, intended to be human-readable. For example, "Local Sales and Use Tax", "Value-added tax (VAT)", or "Umsatzsteuer (USt.)".
            sig { returns(String) }
            def display_name; end
            # The tax rate percentage as a string. For example, 8.5% is represented as "8.5".
            sig { returns(String) }
            def percentage_decimal; end
            # The tax type, such as `vat` or `sales_tax`.
            sig { returns(String) }
            def tax_type; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # The amount of tax, in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
          sig { returns(Integer) }
          def amount; end
          # Attribute for field jurisdiction
          sig { returns(Jurisdiction) }
          def jurisdiction; end
          # Indicates whether the jurisdiction was determined by the origin (merchant's address) or destination (customer's address).
          sig { returns(String) }
          def sourcing; end
          # Details regarding the rate for this tax. This field will be `null` when the tax is not imposed, for example if the product is exempt from tax.
          sig { returns(T.nilable(TaxRateDetails)) }
          def tax_rate_details; end
          # The reasoning behind this tax, for example, if the product is tax exempt. The possible values for this field may be extended as new tax rules are supported.
          sig { returns(String) }
          def taxability_reason; end
          # The amount on which tax is calculated, in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
          sig { returns(Integer) }
          def taxable_amount; end
          def self.inner_class_types
            @inner_class_types = {jurisdiction: Jurisdiction, tax_rate_details: TaxRateDetails}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The shipping amount in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal). If `tax_behavior=inclusive`, then this amount includes taxes. Otherwise, taxes were calculated on top of this amount.
        sig { returns(Integer) }
        def amount; end
        # The amount of tax calculated for shipping, in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
        sig { returns(Integer) }
        def amount_tax; end
        # The ID of an existing [ShippingRate](https://docs.stripe.com/api/shipping_rates/object).
        sig { returns(T.nilable(String)) }
        def shipping_rate; end
        # Specifies whether the `amount` includes taxes. If `tax_behavior=inclusive`, then the amount includes taxes.
        sig { returns(String) }
        def tax_behavior; end
        # Detailed account of taxes relevant to shipping cost.
        sig { returns(T.nilable(T::Array[TaxBreakdown])) }
        def tax_breakdown; end
        # The [tax code](https://docs.stripe.com/tax/tax-categories) ID used for shipping.
        sig { returns(String) }
        def tax_code; end
        def self.inner_class_types
          @inner_class_types = {tax_breakdown: TaxBreakdown}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class TaxBreakdown < ::Stripe::StripeObject
        class TaxRateDetails < ::Stripe::StripeObject
          class FlatAmount < ::Stripe::StripeObject
            # Amount of the tax when the `rate_type` is `flat_amount`. This positive integer represents how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99).
            sig { returns(Integer) }
            def amount; end
            # Three-letter ISO currency code, in lowercase.
            sig { returns(String) }
            def currency; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(T.nilable(String)) }
          def country; end
          # The amount of the tax rate when the `rate_type` is `flat_amount`. Tax rates with `rate_type` `percentage` can vary based on the transaction, resulting in this field being `null`. This field exposes the amount and currency of the flat tax rate.
          sig { returns(T.nilable(FlatAmount)) }
          def flat_amount; end
          # The tax rate percentage as a string. For example, 8.5% is represented as `"8.5"`.
          sig { returns(String) }
          def percentage_decimal; end
          # Indicates the type of tax rate applied to the taxable amount. This value can be `null` when no tax applies to the location. This field is only present for TaxRates created by Stripe Tax.
          sig { returns(T.nilable(String)) }
          def rate_type; end
          # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
          sig { returns(T.nilable(String)) }
          def state; end
          # The tax type, such as `vat` or `sales_tax`.
          sig { returns(T.nilable(String)) }
          def tax_type; end
          def self.inner_class_types
            @inner_class_types = {flat_amount: FlatAmount}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The amount of tax, in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
        sig { returns(Integer) }
        def amount; end
        # Specifies whether the tax amount is included in the line item amount.
        sig { returns(T::Boolean) }
        def inclusive; end
        # Attribute for field tax_rate_details
        sig { returns(TaxRateDetails) }
        def tax_rate_details; end
        # The reasoning behind this tax, for example, if the product is tax exempt. We might extend the possible values for this field to support new tax rules.
        sig { returns(String) }
        def taxability_reason; end
        # The amount on which tax is calculated, in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
        sig { returns(Integer) }
        def taxable_amount; end
        def self.inner_class_types
          @inner_class_types = {tax_rate_details: TaxRateDetails}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Total amount after taxes in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
      sig { returns(Integer) }
      def amount_total; end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # The ID of an existing [Customer](https://docs.stripe.com/api/customers/object) used for the resource.
      sig { returns(T.nilable(String)) }
      def customer; end
      # Attribute for field customer_details
      sig { returns(CustomerDetails) }
      def customer_details; end
      # Timestamp of date at which the tax calculation will expire.
      sig { returns(T.nilable(Integer)) }
      def expires_at; end
      # Unique identifier for the calculation.
      sig { returns(T.nilable(String)) }
      def id; end
      # The list of items the customer is purchasing.
      sig { returns(T.nilable(::Stripe::ListObject)) }
      def line_items; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The details of the ship from location, such as the address.
      sig { returns(T.nilable(ShipFromDetails)) }
      def ship_from_details; end
      # The shipping cost details for the calculation.
      sig { returns(T.nilable(ShippingCost)) }
      def shipping_cost; end
      # The amount of tax to be collected on top of the line item prices.
      sig { returns(Integer) }
      def tax_amount_exclusive; end
      # The amount of tax already included in the line item prices.
      sig { returns(Integer) }
      def tax_amount_inclusive; end
      # Breakdown of individual tax amounts that add up to the total.
      sig { returns(T::Array[TaxBreakdown]) }
      def tax_breakdown; end
      # Timestamp of date at which the tax rules and rates in effect applies for the calculation.
      sig { returns(Integer) }
      def tax_date; end
      # Calculates tax based on the input and returns a Tax Calculation object.
      sig {
        params(params: T.any(::Stripe::Tax::CalculationCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Tax::Calculation)
       }
      def self.create(params = {}, opts = {}); end

      # Retrieves the line items of a tax calculation as a collection, if the calculation hasn't expired.
      sig {
        params(params: T.any(::Stripe::Tax::CalculationListLineItemsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list_line_items(params = {}, opts = {}); end

      # Retrieves the line items of a tax calculation as a collection, if the calculation hasn't expired.
      sig {
        params(calculation: String, params: T.any(::Stripe::Tax::CalculationListLineItemsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list_line_items(calculation, params = {}, opts = {}); end
    end
  end
end