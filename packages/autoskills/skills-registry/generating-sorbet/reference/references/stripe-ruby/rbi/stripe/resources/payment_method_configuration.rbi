# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # PaymentMethodConfigurations control which payment methods are displayed to your customers when you don't explicitly specify payment method types. You can have multiple configurations with different sets of payment methods for different scenarios.
  #
  # There are two types of PaymentMethodConfigurations. Which is used depends on the [charge type](https://docs.stripe.com/connect/charges):
  #
  # **Direct** configurations apply to payments created on your account, including Connect destination charges, Connect separate charges and transfers, and payments not involving Connect.
  #
  # **Child** configurations apply to payments created on your connected accounts using direct charges, and charges with the on_behalf_of parameter.
  #
  # Child configurations have a `parent` that sets default values and controls which settings connected accounts may override. You can specify a parent ID at payment time, and Stripe will automatically resolve the connected account's associated child configuration. Parent configurations are [managed in the dashboard](https://dashboard.stripe.com/settings/payment_methods/connected_accounts) and are not available in this API.
  #
  # Related guides:
  # - [Payment Method Configurations API](https://docs.stripe.com/connect/payment-method-configurations)
  # - [Multiple configurations on dynamic payment methods](https://docs.stripe.com/payments/multiple-payment-method-configs)
  # - [Multiple configurations for your Connect accounts](https://docs.stripe.com/connect/multiple-payment-method-configurations)
  class PaymentMethodConfiguration < APIResource
    class AcssDebit < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Affirm < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class AfterpayClearpay < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Alipay < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Alma < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class AmazonPay < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class ApplePay < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class AuBecsDebit < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class BacsDebit < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Bancontact < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Billie < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Blik < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Boleto < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Card < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class CartesBancaires < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Cashapp < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Crypto < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class CustomerBalance < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Eps < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Fpx < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Giropay < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class GooglePay < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Grabpay < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Ideal < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Jcb < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class KakaoPay < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Klarna < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Konbini < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class KrCard < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Link < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class MbWay < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Mobilepay < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Multibanco < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class NaverPay < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class NzBankAccount < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Oxxo < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class P24 < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class PayByBank < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Payco < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Paynow < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Paypal < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Payto < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Pix < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Promptpay < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class RevolutPay < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class SamsungPay < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Satispay < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class SepaDebit < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Sofort < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Swish < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Twint < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class UsBankAccount < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class WechatPay < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Zip < ::Stripe::StripeObject
      class DisplayPreference < ::Stripe::StripeObject
        # For child configs, whether or not the account's preference will be observed. If `false`, the parent configuration's default is used.
        sig { returns(T.nilable(T::Boolean)) }
        def overridable; end
        # The account's display preference.
        sig { returns(String) }
        def preference; end
        # The effective display preference value.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether this payment method may be offered at checkout. True if `display_preference` is `on` and the payment method's capability is active.
      sig { returns(T::Boolean) }
      def available; end
      # Attribute for field display_preference
      sig { returns(DisplayPreference) }
      def display_preference; end
      def self.inner_class_types
        @inner_class_types = {display_preference: DisplayPreference}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Attribute for field acss_debit
    sig { returns(T.nilable(AcssDebit)) }
    def acss_debit; end
    # Whether the configuration can be used for new payments.
    sig { returns(T::Boolean) }
    def active; end
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
    # Attribute for field apple_pay
    sig { returns(T.nilable(ApplePay)) }
    def apple_pay; end
    # For child configs, the Connect application associated with the configuration.
    sig { returns(T.nilable(String)) }
    def application; end
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
    # Attribute for field blik
    sig { returns(T.nilable(Blik)) }
    def blik; end
    # Attribute for field boleto
    sig { returns(T.nilable(Boleto)) }
    def boleto; end
    # Attribute for field card
    sig { returns(T.nilable(Card)) }
    def card; end
    # Attribute for field cartes_bancaires
    sig { returns(T.nilable(CartesBancaires)) }
    def cartes_bancaires; end
    # Attribute for field cashapp
    sig { returns(T.nilable(Cashapp)) }
    def cashapp; end
    # Attribute for field crypto
    sig { returns(T.nilable(Crypto)) }
    def crypto; end
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
    # Attribute for field google_pay
    sig { returns(T.nilable(GooglePay)) }
    def google_pay; end
    # Attribute for field grabpay
    sig { returns(T.nilable(Grabpay)) }
    def grabpay; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Attribute for field ideal
    sig { returns(T.nilable(Ideal)) }
    def ideal; end
    # The default configuration is used whenever a payment method configuration is not specified.
    sig { returns(T::Boolean) }
    def is_default; end
    # Attribute for field jcb
    sig { returns(T.nilable(Jcb)) }
    def jcb; end
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
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Attribute for field mb_way
    sig { returns(T.nilable(MbWay)) }
    def mb_way; end
    # Attribute for field mobilepay
    sig { returns(T.nilable(Mobilepay)) }
    def mobilepay; end
    # Attribute for field multibanco
    sig { returns(T.nilable(Multibanco)) }
    def multibanco; end
    # The configuration's name.
    sig { returns(String) }
    def name; end
    # Attribute for field naver_pay
    sig { returns(T.nilable(NaverPay)) }
    def naver_pay; end
    # Attribute for field nz_bank_account
    sig { returns(T.nilable(NzBankAccount)) }
    def nz_bank_account; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Attribute for field oxxo
    sig { returns(T.nilable(Oxxo)) }
    def oxxo; end
    # Attribute for field p24
    sig { returns(T.nilable(P24)) }
    def p24; end
    # For child configs, the configuration's parent configuration.
    sig { returns(T.nilable(String)) }
    def parent; end
    # Attribute for field pay_by_bank
    sig { returns(T.nilable(PayByBank)) }
    def pay_by_bank; end
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
    # Attribute for field promptpay
    sig { returns(T.nilable(Promptpay)) }
    def promptpay; end
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
    # Attribute for field wechat_pay
    sig { returns(T.nilable(WechatPay)) }
    def wechat_pay; end
    # Attribute for field zip
    sig { returns(T.nilable(Zip)) }
    def zip; end
    # Creates a payment method configuration
    sig {
      params(params: T.any(::Stripe::PaymentMethodConfigurationCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentMethodConfiguration)
     }
    def self.create(params = {}, opts = {}); end

    # List payment method configurations
    sig {
      params(params: T.any(::Stripe::PaymentMethodConfigurationListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Update payment method configuration
    sig {
      params(configuration: String, params: T.any(::Stripe::PaymentMethodConfigurationUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentMethodConfiguration)
     }
    def self.update(configuration, params = {}, opts = {}); end
  end
end