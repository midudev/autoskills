# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentIntentCaptureParams < ::Stripe::RequestParams
    class AmountDetails < ::Stripe::RequestParams
      class LineItem < ::Stripe::RequestParams
        class PaymentMethodOptions < ::Stripe::RequestParams
          class Card < ::Stripe::RequestParams
            # Identifier that categorizes the items being purchased using a standardized commodity scheme such as (but not limited to) UNSPSC, NAICS, NAPCS, etc.
            sig { returns(T.nilable(String)) }
            def commodity_code; end
            sig { params(_commodity_code: T.nilable(String)).returns(T.nilable(String)) }
            def commodity_code=(_commodity_code); end
            sig { params(commodity_code: T.nilable(String)).void }
            def initialize(commodity_code: nil); end
          end
          class CardPresent < ::Stripe::RequestParams
            # Identifier that categorizes the items being purchased using a standardized commodity scheme such as (but not limited to) UNSPSC, NAICS, NAPCS, etc.
            sig { returns(T.nilable(String)) }
            def commodity_code; end
            sig { params(_commodity_code: T.nilable(String)).returns(T.nilable(String)) }
            def commodity_code=(_commodity_code); end
            sig { params(commodity_code: T.nilable(String)).void }
            def initialize(commodity_code: nil); end
          end
          class Klarna < ::Stripe::RequestParams
            # URL to an image for the product. Max length, 4096 characters.
            sig { returns(T.nilable(String)) }
            def image_url; end
            sig { params(_image_url: T.nilable(String)).returns(T.nilable(String)) }
            def image_url=(_image_url); end
            # URL to the product page. Max length, 4096 characters.
            sig { returns(T.nilable(String)) }
            def product_url; end
            sig { params(_product_url: T.nilable(String)).returns(T.nilable(String)) }
            def product_url=(_product_url); end
            # Unique reference for this line item to correlate it with your system’s internal records. The field is displayed in the Klarna Consumer App if passed.
            sig { returns(T.nilable(String)) }
            def reference; end
            sig { params(_reference: T.nilable(String)).returns(T.nilable(String)) }
            def reference=(_reference); end
            # Reference for the subscription this line item is for.
            sig { returns(T.nilable(String)) }
            def subscription_reference; end
            sig { params(_subscription_reference: T.nilable(String)).returns(T.nilable(String)) }
            def subscription_reference=(_subscription_reference); end
            sig {
              params(image_url: T.nilable(String), product_url: T.nilable(String), reference: T.nilable(String), subscription_reference: T.nilable(String)).void
             }
            def initialize(
              image_url: nil,
              product_url: nil,
              reference: nil,
              subscription_reference: nil
            ); end
          end
          class Paypal < ::Stripe::RequestParams
            # Type of the line item.
            sig { returns(T.nilable(String)) }
            def category; end
            sig { params(_category: T.nilable(String)).returns(T.nilable(String)) }
            def category=(_category); end
            # Description of the line item.
            sig { returns(T.nilable(String)) }
            def description; end
            sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
            def description=(_description); end
            # The Stripe account ID of the connected account that sells the item.
            sig { returns(T.nilable(String)) }
            def sold_by; end
            sig { params(_sold_by: T.nilable(String)).returns(T.nilable(String)) }
            def sold_by=(_sold_by); end
            sig {
              params(category: T.nilable(String), description: T.nilable(String), sold_by: T.nilable(String)).void
             }
            def initialize(category: nil, description: nil, sold_by: nil); end
          end
          # This sub-hash contains line item details that are specific to `card` payment method."
          sig {
            returns(T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions::Card))
           }
          def card; end
          sig {
            params(_card: T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions::Card)).returns(T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions::Card))
           }
          def card=(_card); end
          # This sub-hash contains line item details that are specific to `card_present` payment method."
          sig {
            returns(T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions::CardPresent))
           }
          def card_present; end
          sig {
            params(_card_present: T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions::CardPresent)).returns(T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions::CardPresent))
           }
          def card_present=(_card_present); end
          # This sub-hash contains line item details that are specific to `klarna` payment method."
          sig {
            returns(T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions::Klarna))
           }
          def klarna; end
          sig {
            params(_klarna: T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions::Klarna)).returns(T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions::Klarna))
           }
          def klarna=(_klarna); end
          # This sub-hash contains line item details that are specific to `paypal` payment method."
          sig {
            returns(T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions::Paypal))
           }
          def paypal; end
          sig {
            params(_paypal: T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions::Paypal)).returns(T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions::Paypal))
           }
          def paypal=(_paypal); end
          sig {
            params(card: T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions::Card), card_present: T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions::CardPresent), klarna: T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions::Klarna), paypal: T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions::Paypal)).void
           }
          def initialize(card: nil, card_present: nil, klarna: nil, paypal: nil); end
        end
        class Tax < ::Stripe::RequestParams
          # The total amount of tax on a single line item represented in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal). Required for L3 rates. An integer greater than or equal to 0.
          #
          # This field is mutually exclusive with the `amount_details[tax][total_tax_amount]` field.
          sig { returns(Integer) }
          def total_tax_amount; end
          sig { params(_total_tax_amount: Integer).returns(Integer) }
          def total_tax_amount=(_total_tax_amount); end
          sig { params(total_tax_amount: Integer).void }
          def initialize(total_tax_amount: nil); end
        end
        # The discount applied on this line item represented in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal). An integer greater than 0.
        #
        # This field is mutually exclusive with the `amount_details[discount_amount]` field.
        sig { returns(T.nilable(Integer)) }
        def discount_amount; end
        sig { params(_discount_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def discount_amount=(_discount_amount); end
        # Payment method-specific information for line items.
        sig {
          returns(T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions))
         }
        def payment_method_options; end
        sig {
          params(_payment_method_options: T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions)).returns(T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions))
         }
        def payment_method_options=(_payment_method_options); end
        # The product code of the line item, such as an SKU. Required for L3 rates. At most 12 characters long.
        sig { returns(T.nilable(String)) }
        def product_code; end
        sig { params(_product_code: T.nilable(String)).returns(T.nilable(String)) }
        def product_code=(_product_code); end
        # The product name of the line item. Required for L3 rates. At most 1024 characters long.
        #
        # For Cards, this field is truncated to 26 alphanumeric characters before being sent to the card networks. For Paypal, this field is truncated to 127 characters.
        sig { returns(String) }
        def product_name; end
        sig { params(_product_name: String).returns(String) }
        def product_name=(_product_name); end
        # The quantity of items. Required for L3 rates. An integer greater than 0.
        sig { returns(Integer) }
        def quantity; end
        sig { params(_quantity: Integer).returns(Integer) }
        def quantity=(_quantity); end
        # Contains information about the tax on the item.
        sig { returns(T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::Tax)) }
        def tax; end
        sig {
          params(_tax: T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::Tax)).returns(T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::Tax))
         }
        def tax=(_tax); end
        # The unit cost of the line item represented in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal). Required for L3 rates. An integer greater than or equal to 0.
        sig { returns(Integer) }
        def unit_cost; end
        sig { params(_unit_cost: Integer).returns(Integer) }
        def unit_cost=(_unit_cost); end
        # A unit of measure for the line item, such as gallons, feet, meters, etc.
        sig { returns(T.nilable(String)) }
        def unit_of_measure; end
        sig { params(_unit_of_measure: T.nilable(String)).returns(T.nilable(String)) }
        def unit_of_measure=(_unit_of_measure); end
        sig {
          params(discount_amount: T.nilable(Integer), payment_method_options: T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::PaymentMethodOptions), product_code: T.nilable(String), product_name: String, quantity: Integer, tax: T.nilable(PaymentIntentCaptureParams::AmountDetails::LineItem::Tax), unit_cost: Integer, unit_of_measure: T.nilable(String)).void
         }
        def initialize(
          discount_amount: nil,
          payment_method_options: nil,
          product_code: nil,
          product_name: nil,
          quantity: nil,
          tax: nil,
          unit_cost: nil,
          unit_of_measure: nil
        ); end
      end
      class Shipping < ::Stripe::RequestParams
        # If a physical good is being shipped, the cost of shipping represented in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal). An integer greater than or equal to 0.
        sig { returns(T.nilable(T.any(String, Integer))) }
        def amount; end
        sig {
          params(_amount: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
         }
        def amount=(_amount); end
        # If a physical good is being shipped, the postal code of where it is being shipped from. At most 10 alphanumeric characters long, hyphens are allowed.
        sig { returns(T.nilable(String)) }
        def from_postal_code; end
        sig { params(_from_postal_code: T.nilable(String)).returns(T.nilable(String)) }
        def from_postal_code=(_from_postal_code); end
        # If a physical good is being shipped, the postal code of where it is being shipped to. At most 10 alphanumeric characters long, hyphens are allowed.
        sig { returns(T.nilable(String)) }
        def to_postal_code; end
        sig { params(_to_postal_code: T.nilable(String)).returns(T.nilable(String)) }
        def to_postal_code=(_to_postal_code); end
        sig {
          params(amount: T.nilable(T.any(String, Integer)), from_postal_code: T.nilable(String), to_postal_code: T.nilable(String)).void
         }
        def initialize(amount: nil, from_postal_code: nil, to_postal_code: nil); end
      end
      class Tax < ::Stripe::RequestParams
        # The total amount of tax on the transaction represented in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal). Required for L2 rates. An integer greater than or equal to 0.
        #
        # This field is mutually exclusive with the `amount_details[line_items][#][tax][total_tax_amount]` field.
        sig { returns(Integer) }
        def total_tax_amount; end
        sig { params(_total_tax_amount: Integer).returns(Integer) }
        def total_tax_amount=(_total_tax_amount); end
        sig { params(total_tax_amount: Integer).void }
        def initialize(total_tax_amount: nil); end
      end
      # The total discount applied on the transaction represented in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal). An integer greater than 0.
      #
      # This field is mutually exclusive with the `amount_details[line_items][#][discount_amount]` field.
      sig { returns(T.nilable(T.any(String, Integer))) }
      def discount_amount; end
      sig {
        params(_discount_amount: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
       }
      def discount_amount=(_discount_amount); end
      # A list of line items, each containing information about a product in the PaymentIntent. There is a maximum of 200 line items.
      sig {
        returns(T.nilable(T.any(String, T::Array[PaymentIntentCaptureParams::AmountDetails::LineItem])))
       }
      def line_items; end
      sig {
        params(_line_items: T.nilable(T.any(String, T::Array[PaymentIntentCaptureParams::AmountDetails::LineItem]))).returns(T.nilable(T.any(String, T::Array[PaymentIntentCaptureParams::AmountDetails::LineItem])))
       }
      def line_items=(_line_items); end
      # Contains information about the shipping portion of the amount.
      sig { returns(T.nilable(T.any(String, PaymentIntentCaptureParams::AmountDetails::Shipping))) }
      def shipping; end
      sig {
        params(_shipping: T.nilable(T.any(String, PaymentIntentCaptureParams::AmountDetails::Shipping))).returns(T.nilable(T.any(String, PaymentIntentCaptureParams::AmountDetails::Shipping)))
       }
      def shipping=(_shipping); end
      # Contains information about the tax portion of the amount.
      sig { returns(T.nilable(T.any(String, PaymentIntentCaptureParams::AmountDetails::Tax))) }
      def tax; end
      sig {
        params(_tax: T.nilable(T.any(String, PaymentIntentCaptureParams::AmountDetails::Tax))).returns(T.nilable(T.any(String, PaymentIntentCaptureParams::AmountDetails::Tax)))
       }
      def tax=(_tax); end
      sig {
        params(discount_amount: T.nilable(T.any(String, Integer)), line_items: T.nilable(T.any(String, T::Array[PaymentIntentCaptureParams::AmountDetails::LineItem])), shipping: T.nilable(T.any(String, PaymentIntentCaptureParams::AmountDetails::Shipping)), tax: T.nilable(T.any(String, PaymentIntentCaptureParams::AmountDetails::Tax))).void
       }
      def initialize(discount_amount: nil, line_items: nil, shipping: nil, tax: nil); end
    end
    class Hooks < ::Stripe::RequestParams
      class Inputs < ::Stripe::RequestParams
        class Tax < ::Stripe::RequestParams
          # The [TaxCalculation](https://docs.stripe.com/api/tax/calculations) id
          sig { returns(String) }
          def calculation; end
          sig { params(_calculation: String).returns(String) }
          def calculation=(_calculation); end
          sig { params(calculation: String).void }
          def initialize(calculation: nil); end
        end
        # Tax arguments for automations
        sig { returns(T.nilable(PaymentIntentCaptureParams::Hooks::Inputs::Tax)) }
        def tax; end
        sig {
          params(_tax: T.nilable(PaymentIntentCaptureParams::Hooks::Inputs::Tax)).returns(T.nilable(PaymentIntentCaptureParams::Hooks::Inputs::Tax))
         }
        def tax=(_tax); end
        sig { params(tax: T.nilable(PaymentIntentCaptureParams::Hooks::Inputs::Tax)).void }
        def initialize(tax: nil); end
      end
      # Arguments passed in automations
      sig { returns(T.nilable(PaymentIntentCaptureParams::Hooks::Inputs)) }
      def inputs; end
      sig {
        params(_inputs: T.nilable(PaymentIntentCaptureParams::Hooks::Inputs)).returns(T.nilable(PaymentIntentCaptureParams::Hooks::Inputs))
       }
      def inputs=(_inputs); end
      sig { params(inputs: T.nilable(PaymentIntentCaptureParams::Hooks::Inputs)).void }
      def initialize(inputs: nil); end
    end
    class PaymentDetails < ::Stripe::RequestParams
      # A unique value to identify the customer. This field is available only for card payments.
      #
      # This field is truncated to 25 alphanumeric characters, excluding spaces, before being sent to card networks.
      sig { returns(T.nilable(String)) }
      def customer_reference; end
      sig { params(_customer_reference: T.nilable(String)).returns(T.nilable(String)) }
      def customer_reference=(_customer_reference); end
      # A unique value assigned by the business to identify the transaction. Required for L2 and L3 rates.
      #
      # Required when the Payment Method Types array contains `card`, including when [automatic_payment_methods.enabled](/api/payment_intents/create#create_payment_intent-automatic_payment_methods-enabled) is set to `true`.
      #
      # For Cards, this field is truncated to 25 alphanumeric characters, excluding spaces, before being sent to card networks. For Klarna, this field is truncated to 255 characters and is visible to customers when they view the order in the Klarna app.
      sig { returns(T.nilable(String)) }
      def order_reference; end
      sig { params(_order_reference: T.nilable(String)).returns(T.nilable(String)) }
      def order_reference=(_order_reference); end
      sig { params(customer_reference: T.nilable(String), order_reference: T.nilable(String)).void }
      def initialize(customer_reference: nil, order_reference: nil); end
    end
    class TransferData < ::Stripe::RequestParams
      # The amount that will be transferred automatically when a charge succeeds.
      sig { returns(T.nilable(Integer)) }
      def amount; end
      sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def amount=(_amount); end
      sig { params(amount: T.nilable(Integer)).void }
      def initialize(amount: nil); end
    end
    # Provides industry-specific information about the amount.
    sig { returns(T.nilable(PaymentIntentCaptureParams::AmountDetails)) }
    def amount_details; end
    sig {
      params(_amount_details: T.nilable(PaymentIntentCaptureParams::AmountDetails)).returns(T.nilable(PaymentIntentCaptureParams::AmountDetails))
     }
    def amount_details=(_amount_details); end
    # The amount to capture from the PaymentIntent, which must be less than or equal to the original amount. Defaults to the full `amount_capturable` if it's not provided.
    sig { returns(T.nilable(Integer)) }
    def amount_to_capture; end
    sig { params(_amount_to_capture: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def amount_to_capture=(_amount_to_capture); end
    # The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the application owner's Stripe account. The amount of the application fee collected will be capped at the total amount captured. For more information, see the PaymentIntents [use case for connected accounts](https://docs.stripe.com/payments/connected-accounts).
    sig { returns(T.nilable(Integer)) }
    def application_fee_amount; end
    sig { params(_application_fee_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def application_fee_amount=(_application_fee_amount); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Defaults to `true`. When capturing a PaymentIntent, setting `final_capture` to `false` notifies Stripe to not release the remaining uncaptured funds to make sure that they're captured in future requests. You can only use this setting when [multicapture](https://docs.stripe.com/payments/multicapture) is available for PaymentIntents.
    sig { returns(T.nilable(T::Boolean)) }
    def final_capture; end
    sig { params(_final_capture: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def final_capture=(_final_capture); end
    # Automations to be run during the PaymentIntent lifecycle
    sig { returns(T.nilable(PaymentIntentCaptureParams::Hooks)) }
    def hooks; end
    sig {
      params(_hooks: T.nilable(PaymentIntentCaptureParams::Hooks)).returns(T.nilable(PaymentIntentCaptureParams::Hooks))
     }
    def hooks=(_hooks); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # Provides industry-specific information about the charge.
    sig { returns(T.nilable(T.any(String, PaymentIntentCaptureParams::PaymentDetails))) }
    def payment_details; end
    sig {
      params(_payment_details: T.nilable(T.any(String, PaymentIntentCaptureParams::PaymentDetails))).returns(T.nilable(T.any(String, PaymentIntentCaptureParams::PaymentDetails)))
     }
    def payment_details=(_payment_details); end
    # Text that appears on the customer's statement as the statement descriptor for a non-card charge. This value overrides the account's default statement descriptor. For information about requirements, including the 22-character limit, see [the Statement Descriptor docs](https://docs.stripe.com/get-started/account/statement-descriptors).
    #
    # Setting this value for a card charge returns an error. For card charges, set the [statement_descriptor_suffix](https://docs.stripe.com/get-started/account/statement-descriptors#dynamic) instead.
    sig { returns(T.nilable(String)) }
    def statement_descriptor; end
    sig { params(_statement_descriptor: T.nilable(String)).returns(T.nilable(String)) }
    def statement_descriptor=(_statement_descriptor); end
    # Provides information about a card charge. Concatenated to the account's [statement descriptor prefix](https://docs.stripe.com/get-started/account/statement-descriptors#static) to form the complete statement descriptor that appears on the customer's statement.
    sig { returns(T.nilable(String)) }
    def statement_descriptor_suffix; end
    sig { params(_statement_descriptor_suffix: T.nilable(String)).returns(T.nilable(String)) }
    def statement_descriptor_suffix=(_statement_descriptor_suffix); end
    # The parameters that you can use to automatically create a transfer after the payment
    # is captured. Learn more about the [use case for connected accounts](https://docs.stripe.com/payments/connected-accounts).
    sig { returns(T.nilable(PaymentIntentCaptureParams::TransferData)) }
    def transfer_data; end
    sig {
      params(_transfer_data: T.nilable(PaymentIntentCaptureParams::TransferData)).returns(T.nilable(PaymentIntentCaptureParams::TransferData))
     }
    def transfer_data=(_transfer_data); end
    sig {
      params(amount_details: T.nilable(PaymentIntentCaptureParams::AmountDetails), amount_to_capture: T.nilable(Integer), application_fee_amount: T.nilable(Integer), expand: T.nilable(T::Array[String]), final_capture: T.nilable(T::Boolean), hooks: T.nilable(PaymentIntentCaptureParams::Hooks), metadata: T.nilable(T.any(String, T::Hash[String, String])), payment_details: T.nilable(T.any(String, PaymentIntentCaptureParams::PaymentDetails)), statement_descriptor: T.nilable(String), statement_descriptor_suffix: T.nilable(String), transfer_data: T.nilable(PaymentIntentCaptureParams::TransferData)).void
     }
    def initialize(
      amount_details: nil,
      amount_to_capture: nil,
      application_fee_amount: nil,
      expand: nil,
      final_capture: nil,
      hooks: nil,
      metadata: nil,
      payment_details: nil,
      statement_descriptor: nil,
      statement_descriptor_suffix: nil,
      transfer_data: nil
    ); end
  end
end