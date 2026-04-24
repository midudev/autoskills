# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    class CalculationCreateParams < ::Stripe::RequestParams
      class CustomerDetails < ::Stripe::RequestParams
        class Address < ::Stripe::RequestParams
          # City, district, suburb, town, or village.
          sig { returns(T.nilable(String)) }
          def city; end
          sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
          def city=(_city); end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(String) }
          def country; end
          sig { params(_country: String).returns(String) }
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
          # State, county, province, or region. We recommend sending [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2) subdivision code value when possible.
          sig { returns(T.nilable(String)) }
          def state; end
          sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
          def state=(_state); end
          sig {
            params(city: T.nilable(String), country: String, line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String)).void
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
        # The customer's postal address (for example, home or business location).
        sig { returns(T.nilable(Tax::CalculationCreateParams::CustomerDetails::Address)) }
        def address; end
        sig {
          params(_address: T.nilable(Tax::CalculationCreateParams::CustomerDetails::Address)).returns(T.nilable(Tax::CalculationCreateParams::CustomerDetails::Address))
         }
        def address=(_address); end
        # The type of customer address provided.
        sig { returns(T.nilable(String)) }
        def address_source; end
        sig { params(_address_source: T.nilable(String)).returns(T.nilable(String)) }
        def address_source=(_address_source); end
        # The customer's IP address (IPv4 or IPv6).
        sig { returns(T.nilable(String)) }
        def ip_address; end
        sig { params(_ip_address: T.nilable(String)).returns(T.nilable(String)) }
        def ip_address=(_ip_address); end
        # The customer's tax IDs. Stripe Tax might consider a transaction with applicable tax IDs to be B2B, which might affect the tax calculation result. Stripe Tax doesn't validate tax IDs for correctness.
        sig { returns(T.nilable(T::Array[Tax::CalculationCreateParams::CustomerDetails::TaxId])) }
        def tax_ids; end
        sig {
          params(_tax_ids: T.nilable(T::Array[Tax::CalculationCreateParams::CustomerDetails::TaxId])).returns(T.nilable(T::Array[Tax::CalculationCreateParams::CustomerDetails::TaxId]))
         }
        def tax_ids=(_tax_ids); end
        # Overrides the tax calculation result to allow you to not collect tax from your customer. Use this if you've manually checked your customer's tax exemptions. Prefer providing the customer's `tax_ids` where possible, which automatically determines whether `reverse_charge` applies.
        sig { returns(T.nilable(String)) }
        def taxability_override; end
        sig { params(_taxability_override: T.nilable(String)).returns(T.nilable(String)) }
        def taxability_override=(_taxability_override); end
        sig {
          params(address: T.nilable(Tax::CalculationCreateParams::CustomerDetails::Address), address_source: T.nilable(String), ip_address: T.nilable(String), tax_ids: T.nilable(T::Array[Tax::CalculationCreateParams::CustomerDetails::TaxId]), taxability_override: T.nilable(String)).void
         }
        def initialize(
          address: nil,
          address_source: nil,
          ip_address: nil,
          tax_ids: nil,
          taxability_override: nil
        ); end
      end
      class LineItem < ::Stripe::RequestParams
        # A positive integer representing the line item's total price in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
        # If `tax_behavior=inclusive`, then this amount includes taxes. Otherwise, taxes are calculated on top of this amount.
        sig { returns(Integer) }
        def amount; end
        sig { params(_amount: Integer).returns(Integer) }
        def amount=(_amount); end
        # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        sig { returns(T.nilable(T::Hash[String, String])) }
        def metadata; end
        sig {
          params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
         }
        def metadata=(_metadata); end
        # If provided, the product's `tax_code` will be used as the line item's `tax_code`.
        sig { returns(T.nilable(String)) }
        def product; end
        sig { params(_product: T.nilable(String)).returns(T.nilable(String)) }
        def product=(_product); end
        # The number of units of the item being purchased. Used to calculate the per-unit price from the total `amount` for the line. For example, if `amount=100` and `quantity=4`, the calculated unit price is 25.
        sig { returns(T.nilable(Integer)) }
        def quantity; end
        sig { params(_quantity: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def quantity=(_quantity); end
        # A custom identifier for this line item, which must be unique across the line items in the calculation. The reference helps identify each line item in exported [tax reports](https://docs.stripe.com/tax/reports).
        sig { returns(T.nilable(String)) }
        def reference; end
        sig { params(_reference: T.nilable(String)).returns(T.nilable(String)) }
        def reference=(_reference); end
        # Specifies whether the `amount` includes taxes. Defaults to `exclusive`.
        sig { returns(T.nilable(String)) }
        def tax_behavior; end
        sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
        def tax_behavior=(_tax_behavior); end
        # A [tax code](https://docs.stripe.com/tax/tax-categories) ID to use for this line item. If not provided, we will use the tax code from the provided `product` param. If neither `tax_code` nor `product` is provided, we will use the default tax code from your Tax Settings.
        sig { returns(T.nilable(String)) }
        def tax_code; end
        sig { params(_tax_code: T.nilable(String)).returns(T.nilable(String)) }
        def tax_code=(_tax_code); end
        sig {
          params(amount: Integer, metadata: T.nilable(T::Hash[String, String]), product: T.nilable(String), quantity: T.nilable(Integer), reference: T.nilable(String), tax_behavior: T.nilable(String), tax_code: T.nilable(String)).void
         }
        def initialize(
          amount: nil,
          metadata: nil,
          product: nil,
          quantity: nil,
          reference: nil,
          tax_behavior: nil,
          tax_code: nil
        ); end
      end
      class ShipFromDetails < ::Stripe::RequestParams
        class Address < ::Stripe::RequestParams
          # City, district, suburb, town, or village.
          sig { returns(T.nilable(String)) }
          def city; end
          sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
          def city=(_city); end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(String) }
          def country; end
          sig { params(_country: String).returns(String) }
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
          # State/province as an [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2) subdivision code, without country prefix, such as "NY" or "TX".
          sig { returns(T.nilable(String)) }
          def state; end
          sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
          def state=(_state); end
          sig {
            params(city: T.nilable(String), country: String, line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String)).void
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
        # The address from which the goods are being shipped from.
        sig { returns(Tax::CalculationCreateParams::ShipFromDetails::Address) }
        def address; end
        sig {
          params(_address: Tax::CalculationCreateParams::ShipFromDetails::Address).returns(Tax::CalculationCreateParams::ShipFromDetails::Address)
         }
        def address=(_address); end
        sig { params(address: Tax::CalculationCreateParams::ShipFromDetails::Address).void }
        def initialize(address: nil); end
      end
      class ShippingCost < ::Stripe::RequestParams
        # A positive integer in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal) representing the shipping charge. If `tax_behavior=inclusive`, then this amount includes taxes. Otherwise, taxes are calculated on top of this amount.
        sig { returns(T.nilable(Integer)) }
        def amount; end
        sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def amount=(_amount); end
        # If provided, the [shipping rate](https://docs.stripe.com/api/shipping_rates/object)'s `amount`, `tax_code` and `tax_behavior` are used. If you provide a shipping rate, then you cannot pass the `amount`, `tax_code`, or `tax_behavior` parameters.
        sig { returns(T.nilable(String)) }
        def shipping_rate; end
        sig { params(_shipping_rate: T.nilable(String)).returns(T.nilable(String)) }
        def shipping_rate=(_shipping_rate); end
        # Specifies whether the `amount` includes taxes. If `tax_behavior=inclusive`, then the amount includes taxes. Defaults to `exclusive`.
        sig { returns(T.nilable(String)) }
        def tax_behavior; end
        sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
        def tax_behavior=(_tax_behavior); end
        # The [tax code](https://docs.stripe.com/tax/tax-categories) used to calculate tax on shipping. If not provided, the default shipping tax code from your [Tax Settings](https://dashboard.stripe.com/settings/tax) is used.
        sig { returns(T.nilable(String)) }
        def tax_code; end
        sig { params(_tax_code: T.nilable(String)).returns(T.nilable(String)) }
        def tax_code=(_tax_code); end
        sig {
          params(amount: T.nilable(Integer), shipping_rate: T.nilable(String), tax_behavior: T.nilable(String), tax_code: T.nilable(String)).void
         }
        def initialize(amount: nil, shipping_rate: nil, tax_behavior: nil, tax_code: nil); end
      end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      sig { params(_currency: String).returns(String) }
      def currency=(_currency); end
      # The ID of an existing customer to use for this calculation. If provided, the customer's address and tax IDs are copied to `customer_details`.
      sig { returns(T.nilable(String)) }
      def customer; end
      sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
      def customer=(_customer); end
      # Details about the customer, including address and tax IDs.
      sig { returns(T.nilable(Tax::CalculationCreateParams::CustomerDetails)) }
      def customer_details; end
      sig {
        params(_customer_details: T.nilable(Tax::CalculationCreateParams::CustomerDetails)).returns(T.nilable(Tax::CalculationCreateParams::CustomerDetails))
       }
      def customer_details=(_customer_details); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # A list of items the customer is purchasing.
      sig { returns(T::Array[Tax::CalculationCreateParams::LineItem]) }
      def line_items; end
      sig {
        params(_line_items: T::Array[Tax::CalculationCreateParams::LineItem]).returns(T::Array[Tax::CalculationCreateParams::LineItem])
       }
      def line_items=(_line_items); end
      # Details about the address from which the goods are being shipped.
      sig { returns(T.nilable(Tax::CalculationCreateParams::ShipFromDetails)) }
      def ship_from_details; end
      sig {
        params(_ship_from_details: T.nilable(Tax::CalculationCreateParams::ShipFromDetails)).returns(T.nilable(Tax::CalculationCreateParams::ShipFromDetails))
       }
      def ship_from_details=(_ship_from_details); end
      # Shipping cost details to be used for the calculation.
      sig { returns(T.nilable(Tax::CalculationCreateParams::ShippingCost)) }
      def shipping_cost; end
      sig {
        params(_shipping_cost: T.nilable(Tax::CalculationCreateParams::ShippingCost)).returns(T.nilable(Tax::CalculationCreateParams::ShippingCost))
       }
      def shipping_cost=(_shipping_cost); end
      # Timestamp of date at which the tax rules and rates in effect applies for the calculation. Measured in seconds since the Unix epoch. Can be up to 48 hours in the past, and up to 48 hours in the future.
      sig { returns(T.nilable(Integer)) }
      def tax_date; end
      sig { params(_tax_date: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def tax_date=(_tax_date); end
      sig {
        params(currency: String, customer: T.nilable(String), customer_details: T.nilable(Tax::CalculationCreateParams::CustomerDetails), expand: T.nilable(T::Array[String]), line_items: T::Array[Tax::CalculationCreateParams::LineItem], ship_from_details: T.nilable(Tax::CalculationCreateParams::ShipFromDetails), shipping_cost: T.nilable(Tax::CalculationCreateParams::ShippingCost), tax_date: T.nilable(Integer)).void
       }
      def initialize(
        currency: nil,
        customer: nil,
        customer_details: nil,
        expand: nil,
        line_items: nil,
        ship_from_details: nil,
        shipping_cost: nil,
        tax_date: nil
      ); end
    end
  end
end