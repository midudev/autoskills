# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # You can add one or multiple tax IDs to a [customer](https://docs.stripe.com/api/customers) or account.
  # Customer and account tax IDs get displayed on related invoices and credit notes.
  #
  # Related guides: [Customer tax identification numbers](https://docs.stripe.com/billing/taxes/tax-ids), [Account tax IDs](https://docs.stripe.com/invoicing/connect#account-tax-ids)
  class TaxId < APIResource
    class Owner < ::Stripe::StripeObject
      # The account being referenced when `type` is `account`.
      sig { returns(T.nilable(T.any(String, ::Stripe::Account))) }
      def account; end
      # The Connect Application being referenced when `type` is `application`.
      sig { returns(T.nilable(T.any(String, ::Stripe::Application))) }
      def application; end
      # The customer being referenced when `type` is `customer`.
      sig { returns(T.nilable(T.any(String, ::Stripe::Customer))) }
      def customer; end
      # The Account representing the customer being referenced when `type` is `customer`.
      sig { returns(T.nilable(String)) }
      def customer_account; end
      # Type of owner referenced.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Verification < ::Stripe::StripeObject
      # Verification status, one of `pending`, `verified`, `unverified`, or `unavailable`.
      sig { returns(String) }
      def status; end
      # Verified address.
      sig { returns(T.nilable(String)) }
      def verified_address; end
      # Verified name.
      sig { returns(T.nilable(String)) }
      def verified_name; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Two-letter ISO code representing the country of the tax ID.
    sig { returns(T.nilable(String)) }
    def country; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # ID of the customer.
    sig { returns(T.nilable(T.any(String, ::Stripe::Customer))) }
    def customer; end
    # ID of the Account representing the customer.
    sig { returns(T.nilable(String)) }
    def customer_account; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The account or customer the tax ID belongs to.
    sig { returns(T.nilable(Owner)) }
    def owner; end
    # Type of the tax ID, one of `ad_nrt`, `ae_trn`, `al_tin`, `am_tin`, `ao_tin`, `ar_cuit`, `au_abn`, `au_arn`, `aw_tin`, `az_tin`, `ba_tin`, `bb_tin`, `bd_bin`, `bf_ifu`, `bg_uic`, `bh_vat`, `bj_ifu`, `bo_tin`, `br_cnpj`, `br_cpf`, `bs_tin`, `by_tin`, `ca_bn`, `ca_gst_hst`, `ca_pst_bc`, `ca_pst_mb`, `ca_pst_sk`, `ca_qst`, `cd_nif`, `ch_uid`, `ch_vat`, `cl_tin`, `cm_niu`, `cn_tin`, `co_nit`, `cr_tin`, `cv_nif`, `de_stn`, `do_rcn`, `ec_ruc`, `eg_tin`, `es_cif`, `et_tin`, `eu_oss_vat`, `eu_vat`, `gb_vat`, `ge_vat`, `gn_nif`, `hk_br`, `hr_oib`, `hu_tin`, `id_npwp`, `il_vat`, `in_gst`, `is_vat`, `jp_cn`, `jp_rn`, `jp_trn`, `ke_pin`, `kg_tin`, `kh_tin`, `kr_brn`, `kz_bin`, `la_tin`, `li_uid`, `li_vat`, `ma_vat`, `md_vat`, `me_pib`, `mk_vat`, `mr_nif`, `mx_rfc`, `my_frp`, `my_itn`, `my_sst`, `ng_tin`, `no_vat`, `no_voec`, `np_pan`, `nz_gst`, `om_vat`, `pe_ruc`, `ph_tin`, `ro_tin`, `rs_pib`, `ru_inn`, `ru_kpp`, `sa_vat`, `sg_gst`, `sg_uen`, `si_tin`, `sn_ninea`, `sr_fin`, `sv_nit`, `th_vat`, `tj_tin`, `tr_tin`, `tw_vat`, `tz_vat`, `ua_vat`, `ug_tin`, `us_ein`, `uy_ruc`, `uz_tin`, `uz_vat`, `ve_rif`, `vn_tin`, `za_vat`, `zm_tin`, or `zw_tin`. Note that some legacy tax IDs have type `unknown`
    sig { returns(String) }
    def type; end
    # Value of the tax ID.
    sig { returns(String) }
    def value; end
    # Tax ID verification information.
    sig { returns(T.nilable(Verification)) }
    def verification; end
    # Always true for a deleted object
    sig { returns(T.nilable(T::Boolean)) }
    def deleted; end
    # Creates a new account or customer tax_id object.
    sig {
      params(params: T.any(::Stripe::TaxIdCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TaxId)
     }
    def self.create(params = {}, opts = {}); end

    # Deletes an existing account or customer tax_id object.
    sig {
      params(id: String, params: T.any(::Stripe::TaxIdDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TaxId)
     }
    def self.delete(id, params = {}, opts = {}); end

    # Deletes an existing account or customer tax_id object.
    sig {
      params(params: T.any(::Stripe::TaxIdDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TaxId)
     }
    def delete(params = {}, opts = {}); end

    # Returns a list of tax IDs.
    sig {
      params(params: T.any(::Stripe::TaxIdListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end
  end
end