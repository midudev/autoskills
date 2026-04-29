# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentMethodConfigurationUpdateParams < ::Stripe::RequestParams
    class AcssDebit < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::AcssDebit::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::AcssDebit::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::AcssDebit::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::AcssDebit::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Affirm < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Affirm::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Affirm::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Affirm::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Affirm::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class AfterpayClearpay < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::AfterpayClearpay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::AfterpayClearpay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::AfterpayClearpay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::AfterpayClearpay::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Alipay < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Alipay::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Alipay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Alipay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Alipay::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Alma < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Alma::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Alma::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Alma::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Alma::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class AmazonPay < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::AmazonPay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::AmazonPay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::AmazonPay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::AmazonPay::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class ApplePay < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::ApplePay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::ApplePay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::ApplePay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::ApplePay::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class ApplePayLater < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::ApplePayLater::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::ApplePayLater::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::ApplePayLater::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::ApplePayLater::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class AuBecsDebit < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::AuBecsDebit::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::AuBecsDebit::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::AuBecsDebit::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::AuBecsDebit::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class BacsDebit < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::BacsDebit::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::BacsDebit::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::BacsDebit::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::BacsDebit::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Bancontact < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::Bancontact::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Bancontact::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Bancontact::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Bancontact::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Billie < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Billie::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Billie::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Billie::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Billie::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Blik < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Blik::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Blik::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Blik::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Blik::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Boleto < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Boleto::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Boleto::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Boleto::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Boleto::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Card < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Card::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Card::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Card::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Card::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class CartesBancaires < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::CartesBancaires::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::CartesBancaires::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::CartesBancaires::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::CartesBancaires::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Cashapp < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Cashapp::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Cashapp::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Cashapp::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Cashapp::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Crypto < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Crypto::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Crypto::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Crypto::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Crypto::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class CustomerBalance < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::CustomerBalance::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::CustomerBalance::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::CustomerBalance::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::CustomerBalance::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Eps < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Eps::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Eps::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Eps::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Eps::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Fpx < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Fpx::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Fpx::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Fpx::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Fpx::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class FrMealVoucherConecs < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::FrMealVoucherConecs::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::FrMealVoucherConecs::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::FrMealVoucherConecs::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::FrMealVoucherConecs::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Giropay < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Giropay::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Giropay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Giropay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Giropay::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class GooglePay < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::GooglePay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::GooglePay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::GooglePay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::GooglePay::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Grabpay < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Grabpay::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Grabpay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Grabpay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Grabpay::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Ideal < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Ideal::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Ideal::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Ideal::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Ideal::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Jcb < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Jcb::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Jcb::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Jcb::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Jcb::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class KakaoPay < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::KakaoPay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::KakaoPay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::KakaoPay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::KakaoPay::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Klarna < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Klarna::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Klarna::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Klarna::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Klarna::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Konbini < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Konbini::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Konbini::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Konbini::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Konbini::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class KrCard < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::KrCard::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::KrCard::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::KrCard::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::KrCard::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Link < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Link::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Link::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Link::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Link::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class MbWay < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::MbWay::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::MbWay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::MbWay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::MbWay::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Mobilepay < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::Mobilepay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Mobilepay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Mobilepay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Mobilepay::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Multibanco < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::Multibanco::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Multibanco::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Multibanco::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Multibanco::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class NaverPay < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::NaverPay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::NaverPay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::NaverPay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::NaverPay::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class NzBankAccount < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::NzBankAccount::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::NzBankAccount::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::NzBankAccount::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::NzBankAccount::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Oxxo < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Oxxo::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Oxxo::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Oxxo::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Oxxo::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class P24 < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::P24::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::P24::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::P24::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::P24::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class PayByBank < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::PayByBank::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::PayByBank::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::PayByBank::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::PayByBank::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Payco < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Payco::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Payco::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Payco::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Payco::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Paynow < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Paynow::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Paynow::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Paynow::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Paynow::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Paypal < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Paypal::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Paypal::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Paypal::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Paypal::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Payto < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Payto::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Payto::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Payto::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Payto::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Pix < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Pix::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Pix::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Pix::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Pix::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Promptpay < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::Promptpay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Promptpay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Promptpay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Promptpay::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class RevolutPay < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::RevolutPay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::RevolutPay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::RevolutPay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::RevolutPay::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class SamsungPay < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::SamsungPay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::SamsungPay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::SamsungPay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::SamsungPay::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Satispay < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::Satispay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Satispay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Satispay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Satispay::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class SepaDebit < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::SepaDebit::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::SepaDebit::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::SepaDebit::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::SepaDebit::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Sofort < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Sofort::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Sofort::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Sofort::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Sofort::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Swish < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Swish::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Swish::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Swish::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Swish::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Twint < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Twint::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Twint::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Twint::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Twint::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class UsBankAccount < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::UsBankAccount::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::UsBankAccount::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::UsBankAccount::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::UsBankAccount::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class WechatPay < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig {
        returns(T.nilable(PaymentMethodConfigurationUpdateParams::WechatPay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::WechatPay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::WechatPay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::WechatPay::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    class Zip < ::Stripe::RequestParams
      class DisplayPreference < ::Stripe::RequestParams
        # The account's preference for whether or not to display this payment method.
        sig { returns(T.nilable(String)) }
        def preference; end
        sig { params(_preference: T.nilable(String)).returns(T.nilable(String)) }
        def preference=(_preference); end
        sig { params(preference: T.nilable(String)).void }
        def initialize(preference: nil); end
      end
      # Whether or not the payment method should be displayed.
      sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Zip::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Zip::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Zip::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationUpdateParams::Zip::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    # Canadian pre-authorized debit payments, check this [page](https://docs.stripe.com/payments/acss-debit) for more details like country availability.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::AcssDebit)) }
    def acss_debit; end
    sig {
      params(_acss_debit: T.nilable(PaymentMethodConfigurationUpdateParams::AcssDebit)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::AcssDebit))
     }
    def acss_debit=(_acss_debit); end
    # Whether the configuration can be used for new payments.
    sig { returns(T.nilable(T::Boolean)) }
    def active; end
    sig { params(_active: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def active=(_active); end
    # [Affirm](https://www.affirm.com/) gives your customers a way to split purchases over a series of payments. Depending on the purchase, they can pay with four interest-free payments (Split Pay) or pay over a longer term (Installments), which might include interest. Check this [page](https://docs.stripe.com/payments/affirm) for more details like country availability.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Affirm)) }
    def affirm; end
    sig {
      params(_affirm: T.nilable(PaymentMethodConfigurationUpdateParams::Affirm)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Affirm))
     }
    def affirm=(_affirm); end
    # Afterpay gives your customers a way to pay for purchases in installments, check this [page](https://docs.stripe.com/payments/afterpay-clearpay) for more details like country availability. Afterpay is particularly popular among businesses selling fashion, beauty, and sports products.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::AfterpayClearpay)) }
    def afterpay_clearpay; end
    sig {
      params(_afterpay_clearpay: T.nilable(PaymentMethodConfigurationUpdateParams::AfterpayClearpay)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::AfterpayClearpay))
     }
    def afterpay_clearpay=(_afterpay_clearpay); end
    # Alipay is a digital wallet in China that has more than a billion active users worldwide. Alipay users can pay on the web or on a mobile device using login credentials or their Alipay app. Alipay has a low dispute rate and reduces fraud by authenticating payments using the customer's login credentials. Check this [page](https://docs.stripe.com/payments/alipay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Alipay)) }
    def alipay; end
    sig {
      params(_alipay: T.nilable(PaymentMethodConfigurationUpdateParams::Alipay)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Alipay))
     }
    def alipay=(_alipay); end
    # Alma is a Buy Now, Pay Later payment method that offers customers the ability to pay in 2, 3, or 4 installments.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Alma)) }
    def alma; end
    sig {
      params(_alma: T.nilable(PaymentMethodConfigurationUpdateParams::Alma)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Alma))
     }
    def alma=(_alma); end
    # Amazon Pay is a wallet payment method that lets your customers check out the same way as on Amazon.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::AmazonPay)) }
    def amazon_pay; end
    sig {
      params(_amazon_pay: T.nilable(PaymentMethodConfigurationUpdateParams::AmazonPay)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::AmazonPay))
     }
    def amazon_pay=(_amazon_pay); end
    # Stripe users can accept [Apple Pay](https://stripe.com/payments/apple-pay) in iOS applications in iOS 9 and later, and on the web in Safari starting with iOS 10 or macOS Sierra. There are no additional fees to process Apple Pay payments, and the [pricing](https://stripe.com/pricing) is the same as other card transactions. Check this [page](https://docs.stripe.com/apple-pay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::ApplePay)) }
    def apple_pay; end
    sig {
      params(_apple_pay: T.nilable(PaymentMethodConfigurationUpdateParams::ApplePay)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::ApplePay))
     }
    def apple_pay=(_apple_pay); end
    # Apple Pay Later, a payment method for customers to buy now and pay later, gives your customers a way to split purchases into four installments across six weeks.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::ApplePayLater)) }
    def apple_pay_later; end
    sig {
      params(_apple_pay_later: T.nilable(PaymentMethodConfigurationUpdateParams::ApplePayLater)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::ApplePayLater))
     }
    def apple_pay_later=(_apple_pay_later); end
    # Stripe users in Australia can accept Bulk Electronic Clearing System (BECS) direct debit payments from customers with an Australian bank account. Check this [page](https://docs.stripe.com/payments/au-becs-debit) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::AuBecsDebit)) }
    def au_becs_debit; end
    sig {
      params(_au_becs_debit: T.nilable(PaymentMethodConfigurationUpdateParams::AuBecsDebit)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::AuBecsDebit))
     }
    def au_becs_debit=(_au_becs_debit); end
    # Stripe users in the UK can accept Bacs Direct Debit payments from customers with a UK bank account, check this [page](https://docs.stripe.com/payments/payment-methods/bacs-debit) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::BacsDebit)) }
    def bacs_debit; end
    sig {
      params(_bacs_debit: T.nilable(PaymentMethodConfigurationUpdateParams::BacsDebit)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::BacsDebit))
     }
    def bacs_debit=(_bacs_debit); end
    # Bancontact is the most popular online payment method in Belgium, with over 15 million cards in circulation. [Customers](https://docs.stripe.com/api/customers) use a Bancontact card or mobile app linked to a Belgian bank account to make online payments that are secure, guaranteed, and confirmed immediately. Check this [page](https://docs.stripe.com/payments/bancontact) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Bancontact)) }
    def bancontact; end
    sig {
      params(_bancontact: T.nilable(PaymentMethodConfigurationUpdateParams::Bancontact)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Bancontact))
     }
    def bancontact=(_bancontact); end
    # Billie is a [single-use](https://docs.stripe.com/payments/payment-methods#usage) payment method that offers businesses Pay by Invoice where they offer payment terms ranging from 7-120 days. Customers are redirected from your website or app, authorize the payment with Billie, then return to your website or app. You get [immediate notification](/payments/payment-methods#payment-notification) of whether the payment succeeded or failed.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Billie)) }
    def billie; end
    sig {
      params(_billie: T.nilable(PaymentMethodConfigurationUpdateParams::Billie)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Billie))
     }
    def billie=(_billie); end
    # BLIK is a [single use](https://docs.stripe.com/payments/payment-methods#usage) payment method that requires customers to authenticate their payments. When customers want to pay online using BLIK, they request a six-digit code from their banking application and enter it into the payment collection form. Check this [page](https://docs.stripe.com/payments/blik) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Blik)) }
    def blik; end
    sig {
      params(_blik: T.nilable(PaymentMethodConfigurationUpdateParams::Blik)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Blik))
     }
    def blik=(_blik); end
    # Boleto is an official (regulated by the Central Bank of Brazil) payment method in Brazil. Check this [page](https://docs.stripe.com/payments/boleto) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Boleto)) }
    def boleto; end
    sig {
      params(_boleto: T.nilable(PaymentMethodConfigurationUpdateParams::Boleto)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Boleto))
     }
    def boleto=(_boleto); end
    # Cards are a popular way for consumers and businesses to pay online or in person. Stripe supports global and local card networks.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Card)) }
    def card; end
    sig {
      params(_card: T.nilable(PaymentMethodConfigurationUpdateParams::Card)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Card))
     }
    def card=(_card); end
    # Cartes Bancaires is France's local card network. More than 95% of these cards are co-branded with either Visa or Mastercard, meaning you can process these cards over either Cartes Bancaires or the Visa or Mastercard networks. Check this [page](https://docs.stripe.com/payments/cartes-bancaires) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::CartesBancaires)) }
    def cartes_bancaires; end
    sig {
      params(_cartes_bancaires: T.nilable(PaymentMethodConfigurationUpdateParams::CartesBancaires)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::CartesBancaires))
     }
    def cartes_bancaires=(_cartes_bancaires); end
    # Cash App is a popular consumer app in the US that allows customers to bank, invest, send, and receive money using their digital wallet. Check this [page](https://docs.stripe.com/payments/cash-app-pay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Cashapp)) }
    def cashapp; end
    sig {
      params(_cashapp: T.nilable(PaymentMethodConfigurationUpdateParams::Cashapp)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Cashapp))
     }
    def cashapp=(_cashapp); end
    # [Stablecoin payments](https://docs.stripe.com/payments/stablecoin-payments) enable customers to pay in stablecoins like USDC from 100s of wallets including Phantom and Metamask.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Crypto)) }
    def crypto; end
    sig {
      params(_crypto: T.nilable(PaymentMethodConfigurationUpdateParams::Crypto)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Crypto))
     }
    def crypto=(_crypto); end
    # Uses a customer’s [cash balance](https://docs.stripe.com/payments/customer-balance) for the payment. The cash balance can be funded via a bank transfer. Check this [page](https://docs.stripe.com/payments/bank-transfers) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::CustomerBalance)) }
    def customer_balance; end
    sig {
      params(_customer_balance: T.nilable(PaymentMethodConfigurationUpdateParams::CustomerBalance)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::CustomerBalance))
     }
    def customer_balance=(_customer_balance); end
    # EPS is an Austria-based payment method that allows customers to complete transactions online using their bank credentials. EPS is supported by all Austrian banks and is accepted by over 80% of Austrian online retailers. Check this [page](https://docs.stripe.com/payments/eps) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Eps)) }
    def eps; end
    sig {
      params(_eps: T.nilable(PaymentMethodConfigurationUpdateParams::Eps)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Eps))
     }
    def eps=(_eps); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Financial Process Exchange (FPX) is a Malaysia-based payment method that allows customers to complete transactions online using their bank credentials. Bank Negara Malaysia (BNM), the Central Bank of Malaysia, and eleven other major Malaysian financial institutions are members of the PayNet Group, which owns and operates FPX. It is one of the most popular online payment methods in Malaysia, with nearly 90 million transactions in 2018 according to BNM. Check this [page](https://docs.stripe.com/payments/fpx) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Fpx)) }
    def fpx; end
    sig {
      params(_fpx: T.nilable(PaymentMethodConfigurationUpdateParams::Fpx)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Fpx))
     }
    def fpx=(_fpx); end
    # Meal vouchers in France, or “titres-restaurant”, is a local benefits program commonly offered by employers for their employees to purchase prepared food and beverages on working days. Check this [page](https://docs.stripe.com/payments/benefits/fr-meal-vouchers) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::FrMealVoucherConecs)) }
    def fr_meal_voucher_conecs; end
    sig {
      params(_fr_meal_voucher_conecs: T.nilable(PaymentMethodConfigurationUpdateParams::FrMealVoucherConecs)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::FrMealVoucherConecs))
     }
    def fr_meal_voucher_conecs=(_fr_meal_voucher_conecs); end
    # giropay is a German payment method based on online banking, introduced in 2006. It allows customers to complete transactions online using their online banking environment, with funds debited from their bank account. Depending on their bank, customers confirm payments on giropay using a second factor of authentication or a PIN. giropay accounts for 10% of online checkouts in Germany. Check this [page](https://docs.stripe.com/payments/giropay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Giropay)) }
    def giropay; end
    sig {
      params(_giropay: T.nilable(PaymentMethodConfigurationUpdateParams::Giropay)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Giropay))
     }
    def giropay=(_giropay); end
    # Google Pay allows customers to make payments in your app or website using any credit or debit card saved to their Google Account, including those from Google Play, YouTube, Chrome, or an Android device. Use the Google Pay API to request any credit or debit card stored in your customer's Google account. Check this [page](https://docs.stripe.com/google-pay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::GooglePay)) }
    def google_pay; end
    sig {
      params(_google_pay: T.nilable(PaymentMethodConfigurationUpdateParams::GooglePay)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::GooglePay))
     }
    def google_pay=(_google_pay); end
    # GrabPay is a payment method developed by [Grab](https://www.grab.com/sg/consumer/finance/pay/). GrabPay is a digital wallet - customers maintain a balance in their wallets that they pay out with. Check this [page](https://docs.stripe.com/payments/grabpay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Grabpay)) }
    def grabpay; end
    sig {
      params(_grabpay: T.nilable(PaymentMethodConfigurationUpdateParams::Grabpay)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Grabpay))
     }
    def grabpay=(_grabpay); end
    # iDEAL is a Netherlands-based payment method that allows customers to complete transactions online using their bank credentials. All major Dutch banks are members of Currence, the scheme that operates iDEAL, making it the most popular online payment method in the Netherlands with a share of online transactions close to 55%. Check this [page](https://docs.stripe.com/payments/ideal) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Ideal)) }
    def ideal; end
    sig {
      params(_ideal: T.nilable(PaymentMethodConfigurationUpdateParams::Ideal)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Ideal))
     }
    def ideal=(_ideal); end
    # JCB is a credit card company based in Japan. JCB is currently available in Japan to businesses approved by JCB, and available to all businesses in Australia, Canada, Hong Kong, Japan, New Zealand, Singapore, Switzerland, United Kingdom, United States, and all countries in the European Economic Area except Iceland. Check this [page](https://support.stripe.com/questions/accepting-japan-credit-bureau-%28jcb%29-payments) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Jcb)) }
    def jcb; end
    sig {
      params(_jcb: T.nilable(PaymentMethodConfigurationUpdateParams::Jcb)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Jcb))
     }
    def jcb=(_jcb); end
    # Kakao Pay is a popular local wallet available in South Korea.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::KakaoPay)) }
    def kakao_pay; end
    sig {
      params(_kakao_pay: T.nilable(PaymentMethodConfigurationUpdateParams::KakaoPay)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::KakaoPay))
     }
    def kakao_pay=(_kakao_pay); end
    # Klarna gives customers a range of [payment options](https://docs.stripe.com/payments/klarna#payment-options) during checkout. Available payment options vary depending on the customer's billing address and the transaction amount. These payment options make it convenient for customers to purchase items in all price ranges. Check this [page](https://docs.stripe.com/payments/klarna) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Klarna)) }
    def klarna; end
    sig {
      params(_klarna: T.nilable(PaymentMethodConfigurationUpdateParams::Klarna)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Klarna))
     }
    def klarna=(_klarna); end
    # Konbini allows customers in Japan to pay for bills and online purchases at convenience stores with cash. Check this [page](https://docs.stripe.com/payments/konbini) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Konbini)) }
    def konbini; end
    sig {
      params(_konbini: T.nilable(PaymentMethodConfigurationUpdateParams::Konbini)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Konbini))
     }
    def konbini=(_konbini); end
    # Korean cards let users pay using locally issued cards from South Korea.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::KrCard)) }
    def kr_card; end
    sig {
      params(_kr_card: T.nilable(PaymentMethodConfigurationUpdateParams::KrCard)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::KrCard))
     }
    def kr_card=(_kr_card); end
    # [Link](https://docs.stripe.com/payments/link) is a payment method network. With Link, users save their payment details once, then reuse that information to pay with one click for any business on the network.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Link)) }
    def link; end
    sig {
      params(_link: T.nilable(PaymentMethodConfigurationUpdateParams::Link)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Link))
     }
    def link=(_link); end
    # MB WAY is the most popular wallet in Portugal. After entering their phone number in your checkout, customers approve the payment directly in their MB WAY app. Check this [page](https://docs.stripe.com/payments/mb-way) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::MbWay)) }
    def mb_way; end
    sig {
      params(_mb_way: T.nilable(PaymentMethodConfigurationUpdateParams::MbWay)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::MbWay))
     }
    def mb_way=(_mb_way); end
    # MobilePay is a [single-use](https://docs.stripe.com/payments/payment-methods#usage) card wallet payment method used in Denmark and Finland. It allows customers to [authenticate and approve](https://docs.stripe.com/payments/payment-methods#customer-actions) payments using the MobilePay app. Check this [page](https://docs.stripe.com/payments/mobilepay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Mobilepay)) }
    def mobilepay; end
    sig {
      params(_mobilepay: T.nilable(PaymentMethodConfigurationUpdateParams::Mobilepay)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Mobilepay))
     }
    def mobilepay=(_mobilepay); end
    # Stripe users in Europe and the United States can accept Multibanco payments from customers in Portugal using [Sources](https://stripe.com/docs/sources)—a single integration path for creating payments using any supported method.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Multibanco)) }
    def multibanco; end
    sig {
      params(_multibanco: T.nilable(PaymentMethodConfigurationUpdateParams::Multibanco)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Multibanco))
     }
    def multibanco=(_multibanco); end
    # Configuration name.
    sig { returns(T.nilable(String)) }
    def name; end
    sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
    def name=(_name); end
    # Naver Pay is a popular local wallet available in South Korea.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::NaverPay)) }
    def naver_pay; end
    sig {
      params(_naver_pay: T.nilable(PaymentMethodConfigurationUpdateParams::NaverPay)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::NaverPay))
     }
    def naver_pay=(_naver_pay); end
    # Stripe users in New Zealand can accept Bulk Electronic Clearing System (BECS) direct debit payments from customers with a New Zeland bank account. Check this [page](https://docs.stripe.com/payments/nz-bank-account) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::NzBankAccount)) }
    def nz_bank_account; end
    sig {
      params(_nz_bank_account: T.nilable(PaymentMethodConfigurationUpdateParams::NzBankAccount)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::NzBankAccount))
     }
    def nz_bank_account=(_nz_bank_account); end
    # OXXO is a Mexican chain of convenience stores with thousands of locations across Latin America and represents nearly 20% of online transactions in Mexico. OXXO allows customers to pay bills and online purchases in-store with cash. Check this [page](https://docs.stripe.com/payments/oxxo) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Oxxo)) }
    def oxxo; end
    sig {
      params(_oxxo: T.nilable(PaymentMethodConfigurationUpdateParams::Oxxo)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Oxxo))
     }
    def oxxo=(_oxxo); end
    # Przelewy24 is a Poland-based payment method aggregator that allows customers to complete transactions online using bank transfers and other methods. Bank transfers account for 30% of online payments in Poland and Przelewy24 provides a way for customers to pay with over 165 banks. Check this [page](https://docs.stripe.com/payments/p24) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::P24)) }
    def p24; end
    sig {
      params(_p24: T.nilable(PaymentMethodConfigurationUpdateParams::P24)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::P24))
     }
    def p24=(_p24); end
    # Pay by bank is a redirect payment method backed by bank transfers. A customer is redirected to their bank to authorize a bank transfer for a given amount. This removes a lot of the error risks inherent in waiting for the customer to initiate a transfer themselves, and is less expensive than card payments.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::PayByBank)) }
    def pay_by_bank; end
    sig {
      params(_pay_by_bank: T.nilable(PaymentMethodConfigurationUpdateParams::PayByBank)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::PayByBank))
     }
    def pay_by_bank=(_pay_by_bank); end
    # PAYCO is a [single-use](https://docs.stripe.com/payments/payment-methods#usage local wallet available in South Korea.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Payco)) }
    def payco; end
    sig {
      params(_payco: T.nilable(PaymentMethodConfigurationUpdateParams::Payco)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Payco))
     }
    def payco=(_payco); end
    # PayNow is a Singapore-based payment method that allows customers to make a payment using their preferred app from participating banks and participating non-bank financial institutions. Check this [page](https://docs.stripe.com/payments/paynow) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Paynow)) }
    def paynow; end
    sig {
      params(_paynow: T.nilable(PaymentMethodConfigurationUpdateParams::Paynow)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Paynow))
     }
    def paynow=(_paynow); end
    # PayPal, a digital wallet popular with customers in Europe, allows your customers worldwide to pay using their PayPal account. Check this [page](https://docs.stripe.com/payments/paypal) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Paypal)) }
    def paypal; end
    sig {
      params(_paypal: T.nilable(PaymentMethodConfigurationUpdateParams::Paypal)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Paypal))
     }
    def paypal=(_paypal); end
    # PayTo is a [real-time](https://docs.stripe.com/payments/real-time) payment method that enables customers in Australia to pay by providing their bank account details. Customers must accept a mandate authorizing you to debit their account. Check this [page](https://docs.stripe.com/payments/payto) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Payto)) }
    def payto; end
    sig {
      params(_payto: T.nilable(PaymentMethodConfigurationUpdateParams::Payto)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Payto))
     }
    def payto=(_payto); end
    # Pix is a payment method popular in Brazil. When paying with Pix, customers authenticate and approve payments by scanning a QR code in their preferred banking app. Check this [page](https://docs.stripe.com/payments/pix) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Pix)) }
    def pix; end
    sig {
      params(_pix: T.nilable(PaymentMethodConfigurationUpdateParams::Pix)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Pix))
     }
    def pix=(_pix); end
    # PromptPay is a Thailand-based payment method that allows customers to make a payment using their preferred app from participating banks. Check this [page](https://docs.stripe.com/payments/promptpay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Promptpay)) }
    def promptpay; end
    sig {
      params(_promptpay: T.nilable(PaymentMethodConfigurationUpdateParams::Promptpay)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Promptpay))
     }
    def promptpay=(_promptpay); end
    # Revolut Pay, developed by Revolut, a global finance app, is a digital wallet payment method. Revolut Pay uses the customer’s stored balance or cards to fund the payment, and offers the option for non-Revolut customers to save their details after their first purchase.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::RevolutPay)) }
    def revolut_pay; end
    sig {
      params(_revolut_pay: T.nilable(PaymentMethodConfigurationUpdateParams::RevolutPay)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::RevolutPay))
     }
    def revolut_pay=(_revolut_pay); end
    # Samsung Pay is a [single-use](https://docs.stripe.com/payments/payment-methods#usage local wallet available in South Korea.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::SamsungPay)) }
    def samsung_pay; end
    sig {
      params(_samsung_pay: T.nilable(PaymentMethodConfigurationUpdateParams::SamsungPay)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::SamsungPay))
     }
    def samsung_pay=(_samsung_pay); end
    # Satispay is a [single-use](https://docs.stripe.com/payments/payment-methods#usage) payment method where customers are required to [authenticate](/payments/payment-methods#customer-actions) their payment. Customers pay by being redirected from your website or app, authorizing the payment with Satispay, then returning to your website or app. You get [immediate notification](/payments/payment-methods#payment-notification) of whether the payment succeeded or failed.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Satispay)) }
    def satispay; end
    sig {
      params(_satispay: T.nilable(PaymentMethodConfigurationUpdateParams::Satispay)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Satispay))
     }
    def satispay=(_satispay); end
    # The [Single Euro Payments Area (SEPA)](https://en.wikipedia.org/wiki/Single_Euro_Payments_Area) is an initiative of the European Union to simplify payments within and across member countries. SEPA established and enforced banking standards to allow for the direct debiting of every EUR-denominated bank account within the SEPA region, check this [page](https://docs.stripe.com/payments/sepa-debit) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::SepaDebit)) }
    def sepa_debit; end
    sig {
      params(_sepa_debit: T.nilable(PaymentMethodConfigurationUpdateParams::SepaDebit)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::SepaDebit))
     }
    def sepa_debit=(_sepa_debit); end
    # Stripe users in Europe and the United States can use the [Payment Intents API](https://stripe.com/docs/payments/payment-intents)—a single integration path for creating payments using any supported method—to accept [Sofort](https://www.sofort.com/) payments from customers. Check this [page](https://docs.stripe.com/payments/sofort) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Sofort)) }
    def sofort; end
    sig {
      params(_sofort: T.nilable(PaymentMethodConfigurationUpdateParams::Sofort)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Sofort))
     }
    def sofort=(_sofort); end
    # Swish is a [real-time](https://docs.stripe.com/payments/real-time) payment method popular in Sweden. It allows customers to [authenticate and approve](https://docs.stripe.com/payments/payment-methods#customer-actions) payments using the Swish mobile app and the Swedish BankID mobile app. Check this [page](https://docs.stripe.com/payments/swish) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Swish)) }
    def swish; end
    sig {
      params(_swish: T.nilable(PaymentMethodConfigurationUpdateParams::Swish)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Swish))
     }
    def swish=(_swish); end
    # Twint is a payment method popular in Switzerland. It allows customers to pay using their mobile phone. Check this [page](https://docs.stripe.com/payments/twint) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Twint)) }
    def twint; end
    sig {
      params(_twint: T.nilable(PaymentMethodConfigurationUpdateParams::Twint)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Twint))
     }
    def twint=(_twint); end
    # Stripe users in the United States can accept ACH direct debit payments from customers with a US bank account using the Automated Clearing House (ACH) payments system operated by Nacha. Check this [page](https://docs.stripe.com/payments/ach-direct-debit) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::UsBankAccount)) }
    def us_bank_account; end
    sig {
      params(_us_bank_account: T.nilable(PaymentMethodConfigurationUpdateParams::UsBankAccount)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::UsBankAccount))
     }
    def us_bank_account=(_us_bank_account); end
    # WeChat, owned by Tencent, is China's leading mobile app with over 1 billion monthly active users. Chinese consumers can use WeChat Pay to pay for goods and services inside of businesses' apps and websites. WeChat Pay users buy most frequently in gaming, e-commerce, travel, online education, and food/nutrition. Check this [page](https://docs.stripe.com/payments/wechat-pay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::WechatPay)) }
    def wechat_pay; end
    sig {
      params(_wechat_pay: T.nilable(PaymentMethodConfigurationUpdateParams::WechatPay)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::WechatPay))
     }
    def wechat_pay=(_wechat_pay); end
    # Zip gives your customers a way to split purchases over a series of payments. Check this [page](https://docs.stripe.com/payments/zip) for more details like country availability.
    sig { returns(T.nilable(PaymentMethodConfigurationUpdateParams::Zip)) }
    def zip; end
    sig {
      params(_zip: T.nilable(PaymentMethodConfigurationUpdateParams::Zip)).returns(T.nilable(PaymentMethodConfigurationUpdateParams::Zip))
     }
    def zip=(_zip); end
    sig {
      params(acss_debit: T.nilable(PaymentMethodConfigurationUpdateParams::AcssDebit), active: T.nilable(T::Boolean), affirm: T.nilable(PaymentMethodConfigurationUpdateParams::Affirm), afterpay_clearpay: T.nilable(PaymentMethodConfigurationUpdateParams::AfterpayClearpay), alipay: T.nilable(PaymentMethodConfigurationUpdateParams::Alipay), alma: T.nilable(PaymentMethodConfigurationUpdateParams::Alma), amazon_pay: T.nilable(PaymentMethodConfigurationUpdateParams::AmazonPay), apple_pay: T.nilable(PaymentMethodConfigurationUpdateParams::ApplePay), apple_pay_later: T.nilable(PaymentMethodConfigurationUpdateParams::ApplePayLater), au_becs_debit: T.nilable(PaymentMethodConfigurationUpdateParams::AuBecsDebit), bacs_debit: T.nilable(PaymentMethodConfigurationUpdateParams::BacsDebit), bancontact: T.nilable(PaymentMethodConfigurationUpdateParams::Bancontact), billie: T.nilable(PaymentMethodConfigurationUpdateParams::Billie), blik: T.nilable(PaymentMethodConfigurationUpdateParams::Blik), boleto: T.nilable(PaymentMethodConfigurationUpdateParams::Boleto), card: T.nilable(PaymentMethodConfigurationUpdateParams::Card), cartes_bancaires: T.nilable(PaymentMethodConfigurationUpdateParams::CartesBancaires), cashapp: T.nilable(PaymentMethodConfigurationUpdateParams::Cashapp), crypto: T.nilable(PaymentMethodConfigurationUpdateParams::Crypto), customer_balance: T.nilable(PaymentMethodConfigurationUpdateParams::CustomerBalance), eps: T.nilable(PaymentMethodConfigurationUpdateParams::Eps), expand: T.nilable(T::Array[String]), fpx: T.nilable(PaymentMethodConfigurationUpdateParams::Fpx), fr_meal_voucher_conecs: T.nilable(PaymentMethodConfigurationUpdateParams::FrMealVoucherConecs), giropay: T.nilable(PaymentMethodConfigurationUpdateParams::Giropay), google_pay: T.nilable(PaymentMethodConfigurationUpdateParams::GooglePay), grabpay: T.nilable(PaymentMethodConfigurationUpdateParams::Grabpay), ideal: T.nilable(PaymentMethodConfigurationUpdateParams::Ideal), jcb: T.nilable(PaymentMethodConfigurationUpdateParams::Jcb), kakao_pay: T.nilable(PaymentMethodConfigurationUpdateParams::KakaoPay), klarna: T.nilable(PaymentMethodConfigurationUpdateParams::Klarna), konbini: T.nilable(PaymentMethodConfigurationUpdateParams::Konbini), kr_card: T.nilable(PaymentMethodConfigurationUpdateParams::KrCard), link: T.nilable(PaymentMethodConfigurationUpdateParams::Link), mb_way: T.nilable(PaymentMethodConfigurationUpdateParams::MbWay), mobilepay: T.nilable(PaymentMethodConfigurationUpdateParams::Mobilepay), multibanco: T.nilable(PaymentMethodConfigurationUpdateParams::Multibanco), name: T.nilable(String), naver_pay: T.nilable(PaymentMethodConfigurationUpdateParams::NaverPay), nz_bank_account: T.nilable(PaymentMethodConfigurationUpdateParams::NzBankAccount), oxxo: T.nilable(PaymentMethodConfigurationUpdateParams::Oxxo), p24: T.nilable(PaymentMethodConfigurationUpdateParams::P24), pay_by_bank: T.nilable(PaymentMethodConfigurationUpdateParams::PayByBank), payco: T.nilable(PaymentMethodConfigurationUpdateParams::Payco), paynow: T.nilable(PaymentMethodConfigurationUpdateParams::Paynow), paypal: T.nilable(PaymentMethodConfigurationUpdateParams::Paypal), payto: T.nilable(PaymentMethodConfigurationUpdateParams::Payto), pix: T.nilable(PaymentMethodConfigurationUpdateParams::Pix), promptpay: T.nilable(PaymentMethodConfigurationUpdateParams::Promptpay), revolut_pay: T.nilable(PaymentMethodConfigurationUpdateParams::RevolutPay), samsung_pay: T.nilable(PaymentMethodConfigurationUpdateParams::SamsungPay), satispay: T.nilable(PaymentMethodConfigurationUpdateParams::Satispay), sepa_debit: T.nilable(PaymentMethodConfigurationUpdateParams::SepaDebit), sofort: T.nilable(PaymentMethodConfigurationUpdateParams::Sofort), swish: T.nilable(PaymentMethodConfigurationUpdateParams::Swish), twint: T.nilable(PaymentMethodConfigurationUpdateParams::Twint), us_bank_account: T.nilable(PaymentMethodConfigurationUpdateParams::UsBankAccount), wechat_pay: T.nilable(PaymentMethodConfigurationUpdateParams::WechatPay), zip: T.nilable(PaymentMethodConfigurationUpdateParams::Zip)).void
     }
    def initialize(
      acss_debit: nil,
      active: nil,
      affirm: nil,
      afterpay_clearpay: nil,
      alipay: nil,
      alma: nil,
      amazon_pay: nil,
      apple_pay: nil,
      apple_pay_later: nil,
      au_becs_debit: nil,
      bacs_debit: nil,
      bancontact: nil,
      billie: nil,
      blik: nil,
      boleto: nil,
      card: nil,
      cartes_bancaires: nil,
      cashapp: nil,
      crypto: nil,
      customer_balance: nil,
      eps: nil,
      expand: nil,
      fpx: nil,
      fr_meal_voucher_conecs: nil,
      giropay: nil,
      google_pay: nil,
      grabpay: nil,
      ideal: nil,
      jcb: nil,
      kakao_pay: nil,
      klarna: nil,
      konbini: nil,
      kr_card: nil,
      link: nil,
      mb_way: nil,
      mobilepay: nil,
      multibanco: nil,
      name: nil,
      naver_pay: nil,
      nz_bank_account: nil,
      oxxo: nil,
      p24: nil,
      pay_by_bank: nil,
      payco: nil,
      paynow: nil,
      paypal: nil,
      payto: nil,
      pix: nil,
      promptpay: nil,
      revolut_pay: nil,
      samsung_pay: nil,
      satispay: nil,
      sepa_debit: nil,
      sofort: nil,
      swish: nil,
      twint: nil,
      us_bank_account: nil,
      wechat_pay: nil,
      zip: nil
    ); end
  end
end