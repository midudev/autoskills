# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentMethodConfigurationCreateParams < ::Stripe::RequestParams
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::AcssDebit::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::AcssDebit::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::AcssDebit::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::AcssDebit::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Affirm::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Affirm::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Affirm::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Affirm::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::AfterpayClearpay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::AfterpayClearpay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::AfterpayClearpay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::AfterpayClearpay::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Alipay::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Alipay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Alipay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Alipay::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Alma::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Alma::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Alma::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Alma::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::AmazonPay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::AmazonPay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::AmazonPay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::AmazonPay::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::ApplePay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::ApplePay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::ApplePay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::ApplePay::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::ApplePayLater::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::ApplePayLater::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::ApplePayLater::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::ApplePayLater::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::AuBecsDebit::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::AuBecsDebit::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::AuBecsDebit::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::AuBecsDebit::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::BacsDebit::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::BacsDebit::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::BacsDebit::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::BacsDebit::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::Bancontact::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Bancontact::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Bancontact::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Bancontact::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Billie::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Billie::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Billie::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Billie::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Blik::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Blik::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Blik::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Blik::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Boleto::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Boleto::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Boleto::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Boleto::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Card::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Card::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Card::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Card::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::CartesBancaires::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::CartesBancaires::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::CartesBancaires::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::CartesBancaires::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Cashapp::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Cashapp::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Cashapp::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Cashapp::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Crypto::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Crypto::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Crypto::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Crypto::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::CustomerBalance::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::CustomerBalance::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::CustomerBalance::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::CustomerBalance::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Eps::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Eps::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Eps::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Eps::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Fpx::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Fpx::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Fpx::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Fpx::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::FrMealVoucherConecs::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::FrMealVoucherConecs::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::FrMealVoucherConecs::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::FrMealVoucherConecs::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Giropay::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Giropay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Giropay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Giropay::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::GooglePay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::GooglePay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::GooglePay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::GooglePay::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Grabpay::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Grabpay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Grabpay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Grabpay::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Ideal::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Ideal::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Ideal::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Ideal::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Jcb::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Jcb::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Jcb::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Jcb::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::KakaoPay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::KakaoPay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::KakaoPay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::KakaoPay::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Klarna::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Klarna::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Klarna::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Klarna::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Konbini::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Konbini::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Konbini::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Konbini::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::KrCard::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::KrCard::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::KrCard::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::KrCard::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Link::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Link::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Link::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Link::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::MbWay::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::MbWay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::MbWay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::MbWay::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::Mobilepay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Mobilepay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Mobilepay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Mobilepay::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::Multibanco::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Multibanco::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Multibanco::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Multibanco::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::NaverPay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::NaverPay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::NaverPay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::NaverPay::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::NzBankAccount::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::NzBankAccount::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::NzBankAccount::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::NzBankAccount::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Oxxo::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Oxxo::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Oxxo::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Oxxo::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::P24::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::P24::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::P24::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::P24::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::PayByBank::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::PayByBank::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::PayByBank::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::PayByBank::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Payco::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Payco::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Payco::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Payco::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Paynow::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Paynow::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Paynow::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Paynow::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Paypal::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Paypal::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Paypal::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Paypal::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Payto::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Payto::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Payto::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Payto::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Pix::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Pix::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Pix::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Pix::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::Promptpay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Promptpay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Promptpay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Promptpay::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::RevolutPay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::RevolutPay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::RevolutPay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::RevolutPay::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::SamsungPay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::SamsungPay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::SamsungPay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::SamsungPay::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::Satispay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Satispay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Satispay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Satispay::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::SepaDebit::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::SepaDebit::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::SepaDebit::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::SepaDebit::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Sofort::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Sofort::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Sofort::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Sofort::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Swish::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Swish::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Swish::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Swish::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Twint::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Twint::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Twint::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Twint::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::UsBankAccount::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::UsBankAccount::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::UsBankAccount::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::UsBankAccount::DisplayPreference)).void
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
        returns(T.nilable(PaymentMethodConfigurationCreateParams::WechatPay::DisplayPreference))
       }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::WechatPay::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::WechatPay::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::WechatPay::DisplayPreference)).void
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
      sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Zip::DisplayPreference)) }
      def display_preference; end
      sig {
        params(_display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Zip::DisplayPreference)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Zip::DisplayPreference))
       }
      def display_preference=(_display_preference); end
      sig {
        params(display_preference: T.nilable(PaymentMethodConfigurationCreateParams::Zip::DisplayPreference)).void
       }
      def initialize(display_preference: nil); end
    end
    # Canadian pre-authorized debit payments, check this [page](https://docs.stripe.com/payments/acss-debit) for more details like country availability.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::AcssDebit)) }
    def acss_debit; end
    sig {
      params(_acss_debit: T.nilable(PaymentMethodConfigurationCreateParams::AcssDebit)).returns(T.nilable(PaymentMethodConfigurationCreateParams::AcssDebit))
     }
    def acss_debit=(_acss_debit); end
    # [Affirm](https://www.affirm.com/) gives your customers a way to split purchases over a series of payments. Depending on the purchase, they can pay with four interest-free payments (Split Pay) or pay over a longer term (Installments), which might include interest. Check this [page](https://docs.stripe.com/payments/affirm) for more details like country availability.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Affirm)) }
    def affirm; end
    sig {
      params(_affirm: T.nilable(PaymentMethodConfigurationCreateParams::Affirm)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Affirm))
     }
    def affirm=(_affirm); end
    # Afterpay gives your customers a way to pay for purchases in installments, check this [page](https://docs.stripe.com/payments/afterpay-clearpay) for more details like country availability. Afterpay is particularly popular among businesses selling fashion, beauty, and sports products.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::AfterpayClearpay)) }
    def afterpay_clearpay; end
    sig {
      params(_afterpay_clearpay: T.nilable(PaymentMethodConfigurationCreateParams::AfterpayClearpay)).returns(T.nilable(PaymentMethodConfigurationCreateParams::AfterpayClearpay))
     }
    def afterpay_clearpay=(_afterpay_clearpay); end
    # Alipay is a digital wallet in China that has more than a billion active users worldwide. Alipay users can pay on the web or on a mobile device using login credentials or their Alipay app. Alipay has a low dispute rate and reduces fraud by authenticating payments using the customer's login credentials. Check this [page](https://docs.stripe.com/payments/alipay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Alipay)) }
    def alipay; end
    sig {
      params(_alipay: T.nilable(PaymentMethodConfigurationCreateParams::Alipay)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Alipay))
     }
    def alipay=(_alipay); end
    # Alma is a Buy Now, Pay Later payment method that offers customers the ability to pay in 2, 3, or 4 installments.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Alma)) }
    def alma; end
    sig {
      params(_alma: T.nilable(PaymentMethodConfigurationCreateParams::Alma)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Alma))
     }
    def alma=(_alma); end
    # Amazon Pay is a wallet payment method that lets your customers check out the same way as on Amazon.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::AmazonPay)) }
    def amazon_pay; end
    sig {
      params(_amazon_pay: T.nilable(PaymentMethodConfigurationCreateParams::AmazonPay)).returns(T.nilable(PaymentMethodConfigurationCreateParams::AmazonPay))
     }
    def amazon_pay=(_amazon_pay); end
    # Stripe users can accept [Apple Pay](https://stripe.com/payments/apple-pay) in iOS applications in iOS 9 and later, and on the web in Safari starting with iOS 10 or macOS Sierra. There are no additional fees to process Apple Pay payments, and the [pricing](https://stripe.com/pricing) is the same as other card transactions. Check this [page](https://docs.stripe.com/apple-pay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::ApplePay)) }
    def apple_pay; end
    sig {
      params(_apple_pay: T.nilable(PaymentMethodConfigurationCreateParams::ApplePay)).returns(T.nilable(PaymentMethodConfigurationCreateParams::ApplePay))
     }
    def apple_pay=(_apple_pay); end
    # Apple Pay Later, a payment method for customers to buy now and pay later, gives your customers a way to split purchases into four installments across six weeks.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::ApplePayLater)) }
    def apple_pay_later; end
    sig {
      params(_apple_pay_later: T.nilable(PaymentMethodConfigurationCreateParams::ApplePayLater)).returns(T.nilable(PaymentMethodConfigurationCreateParams::ApplePayLater))
     }
    def apple_pay_later=(_apple_pay_later); end
    # Stripe users in Australia can accept Bulk Electronic Clearing System (BECS) direct debit payments from customers with an Australian bank account. Check this [page](https://docs.stripe.com/payments/au-becs-debit) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::AuBecsDebit)) }
    def au_becs_debit; end
    sig {
      params(_au_becs_debit: T.nilable(PaymentMethodConfigurationCreateParams::AuBecsDebit)).returns(T.nilable(PaymentMethodConfigurationCreateParams::AuBecsDebit))
     }
    def au_becs_debit=(_au_becs_debit); end
    # Stripe users in the UK can accept Bacs Direct Debit payments from customers with a UK bank account, check this [page](https://docs.stripe.com/payments/payment-methods/bacs-debit) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::BacsDebit)) }
    def bacs_debit; end
    sig {
      params(_bacs_debit: T.nilable(PaymentMethodConfigurationCreateParams::BacsDebit)).returns(T.nilable(PaymentMethodConfigurationCreateParams::BacsDebit))
     }
    def bacs_debit=(_bacs_debit); end
    # Bancontact is the most popular online payment method in Belgium, with over 15 million cards in circulation. [Customers](https://docs.stripe.com/api/customers) use a Bancontact card or mobile app linked to a Belgian bank account to make online payments that are secure, guaranteed, and confirmed immediately. Check this [page](https://docs.stripe.com/payments/bancontact) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Bancontact)) }
    def bancontact; end
    sig {
      params(_bancontact: T.nilable(PaymentMethodConfigurationCreateParams::Bancontact)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Bancontact))
     }
    def bancontact=(_bancontact); end
    # Billie is a [single-use](https://docs.stripe.com/payments/payment-methods#usage) payment method that offers businesses Pay by Invoice where they offer payment terms ranging from 7-120 days. Customers are redirected from your website or app, authorize the payment with Billie, then return to your website or app. You get [immediate notification](/payments/payment-methods#payment-notification) of whether the payment succeeded or failed.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Billie)) }
    def billie; end
    sig {
      params(_billie: T.nilable(PaymentMethodConfigurationCreateParams::Billie)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Billie))
     }
    def billie=(_billie); end
    # BLIK is a [single use](https://docs.stripe.com/payments/payment-methods#usage) payment method that requires customers to authenticate their payments. When customers want to pay online using BLIK, they request a six-digit code from their banking application and enter it into the payment collection form. Check this [page](https://docs.stripe.com/payments/blik) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Blik)) }
    def blik; end
    sig {
      params(_blik: T.nilable(PaymentMethodConfigurationCreateParams::Blik)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Blik))
     }
    def blik=(_blik); end
    # Boleto is an official (regulated by the Central Bank of Brazil) payment method in Brazil. Check this [page](https://docs.stripe.com/payments/boleto) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Boleto)) }
    def boleto; end
    sig {
      params(_boleto: T.nilable(PaymentMethodConfigurationCreateParams::Boleto)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Boleto))
     }
    def boleto=(_boleto); end
    # Cards are a popular way for consumers and businesses to pay online or in person. Stripe supports global and local card networks.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Card)) }
    def card; end
    sig {
      params(_card: T.nilable(PaymentMethodConfigurationCreateParams::Card)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Card))
     }
    def card=(_card); end
    # Cartes Bancaires is France's local card network. More than 95% of these cards are co-branded with either Visa or Mastercard, meaning you can process these cards over either Cartes Bancaires or the Visa or Mastercard networks. Check this [page](https://docs.stripe.com/payments/cartes-bancaires) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::CartesBancaires)) }
    def cartes_bancaires; end
    sig {
      params(_cartes_bancaires: T.nilable(PaymentMethodConfigurationCreateParams::CartesBancaires)).returns(T.nilable(PaymentMethodConfigurationCreateParams::CartesBancaires))
     }
    def cartes_bancaires=(_cartes_bancaires); end
    # Cash App is a popular consumer app in the US that allows customers to bank, invest, send, and receive money using their digital wallet. Check this [page](https://docs.stripe.com/payments/cash-app-pay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Cashapp)) }
    def cashapp; end
    sig {
      params(_cashapp: T.nilable(PaymentMethodConfigurationCreateParams::Cashapp)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Cashapp))
     }
    def cashapp=(_cashapp); end
    # [Stablecoin payments](https://docs.stripe.com/payments/stablecoin-payments) enable customers to pay in stablecoins like USDC from 100s of wallets including Phantom and Metamask.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Crypto)) }
    def crypto; end
    sig {
      params(_crypto: T.nilable(PaymentMethodConfigurationCreateParams::Crypto)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Crypto))
     }
    def crypto=(_crypto); end
    # Uses a customer’s [cash balance](https://docs.stripe.com/payments/customer-balance) for the payment. The cash balance can be funded via a bank transfer. Check this [page](https://docs.stripe.com/payments/bank-transfers) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::CustomerBalance)) }
    def customer_balance; end
    sig {
      params(_customer_balance: T.nilable(PaymentMethodConfigurationCreateParams::CustomerBalance)).returns(T.nilable(PaymentMethodConfigurationCreateParams::CustomerBalance))
     }
    def customer_balance=(_customer_balance); end
    # EPS is an Austria-based payment method that allows customers to complete transactions online using their bank credentials. EPS is supported by all Austrian banks and is accepted by over 80% of Austrian online retailers. Check this [page](https://docs.stripe.com/payments/eps) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Eps)) }
    def eps; end
    sig {
      params(_eps: T.nilable(PaymentMethodConfigurationCreateParams::Eps)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Eps))
     }
    def eps=(_eps); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Financial Process Exchange (FPX) is a Malaysia-based payment method that allows customers to complete transactions online using their bank credentials. Bank Negara Malaysia (BNM), the Central Bank of Malaysia, and eleven other major Malaysian financial institutions are members of the PayNet Group, which owns and operates FPX. It is one of the most popular online payment methods in Malaysia, with nearly 90 million transactions in 2018 according to BNM. Check this [page](https://docs.stripe.com/payments/fpx) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Fpx)) }
    def fpx; end
    sig {
      params(_fpx: T.nilable(PaymentMethodConfigurationCreateParams::Fpx)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Fpx))
     }
    def fpx=(_fpx); end
    # Meal vouchers in France, or “titres-restaurant”, is a local benefits program commonly offered by employers for their employees to purchase prepared food and beverages on working days. Check this [page](https://docs.stripe.com/payments/benefits/fr-meal-vouchers) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::FrMealVoucherConecs)) }
    def fr_meal_voucher_conecs; end
    sig {
      params(_fr_meal_voucher_conecs: T.nilable(PaymentMethodConfigurationCreateParams::FrMealVoucherConecs)).returns(T.nilable(PaymentMethodConfigurationCreateParams::FrMealVoucherConecs))
     }
    def fr_meal_voucher_conecs=(_fr_meal_voucher_conecs); end
    # giropay is a German payment method based on online banking, introduced in 2006. It allows customers to complete transactions online using their online banking environment, with funds debited from their bank account. Depending on their bank, customers confirm payments on giropay using a second factor of authentication or a PIN. giropay accounts for 10% of online checkouts in Germany. Check this [page](https://docs.stripe.com/payments/giropay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Giropay)) }
    def giropay; end
    sig {
      params(_giropay: T.nilable(PaymentMethodConfigurationCreateParams::Giropay)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Giropay))
     }
    def giropay=(_giropay); end
    # Google Pay allows customers to make payments in your app or website using any credit or debit card saved to their Google Account, including those from Google Play, YouTube, Chrome, or an Android device. Use the Google Pay API to request any credit or debit card stored in your customer's Google account. Check this [page](https://docs.stripe.com/google-pay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::GooglePay)) }
    def google_pay; end
    sig {
      params(_google_pay: T.nilable(PaymentMethodConfigurationCreateParams::GooglePay)).returns(T.nilable(PaymentMethodConfigurationCreateParams::GooglePay))
     }
    def google_pay=(_google_pay); end
    # GrabPay is a payment method developed by [Grab](https://www.grab.com/sg/consumer/finance/pay/). GrabPay is a digital wallet - customers maintain a balance in their wallets that they pay out with. Check this [page](https://docs.stripe.com/payments/grabpay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Grabpay)) }
    def grabpay; end
    sig {
      params(_grabpay: T.nilable(PaymentMethodConfigurationCreateParams::Grabpay)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Grabpay))
     }
    def grabpay=(_grabpay); end
    # iDEAL is a Netherlands-based payment method that allows customers to complete transactions online using their bank credentials. All major Dutch banks are members of Currence, the scheme that operates iDEAL, making it the most popular online payment method in the Netherlands with a share of online transactions close to 55%. Check this [page](https://docs.stripe.com/payments/ideal) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Ideal)) }
    def ideal; end
    sig {
      params(_ideal: T.nilable(PaymentMethodConfigurationCreateParams::Ideal)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Ideal))
     }
    def ideal=(_ideal); end
    # JCB is a credit card company based in Japan. JCB is currently available in Japan to businesses approved by JCB, and available to all businesses in Australia, Canada, Hong Kong, Japan, New Zealand, Singapore, Switzerland, United Kingdom, United States, and all countries in the European Economic Area except Iceland. Check this [page](https://support.stripe.com/questions/accepting-japan-credit-bureau-%28jcb%29-payments) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Jcb)) }
    def jcb; end
    sig {
      params(_jcb: T.nilable(PaymentMethodConfigurationCreateParams::Jcb)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Jcb))
     }
    def jcb=(_jcb); end
    # Kakao Pay is a popular local wallet available in South Korea.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::KakaoPay)) }
    def kakao_pay; end
    sig {
      params(_kakao_pay: T.nilable(PaymentMethodConfigurationCreateParams::KakaoPay)).returns(T.nilable(PaymentMethodConfigurationCreateParams::KakaoPay))
     }
    def kakao_pay=(_kakao_pay); end
    # Klarna gives customers a range of [payment options](https://docs.stripe.com/payments/klarna#payment-options) during checkout. Available payment options vary depending on the customer's billing address and the transaction amount. These payment options make it convenient for customers to purchase items in all price ranges. Check this [page](https://docs.stripe.com/payments/klarna) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Klarna)) }
    def klarna; end
    sig {
      params(_klarna: T.nilable(PaymentMethodConfigurationCreateParams::Klarna)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Klarna))
     }
    def klarna=(_klarna); end
    # Konbini allows customers in Japan to pay for bills and online purchases at convenience stores with cash. Check this [page](https://docs.stripe.com/payments/konbini) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Konbini)) }
    def konbini; end
    sig {
      params(_konbini: T.nilable(PaymentMethodConfigurationCreateParams::Konbini)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Konbini))
     }
    def konbini=(_konbini); end
    # Korean cards let users pay using locally issued cards from South Korea.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::KrCard)) }
    def kr_card; end
    sig {
      params(_kr_card: T.nilable(PaymentMethodConfigurationCreateParams::KrCard)).returns(T.nilable(PaymentMethodConfigurationCreateParams::KrCard))
     }
    def kr_card=(_kr_card); end
    # [Link](https://docs.stripe.com/payments/link) is a payment method network. With Link, users save their payment details once, then reuse that information to pay with one click for any business on the network.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Link)) }
    def link; end
    sig {
      params(_link: T.nilable(PaymentMethodConfigurationCreateParams::Link)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Link))
     }
    def link=(_link); end
    # MB WAY is the most popular wallet in Portugal. After entering their phone number in your checkout, customers approve the payment directly in their MB WAY app. Check this [page](https://docs.stripe.com/payments/mb-way) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::MbWay)) }
    def mb_way; end
    sig {
      params(_mb_way: T.nilable(PaymentMethodConfigurationCreateParams::MbWay)).returns(T.nilable(PaymentMethodConfigurationCreateParams::MbWay))
     }
    def mb_way=(_mb_way); end
    # MobilePay is a [single-use](https://docs.stripe.com/payments/payment-methods#usage) card wallet payment method used in Denmark and Finland. It allows customers to [authenticate and approve](https://docs.stripe.com/payments/payment-methods#customer-actions) payments using the MobilePay app. Check this [page](https://docs.stripe.com/payments/mobilepay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Mobilepay)) }
    def mobilepay; end
    sig {
      params(_mobilepay: T.nilable(PaymentMethodConfigurationCreateParams::Mobilepay)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Mobilepay))
     }
    def mobilepay=(_mobilepay); end
    # Stripe users in Europe and the United States can accept Multibanco payments from customers in Portugal using [Sources](https://stripe.com/docs/sources)—a single integration path for creating payments using any supported method.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Multibanco)) }
    def multibanco; end
    sig {
      params(_multibanco: T.nilable(PaymentMethodConfigurationCreateParams::Multibanco)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Multibanco))
     }
    def multibanco=(_multibanco); end
    # Configuration name.
    sig { returns(T.nilable(String)) }
    def name; end
    sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
    def name=(_name); end
    # Naver Pay is a popular local wallet available in South Korea.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::NaverPay)) }
    def naver_pay; end
    sig {
      params(_naver_pay: T.nilable(PaymentMethodConfigurationCreateParams::NaverPay)).returns(T.nilable(PaymentMethodConfigurationCreateParams::NaverPay))
     }
    def naver_pay=(_naver_pay); end
    # Stripe users in New Zealand can accept Bulk Electronic Clearing System (BECS) direct debit payments from customers with a New Zeland bank account. Check this [page](https://docs.stripe.com/payments/nz-bank-account) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::NzBankAccount)) }
    def nz_bank_account; end
    sig {
      params(_nz_bank_account: T.nilable(PaymentMethodConfigurationCreateParams::NzBankAccount)).returns(T.nilable(PaymentMethodConfigurationCreateParams::NzBankAccount))
     }
    def nz_bank_account=(_nz_bank_account); end
    # OXXO is a Mexican chain of convenience stores with thousands of locations across Latin America and represents nearly 20% of online transactions in Mexico. OXXO allows customers to pay bills and online purchases in-store with cash. Check this [page](https://docs.stripe.com/payments/oxxo) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Oxxo)) }
    def oxxo; end
    sig {
      params(_oxxo: T.nilable(PaymentMethodConfigurationCreateParams::Oxxo)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Oxxo))
     }
    def oxxo=(_oxxo); end
    # Przelewy24 is a Poland-based payment method aggregator that allows customers to complete transactions online using bank transfers and other methods. Bank transfers account for 30% of online payments in Poland and Przelewy24 provides a way for customers to pay with over 165 banks. Check this [page](https://docs.stripe.com/payments/p24) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::P24)) }
    def p24; end
    sig {
      params(_p24: T.nilable(PaymentMethodConfigurationCreateParams::P24)).returns(T.nilable(PaymentMethodConfigurationCreateParams::P24))
     }
    def p24=(_p24); end
    # Configuration's parent configuration. Specify to create a child configuration.
    sig { returns(T.nilable(String)) }
    def parent; end
    sig { params(_parent: T.nilable(String)).returns(T.nilable(String)) }
    def parent=(_parent); end
    # Pay by bank is a redirect payment method backed by bank transfers. A customer is redirected to their bank to authorize a bank transfer for a given amount. This removes a lot of the error risks inherent in waiting for the customer to initiate a transfer themselves, and is less expensive than card payments.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::PayByBank)) }
    def pay_by_bank; end
    sig {
      params(_pay_by_bank: T.nilable(PaymentMethodConfigurationCreateParams::PayByBank)).returns(T.nilable(PaymentMethodConfigurationCreateParams::PayByBank))
     }
    def pay_by_bank=(_pay_by_bank); end
    # PAYCO is a [single-use](https://docs.stripe.com/payments/payment-methods#usage local wallet available in South Korea.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Payco)) }
    def payco; end
    sig {
      params(_payco: T.nilable(PaymentMethodConfigurationCreateParams::Payco)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Payco))
     }
    def payco=(_payco); end
    # PayNow is a Singapore-based payment method that allows customers to make a payment using their preferred app from participating banks and participating non-bank financial institutions. Check this [page](https://docs.stripe.com/payments/paynow) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Paynow)) }
    def paynow; end
    sig {
      params(_paynow: T.nilable(PaymentMethodConfigurationCreateParams::Paynow)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Paynow))
     }
    def paynow=(_paynow); end
    # PayPal, a digital wallet popular with customers in Europe, allows your customers worldwide to pay using their PayPal account. Check this [page](https://docs.stripe.com/payments/paypal) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Paypal)) }
    def paypal; end
    sig {
      params(_paypal: T.nilable(PaymentMethodConfigurationCreateParams::Paypal)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Paypal))
     }
    def paypal=(_paypal); end
    # PayTo is a [real-time](https://docs.stripe.com/payments/real-time) payment method that enables customers in Australia to pay by providing their bank account details. Customers must accept a mandate authorizing you to debit their account. Check this [page](https://docs.stripe.com/payments/payto) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Payto)) }
    def payto; end
    sig {
      params(_payto: T.nilable(PaymentMethodConfigurationCreateParams::Payto)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Payto))
     }
    def payto=(_payto); end
    # Pix is a payment method popular in Brazil. When paying with Pix, customers authenticate and approve payments by scanning a QR code in their preferred banking app. Check this [page](https://docs.stripe.com/payments/pix) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Pix)) }
    def pix; end
    sig {
      params(_pix: T.nilable(PaymentMethodConfigurationCreateParams::Pix)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Pix))
     }
    def pix=(_pix); end
    # PromptPay is a Thailand-based payment method that allows customers to make a payment using their preferred app from participating banks. Check this [page](https://docs.stripe.com/payments/promptpay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Promptpay)) }
    def promptpay; end
    sig {
      params(_promptpay: T.nilable(PaymentMethodConfigurationCreateParams::Promptpay)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Promptpay))
     }
    def promptpay=(_promptpay); end
    # Revolut Pay, developed by Revolut, a global finance app, is a digital wallet payment method. Revolut Pay uses the customer’s stored balance or cards to fund the payment, and offers the option for non-Revolut customers to save their details after their first purchase.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::RevolutPay)) }
    def revolut_pay; end
    sig {
      params(_revolut_pay: T.nilable(PaymentMethodConfigurationCreateParams::RevolutPay)).returns(T.nilable(PaymentMethodConfigurationCreateParams::RevolutPay))
     }
    def revolut_pay=(_revolut_pay); end
    # Samsung Pay is a [single-use](https://docs.stripe.com/payments/payment-methods#usage local wallet available in South Korea.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::SamsungPay)) }
    def samsung_pay; end
    sig {
      params(_samsung_pay: T.nilable(PaymentMethodConfigurationCreateParams::SamsungPay)).returns(T.nilable(PaymentMethodConfigurationCreateParams::SamsungPay))
     }
    def samsung_pay=(_samsung_pay); end
    # Satispay is a [single-use](https://docs.stripe.com/payments/payment-methods#usage) payment method where customers are required to [authenticate](/payments/payment-methods#customer-actions) their payment. Customers pay by being redirected from your website or app, authorizing the payment with Satispay, then returning to your website or app. You get [immediate notification](/payments/payment-methods#payment-notification) of whether the payment succeeded or failed.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Satispay)) }
    def satispay; end
    sig {
      params(_satispay: T.nilable(PaymentMethodConfigurationCreateParams::Satispay)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Satispay))
     }
    def satispay=(_satispay); end
    # The [Single Euro Payments Area (SEPA)](https://en.wikipedia.org/wiki/Single_Euro_Payments_Area) is an initiative of the European Union to simplify payments within and across member countries. SEPA established and enforced banking standards to allow for the direct debiting of every EUR-denominated bank account within the SEPA region, check this [page](https://docs.stripe.com/payments/sepa-debit) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::SepaDebit)) }
    def sepa_debit; end
    sig {
      params(_sepa_debit: T.nilable(PaymentMethodConfigurationCreateParams::SepaDebit)).returns(T.nilable(PaymentMethodConfigurationCreateParams::SepaDebit))
     }
    def sepa_debit=(_sepa_debit); end
    # Stripe users in Europe and the United States can use the [Payment Intents API](https://stripe.com/docs/payments/payment-intents)—a single integration path for creating payments using any supported method—to accept [Sofort](https://www.sofort.com/) payments from customers. Check this [page](https://docs.stripe.com/payments/sofort) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Sofort)) }
    def sofort; end
    sig {
      params(_sofort: T.nilable(PaymentMethodConfigurationCreateParams::Sofort)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Sofort))
     }
    def sofort=(_sofort); end
    # Swish is a [real-time](https://docs.stripe.com/payments/real-time) payment method popular in Sweden. It allows customers to [authenticate and approve](https://docs.stripe.com/payments/payment-methods#customer-actions) payments using the Swish mobile app and the Swedish BankID mobile app. Check this [page](https://docs.stripe.com/payments/swish) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Swish)) }
    def swish; end
    sig {
      params(_swish: T.nilable(PaymentMethodConfigurationCreateParams::Swish)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Swish))
     }
    def swish=(_swish); end
    # Twint is a payment method popular in Switzerland. It allows customers to pay using their mobile phone. Check this [page](https://docs.stripe.com/payments/twint) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Twint)) }
    def twint; end
    sig {
      params(_twint: T.nilable(PaymentMethodConfigurationCreateParams::Twint)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Twint))
     }
    def twint=(_twint); end
    # Stripe users in the United States can accept ACH direct debit payments from customers with a US bank account using the Automated Clearing House (ACH) payments system operated by Nacha. Check this [page](https://docs.stripe.com/payments/ach-direct-debit) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::UsBankAccount)) }
    def us_bank_account; end
    sig {
      params(_us_bank_account: T.nilable(PaymentMethodConfigurationCreateParams::UsBankAccount)).returns(T.nilable(PaymentMethodConfigurationCreateParams::UsBankAccount))
     }
    def us_bank_account=(_us_bank_account); end
    # WeChat, owned by Tencent, is China's leading mobile app with over 1 billion monthly active users. Chinese consumers can use WeChat Pay to pay for goods and services inside of businesses' apps and websites. WeChat Pay users buy most frequently in gaming, e-commerce, travel, online education, and food/nutrition. Check this [page](https://docs.stripe.com/payments/wechat-pay) for more details.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::WechatPay)) }
    def wechat_pay; end
    sig {
      params(_wechat_pay: T.nilable(PaymentMethodConfigurationCreateParams::WechatPay)).returns(T.nilable(PaymentMethodConfigurationCreateParams::WechatPay))
     }
    def wechat_pay=(_wechat_pay); end
    # Zip gives your customers a way to split purchases over a series of payments. Check this [page](https://docs.stripe.com/payments/zip) for more details like country availability.
    sig { returns(T.nilable(PaymentMethodConfigurationCreateParams::Zip)) }
    def zip; end
    sig {
      params(_zip: T.nilable(PaymentMethodConfigurationCreateParams::Zip)).returns(T.nilable(PaymentMethodConfigurationCreateParams::Zip))
     }
    def zip=(_zip); end
    sig {
      params(acss_debit: T.nilable(PaymentMethodConfigurationCreateParams::AcssDebit), affirm: T.nilable(PaymentMethodConfigurationCreateParams::Affirm), afterpay_clearpay: T.nilable(PaymentMethodConfigurationCreateParams::AfterpayClearpay), alipay: T.nilable(PaymentMethodConfigurationCreateParams::Alipay), alma: T.nilable(PaymentMethodConfigurationCreateParams::Alma), amazon_pay: T.nilable(PaymentMethodConfigurationCreateParams::AmazonPay), apple_pay: T.nilable(PaymentMethodConfigurationCreateParams::ApplePay), apple_pay_later: T.nilable(PaymentMethodConfigurationCreateParams::ApplePayLater), au_becs_debit: T.nilable(PaymentMethodConfigurationCreateParams::AuBecsDebit), bacs_debit: T.nilable(PaymentMethodConfigurationCreateParams::BacsDebit), bancontact: T.nilable(PaymentMethodConfigurationCreateParams::Bancontact), billie: T.nilable(PaymentMethodConfigurationCreateParams::Billie), blik: T.nilable(PaymentMethodConfigurationCreateParams::Blik), boleto: T.nilable(PaymentMethodConfigurationCreateParams::Boleto), card: T.nilable(PaymentMethodConfigurationCreateParams::Card), cartes_bancaires: T.nilable(PaymentMethodConfigurationCreateParams::CartesBancaires), cashapp: T.nilable(PaymentMethodConfigurationCreateParams::Cashapp), crypto: T.nilable(PaymentMethodConfigurationCreateParams::Crypto), customer_balance: T.nilable(PaymentMethodConfigurationCreateParams::CustomerBalance), eps: T.nilable(PaymentMethodConfigurationCreateParams::Eps), expand: T.nilable(T::Array[String]), fpx: T.nilable(PaymentMethodConfigurationCreateParams::Fpx), fr_meal_voucher_conecs: T.nilable(PaymentMethodConfigurationCreateParams::FrMealVoucherConecs), giropay: T.nilable(PaymentMethodConfigurationCreateParams::Giropay), google_pay: T.nilable(PaymentMethodConfigurationCreateParams::GooglePay), grabpay: T.nilable(PaymentMethodConfigurationCreateParams::Grabpay), ideal: T.nilable(PaymentMethodConfigurationCreateParams::Ideal), jcb: T.nilable(PaymentMethodConfigurationCreateParams::Jcb), kakao_pay: T.nilable(PaymentMethodConfigurationCreateParams::KakaoPay), klarna: T.nilable(PaymentMethodConfigurationCreateParams::Klarna), konbini: T.nilable(PaymentMethodConfigurationCreateParams::Konbini), kr_card: T.nilable(PaymentMethodConfigurationCreateParams::KrCard), link: T.nilable(PaymentMethodConfigurationCreateParams::Link), mb_way: T.nilable(PaymentMethodConfigurationCreateParams::MbWay), mobilepay: T.nilable(PaymentMethodConfigurationCreateParams::Mobilepay), multibanco: T.nilable(PaymentMethodConfigurationCreateParams::Multibanco), name: T.nilable(String), naver_pay: T.nilable(PaymentMethodConfigurationCreateParams::NaverPay), nz_bank_account: T.nilable(PaymentMethodConfigurationCreateParams::NzBankAccount), oxxo: T.nilable(PaymentMethodConfigurationCreateParams::Oxxo), p24: T.nilable(PaymentMethodConfigurationCreateParams::P24), parent: T.nilable(String), pay_by_bank: T.nilable(PaymentMethodConfigurationCreateParams::PayByBank), payco: T.nilable(PaymentMethodConfigurationCreateParams::Payco), paynow: T.nilable(PaymentMethodConfigurationCreateParams::Paynow), paypal: T.nilable(PaymentMethodConfigurationCreateParams::Paypal), payto: T.nilable(PaymentMethodConfigurationCreateParams::Payto), pix: T.nilable(PaymentMethodConfigurationCreateParams::Pix), promptpay: T.nilable(PaymentMethodConfigurationCreateParams::Promptpay), revolut_pay: T.nilable(PaymentMethodConfigurationCreateParams::RevolutPay), samsung_pay: T.nilable(PaymentMethodConfigurationCreateParams::SamsungPay), satispay: T.nilable(PaymentMethodConfigurationCreateParams::Satispay), sepa_debit: T.nilable(PaymentMethodConfigurationCreateParams::SepaDebit), sofort: T.nilable(PaymentMethodConfigurationCreateParams::Sofort), swish: T.nilable(PaymentMethodConfigurationCreateParams::Swish), twint: T.nilable(PaymentMethodConfigurationCreateParams::Twint), us_bank_account: T.nilable(PaymentMethodConfigurationCreateParams::UsBankAccount), wechat_pay: T.nilable(PaymentMethodConfigurationCreateParams::WechatPay), zip: T.nilable(PaymentMethodConfigurationCreateParams::Zip)).void
     }
    def initialize(
      acss_debit: nil,
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
      parent: nil,
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