# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentIntentUpdateParams < ::Stripe::RequestParams
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
            returns(T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions::Card))
           }
          def card; end
          sig {
            params(_card: T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions::Card)).returns(T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions::Card))
           }
          def card=(_card); end
          # This sub-hash contains line item details that are specific to `card_present` payment method."
          sig {
            returns(T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions::CardPresent))
           }
          def card_present; end
          sig {
            params(_card_present: T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions::CardPresent)).returns(T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions::CardPresent))
           }
          def card_present=(_card_present); end
          # This sub-hash contains line item details that are specific to `klarna` payment method."
          sig {
            returns(T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions::Klarna))
           }
          def klarna; end
          sig {
            params(_klarna: T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions::Klarna)).returns(T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions::Klarna))
           }
          def klarna=(_klarna); end
          # This sub-hash contains line item details that are specific to `paypal` payment method."
          sig {
            returns(T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions::Paypal))
           }
          def paypal; end
          sig {
            params(_paypal: T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions::Paypal)).returns(T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions::Paypal))
           }
          def paypal=(_paypal); end
          sig {
            params(card: T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions::Card), card_present: T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions::CardPresent), klarna: T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions::Klarna), paypal: T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions::Paypal)).void
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
          returns(T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions))
         }
        def payment_method_options; end
        sig {
          params(_payment_method_options: T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions)).returns(T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions))
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
        sig { returns(T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::Tax)) }
        def tax; end
        sig {
          params(_tax: T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::Tax)).returns(T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::Tax))
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
          params(discount_amount: T.nilable(Integer), payment_method_options: T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::PaymentMethodOptions), product_code: T.nilable(String), product_name: String, quantity: Integer, tax: T.nilable(PaymentIntentUpdateParams::AmountDetails::LineItem::Tax), unit_cost: Integer, unit_of_measure: T.nilable(String)).void
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
        returns(T.nilable(T.any(String, T::Array[PaymentIntentUpdateParams::AmountDetails::LineItem])))
       }
      def line_items; end
      sig {
        params(_line_items: T.nilable(T.any(String, T::Array[PaymentIntentUpdateParams::AmountDetails::LineItem]))).returns(T.nilable(T.any(String, T::Array[PaymentIntentUpdateParams::AmountDetails::LineItem])))
       }
      def line_items=(_line_items); end
      # Contains information about the shipping portion of the amount.
      sig { returns(T.nilable(T.any(String, PaymentIntentUpdateParams::AmountDetails::Shipping))) }
      def shipping; end
      sig {
        params(_shipping: T.nilable(T.any(String, PaymentIntentUpdateParams::AmountDetails::Shipping))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::AmountDetails::Shipping)))
       }
      def shipping=(_shipping); end
      # Contains information about the tax portion of the amount.
      sig { returns(T.nilable(T.any(String, PaymentIntentUpdateParams::AmountDetails::Tax))) }
      def tax; end
      sig {
        params(_tax: T.nilable(T.any(String, PaymentIntentUpdateParams::AmountDetails::Tax))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::AmountDetails::Tax)))
       }
      def tax=(_tax); end
      sig {
        params(discount_amount: T.nilable(T.any(String, Integer)), line_items: T.nilable(T.any(String, T::Array[PaymentIntentUpdateParams::AmountDetails::LineItem])), shipping: T.nilable(T.any(String, PaymentIntentUpdateParams::AmountDetails::Shipping)), tax: T.nilable(T.any(String, PaymentIntentUpdateParams::AmountDetails::Tax))).void
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
        sig { returns(T.nilable(PaymentIntentUpdateParams::Hooks::Inputs::Tax)) }
        def tax; end
        sig {
          params(_tax: T.nilable(PaymentIntentUpdateParams::Hooks::Inputs::Tax)).returns(T.nilable(PaymentIntentUpdateParams::Hooks::Inputs::Tax))
         }
        def tax=(_tax); end
        sig { params(tax: T.nilable(PaymentIntentUpdateParams::Hooks::Inputs::Tax)).void }
        def initialize(tax: nil); end
      end
      # Arguments passed in automations
      sig { returns(T.nilable(PaymentIntentUpdateParams::Hooks::Inputs)) }
      def inputs; end
      sig {
        params(_inputs: T.nilable(PaymentIntentUpdateParams::Hooks::Inputs)).returns(T.nilable(PaymentIntentUpdateParams::Hooks::Inputs))
       }
      def inputs=(_inputs); end
      sig { params(inputs: T.nilable(PaymentIntentUpdateParams::Hooks::Inputs)).void }
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
    class PaymentMethodData < ::Stripe::RequestParams
      class AcssDebit < ::Stripe::RequestParams
        # Customer's bank account number.
        sig { returns(String) }
        def account_number; end
        sig { params(_account_number: String).returns(String) }
        def account_number=(_account_number); end
        # Institution number of the customer's bank.
        sig { returns(String) }
        def institution_number; end
        sig { params(_institution_number: String).returns(String) }
        def institution_number=(_institution_number); end
        # Transit number of the customer's bank.
        sig { returns(String) }
        def transit_number; end
        sig { params(_transit_number: String).returns(String) }
        def transit_number=(_transit_number); end
        sig {
          params(account_number: String, institution_number: String, transit_number: String).void
         }
        def initialize(account_number: nil, institution_number: nil, transit_number: nil); end
      end
      class Affirm < ::Stripe::RequestParams; end
      class AfterpayClearpay < ::Stripe::RequestParams; end
      class Alipay < ::Stripe::RequestParams; end
      class Alma < ::Stripe::RequestParams; end
      class AmazonPay < ::Stripe::RequestParams; end
      class AuBecsDebit < ::Stripe::RequestParams
        # The account number for the bank account.
        sig { returns(String) }
        def account_number; end
        sig { params(_account_number: String).returns(String) }
        def account_number=(_account_number); end
        # Bank-State-Branch number of the bank account.
        sig { returns(String) }
        def bsb_number; end
        sig { params(_bsb_number: String).returns(String) }
        def bsb_number=(_bsb_number); end
        sig { params(account_number: String, bsb_number: String).void }
        def initialize(account_number: nil, bsb_number: nil); end
      end
      class BacsDebit < ::Stripe::RequestParams
        # Account number of the bank account that the funds will be debited from.
        sig { returns(T.nilable(String)) }
        def account_number; end
        sig { params(_account_number: T.nilable(String)).returns(T.nilable(String)) }
        def account_number=(_account_number); end
        # Sort code of the bank account. (e.g., `10-20-30`)
        sig { returns(T.nilable(String)) }
        def sort_code; end
        sig { params(_sort_code: T.nilable(String)).returns(T.nilable(String)) }
        def sort_code=(_sort_code); end
        sig { params(account_number: T.nilable(String), sort_code: T.nilable(String)).void }
        def initialize(account_number: nil, sort_code: nil); end
      end
      class Bancontact < ::Stripe::RequestParams; end
      class Billie < ::Stripe::RequestParams; end
      class BillingDetails < ::Stripe::RequestParams
        class Address < ::Stripe::RequestParams
          # City, district, suburb, town, or village.
          sig { returns(T.nilable(String)) }
          def city; end
          sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
          def city=(_city); end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(T.nilable(String)) }
          def country; end
          sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
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
          # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
          sig { returns(T.nilable(String)) }
          def state; end
          sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
          def state=(_state); end
          sig {
            params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String)).void
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
        # Billing address.
        sig {
          returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodData::BillingDetails::Address)))
         }
        def address; end
        sig {
          params(_address: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodData::BillingDetails::Address))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodData::BillingDetails::Address)))
         }
        def address=(_address); end
        # Email address.
        sig { returns(T.nilable(String)) }
        def email; end
        sig { params(_email: T.nilable(String)).returns(T.nilable(String)) }
        def email=(_email); end
        # Full name.
        sig { returns(T.nilable(String)) }
        def name; end
        sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
        def name=(_name); end
        # Billing phone number (including extension).
        sig { returns(T.nilable(String)) }
        def phone; end
        sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
        def phone=(_phone); end
        # Taxpayer identification number. Used only for transactions between LATAM buyers and non-LATAM sellers.
        sig { returns(T.nilable(String)) }
        def tax_id; end
        sig { params(_tax_id: T.nilable(String)).returns(T.nilable(String)) }
        def tax_id=(_tax_id); end
        sig {
          params(address: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodData::BillingDetails::Address)), email: T.nilable(String), name: T.nilable(String), phone: T.nilable(String), tax_id: T.nilable(String)).void
         }
        def initialize(address: nil, email: nil, name: nil, phone: nil, tax_id: nil); end
      end
      class Blik < ::Stripe::RequestParams; end
      class Boleto < ::Stripe::RequestParams
        # The tax ID of the customer (CPF for individual consumers or CNPJ for businesses consumers)
        sig { returns(String) }
        def tax_id; end
        sig { params(_tax_id: String).returns(String) }
        def tax_id=(_tax_id); end
        sig { params(tax_id: String).void }
        def initialize(tax_id: nil); end
      end
      class Cashapp < ::Stripe::RequestParams; end
      class Crypto < ::Stripe::RequestParams; end
      class CustomerBalance < ::Stripe::RequestParams; end
      class Eps < ::Stripe::RequestParams
        # The customer's bank.
        sig { returns(T.nilable(String)) }
        def bank; end
        sig { params(_bank: T.nilable(String)).returns(T.nilable(String)) }
        def bank=(_bank); end
        sig { params(bank: T.nilable(String)).void }
        def initialize(bank: nil); end
      end
      class Fpx < ::Stripe::RequestParams
        # Account holder type for FPX transaction
        sig { returns(T.nilable(String)) }
        def account_holder_type; end
        sig { params(_account_holder_type: T.nilable(String)).returns(T.nilable(String)) }
        def account_holder_type=(_account_holder_type); end
        # The customer's bank.
        sig { returns(String) }
        def bank; end
        sig { params(_bank: String).returns(String) }
        def bank=(_bank); end
        sig { params(account_holder_type: T.nilable(String), bank: String).void }
        def initialize(account_holder_type: nil, bank: nil); end
      end
      class Giropay < ::Stripe::RequestParams; end
      class Grabpay < ::Stripe::RequestParams; end
      class Ideal < ::Stripe::RequestParams
        # The customer's bank. Only use this parameter for existing customers. Don't use it for new customers.
        sig { returns(T.nilable(String)) }
        def bank; end
        sig { params(_bank: T.nilable(String)).returns(T.nilable(String)) }
        def bank=(_bank); end
        sig { params(bank: T.nilable(String)).void }
        def initialize(bank: nil); end
      end
      class InteracPresent < ::Stripe::RequestParams; end
      class KakaoPay < ::Stripe::RequestParams; end
      class Klarna < ::Stripe::RequestParams
        class Dob < ::Stripe::RequestParams
          # The day of birth, between 1 and 31.
          sig { returns(Integer) }
          def day; end
          sig { params(_day: Integer).returns(Integer) }
          def day=(_day); end
          # The month of birth, between 1 and 12.
          sig { returns(Integer) }
          def month; end
          sig { params(_month: Integer).returns(Integer) }
          def month=(_month); end
          # The four-digit year of birth.
          sig { returns(Integer) }
          def year; end
          sig { params(_year: Integer).returns(Integer) }
          def year=(_year); end
          sig { params(day: Integer, month: Integer, year: Integer).void }
          def initialize(day: nil, month: nil, year: nil); end
        end
        # Customer's date of birth
        sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Klarna::Dob)) }
        def dob; end
        sig {
          params(_dob: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Klarna::Dob)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Klarna::Dob))
         }
        def dob=(_dob); end
        sig {
          params(dob: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Klarna::Dob)).void
         }
        def initialize(dob: nil); end
      end
      class Konbini < ::Stripe::RequestParams; end
      class KrCard < ::Stripe::RequestParams; end
      class Link < ::Stripe::RequestParams; end
      class MbWay < ::Stripe::RequestParams; end
      class Mobilepay < ::Stripe::RequestParams; end
      class Multibanco < ::Stripe::RequestParams; end
      class NaverPay < ::Stripe::RequestParams
        # Whether to use Naver Pay points or a card to fund this transaction. If not provided, this defaults to `card`.
        sig { returns(T.nilable(String)) }
        def funding; end
        sig { params(_funding: T.nilable(String)).returns(T.nilable(String)) }
        def funding=(_funding); end
        sig { params(funding: T.nilable(String)).void }
        def initialize(funding: nil); end
      end
      class NzBankAccount < ::Stripe::RequestParams
        # The name on the bank account. Only required if the account holder name is different from the name of the authorized signatory collected in the PaymentMethod’s billing details.
        sig { returns(T.nilable(String)) }
        def account_holder_name; end
        sig { params(_account_holder_name: T.nilable(String)).returns(T.nilable(String)) }
        def account_holder_name=(_account_holder_name); end
        # The account number for the bank account.
        sig { returns(String) }
        def account_number; end
        sig { params(_account_number: String).returns(String) }
        def account_number=(_account_number); end
        # The numeric code for the bank account's bank.
        sig { returns(String) }
        def bank_code; end
        sig { params(_bank_code: String).returns(String) }
        def bank_code=(_bank_code); end
        # The numeric code for the bank account's bank branch.
        sig { returns(String) }
        def branch_code; end
        sig { params(_branch_code: String).returns(String) }
        def branch_code=(_branch_code); end
        # Attribute for param field reference
        sig { returns(T.nilable(String)) }
        def reference; end
        sig { params(_reference: T.nilable(String)).returns(T.nilable(String)) }
        def reference=(_reference); end
        # The suffix of the bank account number.
        sig { returns(String) }
        def suffix; end
        sig { params(_suffix: String).returns(String) }
        def suffix=(_suffix); end
        sig {
          params(account_holder_name: T.nilable(String), account_number: String, bank_code: String, branch_code: String, reference: T.nilable(String), suffix: String).void
         }
        def initialize(
          account_holder_name: nil,
          account_number: nil,
          bank_code: nil,
          branch_code: nil,
          reference: nil,
          suffix: nil
        ); end
      end
      class Oxxo < ::Stripe::RequestParams; end
      class P24 < ::Stripe::RequestParams
        # The customer's bank.
        sig { returns(T.nilable(String)) }
        def bank; end
        sig { params(_bank: T.nilable(String)).returns(T.nilable(String)) }
        def bank=(_bank); end
        sig { params(bank: T.nilable(String)).void }
        def initialize(bank: nil); end
      end
      class PayByBank < ::Stripe::RequestParams; end
      class Payco < ::Stripe::RequestParams; end
      class Paynow < ::Stripe::RequestParams; end
      class Paypal < ::Stripe::RequestParams; end
      class Payto < ::Stripe::RequestParams
        # The account number for the bank account.
        sig { returns(T.nilable(String)) }
        def account_number; end
        sig { params(_account_number: T.nilable(String)).returns(T.nilable(String)) }
        def account_number=(_account_number); end
        # Bank-State-Branch number of the bank account.
        sig { returns(T.nilable(String)) }
        def bsb_number; end
        sig { params(_bsb_number: T.nilable(String)).returns(T.nilable(String)) }
        def bsb_number=(_bsb_number); end
        # The PayID alias for the bank account.
        sig { returns(T.nilable(String)) }
        def pay_id; end
        sig { params(_pay_id: T.nilable(String)).returns(T.nilable(String)) }
        def pay_id=(_pay_id); end
        sig {
          params(account_number: T.nilable(String), bsb_number: T.nilable(String), pay_id: T.nilable(String)).void
         }
        def initialize(account_number: nil, bsb_number: nil, pay_id: nil); end
      end
      class Pix < ::Stripe::RequestParams; end
      class Promptpay < ::Stripe::RequestParams; end
      class RadarOptions < ::Stripe::RequestParams
        # A [Radar Session](https://docs.stripe.com/radar/radar-session) is a snapshot of the browser metadata and device details that help Radar make more accurate predictions on your payments.
        sig { returns(T.nilable(String)) }
        def session; end
        sig { params(_session: T.nilable(String)).returns(T.nilable(String)) }
        def session=(_session); end
        sig { params(session: T.nilable(String)).void }
        def initialize(session: nil); end
      end
      class RevolutPay < ::Stripe::RequestParams; end
      class SamsungPay < ::Stripe::RequestParams; end
      class Satispay < ::Stripe::RequestParams; end
      class SepaDebit < ::Stripe::RequestParams
        # IBAN of the bank account.
        sig { returns(String) }
        def iban; end
        sig { params(_iban: String).returns(String) }
        def iban=(_iban); end
        sig { params(iban: String).void }
        def initialize(iban: nil); end
      end
      class Sofort < ::Stripe::RequestParams
        # Two-letter ISO code representing the country the bank account is located in.
        sig { returns(String) }
        def country; end
        sig { params(_country: String).returns(String) }
        def country=(_country); end
        sig { params(country: String).void }
        def initialize(country: nil); end
      end
      class Swish < ::Stripe::RequestParams; end
      class Twint < ::Stripe::RequestParams; end
      class UsBankAccount < ::Stripe::RequestParams
        # Account holder type: individual or company.
        sig { returns(T.nilable(String)) }
        def account_holder_type; end
        sig { params(_account_holder_type: T.nilable(String)).returns(T.nilable(String)) }
        def account_holder_type=(_account_holder_type); end
        # Account number of the bank account.
        sig { returns(T.nilable(String)) }
        def account_number; end
        sig { params(_account_number: T.nilable(String)).returns(T.nilable(String)) }
        def account_number=(_account_number); end
        # Account type: checkings or savings. Defaults to checking if omitted.
        sig { returns(T.nilable(String)) }
        def account_type; end
        sig { params(_account_type: T.nilable(String)).returns(T.nilable(String)) }
        def account_type=(_account_type); end
        # The ID of a Financial Connections Account to use as a payment method.
        sig { returns(T.nilable(String)) }
        def financial_connections_account; end
        sig { params(_financial_connections_account: T.nilable(String)).returns(T.nilable(String)) }
        def financial_connections_account=(_financial_connections_account); end
        # Routing number of the bank account.
        sig { returns(T.nilable(String)) }
        def routing_number; end
        sig { params(_routing_number: T.nilable(String)).returns(T.nilable(String)) }
        def routing_number=(_routing_number); end
        sig {
          params(account_holder_type: T.nilable(String), account_number: T.nilable(String), account_type: T.nilable(String), financial_connections_account: T.nilable(String), routing_number: T.nilable(String)).void
         }
        def initialize(
          account_holder_type: nil,
          account_number: nil,
          account_type: nil,
          financial_connections_account: nil,
          routing_number: nil
        ); end
      end
      class WechatPay < ::Stripe::RequestParams; end
      class Zip < ::Stripe::RequestParams; end
      # If this is an `acss_debit` PaymentMethod, this hash contains details about the ACSS Debit payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::AcssDebit)) }
      def acss_debit; end
      sig {
        params(_acss_debit: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::AcssDebit)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::AcssDebit))
       }
      def acss_debit=(_acss_debit); end
      # If this is an `affirm` PaymentMethod, this hash contains details about the Affirm payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Affirm)) }
      def affirm; end
      sig {
        params(_affirm: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Affirm)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Affirm))
       }
      def affirm=(_affirm); end
      # If this is an `AfterpayClearpay` PaymentMethod, this hash contains details about the AfterpayClearpay payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::AfterpayClearpay)) }
      def afterpay_clearpay; end
      sig {
        params(_afterpay_clearpay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::AfterpayClearpay)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::AfterpayClearpay))
       }
      def afterpay_clearpay=(_afterpay_clearpay); end
      # If this is an `Alipay` PaymentMethod, this hash contains details about the Alipay payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Alipay)) }
      def alipay; end
      sig {
        params(_alipay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Alipay)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Alipay))
       }
      def alipay=(_alipay); end
      # This field indicates whether this payment method can be shown again to its customer in a checkout flow. Stripe products such as Checkout and Elements use this field to determine whether a payment method can be shown as a saved payment method in a checkout flow. The field defaults to `unspecified`.
      sig { returns(T.nilable(String)) }
      def allow_redisplay; end
      sig { params(_allow_redisplay: T.nilable(String)).returns(T.nilable(String)) }
      def allow_redisplay=(_allow_redisplay); end
      # If this is a Alma PaymentMethod, this hash contains details about the Alma payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Alma)) }
      def alma; end
      sig {
        params(_alma: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Alma)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Alma))
       }
      def alma=(_alma); end
      # If this is a AmazonPay PaymentMethod, this hash contains details about the AmazonPay payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::AmazonPay)) }
      def amazon_pay; end
      sig {
        params(_amazon_pay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::AmazonPay)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::AmazonPay))
       }
      def amazon_pay=(_amazon_pay); end
      # If this is an `au_becs_debit` PaymentMethod, this hash contains details about the bank account.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::AuBecsDebit)) }
      def au_becs_debit; end
      sig {
        params(_au_becs_debit: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::AuBecsDebit)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::AuBecsDebit))
       }
      def au_becs_debit=(_au_becs_debit); end
      # If this is a `bacs_debit` PaymentMethod, this hash contains details about the Bacs Direct Debit bank account.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::BacsDebit)) }
      def bacs_debit; end
      sig {
        params(_bacs_debit: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::BacsDebit)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::BacsDebit))
       }
      def bacs_debit=(_bacs_debit); end
      # If this is a `bancontact` PaymentMethod, this hash contains details about the Bancontact payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Bancontact)) }
      def bancontact; end
      sig {
        params(_bancontact: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Bancontact)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Bancontact))
       }
      def bancontact=(_bancontact); end
      # If this is a `billie` PaymentMethod, this hash contains details about the Billie payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Billie)) }
      def billie; end
      sig {
        params(_billie: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Billie)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Billie))
       }
      def billie=(_billie); end
      # Billing information associated with the PaymentMethod that may be used or required by particular types of payment methods.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::BillingDetails)) }
      def billing_details; end
      sig {
        params(_billing_details: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::BillingDetails)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::BillingDetails))
       }
      def billing_details=(_billing_details); end
      # If this is a `blik` PaymentMethod, this hash contains details about the BLIK payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Blik)) }
      def blik; end
      sig {
        params(_blik: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Blik)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Blik))
       }
      def blik=(_blik); end
      # If this is a `boleto` PaymentMethod, this hash contains details about the Boleto payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Boleto)) }
      def boleto; end
      sig {
        params(_boleto: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Boleto)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Boleto))
       }
      def boleto=(_boleto); end
      # If this is a `cashapp` PaymentMethod, this hash contains details about the Cash App Pay payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Cashapp)) }
      def cashapp; end
      sig {
        params(_cashapp: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Cashapp)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Cashapp))
       }
      def cashapp=(_cashapp); end
      # If this is a Crypto PaymentMethod, this hash contains details about the Crypto payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Crypto)) }
      def crypto; end
      sig {
        params(_crypto: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Crypto)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Crypto))
       }
      def crypto=(_crypto); end
      # If this is a `customer_balance` PaymentMethod, this hash contains details about the CustomerBalance payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::CustomerBalance)) }
      def customer_balance; end
      sig {
        params(_customer_balance: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::CustomerBalance)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::CustomerBalance))
       }
      def customer_balance=(_customer_balance); end
      # If this is an `eps` PaymentMethod, this hash contains details about the EPS payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Eps)) }
      def eps; end
      sig {
        params(_eps: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Eps)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Eps))
       }
      def eps=(_eps); end
      # If this is an `fpx` PaymentMethod, this hash contains details about the FPX payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Fpx)) }
      def fpx; end
      sig {
        params(_fpx: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Fpx)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Fpx))
       }
      def fpx=(_fpx); end
      # If this is a `giropay` PaymentMethod, this hash contains details about the Giropay payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Giropay)) }
      def giropay; end
      sig {
        params(_giropay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Giropay)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Giropay))
       }
      def giropay=(_giropay); end
      # If this is a `grabpay` PaymentMethod, this hash contains details about the GrabPay payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Grabpay)) }
      def grabpay; end
      sig {
        params(_grabpay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Grabpay)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Grabpay))
       }
      def grabpay=(_grabpay); end
      # If this is an `ideal` PaymentMethod, this hash contains details about the iDEAL payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Ideal)) }
      def ideal; end
      sig {
        params(_ideal: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Ideal)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Ideal))
       }
      def ideal=(_ideal); end
      # If this is an `interac_present` PaymentMethod, this hash contains details about the Interac Present payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::InteracPresent)) }
      def interac_present; end
      sig {
        params(_interac_present: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::InteracPresent)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::InteracPresent))
       }
      def interac_present=(_interac_present); end
      # If this is a `kakao_pay` PaymentMethod, this hash contains details about the Kakao Pay payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::KakaoPay)) }
      def kakao_pay; end
      sig {
        params(_kakao_pay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::KakaoPay)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::KakaoPay))
       }
      def kakao_pay=(_kakao_pay); end
      # If this is a `klarna` PaymentMethod, this hash contains details about the Klarna payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Klarna)) }
      def klarna; end
      sig {
        params(_klarna: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Klarna)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Klarna))
       }
      def klarna=(_klarna); end
      # If this is a `konbini` PaymentMethod, this hash contains details about the Konbini payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Konbini)) }
      def konbini; end
      sig {
        params(_konbini: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Konbini)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Konbini))
       }
      def konbini=(_konbini); end
      # If this is a `kr_card` PaymentMethod, this hash contains details about the Korean Card payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::KrCard)) }
      def kr_card; end
      sig {
        params(_kr_card: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::KrCard)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::KrCard))
       }
      def kr_card=(_kr_card); end
      # If this is an `Link` PaymentMethod, this hash contains details about the Link payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Link)) }
      def link; end
      sig {
        params(_link: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Link)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Link))
       }
      def link=(_link); end
      # If this is a MB WAY PaymentMethod, this hash contains details about the MB WAY payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::MbWay)) }
      def mb_way; end
      sig {
        params(_mb_way: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::MbWay)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::MbWay))
       }
      def mb_way=(_mb_way); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # If this is a `mobilepay` PaymentMethod, this hash contains details about the MobilePay payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Mobilepay)) }
      def mobilepay; end
      sig {
        params(_mobilepay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Mobilepay)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Mobilepay))
       }
      def mobilepay=(_mobilepay); end
      # If this is a `multibanco` PaymentMethod, this hash contains details about the Multibanco payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Multibanco)) }
      def multibanco; end
      sig {
        params(_multibanco: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Multibanco)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Multibanco))
       }
      def multibanco=(_multibanco); end
      # If this is a `naver_pay` PaymentMethod, this hash contains details about the Naver Pay payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::NaverPay)) }
      def naver_pay; end
      sig {
        params(_naver_pay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::NaverPay)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::NaverPay))
       }
      def naver_pay=(_naver_pay); end
      # If this is an nz_bank_account PaymentMethod, this hash contains details about the nz_bank_account payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::NzBankAccount)) }
      def nz_bank_account; end
      sig {
        params(_nz_bank_account: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::NzBankAccount)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::NzBankAccount))
       }
      def nz_bank_account=(_nz_bank_account); end
      # If this is an `oxxo` PaymentMethod, this hash contains details about the OXXO payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Oxxo)) }
      def oxxo; end
      sig {
        params(_oxxo: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Oxxo)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Oxxo))
       }
      def oxxo=(_oxxo); end
      # If this is a `p24` PaymentMethod, this hash contains details about the P24 payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::P24)) }
      def p24; end
      sig {
        params(_p24: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::P24)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::P24))
       }
      def p24=(_p24); end
      # If this is a `pay_by_bank` PaymentMethod, this hash contains details about the PayByBank payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::PayByBank)) }
      def pay_by_bank; end
      sig {
        params(_pay_by_bank: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::PayByBank)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::PayByBank))
       }
      def pay_by_bank=(_pay_by_bank); end
      # If this is a `payco` PaymentMethod, this hash contains details about the PAYCO payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Payco)) }
      def payco; end
      sig {
        params(_payco: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Payco)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Payco))
       }
      def payco=(_payco); end
      # If this is a `paynow` PaymentMethod, this hash contains details about the PayNow payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Paynow)) }
      def paynow; end
      sig {
        params(_paynow: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Paynow)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Paynow))
       }
      def paynow=(_paynow); end
      # If this is a `paypal` PaymentMethod, this hash contains details about the PayPal payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Paypal)) }
      def paypal; end
      sig {
        params(_paypal: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Paypal)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Paypal))
       }
      def paypal=(_paypal); end
      # If this is a `payto` PaymentMethod, this hash contains details about the PayTo payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Payto)) }
      def payto; end
      sig {
        params(_payto: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Payto)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Payto))
       }
      def payto=(_payto); end
      # If this is a `pix` PaymentMethod, this hash contains details about the Pix payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Pix)) }
      def pix; end
      sig {
        params(_pix: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Pix)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Pix))
       }
      def pix=(_pix); end
      # If this is a `promptpay` PaymentMethod, this hash contains details about the PromptPay payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Promptpay)) }
      def promptpay; end
      sig {
        params(_promptpay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Promptpay)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Promptpay))
       }
      def promptpay=(_promptpay); end
      # Options to configure Radar. See [Radar Session](https://docs.stripe.com/radar/radar-session) for more information.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::RadarOptions)) }
      def radar_options; end
      sig {
        params(_radar_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::RadarOptions)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::RadarOptions))
       }
      def radar_options=(_radar_options); end
      # If this is a `revolut_pay` PaymentMethod, this hash contains details about the Revolut Pay payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::RevolutPay)) }
      def revolut_pay; end
      sig {
        params(_revolut_pay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::RevolutPay)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::RevolutPay))
       }
      def revolut_pay=(_revolut_pay); end
      # If this is a `samsung_pay` PaymentMethod, this hash contains details about the SamsungPay payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::SamsungPay)) }
      def samsung_pay; end
      sig {
        params(_samsung_pay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::SamsungPay)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::SamsungPay))
       }
      def samsung_pay=(_samsung_pay); end
      # If this is a `satispay` PaymentMethod, this hash contains details about the Satispay payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Satispay)) }
      def satispay; end
      sig {
        params(_satispay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Satispay)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Satispay))
       }
      def satispay=(_satispay); end
      # If this is a `sepa_debit` PaymentMethod, this hash contains details about the SEPA debit bank account.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::SepaDebit)) }
      def sepa_debit; end
      sig {
        params(_sepa_debit: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::SepaDebit)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::SepaDebit))
       }
      def sepa_debit=(_sepa_debit); end
      # If this is a `sofort` PaymentMethod, this hash contains details about the SOFORT payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Sofort)) }
      def sofort; end
      sig {
        params(_sofort: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Sofort)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Sofort))
       }
      def sofort=(_sofort); end
      # If this is a `swish` PaymentMethod, this hash contains details about the Swish payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Swish)) }
      def swish; end
      sig {
        params(_swish: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Swish)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Swish))
       }
      def swish=(_swish); end
      # If this is a TWINT PaymentMethod, this hash contains details about the TWINT payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Twint)) }
      def twint; end
      sig {
        params(_twint: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Twint)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Twint))
       }
      def twint=(_twint); end
      # The type of the PaymentMethod. An additional hash is included on the PaymentMethod with a name matching this value. It contains additional information specific to the PaymentMethod type.
      sig { returns(String) }
      def type; end
      sig { params(_type: String).returns(String) }
      def type=(_type); end
      # If this is an `us_bank_account` PaymentMethod, this hash contains details about the US bank account payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::UsBankAccount)) }
      def us_bank_account; end
      sig {
        params(_us_bank_account: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::UsBankAccount)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::UsBankAccount))
       }
      def us_bank_account=(_us_bank_account); end
      # If this is an `wechat_pay` PaymentMethod, this hash contains details about the wechat_pay payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::WechatPay)) }
      def wechat_pay; end
      sig {
        params(_wechat_pay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::WechatPay)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::WechatPay))
       }
      def wechat_pay=(_wechat_pay); end
      # If this is a `zip` PaymentMethod, this hash contains details about the Zip payment method.
      sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Zip)) }
      def zip; end
      sig {
        params(_zip: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Zip)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Zip))
       }
      def zip=(_zip); end
      sig {
        params(acss_debit: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::AcssDebit), affirm: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Affirm), afterpay_clearpay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::AfterpayClearpay), alipay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Alipay), allow_redisplay: T.nilable(String), alma: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Alma), amazon_pay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::AmazonPay), au_becs_debit: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::AuBecsDebit), bacs_debit: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::BacsDebit), bancontact: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Bancontact), billie: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Billie), billing_details: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::BillingDetails), blik: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Blik), boleto: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Boleto), cashapp: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Cashapp), crypto: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Crypto), customer_balance: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::CustomerBalance), eps: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Eps), fpx: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Fpx), giropay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Giropay), grabpay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Grabpay), ideal: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Ideal), interac_present: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::InteracPresent), kakao_pay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::KakaoPay), klarna: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Klarna), konbini: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Konbini), kr_card: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::KrCard), link: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Link), mb_way: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::MbWay), metadata: T.nilable(T::Hash[String, String]), mobilepay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Mobilepay), multibanco: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Multibanco), naver_pay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::NaverPay), nz_bank_account: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::NzBankAccount), oxxo: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Oxxo), p24: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::P24), pay_by_bank: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::PayByBank), payco: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Payco), paynow: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Paynow), paypal: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Paypal), payto: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Payto), pix: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Pix), promptpay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Promptpay), radar_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::RadarOptions), revolut_pay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::RevolutPay), samsung_pay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::SamsungPay), satispay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Satispay), sepa_debit: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::SepaDebit), sofort: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Sofort), swish: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Swish), twint: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Twint), type: String, us_bank_account: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::UsBankAccount), wechat_pay: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::WechatPay), zip: T.nilable(PaymentIntentUpdateParams::PaymentMethodData::Zip)).void
       }
      def initialize(
        acss_debit: nil,
        affirm: nil,
        afterpay_clearpay: nil,
        alipay: nil,
        allow_redisplay: nil,
        alma: nil,
        amazon_pay: nil,
        au_becs_debit: nil,
        bacs_debit: nil,
        bancontact: nil,
        billie: nil,
        billing_details: nil,
        blik: nil,
        boleto: nil,
        cashapp: nil,
        crypto: nil,
        customer_balance: nil,
        eps: nil,
        fpx: nil,
        giropay: nil,
        grabpay: nil,
        ideal: nil,
        interac_present: nil,
        kakao_pay: nil,
        klarna: nil,
        konbini: nil,
        kr_card: nil,
        link: nil,
        mb_way: nil,
        metadata: nil,
        mobilepay: nil,
        multibanco: nil,
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
        radar_options: nil,
        revolut_pay: nil,
        samsung_pay: nil,
        satispay: nil,
        sepa_debit: nil,
        sofort: nil,
        swish: nil,
        twint: nil,
        type: nil,
        us_bank_account: nil,
        wechat_pay: nil,
        zip: nil
      ); end
    end
    class PaymentMethodOptions < ::Stripe::RequestParams
      class AcssDebit < ::Stripe::RequestParams
        class MandateOptions < ::Stripe::RequestParams
          # A URL for custom mandate text to render during confirmation step.
          # The URL will be rendered with additional GET parameters `payment_intent` and `payment_intent_client_secret` when confirming a Payment Intent,
          # or `setup_intent` and `setup_intent_client_secret` when confirming a Setup Intent.
          sig { returns(T.nilable(String)) }
          def custom_mandate_url; end
          sig { params(_custom_mandate_url: T.nilable(String)).returns(T.nilable(String)) }
          def custom_mandate_url=(_custom_mandate_url); end
          # Description of the mandate interval. Only required if 'payment_schedule' parameter is 'interval' or 'combined'.
          sig { returns(T.nilable(String)) }
          def interval_description; end
          sig { params(_interval_description: T.nilable(String)).returns(T.nilable(String)) }
          def interval_description=(_interval_description); end
          # Payment schedule for the mandate.
          sig { returns(T.nilable(String)) }
          def payment_schedule; end
          sig { params(_payment_schedule: T.nilable(String)).returns(T.nilable(String)) }
          def payment_schedule=(_payment_schedule); end
          # Transaction type of the mandate.
          sig { returns(T.nilable(String)) }
          def transaction_type; end
          sig { params(_transaction_type: T.nilable(String)).returns(T.nilable(String)) }
          def transaction_type=(_transaction_type); end
          sig {
            params(custom_mandate_url: T.nilable(String), interval_description: T.nilable(String), payment_schedule: T.nilable(String), transaction_type: T.nilable(String)).void
           }
          def initialize(
            custom_mandate_url: nil,
            interval_description: nil,
            payment_schedule: nil,
            transaction_type: nil
          ); end
        end
        # Additional fields for Mandate creation
        sig {
          returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::AcssDebit::MandateOptions))
         }
        def mandate_options; end
        sig {
          params(_mandate_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::AcssDebit::MandateOptions)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::AcssDebit::MandateOptions))
         }
        def mandate_options=(_mandate_options); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        # Controls when Stripe will attempt to debit the funds from the customer's account. The date must be a string in YYYY-MM-DD format. The date must be in the future and between 3 and 15 calendar days from now.
        sig { returns(T.nilable(String)) }
        def target_date; end
        sig { params(_target_date: T.nilable(String)).returns(T.nilable(String)) }
        def target_date=(_target_date); end
        # Bank account verification method.
        sig { returns(T.nilable(String)) }
        def verification_method; end
        sig { params(_verification_method: T.nilable(String)).returns(T.nilable(String)) }
        def verification_method=(_verification_method); end
        sig {
          params(mandate_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::AcssDebit::MandateOptions), setup_future_usage: T.nilable(T.any(String, String)), target_date: T.nilable(String), verification_method: T.nilable(String)).void
         }
        def initialize(
          mandate_options: nil,
          setup_future_usage: nil,
          target_date: nil,
          verification_method: nil
        ); end
      end
      class Affirm < ::Stripe::RequestParams
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        # Preferred language of the Affirm authorization page that the customer is redirected to.
        sig { returns(T.nilable(String)) }
        def preferred_locale; end
        sig { params(_preferred_locale: T.nilable(String)).returns(T.nilable(String)) }
        def preferred_locale=(_preferred_locale); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(capture_method: T.nilable(String), preferred_locale: T.nilable(String), setup_future_usage: T.nilable(String)).void
         }
        def initialize(capture_method: nil, preferred_locale: nil, setup_future_usage: nil); end
      end
      class AfterpayClearpay < ::Stripe::RequestParams
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        # An internal identifier or reference that this payment corresponds to. You must limit the identifier to 128 characters, and it can only contain letters, numbers, underscores, backslashes, and dashes.
        # This field differs from the statement descriptor and item name.
        sig { returns(T.nilable(String)) }
        def reference; end
        sig { params(_reference: T.nilable(String)).returns(T.nilable(String)) }
        def reference=(_reference); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(capture_method: T.nilable(String), reference: T.nilable(String), setup_future_usage: T.nilable(String)).void
         }
        def initialize(capture_method: nil, reference: nil, setup_future_usage: nil); end
      end
      class Alipay < ::Stripe::RequestParams
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        sig { params(setup_future_usage: T.nilable(T.any(String, String))).void }
        def initialize(setup_future_usage: nil); end
      end
      class Alma < ::Stripe::RequestParams
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        sig { params(capture_method: T.nilable(String)).void }
        def initialize(capture_method: nil); end
      end
      class AmazonPay < ::Stripe::RequestParams
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(capture_method: T.nilable(String), setup_future_usage: T.nilable(T.any(String, String))).void
         }
        def initialize(capture_method: nil, setup_future_usage: nil); end
      end
      class AuBecsDebit < ::Stripe::RequestParams
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        # Controls when Stripe will attempt to debit the funds from the customer's account. The date must be a string in YYYY-MM-DD format. The date must be in the future and between 3 and 15 calendar days from now.
        sig { returns(T.nilable(String)) }
        def target_date; end
        sig { params(_target_date: T.nilable(String)).returns(T.nilable(String)) }
        def target_date=(_target_date); end
        sig {
          params(setup_future_usage: T.nilable(T.any(String, String)), target_date: T.nilable(String)).void
         }
        def initialize(setup_future_usage: nil, target_date: nil); end
      end
      class BacsDebit < ::Stripe::RequestParams
        class MandateOptions < ::Stripe::RequestParams
          # Prefix used to generate the Mandate reference. Must be at most 12 characters long. Must consist of only uppercase letters, numbers, spaces, or the following special characters: '/', '_', '-', '&', '.'. Cannot begin with 'DDIC' or 'STRIPE'.
          sig { returns(T.nilable(String)) }
          def reference_prefix; end
          sig { params(_reference_prefix: T.nilable(String)).returns(T.nilable(String)) }
          def reference_prefix=(_reference_prefix); end
          sig { params(reference_prefix: T.nilable(String)).void }
          def initialize(reference_prefix: nil); end
        end
        # Additional fields for Mandate creation
        sig {
          returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::BacsDebit::MandateOptions))
         }
        def mandate_options; end
        sig {
          params(_mandate_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::BacsDebit::MandateOptions)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::BacsDebit::MandateOptions))
         }
        def mandate_options=(_mandate_options); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        # Controls when Stripe will attempt to debit the funds from the customer's account. The date must be a string in YYYY-MM-DD format. The date must be in the future and between 3 and 15 calendar days from now.
        sig { returns(T.nilable(String)) }
        def target_date; end
        sig { params(_target_date: T.nilable(String)).returns(T.nilable(String)) }
        def target_date=(_target_date); end
        sig {
          params(mandate_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::BacsDebit::MandateOptions), setup_future_usage: T.nilable(T.any(String, String)), target_date: T.nilable(String)).void
         }
        def initialize(mandate_options: nil, setup_future_usage: nil, target_date: nil); end
      end
      class Bancontact < ::Stripe::RequestParams
        # Preferred language of the Bancontact authorization page that the customer is redirected to.
        sig { returns(T.nilable(String)) }
        def preferred_language; end
        sig { params(_preferred_language: T.nilable(String)).returns(T.nilable(String)) }
        def preferred_language=(_preferred_language); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(preferred_language: T.nilable(String), setup_future_usage: T.nilable(T.any(String, String))).void
         }
        def initialize(preferred_language: nil, setup_future_usage: nil); end
      end
      class Billie < ::Stripe::RequestParams
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        sig { params(capture_method: T.nilable(String)).void }
        def initialize(capture_method: nil); end
      end
      class Blik < ::Stripe::RequestParams
        # The 6-digit BLIK code that a customer has generated using their banking application. Can only be set on confirmation.
        sig { returns(T.nilable(String)) }
        def code; end
        sig { params(_code: T.nilable(String)).returns(T.nilable(String)) }
        def code=(_code); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig { params(code: T.nilable(String), setup_future_usage: T.nilable(String)).void }
        def initialize(code: nil, setup_future_usage: nil); end
      end
      class Boleto < ::Stripe::RequestParams
        # The number of calendar days before a Boleto voucher expires. For example, if you create a Boleto voucher on Monday and you set expires_after_days to 2, the Boleto invoice will expire on Wednesday at 23:59 America/Sao_Paulo time.
        sig { returns(T.nilable(Integer)) }
        def expires_after_days; end
        sig { params(_expires_after_days: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def expires_after_days=(_expires_after_days); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(expires_after_days: T.nilable(Integer), setup_future_usage: T.nilable(T.any(String, String))).void
         }
        def initialize(expires_after_days: nil, setup_future_usage: nil); end
      end
      class Card < ::Stripe::RequestParams
        class Installments < ::Stripe::RequestParams
          class Plan < ::Stripe::RequestParams
            # For `fixed_count` installment plans, this is required. It represents the number of installment payments your customer will make to their credit card.
            sig { returns(T.nilable(Integer)) }
            def count; end
            sig { params(_count: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def count=(_count); end
            # For `fixed_count` installment plans, this is required. It represents the interval between installment payments your customer will make to their credit card.
            # One of `month`.
            sig { returns(T.nilable(String)) }
            def interval; end
            sig { params(_interval: T.nilable(String)).returns(T.nilable(String)) }
            def interval=(_interval); end
            # Type of installment plan, one of `fixed_count`, `bonus`, or `revolving`.
            sig { returns(String) }
            def type; end
            sig { params(_type: String).returns(String) }
            def type=(_type); end
            sig {
              params(count: T.nilable(Integer), interval: T.nilable(String), type: String).void
             }
            def initialize(count: nil, interval: nil, type: nil); end
          end
          # Setting to true enables installments for this PaymentIntent.
          # This will cause the response to contain a list of available installment plans.
          # Setting to false will prevent any selected plan from applying to a charge.
          sig { returns(T.nilable(T::Boolean)) }
          def enabled; end
          sig { params(_enabled: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
          def enabled=(_enabled); end
          # The selected installment plan to use for this payment attempt.
          # This parameter can only be provided during confirmation.
          sig {
            returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Card::Installments::Plan)))
           }
          def plan; end
          sig {
            params(_plan: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Card::Installments::Plan))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Card::Installments::Plan)))
           }
          def plan=(_plan); end
          sig {
            params(enabled: T.nilable(T::Boolean), plan: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Card::Installments::Plan))).void
           }
          def initialize(enabled: nil, plan: nil); end
        end
        class MandateOptions < ::Stripe::RequestParams
          # Amount to be charged for future payments.
          sig { returns(Integer) }
          def amount; end
          sig { params(_amount: Integer).returns(Integer) }
          def amount=(_amount); end
          # One of `fixed` or `maximum`. If `fixed`, the `amount` param refers to the exact amount to be charged in future payments. If `maximum`, the amount charged can be up to the value passed for the `amount` param.
          sig { returns(String) }
          def amount_type; end
          sig { params(_amount_type: String).returns(String) }
          def amount_type=(_amount_type); end
          # A description of the mandate or subscription that is meant to be displayed to the customer.
          sig { returns(T.nilable(String)) }
          def description; end
          sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
          def description=(_description); end
          # End date of the mandate or subscription. If not provided, the mandate will be active until canceled. If provided, end date should be after start date.
          sig { returns(T.nilable(Integer)) }
          def end_date; end
          sig { params(_end_date: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def end_date=(_end_date); end
          # Specifies payment frequency. One of `day`, `week`, `month`, `year`, or `sporadic`.
          sig { returns(String) }
          def interval; end
          sig { params(_interval: String).returns(String) }
          def interval=(_interval); end
          # The number of intervals between payments. For example, `interval=month` and `interval_count=3` indicates one payment every three months. Maximum of one year interval allowed (1 year, 12 months, or 52 weeks). This parameter is optional when `interval=sporadic`.
          sig { returns(T.nilable(Integer)) }
          def interval_count; end
          sig { params(_interval_count: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def interval_count=(_interval_count); end
          # Unique identifier for the mandate or subscription.
          sig { returns(String) }
          def reference; end
          sig { params(_reference: String).returns(String) }
          def reference=(_reference); end
          # Start date of the mandate or subscription. Start date should not be lesser than yesterday.
          sig { returns(Integer) }
          def start_date; end
          sig { params(_start_date: Integer).returns(Integer) }
          def start_date=(_start_date); end
          # Specifies the type of mandates supported. Possible values are `india`.
          sig { returns(T.nilable(T::Array[String])) }
          def supported_types; end
          sig {
            params(_supported_types: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
           }
          def supported_types=(_supported_types); end
          sig {
            params(amount: Integer, amount_type: String, description: T.nilable(String), end_date: T.nilable(Integer), interval: String, interval_count: T.nilable(Integer), reference: String, start_date: Integer, supported_types: T.nilable(T::Array[String])).void
           }
          def initialize(
            amount: nil,
            amount_type: nil,
            description: nil,
            end_date: nil,
            interval: nil,
            interval_count: nil,
            reference: nil,
            start_date: nil,
            supported_types: nil
          ); end
        end
        class ThreeDSecure < ::Stripe::RequestParams
          class NetworkOptions < ::Stripe::RequestParams
            class CartesBancaires < ::Stripe::RequestParams
              # The cryptogram calculation algorithm used by the card Issuer's ACS
              # to calculate the Authentication cryptogram. Also known as `cavvAlgorithm`.
              # messageExtension: CB-AVALGO
              sig { returns(String) }
              def cb_avalgo; end
              sig { params(_cb_avalgo: String).returns(String) }
              def cb_avalgo=(_cb_avalgo); end
              # The exemption indicator returned from Cartes Bancaires in the ARes.
              # message extension: CB-EXEMPTION; string (4 characters)
              # This is a 3 byte bitmap (low significant byte first and most significant
              # bit first) that has been Base64 encoded
              sig { returns(T.nilable(String)) }
              def cb_exemption; end
              sig { params(_cb_exemption: T.nilable(String)).returns(T.nilable(String)) }
              def cb_exemption=(_cb_exemption); end
              # The risk score returned from Cartes Bancaires in the ARes.
              # message extension: CB-SCORE; numeric value 0-99
              sig { returns(T.nilable(Integer)) }
              def cb_score; end
              sig { params(_cb_score: T.nilable(Integer)).returns(T.nilable(Integer)) }
              def cb_score=(_cb_score); end
              sig {
                params(cb_avalgo: String, cb_exemption: T.nilable(String), cb_score: T.nilable(Integer)).void
               }
              def initialize(cb_avalgo: nil, cb_exemption: nil, cb_score: nil); end
            end
            # Cartes Bancaires-specific 3DS fields.
            sig {
              returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::ThreeDSecure::NetworkOptions::CartesBancaires))
             }
            def cartes_bancaires; end
            sig {
              params(_cartes_bancaires: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::ThreeDSecure::NetworkOptions::CartesBancaires)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::ThreeDSecure::NetworkOptions::CartesBancaires))
             }
            def cartes_bancaires=(_cartes_bancaires); end
            sig {
              params(cartes_bancaires: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::ThreeDSecure::NetworkOptions::CartesBancaires)).void
             }
            def initialize(cartes_bancaires: nil); end
          end
          # The `transStatus` returned from the card Issuer’s ACS in the ARes.
          sig { returns(T.nilable(String)) }
          def ares_trans_status; end
          sig { params(_ares_trans_status: T.nilable(String)).returns(T.nilable(String)) }
          def ares_trans_status=(_ares_trans_status); end
          # The cryptogram, also known as the "authentication value" (AAV, CAVV or
          # AEVV). This value is 20 bytes, base64-encoded into a 28-character string.
          # (Most 3D Secure providers will return the base64-encoded version, which
          # is what you should specify here.)
          sig { returns(String) }
          def cryptogram; end
          sig { params(_cryptogram: String).returns(String) }
          def cryptogram=(_cryptogram); end
          # The Electronic Commerce Indicator (ECI) is returned by your 3D Secure
          # provider and indicates what degree of authentication was performed.
          sig { returns(T.nilable(String)) }
          def electronic_commerce_indicator; end
          sig {
            params(_electronic_commerce_indicator: T.nilable(String)).returns(T.nilable(String))
           }
          def electronic_commerce_indicator=(_electronic_commerce_indicator); end
          # The exemption requested via 3DS and accepted by the issuer at authentication time.
          sig { returns(T.nilable(String)) }
          def exemption_indicator; end
          sig { params(_exemption_indicator: T.nilable(String)).returns(T.nilable(String)) }
          def exemption_indicator=(_exemption_indicator); end
          # Network specific 3DS fields. Network specific arguments require an
          # explicit card brand choice. The parameter `payment_method_options.card.network``
          # must be populated accordingly
          sig {
            returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::ThreeDSecure::NetworkOptions))
           }
          def network_options; end
          sig {
            params(_network_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::ThreeDSecure::NetworkOptions)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::ThreeDSecure::NetworkOptions))
           }
          def network_options=(_network_options); end
          # The challenge indicator (`threeDSRequestorChallengeInd`) which was requested in the
          # AReq sent to the card Issuer's ACS. A string containing 2 digits from 01-99.
          sig { returns(T.nilable(String)) }
          def requestor_challenge_indicator; end
          sig {
            params(_requestor_challenge_indicator: T.nilable(String)).returns(T.nilable(String))
           }
          def requestor_challenge_indicator=(_requestor_challenge_indicator); end
          # For 3D Secure 1, the XID. For 3D Secure 2, the Directory Server
          # Transaction ID (dsTransID).
          sig { returns(String) }
          def transaction_id; end
          sig { params(_transaction_id: String).returns(String) }
          def transaction_id=(_transaction_id); end
          # The version of 3D Secure that was performed.
          sig { returns(String) }
          def version; end
          sig { params(_version: String).returns(String) }
          def version=(_version); end
          sig {
            params(ares_trans_status: T.nilable(String), cryptogram: String, electronic_commerce_indicator: T.nilable(String), exemption_indicator: T.nilable(String), network_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::ThreeDSecure::NetworkOptions), requestor_challenge_indicator: T.nilable(String), transaction_id: String, version: String).void
           }
          def initialize(
            ares_trans_status: nil,
            cryptogram: nil,
            electronic_commerce_indicator: nil,
            exemption_indicator: nil,
            network_options: nil,
            requestor_challenge_indicator: nil,
            transaction_id: nil,
            version: nil
          ); end
        end
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        # A single-use `cvc_update` Token that represents a card CVC value. When provided, the CVC value will be verified during the card payment attempt. This parameter can only be provided during confirmation.
        sig { returns(T.nilable(String)) }
        def cvc_token; end
        sig { params(_cvc_token: T.nilable(String)).returns(T.nilable(String)) }
        def cvc_token=(_cvc_token); end
        # Installment configuration for payments attempted on this PaymentIntent.
        #
        # For more information, see the [installments integration guide](https://docs.stripe.com/payments/installments).
        sig {
          returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::Installments))
         }
        def installments; end
        sig {
          params(_installments: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::Installments)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::Installments))
         }
        def installments=(_installments); end
        # Configuration options for setting up an eMandate for cards issued in India.
        sig {
          returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::MandateOptions))
         }
        def mandate_options; end
        sig {
          params(_mandate_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::MandateOptions)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::MandateOptions))
         }
        def mandate_options=(_mandate_options); end
        # When specified, this parameter indicates that a transaction will be marked
        # as MOTO (Mail Order Telephone Order) and thus out of scope for SCA. This
        # parameter can only be provided during confirmation.
        sig { returns(T.nilable(T::Boolean)) }
        def moto; end
        sig { params(_moto: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def moto=(_moto); end
        # Selected network to process this PaymentIntent on. Depends on the available networks of the card attached to the PaymentIntent. Can be only set confirm-time.
        sig { returns(T.nilable(String)) }
        def network; end
        sig { params(_network: T.nilable(String)).returns(T.nilable(String)) }
        def network=(_network); end
        # Request ability to [capture beyond the standard authorization validity window](https://docs.stripe.com/payments/extended-authorization) for this PaymentIntent.
        sig { returns(T.nilable(String)) }
        def request_extended_authorization; end
        sig {
          params(_request_extended_authorization: T.nilable(String)).returns(T.nilable(String))
         }
        def request_extended_authorization=(_request_extended_authorization); end
        # Request ability to [increment the authorization](https://docs.stripe.com/payments/incremental-authorization) for this PaymentIntent.
        sig { returns(T.nilable(String)) }
        def request_incremental_authorization; end
        sig {
          params(_request_incremental_authorization: T.nilable(String)).returns(T.nilable(String))
         }
        def request_incremental_authorization=(_request_incremental_authorization); end
        # Request ability to make [multiple captures](https://docs.stripe.com/payments/multicapture) for this PaymentIntent.
        sig { returns(T.nilable(String)) }
        def request_multicapture; end
        sig { params(_request_multicapture: T.nilable(String)).returns(T.nilable(String)) }
        def request_multicapture=(_request_multicapture); end
        # Request ability to [overcapture](https://docs.stripe.com/payments/overcapture) for this PaymentIntent.
        sig { returns(T.nilable(String)) }
        def request_overcapture; end
        sig { params(_request_overcapture: T.nilable(String)).returns(T.nilable(String)) }
        def request_overcapture=(_request_overcapture); end
        # We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and [other requirements](https://docs.stripe.com/strong-customer-authentication). However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. If not provided, this value defaults to `automatic`. Read our guide on [manually requesting 3D Secure](https://docs.stripe.com/payments/3d-secure/authentication-flow#manual-three-ds) for more information on how this configuration interacts with Radar and our SCA Engine.
        sig { returns(T.nilable(String)) }
        def request_three_d_secure; end
        sig { params(_request_three_d_secure: T.nilable(String)).returns(T.nilable(String)) }
        def request_three_d_secure=(_request_three_d_secure); end
        # When enabled, using a card that is attached to a customer will require the CVC to be provided again (i.e. using the cvc_token parameter).
        sig { returns(T.nilable(T::Boolean)) }
        def require_cvc_recollection; end
        sig {
          params(_require_cvc_recollection: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean))
         }
        def require_cvc_recollection=(_require_cvc_recollection); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        # Provides information about a card payment that customers see on their statements. Concatenated with the Kana prefix (shortened Kana descriptor) or Kana statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters. On card statements, the *concatenation* of both prefix and suffix (including separators) will appear truncated to 22 characters.
        sig { returns(T.nilable(String)) }
        def statement_descriptor_suffix_kana; end
        sig {
          params(_statement_descriptor_suffix_kana: T.nilable(String)).returns(T.nilable(String))
         }
        def statement_descriptor_suffix_kana=(_statement_descriptor_suffix_kana); end
        # Provides information about a card payment that customers see on their statements. Concatenated with the Kanji prefix (shortened Kanji descriptor) or Kanji statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 17 characters. On card statements, the *concatenation* of both prefix and suffix (including separators) will appear truncated to 17 characters.
        sig { returns(T.nilable(String)) }
        def statement_descriptor_suffix_kanji; end
        sig {
          params(_statement_descriptor_suffix_kanji: T.nilable(String)).returns(T.nilable(String))
         }
        def statement_descriptor_suffix_kanji=(_statement_descriptor_suffix_kanji); end
        # If 3D Secure authentication was performed with a third-party provider,
        # the authentication details to use for this payment.
        sig {
          returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::ThreeDSecure))
         }
        def three_d_secure; end
        sig {
          params(_three_d_secure: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::ThreeDSecure)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::ThreeDSecure))
         }
        def three_d_secure=(_three_d_secure); end
        sig {
          params(capture_method: T.nilable(String), cvc_token: T.nilable(String), installments: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::Installments), mandate_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::MandateOptions), moto: T.nilable(T::Boolean), network: T.nilable(String), request_extended_authorization: T.nilable(String), request_incremental_authorization: T.nilable(String), request_multicapture: T.nilable(String), request_overcapture: T.nilable(String), request_three_d_secure: T.nilable(String), require_cvc_recollection: T.nilable(T::Boolean), setup_future_usage: T.nilable(T.any(String, String)), statement_descriptor_suffix_kana: T.nilable(String), statement_descriptor_suffix_kanji: T.nilable(String), three_d_secure: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Card::ThreeDSecure)).void
         }
        def initialize(
          capture_method: nil,
          cvc_token: nil,
          installments: nil,
          mandate_options: nil,
          moto: nil,
          network: nil,
          request_extended_authorization: nil,
          request_incremental_authorization: nil,
          request_multicapture: nil,
          request_overcapture: nil,
          request_three_d_secure: nil,
          require_cvc_recollection: nil,
          setup_future_usage: nil,
          statement_descriptor_suffix_kana: nil,
          statement_descriptor_suffix_kanji: nil,
          three_d_secure: nil
        ); end
      end
      class CardPresent < ::Stripe::RequestParams
        class Routing < ::Stripe::RequestParams
          # Routing requested priority
          sig { returns(T.nilable(String)) }
          def requested_priority; end
          sig { params(_requested_priority: T.nilable(String)).returns(T.nilable(String)) }
          def requested_priority=(_requested_priority); end
          sig { params(requested_priority: T.nilable(String)).void }
          def initialize(requested_priority: nil); end
        end
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        # Request ability to capture this payment beyond the standard [authorization validity window](https://docs.stripe.com/terminal/features/extended-authorizations#authorization-validity)
        sig { returns(T.nilable(T::Boolean)) }
        def request_extended_authorization; end
        sig {
          params(_request_extended_authorization: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean))
         }
        def request_extended_authorization=(_request_extended_authorization); end
        # Request ability to [increment](https://docs.stripe.com/terminal/features/incremental-authorizations) this PaymentIntent if the combination of MCC and card brand is eligible. Check [incremental_authorization_supported](https://docs.stripe.com/api/charges/object#charge_object-payment_method_details-card_present-incremental_authorization_supported) in the [Confirm](https://docs.stripe.com/api/payment_intents/confirm) response to verify support.
        sig { returns(T.nilable(T::Boolean)) }
        def request_incremental_authorization_support; end
        sig {
          params(_request_incremental_authorization_support: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean))
         }
        def request_incremental_authorization_support=(
          _request_incremental_authorization_support
        ); end
        # Network routing priority on co-branded EMV cards supporting domestic debit and international card schemes.
        sig {
          returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::CardPresent::Routing))
         }
        def routing; end
        sig {
          params(_routing: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::CardPresent::Routing)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::CardPresent::Routing))
         }
        def routing=(_routing); end
        sig {
          params(capture_method: T.nilable(String), request_extended_authorization: T.nilable(T::Boolean), request_incremental_authorization_support: T.nilable(T::Boolean), routing: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::CardPresent::Routing)).void
         }
        def initialize(
          capture_method: nil,
          request_extended_authorization: nil,
          request_incremental_authorization_support: nil,
          routing: nil
        ); end
      end
      class Cashapp < ::Stripe::RequestParams
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(capture_method: T.nilable(String), setup_future_usage: T.nilable(T.any(String, String))).void
         }
        def initialize(capture_method: nil, setup_future_usage: nil); end
      end
      class Crypto < ::Stripe::RequestParams
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig { params(setup_future_usage: T.nilable(String)).void }
        def initialize(setup_future_usage: nil); end
      end
      class CustomerBalance < ::Stripe::RequestParams
        class BankTransfer < ::Stripe::RequestParams
          class EuBankTransfer < ::Stripe::RequestParams
            # The desired country code of the bank account information. Permitted values include: `BE`, `DE`, `ES`, `FR`, `IE`, or `NL`.
            sig { returns(String) }
            def country; end
            sig { params(_country: String).returns(String) }
            def country=(_country); end
            sig { params(country: String).void }
            def initialize(country: nil); end
          end
          # Configuration for the eu_bank_transfer funding type.
          sig {
            returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::CustomerBalance::BankTransfer::EuBankTransfer))
           }
          def eu_bank_transfer; end
          sig {
            params(_eu_bank_transfer: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::CustomerBalance::BankTransfer::EuBankTransfer)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::CustomerBalance::BankTransfer::EuBankTransfer))
           }
          def eu_bank_transfer=(_eu_bank_transfer); end
          # List of address types that should be returned in the financial_addresses response. If not specified, all valid types will be returned.
          #
          # Permitted values include: `sort_code`, `zengin`, `iban`, or `spei`.
          sig { returns(T.nilable(T::Array[String])) }
          def requested_address_types; end
          sig {
            params(_requested_address_types: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
           }
          def requested_address_types=(_requested_address_types); end
          # The list of bank transfer types that this PaymentIntent is allowed to use for funding Permitted values include: `eu_bank_transfer`, `gb_bank_transfer`, `jp_bank_transfer`, `mx_bank_transfer`, or `us_bank_transfer`.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig {
            params(eu_bank_transfer: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::CustomerBalance::BankTransfer::EuBankTransfer), requested_address_types: T.nilable(T::Array[String]), type: String).void
           }
          def initialize(eu_bank_transfer: nil, requested_address_types: nil, type: nil); end
        end
        # Configuration for the bank transfer funding type, if the `funding_type` is set to `bank_transfer`.
        sig {
          returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::CustomerBalance::BankTransfer))
         }
        def bank_transfer; end
        sig {
          params(_bank_transfer: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::CustomerBalance::BankTransfer)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::CustomerBalance::BankTransfer))
         }
        def bank_transfer=(_bank_transfer); end
        # The funding method type to be used when there are not enough funds in the customer balance. Permitted values include: `bank_transfer`.
        sig { returns(T.nilable(String)) }
        def funding_type; end
        sig { params(_funding_type: T.nilable(String)).returns(T.nilable(String)) }
        def funding_type=(_funding_type); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(bank_transfer: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::CustomerBalance::BankTransfer), funding_type: T.nilable(String), setup_future_usage: T.nilable(String)).void
         }
        def initialize(bank_transfer: nil, funding_type: nil, setup_future_usage: nil); end
      end
      class Eps < ::Stripe::RequestParams
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig { params(setup_future_usage: T.nilable(String)).void }
        def initialize(setup_future_usage: nil); end
      end
      class Fpx < ::Stripe::RequestParams
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig { params(setup_future_usage: T.nilable(String)).void }
        def initialize(setup_future_usage: nil); end
      end
      class Giropay < ::Stripe::RequestParams
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig { params(setup_future_usage: T.nilable(String)).void }
        def initialize(setup_future_usage: nil); end
      end
      class Grabpay < ::Stripe::RequestParams
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig { params(setup_future_usage: T.nilable(String)).void }
        def initialize(setup_future_usage: nil); end
      end
      class Ideal < ::Stripe::RequestParams
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        sig { params(setup_future_usage: T.nilable(T.any(String, String))).void }
        def initialize(setup_future_usage: nil); end
      end
      class InteracPresent < ::Stripe::RequestParams; end
      class KakaoPay < ::Stripe::RequestParams
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(capture_method: T.nilable(String), setup_future_usage: T.nilable(T.any(String, String))).void
         }
        def initialize(capture_method: nil, setup_future_usage: nil); end
      end
      class Klarna < ::Stripe::RequestParams
        class OnDemand < ::Stripe::RequestParams
          # Your average amount value. You can use a value across your customer base, or segment based on customer type, country, etc.
          sig { returns(T.nilable(Integer)) }
          def average_amount; end
          sig { params(_average_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def average_amount=(_average_amount); end
          # The maximum value you may charge a customer per purchase. You can use a value across your customer base, or segment based on customer type, country, etc.
          sig { returns(T.nilable(Integer)) }
          def maximum_amount; end
          sig { params(_maximum_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def maximum_amount=(_maximum_amount); end
          # The lowest or minimum value you may charge a customer per purchase. You can use a value across your customer base, or segment based on customer type, country, etc.
          sig { returns(T.nilable(Integer)) }
          def minimum_amount; end
          sig { params(_minimum_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def minimum_amount=(_minimum_amount); end
          # Interval at which the customer is making purchases
          sig { returns(T.nilable(String)) }
          def purchase_interval; end
          sig { params(_purchase_interval: T.nilable(String)).returns(T.nilable(String)) }
          def purchase_interval=(_purchase_interval); end
          # The number of `purchase_interval` between charges
          sig { returns(T.nilable(Integer)) }
          def purchase_interval_count; end
          sig { params(_purchase_interval_count: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def purchase_interval_count=(_purchase_interval_count); end
          sig {
            params(average_amount: T.nilable(Integer), maximum_amount: T.nilable(Integer), minimum_amount: T.nilable(Integer), purchase_interval: T.nilable(String), purchase_interval_count: T.nilable(Integer)).void
           }
          def initialize(
            average_amount: nil,
            maximum_amount: nil,
            minimum_amount: nil,
            purchase_interval: nil,
            purchase_interval_count: nil
          ); end
        end
        class Subscription < ::Stripe::RequestParams
          class NextBilling < ::Stripe::RequestParams
            # The amount of the next charge for the subscription.
            sig { returns(Integer) }
            def amount; end
            sig { params(_amount: Integer).returns(Integer) }
            def amount=(_amount); end
            # The date of the next charge for the subscription in YYYY-MM-DD format.
            sig { returns(String) }
            def date; end
            sig { params(_date: String).returns(String) }
            def date=(_date); end
            sig { params(amount: Integer, date: String).void }
            def initialize(amount: nil, date: nil); end
          end
          # Unit of time between subscription charges.
          sig { returns(String) }
          def interval; end
          sig { params(_interval: String).returns(String) }
          def interval=(_interval); end
          # The number of intervals (specified in the `interval` attribute) between subscription charges. For example, `interval=month` and `interval_count=3` charges every 3 months.
          sig { returns(T.nilable(Integer)) }
          def interval_count; end
          sig { params(_interval_count: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def interval_count=(_interval_count); end
          # Name for subscription.
          sig { returns(T.nilable(String)) }
          def name; end
          sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
          def name=(_name); end
          # Describes the upcoming charge for this subscription.
          sig {
            returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Klarna::Subscription::NextBilling))
           }
          def next_billing; end
          sig {
            params(_next_billing: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Klarna::Subscription::NextBilling)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Klarna::Subscription::NextBilling))
           }
          def next_billing=(_next_billing); end
          # A non-customer-facing reference to correlate subscription charges in the Klarna app. Use a value that persists across subscription charges.
          sig { returns(String) }
          def reference; end
          sig { params(_reference: String).returns(String) }
          def reference=(_reference); end
          sig {
            params(interval: String, interval_count: T.nilable(Integer), name: T.nilable(String), next_billing: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Klarna::Subscription::NextBilling), reference: String).void
           }
          def initialize(
            interval: nil,
            interval_count: nil,
            name: nil,
            next_billing: nil,
            reference: nil
          ); end
        end
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        # On-demand details if setting up or charging an on-demand payment.
        sig {
          returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Klarna::OnDemand))
         }
        def on_demand; end
        sig {
          params(_on_demand: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Klarna::OnDemand)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Klarna::OnDemand))
         }
        def on_demand=(_on_demand); end
        # Preferred language of the Klarna authorization page that the customer is redirected to
        sig { returns(T.nilable(String)) }
        def preferred_locale; end
        sig { params(_preferred_locale: T.nilable(String)).returns(T.nilable(String)) }
        def preferred_locale=(_preferred_locale); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        # Subscription details if setting up or charging a subscription.
        sig {
          returns(T.nilable(T.any(String, T::Array[PaymentIntentUpdateParams::PaymentMethodOptions::Klarna::Subscription])))
         }
        def subscriptions; end
        sig {
          params(_subscriptions: T.nilable(T.any(String, T::Array[PaymentIntentUpdateParams::PaymentMethodOptions::Klarna::Subscription]))).returns(T.nilable(T.any(String, T::Array[PaymentIntentUpdateParams::PaymentMethodOptions::Klarna::Subscription])))
         }
        def subscriptions=(_subscriptions); end
        sig {
          params(capture_method: T.nilable(String), on_demand: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Klarna::OnDemand), preferred_locale: T.nilable(String), setup_future_usage: T.nilable(String), subscriptions: T.nilable(T.any(String, T::Array[PaymentIntentUpdateParams::PaymentMethodOptions::Klarna::Subscription]))).void
         }
        def initialize(
          capture_method: nil,
          on_demand: nil,
          preferred_locale: nil,
          setup_future_usage: nil,
          subscriptions: nil
        ); end
      end
      class Konbini < ::Stripe::RequestParams
        # An optional 10 to 11 digit numeric-only string determining the confirmation code at applicable convenience stores. Must not consist of only zeroes and could be rejected in case of insufficient uniqueness. We recommend to use the customer's phone number.
        sig { returns(T.nilable(String)) }
        def confirmation_number; end
        sig { params(_confirmation_number: T.nilable(String)).returns(T.nilable(String)) }
        def confirmation_number=(_confirmation_number); end
        # The number of calendar days (between 1 and 60) after which Konbini payment instructions will expire. For example, if a PaymentIntent is confirmed with Konbini and `expires_after_days` set to 2 on Monday JST, the instructions will expire on Wednesday 23:59:59 JST. Defaults to 3 days.
        sig { returns(T.nilable(T.any(String, Integer))) }
        def expires_after_days; end
        sig {
          params(_expires_after_days: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
         }
        def expires_after_days=(_expires_after_days); end
        # The timestamp at which the Konbini payment instructions will expire. Only one of `expires_after_days` or `expires_at` may be set.
        sig { returns(T.nilable(T.any(String, Integer))) }
        def expires_at; end
        sig {
          params(_expires_at: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
         }
        def expires_at=(_expires_at); end
        # A product descriptor of up to 22 characters, which will appear to customers at the convenience store.
        sig { returns(T.nilable(String)) }
        def product_description; end
        sig { params(_product_description: T.nilable(String)).returns(T.nilable(String)) }
        def product_description=(_product_description); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(confirmation_number: T.nilable(String), expires_after_days: T.nilable(T.any(String, Integer)), expires_at: T.nilable(T.any(String, Integer)), product_description: T.nilable(String), setup_future_usage: T.nilable(String)).void
         }
        def initialize(
          confirmation_number: nil,
          expires_after_days: nil,
          expires_at: nil,
          product_description: nil,
          setup_future_usage: nil
        ); end
      end
      class KrCard < ::Stripe::RequestParams
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(capture_method: T.nilable(String), setup_future_usage: T.nilable(T.any(String, String))).void
         }
        def initialize(capture_method: nil, setup_future_usage: nil); end
      end
      class Link < ::Stripe::RequestParams
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        # [Deprecated] This is a legacy parameter that no longer has any function.
        sig { returns(T.nilable(String)) }
        def persistent_token; end
        sig { params(_persistent_token: T.nilable(String)).returns(T.nilable(String)) }
        def persistent_token=(_persistent_token); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(capture_method: T.nilable(String), persistent_token: T.nilable(String), setup_future_usage: T.nilable(T.any(String, String))).void
         }
        def initialize(capture_method: nil, persistent_token: nil, setup_future_usage: nil); end
      end
      class MbWay < ::Stripe::RequestParams
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig { params(setup_future_usage: T.nilable(String)).void }
        def initialize(setup_future_usage: nil); end
      end
      class Mobilepay < ::Stripe::RequestParams
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(capture_method: T.nilable(String), setup_future_usage: T.nilable(String)).void
         }
        def initialize(capture_method: nil, setup_future_usage: nil); end
      end
      class Multibanco < ::Stripe::RequestParams
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig { params(setup_future_usage: T.nilable(String)).void }
        def initialize(setup_future_usage: nil); end
      end
      class NaverPay < ::Stripe::RequestParams
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(capture_method: T.nilable(String), setup_future_usage: T.nilable(T.any(String, String))).void
         }
        def initialize(capture_method: nil, setup_future_usage: nil); end
      end
      class NzBankAccount < ::Stripe::RequestParams
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        # Controls when Stripe will attempt to debit the funds from the customer's account. The date must be a string in YYYY-MM-DD format. The date must be in the future and between 3 and 15 calendar days from now.
        sig { returns(T.nilable(String)) }
        def target_date; end
        sig { params(_target_date: T.nilable(String)).returns(T.nilable(String)) }
        def target_date=(_target_date); end
        sig {
          params(setup_future_usage: T.nilable(T.any(String, String)), target_date: T.nilable(String)).void
         }
        def initialize(setup_future_usage: nil, target_date: nil); end
      end
      class Oxxo < ::Stripe::RequestParams
        # The number of calendar days before an OXXO voucher expires. For example, if you create an OXXO voucher on Monday and you set expires_after_days to 2, the OXXO invoice will expire on Wednesday at 23:59 America/Mexico_City time.
        sig { returns(T.nilable(Integer)) }
        def expires_after_days; end
        sig { params(_expires_after_days: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def expires_after_days=(_expires_after_days); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(expires_after_days: T.nilable(Integer), setup_future_usage: T.nilable(String)).void
         }
        def initialize(expires_after_days: nil, setup_future_usage: nil); end
      end
      class P24 < ::Stripe::RequestParams
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        # Confirm that the payer has accepted the P24 terms and conditions.
        sig { returns(T.nilable(T::Boolean)) }
        def tos_shown_and_accepted; end
        sig {
          params(_tos_shown_and_accepted: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean))
         }
        def tos_shown_and_accepted=(_tos_shown_and_accepted); end
        sig {
          params(setup_future_usage: T.nilable(String), tos_shown_and_accepted: T.nilable(T::Boolean)).void
         }
        def initialize(setup_future_usage: nil, tos_shown_and_accepted: nil); end
      end
      class PayByBank < ::Stripe::RequestParams; end
      class Payco < ::Stripe::RequestParams
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        sig { params(capture_method: T.nilable(String)).void }
        def initialize(capture_method: nil); end
      end
      class Paynow < ::Stripe::RequestParams
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig { params(setup_future_usage: T.nilable(String)).void }
        def initialize(setup_future_usage: nil); end
      end
      class Paypal < ::Stripe::RequestParams
        # Controls when the funds will be captured from the customer's account.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        # [Preferred locale](https://docs.stripe.com/payments/paypal/supported-locales) of the PayPal checkout page that the customer is redirected to.
        sig { returns(T.nilable(String)) }
        def preferred_locale; end
        sig { params(_preferred_locale: T.nilable(String)).returns(T.nilable(String)) }
        def preferred_locale=(_preferred_locale); end
        # A reference of the PayPal transaction visible to customer which is mapped to PayPal's invoice ID. This must be a globally unique ID if you have configured in your PayPal settings to block multiple payments per invoice ID.
        sig { returns(T.nilable(String)) }
        def reference; end
        sig { params(_reference: T.nilable(String)).returns(T.nilable(String)) }
        def reference=(_reference); end
        # The risk correlation ID for an on-session payment using a saved PayPal payment method.
        sig { returns(T.nilable(String)) }
        def risk_correlation_id; end
        sig { params(_risk_correlation_id: T.nilable(String)).returns(T.nilable(String)) }
        def risk_correlation_id=(_risk_correlation_id); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(capture_method: T.nilable(String), preferred_locale: T.nilable(String), reference: T.nilable(String), risk_correlation_id: T.nilable(String), setup_future_usage: T.nilable(T.any(String, String))).void
         }
        def initialize(
          capture_method: nil,
          preferred_locale: nil,
          reference: nil,
          risk_correlation_id: nil,
          setup_future_usage: nil
        ); end
      end
      class Payto < ::Stripe::RequestParams
        class MandateOptions < ::Stripe::RequestParams
          # Amount that will be collected. It is required when `amount_type` is `fixed`.
          sig { returns(T.nilable(T.any(String, Integer))) }
          def amount; end
          sig {
            params(_amount: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
           }
          def amount=(_amount); end
          # The type of amount that will be collected. The amount charged must be exact or up to the value of `amount` param for `fixed` or `maximum` type respectively. Defaults to `maximum`.
          sig { returns(T.nilable(T.any(String, String))) }
          def amount_type; end
          sig {
            params(_amount_type: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
           }
          def amount_type=(_amount_type); end
          # Date, in YYYY-MM-DD format, after which payments will not be collected. Defaults to no end date.
          sig { returns(T.nilable(String)) }
          def end_date; end
          sig { params(_end_date: T.nilable(String)).returns(T.nilable(String)) }
          def end_date=(_end_date); end
          # The periodicity at which payments will be collected. Defaults to `adhoc`.
          sig { returns(T.nilable(T.any(String, String))) }
          def payment_schedule; end
          sig {
            params(_payment_schedule: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
           }
          def payment_schedule=(_payment_schedule); end
          # The number of payments that will be made during a payment period. Defaults to 1 except for when `payment_schedule` is `adhoc`. In that case, it defaults to no limit.
          sig { returns(T.nilable(T.any(String, Integer))) }
          def payments_per_period; end
          sig {
            params(_payments_per_period: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
           }
          def payments_per_period=(_payments_per_period); end
          # The purpose for which payments are made. Has a default value based on your merchant category code.
          sig { returns(T.nilable(T.any(String, String))) }
          def purpose; end
          sig {
            params(_purpose: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
           }
          def purpose=(_purpose); end
          sig {
            params(amount: T.nilable(T.any(String, Integer)), amount_type: T.nilable(T.any(String, String)), end_date: T.nilable(String), payment_schedule: T.nilable(T.any(String, String)), payments_per_period: T.nilable(T.any(String, Integer)), purpose: T.nilable(T.any(String, String))).void
           }
          def initialize(
            amount: nil,
            amount_type: nil,
            end_date: nil,
            payment_schedule: nil,
            payments_per_period: nil,
            purpose: nil
          ); end
        end
        # Additional fields for Mandate creation. Only `purpose` field is configurable for PayTo PaymentIntent with `setup_future_usage=none`. Other fields are only applicable to PayTo PaymentIntent with `setup_future_usage=off_session`
        sig {
          returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Payto::MandateOptions))
         }
        def mandate_options; end
        sig {
          params(_mandate_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Payto::MandateOptions)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Payto::MandateOptions))
         }
        def mandate_options=(_mandate_options); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(mandate_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::Payto::MandateOptions), setup_future_usage: T.nilable(T.any(String, String))).void
         }
        def initialize(mandate_options: nil, setup_future_usage: nil); end
      end
      class Pix < ::Stripe::RequestParams
        # Determines if the amount includes the IOF tax. Defaults to `never`.
        sig { returns(T.nilable(String)) }
        def amount_includes_iof; end
        sig { params(_amount_includes_iof: T.nilable(String)).returns(T.nilable(String)) }
        def amount_includes_iof=(_amount_includes_iof); end
        # The number of seconds (between 10 and 1209600) after which Pix payment will expire. Defaults to 86400 seconds.
        sig { returns(T.nilable(Integer)) }
        def expires_after_seconds; end
        sig { params(_expires_after_seconds: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def expires_after_seconds=(_expires_after_seconds); end
        # The timestamp at which the Pix expires (between 10 and 1209600 seconds in the future). Defaults to 1 day in the future.
        sig { returns(T.nilable(Integer)) }
        def expires_at; end
        sig { params(_expires_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def expires_at=(_expires_at); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(amount_includes_iof: T.nilable(String), expires_after_seconds: T.nilable(Integer), expires_at: T.nilable(Integer), setup_future_usage: T.nilable(String)).void
         }
        def initialize(
          amount_includes_iof: nil,
          expires_after_seconds: nil,
          expires_at: nil,
          setup_future_usage: nil
        ); end
      end
      class Promptpay < ::Stripe::RequestParams
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig { params(setup_future_usage: T.nilable(String)).void }
        def initialize(setup_future_usage: nil); end
      end
      class RevolutPay < ::Stripe::RequestParams
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(capture_method: T.nilable(String), setup_future_usage: T.nilable(T.any(String, String))).void
         }
        def initialize(capture_method: nil, setup_future_usage: nil); end
      end
      class SamsungPay < ::Stripe::RequestParams
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        sig { params(capture_method: T.nilable(String)).void }
        def initialize(capture_method: nil); end
      end
      class Satispay < ::Stripe::RequestParams
        # Controls when the funds are captured from the customer's account.
        #
        # If provided, this parameter overrides the behavior of the top-level [capture_method](/api/payment_intents/update#update_payment_intent-capture_method) for this payment method type when finalizing the payment with this payment method type.
        #
        # If `capture_method` is already set on the PaymentIntent, providing an empty value for this parameter unsets the stored value for this payment method type.
        sig { returns(T.nilable(String)) }
        def capture_method; end
        sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
        def capture_method=(_capture_method); end
        sig { params(capture_method: T.nilable(String)).void }
        def initialize(capture_method: nil); end
      end
      class SepaDebit < ::Stripe::RequestParams
        class MandateOptions < ::Stripe::RequestParams
          # Prefix used to generate the Mandate reference. Must be at most 12 characters long. Must consist of only uppercase letters, numbers, spaces, or the following special characters: '/', '_', '-', '&', '.'. Cannot begin with 'STRIPE'.
          sig { returns(T.nilable(String)) }
          def reference_prefix; end
          sig { params(_reference_prefix: T.nilable(String)).returns(T.nilable(String)) }
          def reference_prefix=(_reference_prefix); end
          sig { params(reference_prefix: T.nilable(String)).void }
          def initialize(reference_prefix: nil); end
        end
        # Additional fields for Mandate creation
        sig {
          returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::SepaDebit::MandateOptions))
         }
        def mandate_options; end
        sig {
          params(_mandate_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::SepaDebit::MandateOptions)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::SepaDebit::MandateOptions))
         }
        def mandate_options=(_mandate_options); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        # Controls when Stripe will attempt to debit the funds from the customer's account. The date must be a string in YYYY-MM-DD format. The date must be in the future and between 3 and 15 calendar days from now.
        sig { returns(T.nilable(String)) }
        def target_date; end
        sig { params(_target_date: T.nilable(String)).returns(T.nilable(String)) }
        def target_date=(_target_date); end
        sig {
          params(mandate_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::SepaDebit::MandateOptions), setup_future_usage: T.nilable(T.any(String, String)), target_date: T.nilable(String)).void
         }
        def initialize(mandate_options: nil, setup_future_usage: nil, target_date: nil); end
      end
      class Sofort < ::Stripe::RequestParams
        # Language shown to the payer on redirect.
        sig { returns(T.nilable(T.any(String, String))) }
        def preferred_language; end
        sig {
          params(_preferred_language: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def preferred_language=(_preferred_language); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(preferred_language: T.nilable(T.any(String, String)), setup_future_usage: T.nilable(T.any(String, String))).void
         }
        def initialize(preferred_language: nil, setup_future_usage: nil); end
      end
      class Swish < ::Stripe::RequestParams
        # A reference for this payment to be displayed in the Swish app.
        sig { returns(T.nilable(String)) }
        def reference; end
        sig { params(_reference: T.nilable(String)).returns(T.nilable(String)) }
        def reference=(_reference); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig { params(reference: T.nilable(String), setup_future_usage: T.nilable(String)).void }
        def initialize(reference: nil, setup_future_usage: nil); end
      end
      class Twint < ::Stripe::RequestParams
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig { params(setup_future_usage: T.nilable(String)).void }
        def initialize(setup_future_usage: nil); end
      end
      class UsBankAccount < ::Stripe::RequestParams
        class FinancialConnections < ::Stripe::RequestParams
          class Filters < ::Stripe::RequestParams
            # The account subcategories to use to filter for selectable accounts. Valid subcategories are `checking` and `savings`.
            sig { returns(T.nilable(T::Array[String])) }
            def account_subcategories; end
            sig {
              params(_account_subcategories: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
             }
            def account_subcategories=(_account_subcategories); end
            sig { params(account_subcategories: T.nilable(T::Array[String])).void }
            def initialize(account_subcategories: nil); end
          end
          # Provide filters for the linked accounts that the customer can select for the payment method.
          sig {
            returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount::FinancialConnections::Filters))
           }
          def filters; end
          sig {
            params(_filters: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount::FinancialConnections::Filters)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount::FinancialConnections::Filters))
           }
          def filters=(_filters); end
          # The list of permissions to request. If this parameter is passed, the `payment_method` permission must be included. Valid permissions include: `balances`, `ownership`, `payment_method`, and `transactions`.
          sig { returns(T.nilable(T::Array[String])) }
          def permissions; end
          sig {
            params(_permissions: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
           }
          def permissions=(_permissions); end
          # List of data features that you would like to retrieve upon account creation.
          sig { returns(T.nilable(T::Array[String])) }
          def prefetch; end
          sig {
            params(_prefetch: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
           }
          def prefetch=(_prefetch); end
          # For webview integrations only. Upon completing OAuth login in the native browser, the user will be redirected to this URL to return to your app.
          sig { returns(T.nilable(String)) }
          def return_url; end
          sig { params(_return_url: T.nilable(String)).returns(T.nilable(String)) }
          def return_url=(_return_url); end
          sig {
            params(filters: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount::FinancialConnections::Filters), permissions: T.nilable(T::Array[String]), prefetch: T.nilable(T::Array[String]), return_url: T.nilable(String)).void
           }
          def initialize(filters: nil, permissions: nil, prefetch: nil, return_url: nil); end
        end
        class MandateOptions < ::Stripe::RequestParams
          # The method used to collect offline mandate customer acceptance.
          sig { returns(T.nilable(String)) }
          def collection_method; end
          sig { params(_collection_method: T.nilable(String)).returns(T.nilable(String)) }
          def collection_method=(_collection_method); end
          sig { params(collection_method: T.nilable(String)).void }
          def initialize(collection_method: nil); end
        end
        class Networks < ::Stripe::RequestParams
          # Triggers validations to run across the selected networks
          sig { returns(T.nilable(T::Array[String])) }
          def requested; end
          sig {
            params(_requested: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
           }
          def requested=(_requested); end
          sig { params(requested: T.nilable(T::Array[String])).void }
          def initialize(requested: nil); end
        end
        # Additional fields for Financial Connections Session creation
        sig {
          returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount::FinancialConnections))
         }
        def financial_connections; end
        sig {
          params(_financial_connections: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount::FinancialConnections)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount::FinancialConnections))
         }
        def financial_connections=(_financial_connections); end
        # Additional fields for Mandate creation
        sig {
          returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount::MandateOptions))
         }
        def mandate_options; end
        sig {
          params(_mandate_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount::MandateOptions)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount::MandateOptions))
         }
        def mandate_options=(_mandate_options); end
        # Additional fields for network related functions
        sig {
          returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount::Networks))
         }
        def networks; end
        sig {
          params(_networks: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount::Networks)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount::Networks))
         }
        def networks=(_networks); end
        # Preferred transaction settlement speed
        sig { returns(T.nilable(T.any(String, String))) }
        def preferred_settlement_speed; end
        sig {
          params(_preferred_settlement_speed: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def preferred_settlement_speed=(_preferred_settlement_speed); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(T.any(String, String))) }
        def setup_future_usage; end
        sig {
          params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def setup_future_usage=(_setup_future_usage); end
        # Controls when Stripe will attempt to debit the funds from the customer's account. The date must be a string in YYYY-MM-DD format. The date must be in the future and between 3 and 15 calendar days from now.
        sig { returns(T.nilable(String)) }
        def target_date; end
        sig { params(_target_date: T.nilable(String)).returns(T.nilable(String)) }
        def target_date=(_target_date); end
        # Bank account verification method.
        sig { returns(T.nilable(String)) }
        def verification_method; end
        sig { params(_verification_method: T.nilable(String)).returns(T.nilable(String)) }
        def verification_method=(_verification_method); end
        sig {
          params(financial_connections: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount::FinancialConnections), mandate_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount::MandateOptions), networks: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount::Networks), preferred_settlement_speed: T.nilable(T.any(String, String)), setup_future_usage: T.nilable(T.any(String, String)), target_date: T.nilable(String), verification_method: T.nilable(String)).void
         }
        def initialize(
          financial_connections: nil,
          mandate_options: nil,
          networks: nil,
          preferred_settlement_speed: nil,
          setup_future_usage: nil,
          target_date: nil,
          verification_method: nil
        ); end
      end
      class WechatPay < ::Stripe::RequestParams
        # The app ID registered with WeChat Pay. Only required when client is ios or android.
        sig { returns(T.nilable(String)) }
        def app_id; end
        sig { params(_app_id: T.nilable(String)).returns(T.nilable(String)) }
        def app_id=(_app_id); end
        # The client type that the end customer will pay from
        sig { returns(T.nilable(String)) }
        def client; end
        sig { params(_client: T.nilable(String)).returns(T.nilable(String)) }
        def client=(_client); end
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig {
          params(app_id: T.nilable(String), client: T.nilable(String), setup_future_usage: T.nilable(String)).void
         }
        def initialize(app_id: nil, client: nil, setup_future_usage: nil); end
      end
      class Zip < ::Stripe::RequestParams
        # Indicates that you intend to make future payments with this PaymentIntent's payment method.
        #
        # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
        #
        # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
        #
        # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
        #
        # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
        sig { returns(T.nilable(String)) }
        def setup_future_usage; end
        sig { params(_setup_future_usage: T.nilable(String)).returns(T.nilable(String)) }
        def setup_future_usage=(_setup_future_usage); end
        sig { params(setup_future_usage: T.nilable(String)).void }
        def initialize(setup_future_usage: nil); end
      end
      # If this is a `acss_debit` PaymentMethod, this sub-hash contains details about the ACSS Debit payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::AcssDebit)))
       }
      def acss_debit; end
      sig {
        params(_acss_debit: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::AcssDebit))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::AcssDebit)))
       }
      def acss_debit=(_acss_debit); end
      # If this is an `affirm` PaymentMethod, this sub-hash contains details about the Affirm payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Affirm)))
       }
      def affirm; end
      sig {
        params(_affirm: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Affirm))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Affirm)))
       }
      def affirm=(_affirm); end
      # If this is a `afterpay_clearpay` PaymentMethod, this sub-hash contains details about the Afterpay Clearpay payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::AfterpayClearpay)))
       }
      def afterpay_clearpay; end
      sig {
        params(_afterpay_clearpay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::AfterpayClearpay))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::AfterpayClearpay)))
       }
      def afterpay_clearpay=(_afterpay_clearpay); end
      # If this is a `alipay` PaymentMethod, this sub-hash contains details about the Alipay payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Alipay)))
       }
      def alipay; end
      sig {
        params(_alipay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Alipay))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Alipay)))
       }
      def alipay=(_alipay); end
      # If this is a `alma` PaymentMethod, this sub-hash contains details about the Alma payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Alma)))
       }
      def alma; end
      sig {
        params(_alma: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Alma))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Alma)))
       }
      def alma=(_alma); end
      # If this is a `amazon_pay` PaymentMethod, this sub-hash contains details about the Amazon Pay payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::AmazonPay)))
       }
      def amazon_pay; end
      sig {
        params(_amazon_pay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::AmazonPay))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::AmazonPay)))
       }
      def amazon_pay=(_amazon_pay); end
      # If this is a `au_becs_debit` PaymentMethod, this sub-hash contains details about the AU BECS Direct Debit payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::AuBecsDebit)))
       }
      def au_becs_debit; end
      sig {
        params(_au_becs_debit: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::AuBecsDebit))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::AuBecsDebit)))
       }
      def au_becs_debit=(_au_becs_debit); end
      # If this is a `bacs_debit` PaymentMethod, this sub-hash contains details about the BACS Debit payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::BacsDebit)))
       }
      def bacs_debit; end
      sig {
        params(_bacs_debit: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::BacsDebit))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::BacsDebit)))
       }
      def bacs_debit=(_bacs_debit); end
      # If this is a `bancontact` PaymentMethod, this sub-hash contains details about the Bancontact payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Bancontact)))
       }
      def bancontact; end
      sig {
        params(_bancontact: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Bancontact))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Bancontact)))
       }
      def bancontact=(_bancontact); end
      # If this is a `billie` PaymentMethod, this sub-hash contains details about the Billie payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Billie)))
       }
      def billie; end
      sig {
        params(_billie: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Billie))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Billie)))
       }
      def billie=(_billie); end
      # If this is a `blik` PaymentMethod, this sub-hash contains details about the BLIK payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Blik)))
       }
      def blik; end
      sig {
        params(_blik: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Blik))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Blik)))
       }
      def blik=(_blik); end
      # If this is a `boleto` PaymentMethod, this sub-hash contains details about the Boleto payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Boleto)))
       }
      def boleto; end
      sig {
        params(_boleto: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Boleto))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Boleto)))
       }
      def boleto=(_boleto); end
      # Configuration for any card payments attempted on this PaymentIntent.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Card)))
       }
      def card; end
      sig {
        params(_card: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Card))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Card)))
       }
      def card=(_card); end
      # If this is a `card_present` PaymentMethod, this sub-hash contains details about the Card Present payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::CardPresent)))
       }
      def card_present; end
      sig {
        params(_card_present: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::CardPresent))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::CardPresent)))
       }
      def card_present=(_card_present); end
      # If this is a `cashapp` PaymentMethod, this sub-hash contains details about the Cash App Pay payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Cashapp)))
       }
      def cashapp; end
      sig {
        params(_cashapp: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Cashapp))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Cashapp)))
       }
      def cashapp=(_cashapp); end
      # If this is a `crypto` PaymentMethod, this sub-hash contains details about the Crypto payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Crypto)))
       }
      def crypto; end
      sig {
        params(_crypto: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Crypto))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Crypto)))
       }
      def crypto=(_crypto); end
      # If this is a `customer balance` PaymentMethod, this sub-hash contains details about the customer balance payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::CustomerBalance)))
       }
      def customer_balance; end
      sig {
        params(_customer_balance: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::CustomerBalance))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::CustomerBalance)))
       }
      def customer_balance=(_customer_balance); end
      # If this is a `eps` PaymentMethod, this sub-hash contains details about the EPS payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Eps)))
       }
      def eps; end
      sig {
        params(_eps: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Eps))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Eps)))
       }
      def eps=(_eps); end
      # If this is a `fpx` PaymentMethod, this sub-hash contains details about the FPX payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Fpx)))
       }
      def fpx; end
      sig {
        params(_fpx: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Fpx))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Fpx)))
       }
      def fpx=(_fpx); end
      # If this is a `giropay` PaymentMethod, this sub-hash contains details about the Giropay payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Giropay)))
       }
      def giropay; end
      sig {
        params(_giropay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Giropay))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Giropay)))
       }
      def giropay=(_giropay); end
      # If this is a `grabpay` PaymentMethod, this sub-hash contains details about the Grabpay payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Grabpay)))
       }
      def grabpay; end
      sig {
        params(_grabpay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Grabpay))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Grabpay)))
       }
      def grabpay=(_grabpay); end
      # If this is a `ideal` PaymentMethod, this sub-hash contains details about the Ideal payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Ideal)))
       }
      def ideal; end
      sig {
        params(_ideal: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Ideal))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Ideal)))
       }
      def ideal=(_ideal); end
      # If this is a `interac_present` PaymentMethod, this sub-hash contains details about the Card Present payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::InteracPresent)))
       }
      def interac_present; end
      sig {
        params(_interac_present: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::InteracPresent))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::InteracPresent)))
       }
      def interac_present=(_interac_present); end
      # If this is a `kakao_pay` PaymentMethod, this sub-hash contains details about the Kakao Pay payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::KakaoPay)))
       }
      def kakao_pay; end
      sig {
        params(_kakao_pay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::KakaoPay))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::KakaoPay)))
       }
      def kakao_pay=(_kakao_pay); end
      # If this is a `klarna` PaymentMethod, this sub-hash contains details about the Klarna payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Klarna)))
       }
      def klarna; end
      sig {
        params(_klarna: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Klarna))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Klarna)))
       }
      def klarna=(_klarna); end
      # If this is a `konbini` PaymentMethod, this sub-hash contains details about the Konbini payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Konbini)))
       }
      def konbini; end
      sig {
        params(_konbini: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Konbini))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Konbini)))
       }
      def konbini=(_konbini); end
      # If this is a `kr_card` PaymentMethod, this sub-hash contains details about the KR Card payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::KrCard)))
       }
      def kr_card; end
      sig {
        params(_kr_card: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::KrCard))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::KrCard)))
       }
      def kr_card=(_kr_card); end
      # If this is a `link` PaymentMethod, this sub-hash contains details about the Link payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Link)))
       }
      def link; end
      sig {
        params(_link: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Link))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Link)))
       }
      def link=(_link); end
      # If this is a `mb_way` PaymentMethod, this sub-hash contains details about the MB WAY payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::MbWay)))
       }
      def mb_way; end
      sig {
        params(_mb_way: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::MbWay))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::MbWay)))
       }
      def mb_way=(_mb_way); end
      # If this is a `MobilePay` PaymentMethod, this sub-hash contains details about the MobilePay payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Mobilepay)))
       }
      def mobilepay; end
      sig {
        params(_mobilepay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Mobilepay))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Mobilepay)))
       }
      def mobilepay=(_mobilepay); end
      # If this is a `multibanco` PaymentMethod, this sub-hash contains details about the Multibanco payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Multibanco)))
       }
      def multibanco; end
      sig {
        params(_multibanco: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Multibanco))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Multibanco)))
       }
      def multibanco=(_multibanco); end
      # If this is a `naver_pay` PaymentMethod, this sub-hash contains details about the Naver Pay payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::NaverPay)))
       }
      def naver_pay; end
      sig {
        params(_naver_pay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::NaverPay))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::NaverPay)))
       }
      def naver_pay=(_naver_pay); end
      # If this is a `nz_bank_account` PaymentMethod, this sub-hash contains details about the NZ BECS Direct Debit payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::NzBankAccount)))
       }
      def nz_bank_account; end
      sig {
        params(_nz_bank_account: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::NzBankAccount))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::NzBankAccount)))
       }
      def nz_bank_account=(_nz_bank_account); end
      # If this is a `oxxo` PaymentMethod, this sub-hash contains details about the OXXO payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Oxxo)))
       }
      def oxxo; end
      sig {
        params(_oxxo: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Oxxo))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Oxxo)))
       }
      def oxxo=(_oxxo); end
      # If this is a `p24` PaymentMethod, this sub-hash contains details about the Przelewy24 payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::P24)))
       }
      def p24; end
      sig {
        params(_p24: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::P24))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::P24)))
       }
      def p24=(_p24); end
      # If this is a `pay_by_bank` PaymentMethod, this sub-hash contains details about the PayByBank payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::PayByBank)))
       }
      def pay_by_bank; end
      sig {
        params(_pay_by_bank: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::PayByBank))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::PayByBank)))
       }
      def pay_by_bank=(_pay_by_bank); end
      # If this is a `payco` PaymentMethod, this sub-hash contains details about the PAYCO payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Payco)))
       }
      def payco; end
      sig {
        params(_payco: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Payco))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Payco)))
       }
      def payco=(_payco); end
      # If this is a `paynow` PaymentMethod, this sub-hash contains details about the PayNow payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Paynow)))
       }
      def paynow; end
      sig {
        params(_paynow: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Paynow))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Paynow)))
       }
      def paynow=(_paynow); end
      # If this is a `paypal` PaymentMethod, this sub-hash contains details about the PayPal payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Paypal)))
       }
      def paypal; end
      sig {
        params(_paypal: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Paypal))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Paypal)))
       }
      def paypal=(_paypal); end
      # If this is a `payto` PaymentMethod, this sub-hash contains details about the PayTo payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Payto)))
       }
      def payto; end
      sig {
        params(_payto: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Payto))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Payto)))
       }
      def payto=(_payto); end
      # If this is a `pix` PaymentMethod, this sub-hash contains details about the Pix payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Pix)))
       }
      def pix; end
      sig {
        params(_pix: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Pix))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Pix)))
       }
      def pix=(_pix); end
      # If this is a `promptpay` PaymentMethod, this sub-hash contains details about the PromptPay payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Promptpay)))
       }
      def promptpay; end
      sig {
        params(_promptpay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Promptpay))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Promptpay)))
       }
      def promptpay=(_promptpay); end
      # If this is a `revolut_pay` PaymentMethod, this sub-hash contains details about the Revolut Pay payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::RevolutPay)))
       }
      def revolut_pay; end
      sig {
        params(_revolut_pay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::RevolutPay))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::RevolutPay)))
       }
      def revolut_pay=(_revolut_pay); end
      # If this is a `samsung_pay` PaymentMethod, this sub-hash contains details about the Samsung Pay payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::SamsungPay)))
       }
      def samsung_pay; end
      sig {
        params(_samsung_pay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::SamsungPay))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::SamsungPay)))
       }
      def samsung_pay=(_samsung_pay); end
      # If this is a `satispay` PaymentMethod, this sub-hash contains details about the Satispay payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Satispay)))
       }
      def satispay; end
      sig {
        params(_satispay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Satispay))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Satispay)))
       }
      def satispay=(_satispay); end
      # If this is a `sepa_debit` PaymentIntent, this sub-hash contains details about the SEPA Debit payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::SepaDebit)))
       }
      def sepa_debit; end
      sig {
        params(_sepa_debit: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::SepaDebit))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::SepaDebit)))
       }
      def sepa_debit=(_sepa_debit); end
      # If this is a `sofort` PaymentMethod, this sub-hash contains details about the SOFORT payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Sofort)))
       }
      def sofort; end
      sig {
        params(_sofort: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Sofort))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Sofort)))
       }
      def sofort=(_sofort); end
      # If this is a `Swish` PaymentMethod, this sub-hash contains details about the Swish payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Swish)))
       }
      def swish; end
      sig {
        params(_swish: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Swish))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Swish)))
       }
      def swish=(_swish); end
      # If this is a `twint` PaymentMethod, this sub-hash contains details about the TWINT payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Twint)))
       }
      def twint; end
      sig {
        params(_twint: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Twint))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Twint)))
       }
      def twint=(_twint); end
      # If this is a `us_bank_account` PaymentMethod, this sub-hash contains details about the US bank account payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount)))
       }
      def us_bank_account; end
      sig {
        params(_us_bank_account: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount)))
       }
      def us_bank_account=(_us_bank_account); end
      # If this is a `wechat_pay` PaymentMethod, this sub-hash contains details about the WeChat Pay payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::WechatPay)))
       }
      def wechat_pay; end
      sig {
        params(_wechat_pay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::WechatPay))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::WechatPay)))
       }
      def wechat_pay=(_wechat_pay); end
      # If this is a `zip` PaymentMethod, this sub-hash contains details about the Zip payment method options.
      sig {
        returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Zip)))
       }
      def zip; end
      sig {
        params(_zip: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Zip))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Zip)))
       }
      def zip=(_zip); end
      sig {
        params(acss_debit: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::AcssDebit)), affirm: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Affirm)), afterpay_clearpay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::AfterpayClearpay)), alipay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Alipay)), alma: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Alma)), amazon_pay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::AmazonPay)), au_becs_debit: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::AuBecsDebit)), bacs_debit: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::BacsDebit)), bancontact: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Bancontact)), billie: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Billie)), blik: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Blik)), boleto: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Boleto)), card: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Card)), card_present: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::CardPresent)), cashapp: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Cashapp)), crypto: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Crypto)), customer_balance: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::CustomerBalance)), eps: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Eps)), fpx: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Fpx)), giropay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Giropay)), grabpay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Grabpay)), ideal: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Ideal)), interac_present: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::InteracPresent)), kakao_pay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::KakaoPay)), klarna: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Klarna)), konbini: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Konbini)), kr_card: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::KrCard)), link: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Link)), mb_way: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::MbWay)), mobilepay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Mobilepay)), multibanco: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Multibanco)), naver_pay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::NaverPay)), nz_bank_account: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::NzBankAccount)), oxxo: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Oxxo)), p24: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::P24)), pay_by_bank: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::PayByBank)), payco: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Payco)), paynow: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Paynow)), paypal: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Paypal)), payto: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Payto)), pix: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Pix)), promptpay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Promptpay)), revolut_pay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::RevolutPay)), samsung_pay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::SamsungPay)), satispay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Satispay)), sepa_debit: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::SepaDebit)), sofort: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Sofort)), swish: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Swish)), twint: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Twint)), us_bank_account: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::UsBankAccount)), wechat_pay: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::WechatPay)), zip: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentMethodOptions::Zip))).void
       }
      def initialize(
        acss_debit: nil,
        affirm: nil,
        afterpay_clearpay: nil,
        alipay: nil,
        alma: nil,
        amazon_pay: nil,
        au_becs_debit: nil,
        bacs_debit: nil,
        bancontact: nil,
        billie: nil,
        blik: nil,
        boleto: nil,
        card: nil,
        card_present: nil,
        cashapp: nil,
        crypto: nil,
        customer_balance: nil,
        eps: nil,
        fpx: nil,
        giropay: nil,
        grabpay: nil,
        ideal: nil,
        interac_present: nil,
        kakao_pay: nil,
        klarna: nil,
        konbini: nil,
        kr_card: nil,
        link: nil,
        mb_way: nil,
        mobilepay: nil,
        multibanco: nil,
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
    class Shipping < ::Stripe::RequestParams
      class Address < ::Stripe::RequestParams
        # City, district, suburb, town, or village.
        sig { returns(T.nilable(String)) }
        def city; end
        sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
        def city=(_city); end
        # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        sig { returns(T.nilable(String)) }
        def country; end
        sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
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
        # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
        sig { returns(T.nilable(String)) }
        def state; end
        sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
        def state=(_state); end
        sig {
          params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String)).void
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
      # Shipping address.
      sig { returns(PaymentIntentUpdateParams::Shipping::Address) }
      def address; end
      sig {
        params(_address: PaymentIntentUpdateParams::Shipping::Address).returns(PaymentIntentUpdateParams::Shipping::Address)
       }
      def address=(_address); end
      # The delivery service that shipped a physical product, such as Fedex, UPS, USPS, etc.
      sig { returns(T.nilable(String)) }
      def carrier; end
      sig { params(_carrier: T.nilable(String)).returns(T.nilable(String)) }
      def carrier=(_carrier); end
      # Recipient name.
      sig { returns(String) }
      def name; end
      sig { params(_name: String).returns(String) }
      def name=(_name); end
      # Recipient phone (including extension).
      sig { returns(T.nilable(String)) }
      def phone; end
      sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
      def phone=(_phone); end
      # The tracking number for a physical product, obtained from the delivery service. If multiple tracking numbers were generated for this purchase, please separate them with commas.
      sig { returns(T.nilable(String)) }
      def tracking_number; end
      sig { params(_tracking_number: T.nilable(String)).returns(T.nilable(String)) }
      def tracking_number=(_tracking_number); end
      sig {
        params(address: PaymentIntentUpdateParams::Shipping::Address, carrier: T.nilable(String), name: String, phone: T.nilable(String), tracking_number: T.nilable(String)).void
       }
      def initialize(address: nil, carrier: nil, name: nil, phone: nil, tracking_number: nil); end
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
    # Amount intended to be collected by this PaymentIntent. A positive integer representing how much to charge in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal) (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or [equivalent in charge currency](https://docs.stripe.com/currencies#minimum-and-maximum-charge-amounts). The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99).
    sig { returns(T.nilable(Integer)) }
    def amount; end
    sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def amount=(_amount); end
    # Provides industry-specific information about the amount.
    sig { returns(T.nilable(T.any(String, PaymentIntentUpdateParams::AmountDetails))) }
    def amount_details; end
    sig {
      params(_amount_details: T.nilable(T.any(String, PaymentIntentUpdateParams::AmountDetails))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::AmountDetails)))
     }
    def amount_details=(_amount_details); end
    # The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the application owner's Stripe account. The amount of the application fee collected will be capped at the total amount captured. For more information, see the PaymentIntents [use case for connected accounts](https://docs.stripe.com/payments/connected-accounts).
    sig { returns(T.nilable(T.any(String, Integer))) }
    def application_fee_amount; end
    sig {
      params(_application_fee_amount: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
     }
    def application_fee_amount=(_application_fee_amount); end
    # Controls when the funds will be captured from the customer's account.
    sig { returns(T.nilable(String)) }
    def capture_method; end
    sig { params(_capture_method: T.nilable(String)).returns(T.nilable(String)) }
    def capture_method=(_capture_method); end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(T.nilable(String)) }
    def currency; end
    sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
    def currency=(_currency); end
    # ID of the Customer this PaymentIntent belongs to, if one exists.
    #
    # Payment methods attached to other Customers cannot be used with this PaymentIntent.
    #
    # If [setup_future_usage](https://api.stripe.com#payment_intent_object-setup_future_usage) is set and this PaymentIntent's payment method is not `card_present`, then the payment method attaches to the Customer after the PaymentIntent has been confirmed and any required actions from the user are complete. If the payment method is `card_present` and isn't a digital wallet, then a [generated_card](https://docs.stripe.com/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card is created and attached to the Customer instead.
    sig { returns(T.nilable(String)) }
    def customer; end
    sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
    def customer=(_customer); end
    # ID of the Account representing the customer that this PaymentIntent belongs to, if one exists.
    #
    # Payment methods attached to other Accounts cannot be used with this PaymentIntent.
    #
    # If [setup_future_usage](https://api.stripe.com#payment_intent_object-setup_future_usage) is set and this PaymentIntent's payment method is not `card_present`, then the payment method attaches to the Account after the PaymentIntent has been confirmed and any required actions from the user are complete. If the payment method is `card_present` and isn't a digital wallet, then a [generated_card](https://docs.stripe.com/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card is created and attached to the Account instead.
    sig { returns(T.nilable(String)) }
    def customer_account; end
    sig { params(_customer_account: T.nilable(String)).returns(T.nilable(String)) }
    def customer_account=(_customer_account); end
    # An arbitrary string attached to the object. Often useful for displaying to users.
    sig { returns(T.nilable(String)) }
    def description; end
    sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
    def description=(_description); end
    # The list of payment method types to exclude from use with this payment.
    sig { returns(T.nilable(T.any(String, T::Array[String]))) }
    def excluded_payment_method_types; end
    sig {
      params(_excluded_payment_method_types: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
     }
    def excluded_payment_method_types=(_excluded_payment_method_types); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Automations to be run during the PaymentIntent lifecycle
    sig { returns(T.nilable(PaymentIntentUpdateParams::Hooks)) }
    def hooks; end
    sig {
      params(_hooks: T.nilable(PaymentIntentUpdateParams::Hooks)).returns(T.nilable(PaymentIntentUpdateParams::Hooks))
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
    sig { returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentDetails))) }
    def payment_details; end
    sig {
      params(_payment_details: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentDetails))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentDetails)))
     }
    def payment_details=(_payment_details); end
    # ID of the payment method (a PaymentMethod, Card, or [compatible Source](https://docs.stripe.com/payments/payment-methods/transitioning#compatibility) object) to attach to this PaymentIntent. To unset this field to null, pass in an empty string.
    sig { returns(T.nilable(String)) }
    def payment_method; end
    sig { params(_payment_method: T.nilable(String)).returns(T.nilable(String)) }
    def payment_method=(_payment_method); end
    # The ID of the [payment method configuration](https://docs.stripe.com/api/payment_method_configurations) to use with this PaymentIntent.
    sig { returns(T.nilable(String)) }
    def payment_method_configuration; end
    sig { params(_payment_method_configuration: T.nilable(String)).returns(T.nilable(String)) }
    def payment_method_configuration=(_payment_method_configuration); end
    # If provided, this hash will be used to create a PaymentMethod. The new PaymentMethod will appear
    # in the [payment_method](https://docs.stripe.com/api/payment_intents/object#payment_intent_object-payment_method)
    # property on the PaymentIntent.
    sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData)) }
    def payment_method_data; end
    sig {
      params(_payment_method_data: T.nilable(PaymentIntentUpdateParams::PaymentMethodData)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodData))
     }
    def payment_method_data=(_payment_method_data); end
    # Payment-method-specific configuration for this PaymentIntent.
    sig { returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions)) }
    def payment_method_options; end
    sig {
      params(_payment_method_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions)).returns(T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions))
     }
    def payment_method_options=(_payment_method_options); end
    # The list of payment method types (for example, card) that this PaymentIntent can use. Use `automatic_payment_methods` to manage payment methods from the [Stripe Dashboard](https://dashboard.stripe.com/settings/payment_methods). A list of valid payment method types can be found [here](https://docs.stripe.com/api/payment_methods/object#payment_method_object-type).
    sig { returns(T.nilable(T::Array[String])) }
    def payment_method_types; end
    sig {
      params(_payment_method_types: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
     }
    def payment_method_types=(_payment_method_types); end
    # Email address that the receipt for the resulting payment will be sent to. If `receipt_email` is specified for a payment in live mode, a receipt will be sent regardless of your [email settings](https://dashboard.stripe.com/account/emails).
    sig { returns(T.nilable(String)) }
    def receipt_email; end
    sig { params(_receipt_email: T.nilable(String)).returns(T.nilable(String)) }
    def receipt_email=(_receipt_email); end
    # Indicates that you intend to make future payments with this PaymentIntent's payment method.
    #
    # If you provide a Customer with the PaymentIntent, you can use this parameter to [attach the payment method](/payments/save-during-payment) to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still [attach](/api/payment_methods/attach) the payment method to a Customer after the transaction completes.
    #
    # If the payment method is `card_present` and isn't a digital wallet, Stripe creates and attaches a [generated_card](/api/charges/object#charge_object-payment_method_details-card_present-generated_card) payment method representing the card to the Customer instead.
    #
    # When processing card payments, Stripe uses `setup_future_usage` to help you comply with regional legislation and network rules, such as [SCA](/strong-customer-authentication).
    #
    # If you've already set `setup_future_usage` and you're performing a request using a publishable key, you can only update the value from `on_session` to `off_session`.
    sig { returns(T.nilable(T.any(String, String))) }
    def setup_future_usage; end
    sig {
      params(_setup_future_usage: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
     }
    def setup_future_usage=(_setup_future_usage); end
    # Shipping information for this PaymentIntent.
    sig { returns(T.nilable(T.any(String, PaymentIntentUpdateParams::Shipping))) }
    def shipping; end
    sig {
      params(_shipping: T.nilable(T.any(String, PaymentIntentUpdateParams::Shipping))).returns(T.nilable(T.any(String, PaymentIntentUpdateParams::Shipping)))
     }
    def shipping=(_shipping); end
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
    # Use this parameter to automatically create a Transfer when the payment succeeds. Learn more about the [use case for connected accounts](https://docs.stripe.com/payments/connected-accounts).
    sig { returns(T.nilable(PaymentIntentUpdateParams::TransferData)) }
    def transfer_data; end
    sig {
      params(_transfer_data: T.nilable(PaymentIntentUpdateParams::TransferData)).returns(T.nilable(PaymentIntentUpdateParams::TransferData))
     }
    def transfer_data=(_transfer_data); end
    # A string that identifies the resulting payment as part of a group. You can only provide `transfer_group` if it hasn't been set. Learn more about the [use case for connected accounts](https://docs.stripe.com/payments/connected-accounts).
    sig { returns(T.nilable(String)) }
    def transfer_group; end
    sig { params(_transfer_group: T.nilable(String)).returns(T.nilable(String)) }
    def transfer_group=(_transfer_group); end
    sig {
      params(amount: T.nilable(Integer), amount_details: T.nilable(T.any(String, PaymentIntentUpdateParams::AmountDetails)), application_fee_amount: T.nilable(T.any(String, Integer)), capture_method: T.nilable(String), currency: T.nilable(String), customer: T.nilable(String), customer_account: T.nilable(String), description: T.nilable(String), excluded_payment_method_types: T.nilable(T.any(String, T::Array[String])), expand: T.nilable(T::Array[String]), hooks: T.nilable(PaymentIntentUpdateParams::Hooks), metadata: T.nilable(T.any(String, T::Hash[String, String])), payment_details: T.nilable(T.any(String, PaymentIntentUpdateParams::PaymentDetails)), payment_method: T.nilable(String), payment_method_configuration: T.nilable(String), payment_method_data: T.nilable(PaymentIntentUpdateParams::PaymentMethodData), payment_method_options: T.nilable(PaymentIntentUpdateParams::PaymentMethodOptions), payment_method_types: T.nilable(T::Array[String]), receipt_email: T.nilable(String), setup_future_usage: T.nilable(T.any(String, String)), shipping: T.nilable(T.any(String, PaymentIntentUpdateParams::Shipping)), statement_descriptor: T.nilable(String), statement_descriptor_suffix: T.nilable(String), transfer_data: T.nilable(PaymentIntentUpdateParams::TransferData), transfer_group: T.nilable(String)).void
     }
    def initialize(
      amount: nil,
      amount_details: nil,
      application_fee_amount: nil,
      capture_method: nil,
      currency: nil,
      customer: nil,
      customer_account: nil,
      description: nil,
      excluded_payment_method_types: nil,
      expand: nil,
      hooks: nil,
      metadata: nil,
      payment_details: nil,
      payment_method: nil,
      payment_method_configuration: nil,
      payment_method_data: nil,
      payment_method_options: nil,
      payment_method_types: nil,
      receipt_email: nil,
      setup_future_usage: nil,
      shipping: nil,
      statement_descriptor: nil,
      statement_descriptor_suffix: nil,
      transfer_data: nil,
      transfer_group: nil
    ); end
  end
end