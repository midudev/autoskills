# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    # A Tax Transaction records the tax collected from or refunded to your customer.
    #
    # Related guide: [Calculate tax in your custom payment flow](https://docs.stripe.com/tax/custom#tax-transaction)
    class Transaction < APIResource
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
      class Reversal < ::Stripe::StripeObject
        # The `id` of the reversed `Transaction` object.
        sig { returns(T.nilable(String)) }
        def original_transaction; end
        def self.inner_class_types
          @inner_class_types = {}
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
        # Detailed account of taxes relevant to shipping cost. (It is not populated for the transaction resource object and will be removed in the next API version.)
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
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # The ID of an existing [Customer](https://docs.stripe.com/api/customers/object) used for the resource.
      sig { returns(T.nilable(String)) }
      def customer; end
      # Attribute for field customer_details
      sig { returns(CustomerDetails) }
      def customer_details; end
      # Unique identifier for the transaction.
      sig { returns(String) }
      def id; end
      # The tax collected or refunded, by line item.
      sig { returns(T.nilable(::Stripe::ListObject)) }
      def line_items; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The Unix timestamp representing when the tax liability is assumed or reduced.
      sig { returns(Integer) }
      def posted_at; end
      # A custom unique identifier, such as 'myOrder_123'.
      sig { returns(String) }
      def reference; end
      # If `type=reversal`, contains information about what was reversed.
      sig { returns(T.nilable(Reversal)) }
      def reversal; end
      # The details of the ship from location, such as the address.
      sig { returns(T.nilable(ShipFromDetails)) }
      def ship_from_details; end
      # The shipping cost details for the transaction.
      sig { returns(T.nilable(ShippingCost)) }
      def shipping_cost; end
      # Timestamp of date at which the tax rules and rates in effect applies for the calculation.
      sig { returns(Integer) }
      def tax_date; end
      # If `reversal`, this transaction reverses an earlier transaction.
      sig { returns(String) }
      def type; end
      # Creates a Tax Transaction from a calculation, if that calculation hasn't expired. Calculations expire after 90 days.
      sig {
        params(params: T.any(::Stripe::Tax::TransactionCreateFromCalculationParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Tax::Transaction)
       }
      def self.create_from_calculation(params = {}, opts = {}); end

      # Partially or fully reverses a previously created Transaction.
      sig {
        params(params: T.any(::Stripe::Tax::TransactionCreateReversalParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Tax::Transaction)
       }
      def self.create_reversal(params = {}, opts = {}); end

      # Retrieves the line items of a committed standalone transaction as a collection.
      sig {
        params(params: T.any(::Stripe::Tax::TransactionListLineItemsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list_line_items(params = {}, opts = {}); end

      # Retrieves the line items of a committed standalone transaction as a collection.
      sig {
        params(transaction: String, params: T.any(::Stripe::Tax::TransactionListLineItemsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list_line_items(transaction, params = {}, opts = {}); end
    end
  end
end