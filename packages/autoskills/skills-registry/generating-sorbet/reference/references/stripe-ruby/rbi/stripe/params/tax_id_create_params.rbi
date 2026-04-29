# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class TaxIdCreateParams < ::Stripe::RequestParams
    class Owner < ::Stripe::RequestParams
      # Connected Account the tax ID belongs to. Required when `type=account`
      sig { returns(T.nilable(String)) }
      def account; end
      sig { params(_account: T.nilable(String)).returns(T.nilable(String)) }
      def account=(_account); end
      # Customer the tax ID belongs to. Required when `type=customer`
      sig { returns(T.nilable(String)) }
      def customer; end
      sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
      def customer=(_customer); end
      # ID of the Account representing the customer that the tax ID belongs to. Can be used in place of `customer` when `type=customer`
      sig { returns(T.nilable(String)) }
      def customer_account; end
      sig { params(_customer_account: T.nilable(String)).returns(T.nilable(String)) }
      def customer_account=(_customer_account); end
      # Type of owner referenced.
      sig { returns(String) }
      def type; end
      sig { params(_type: String).returns(String) }
      def type=(_type); end
      sig {
        params(account: T.nilable(String), customer: T.nilable(String), customer_account: T.nilable(String), type: String).void
       }
      def initialize(account: nil, customer: nil, customer_account: nil, type: nil); end
    end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # The account or customer the tax ID belongs to. Defaults to `owner[type]=self`.
    sig { returns(T.nilable(TaxIdCreateParams::Owner)) }
    def owner; end
    sig {
      params(_owner: T.nilable(TaxIdCreateParams::Owner)).returns(T.nilable(TaxIdCreateParams::Owner))
     }
    def owner=(_owner); end
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
    sig {
      params(expand: T.nilable(T::Array[String]), owner: T.nilable(TaxIdCreateParams::Owner), type: String, value: String).void
     }
    def initialize(expand: nil, owner: nil, type: nil, value: nil); end
  end
end