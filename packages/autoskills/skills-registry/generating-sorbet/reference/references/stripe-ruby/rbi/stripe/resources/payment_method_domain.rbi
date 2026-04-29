# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # A payment method domain represents a web domain that you have registered with Stripe.
  # Stripe Elements use registered payment method domains to control where certain payment methods are shown.
  #
  # Related guide: [Payment method domains](https://docs.stripe.com/payments/payment-methods/pmd-registration).
  class PaymentMethodDomain < APIResource
    class AmazonPay < ::Stripe::StripeObject
      class StatusDetails < ::Stripe::StripeObject
        # The error message associated with the status of the payment method on the domain.
        sig { returns(String) }
        def error_message; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The status of the payment method on the domain.
      sig { returns(String) }
      def status; end
      # Contains additional details about the status of a payment method for a specific payment method domain.
      sig { returns(T.nilable(StatusDetails)) }
      def status_details; end
      def self.inner_class_types
        @inner_class_types = {status_details: StatusDetails}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class ApplePay < ::Stripe::StripeObject
      class StatusDetails < ::Stripe::StripeObject
        # The error message associated with the status of the payment method on the domain.
        sig { returns(String) }
        def error_message; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The status of the payment method on the domain.
      sig { returns(String) }
      def status; end
      # Contains additional details about the status of a payment method for a specific payment method domain.
      sig { returns(T.nilable(StatusDetails)) }
      def status_details; end
      def self.inner_class_types
        @inner_class_types = {status_details: StatusDetails}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class GooglePay < ::Stripe::StripeObject
      class StatusDetails < ::Stripe::StripeObject
        # The error message associated with the status of the payment method on the domain.
        sig { returns(String) }
        def error_message; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The status of the payment method on the domain.
      sig { returns(String) }
      def status; end
      # Contains additional details about the status of a payment method for a specific payment method domain.
      sig { returns(T.nilable(StatusDetails)) }
      def status_details; end
      def self.inner_class_types
        @inner_class_types = {status_details: StatusDetails}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Klarna < ::Stripe::StripeObject
      class StatusDetails < ::Stripe::StripeObject
        # The error message associated with the status of the payment method on the domain.
        sig { returns(String) }
        def error_message; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The status of the payment method on the domain.
      sig { returns(String) }
      def status; end
      # Contains additional details about the status of a payment method for a specific payment method domain.
      sig { returns(T.nilable(StatusDetails)) }
      def status_details; end
      def self.inner_class_types
        @inner_class_types = {status_details: StatusDetails}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Link < ::Stripe::StripeObject
      class StatusDetails < ::Stripe::StripeObject
        # The error message associated with the status of the payment method on the domain.
        sig { returns(String) }
        def error_message; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The status of the payment method on the domain.
      sig { returns(String) }
      def status; end
      # Contains additional details about the status of a payment method for a specific payment method domain.
      sig { returns(T.nilable(StatusDetails)) }
      def status_details; end
      def self.inner_class_types
        @inner_class_types = {status_details: StatusDetails}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Paypal < ::Stripe::StripeObject
      class StatusDetails < ::Stripe::StripeObject
        # The error message associated with the status of the payment method on the domain.
        sig { returns(String) }
        def error_message; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The status of the payment method on the domain.
      sig { returns(String) }
      def status; end
      # Contains additional details about the status of a payment method for a specific payment method domain.
      sig { returns(T.nilable(StatusDetails)) }
      def status_details; end
      def self.inner_class_types
        @inner_class_types = {status_details: StatusDetails}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Indicates the status of a specific payment method on a payment method domain.
    sig { returns(AmazonPay) }
    def amazon_pay; end
    # Indicates the status of a specific payment method on a payment method domain.
    sig { returns(ApplePay) }
    def apple_pay; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # The domain name that this payment method domain object represents.
    sig { returns(String) }
    def domain_name; end
    # Whether this payment method domain is enabled. If the domain is not enabled, payment methods that require a payment method domain will not appear in Elements.
    sig { returns(T::Boolean) }
    def enabled; end
    # Indicates the status of a specific payment method on a payment method domain.
    sig { returns(GooglePay) }
    def google_pay; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Indicates the status of a specific payment method on a payment method domain.
    sig { returns(Klarna) }
    def klarna; end
    # Indicates the status of a specific payment method on a payment method domain.
    sig { returns(Link) }
    def link; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Indicates the status of a specific payment method on a payment method domain.
    sig { returns(Paypal) }
    def paypal; end
    # Creates a payment method domain.
    sig {
      params(params: T.any(::Stripe::PaymentMethodDomainCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentMethodDomain)
     }
    def self.create(params = {}, opts = {}); end

    # Lists the details of existing payment method domains.
    sig {
      params(params: T.any(::Stripe::PaymentMethodDomainListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Updates an existing payment method domain.
    sig {
      params(payment_method_domain: String, params: T.any(::Stripe::PaymentMethodDomainUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentMethodDomain)
     }
    def self.update(payment_method_domain, params = {}, opts = {}); end

    # Some payment methods might require additional steps to register a domain. If the requirements weren't satisfied when the domain was created, the payment method will be inactive on the domain.
    # The payment method doesn't appear in Elements or Embedded Checkout for this domain until it is active.
    #
    # To activate a payment method on an existing payment method domain, complete the required registration steps specific to the payment method, and then validate the payment method domain with this endpoint.
    #
    # Related guides: [Payment method domains](https://docs.stripe.com/docs/payments/payment-methods/pmd-registration).
    sig {
      params(params: T.any(::Stripe::PaymentMethodDomainValidateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentMethodDomain)
     }
    def validate(params = {}, opts = {}); end

    # Some payment methods might require additional steps to register a domain. If the requirements weren't satisfied when the domain was created, the payment method will be inactive on the domain.
    # The payment method doesn't appear in Elements or Embedded Checkout for this domain until it is active.
    #
    # To activate a payment method on an existing payment method domain, complete the required registration steps specific to the payment method, and then validate the payment method domain with this endpoint.
    #
    # Related guides: [Payment method domains](https://docs.stripe.com/docs/payments/payment-methods/pmd-registration).
    sig {
      params(payment_method_domain: String, params: T.any(::Stripe::PaymentMethodDomainValidateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentMethodDomain)
     }
    def self.validate(payment_method_domain, params = {}, opts = {}); end
  end
end