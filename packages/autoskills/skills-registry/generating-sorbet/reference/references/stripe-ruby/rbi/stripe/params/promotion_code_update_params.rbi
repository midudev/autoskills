# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PromotionCodeUpdateParams < ::Stripe::RequestParams
    class Restrictions < ::Stripe::RequestParams
      class CurrencyOptions < ::Stripe::RequestParams
        # Minimum amount required to redeem this Promotion Code into a Coupon (e.g., a purchase must be $100 or more to work).
        sig { returns(T.nilable(Integer)) }
        def minimum_amount; end
        sig { params(_minimum_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def minimum_amount=(_minimum_amount); end
        sig { params(minimum_amount: T.nilable(Integer)).void }
        def initialize(minimum_amount: nil); end
      end
      # Promotion codes defined in each available currency option. Each key must be a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) and a [supported currency](https://stripe.com/docs/currencies).
      sig {
        returns(T.nilable(T::Hash[String, PromotionCodeUpdateParams::Restrictions::CurrencyOptions]))
       }
      def currency_options; end
      sig {
        params(_currency_options: T.nilable(T::Hash[String, PromotionCodeUpdateParams::Restrictions::CurrencyOptions])).returns(T.nilable(T::Hash[String, PromotionCodeUpdateParams::Restrictions::CurrencyOptions]))
       }
      def currency_options=(_currency_options); end
      sig {
        params(currency_options: T.nilable(T::Hash[String, PromotionCodeUpdateParams::Restrictions::CurrencyOptions])).void
       }
      def initialize(currency_options: nil); end
    end
    # Whether the promotion code is currently active. A promotion code can only be reactivated when the coupon is still valid and the promotion code is otherwise redeemable.
    sig { returns(T.nilable(T::Boolean)) }
    def active; end
    sig { params(_active: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def active=(_active); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # Settings that restrict the redemption of the promotion code.
    sig { returns(T.nilable(PromotionCodeUpdateParams::Restrictions)) }
    def restrictions; end
    sig {
      params(_restrictions: T.nilable(PromotionCodeUpdateParams::Restrictions)).returns(T.nilable(PromotionCodeUpdateParams::Restrictions))
     }
    def restrictions=(_restrictions); end
    sig {
      params(active: T.nilable(T::Boolean), expand: T.nilable(T::Array[String]), metadata: T.nilable(T.any(String, T::Hash[String, String])), restrictions: T.nilable(PromotionCodeUpdateParams::Restrictions)).void
     }
    def initialize(active: nil, expand: nil, metadata: nil, restrictions: nil); end
  end
end