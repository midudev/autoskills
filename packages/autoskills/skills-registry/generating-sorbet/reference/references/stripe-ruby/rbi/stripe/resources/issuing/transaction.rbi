# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    # Any use of an [issued card](https://docs.stripe.com/issuing) that results in funds entering or leaving
    # your Stripe account, such as a completed purchase or refund, is represented by an Issuing
    # `Transaction` object.
    #
    # Related guide: [Issued card transactions](https://docs.stripe.com/issuing/purchases/transactions)
    class Transaction < APIResource
      class AmountDetails < ::Stripe::StripeObject
        # The fee charged by the ATM for the cash withdrawal.
        sig { returns(T.nilable(Integer)) }
        def atm_fee; end
        # The amount of cash requested by the cardholder.
        sig { returns(T.nilable(Integer)) }
        def cashback_amount; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class MerchantData < ::Stripe::StripeObject
        # A categorization of the seller's type of business. See our [merchant categories guide](https://docs.stripe.com/issuing/merchant-categories) for a list of possible values.
        sig { returns(String) }
        def category; end
        # The merchant category code for the seller’s business
        sig { returns(String) }
        def category_code; end
        # City where the seller is located
        sig { returns(T.nilable(String)) }
        def city; end
        # Country where the seller is located
        sig { returns(T.nilable(String)) }
        def country; end
        # Name of the seller
        sig { returns(T.nilable(String)) }
        def name; end
        # Identifier assigned to the seller by the card network. Different card networks may assign different network_id fields to the same merchant.
        sig { returns(String) }
        def network_id; end
        # Postal code where the seller is located
        sig { returns(T.nilable(String)) }
        def postal_code; end
        # State where the seller is located
        sig { returns(T.nilable(String)) }
        def state; end
        # The seller's tax identification number. Currently populated for French merchants only.
        sig { returns(T.nilable(String)) }
        def tax_id; end
        # An ID assigned by the seller to the location of the sale.
        sig { returns(T.nilable(String)) }
        def terminal_id; end
        # URL provided by the merchant on a 3DS request
        sig { returns(T.nilable(String)) }
        def url; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class NetworkData < ::Stripe::StripeObject
        # A code created by Stripe which is shared with the merchant to validate the authorization. This field will be populated if the authorization message was approved. The code typically starts with the letter "S", followed by a six-digit number. For example, "S498162". Please note that the code is not guaranteed to be unique across authorizations.
        sig { returns(T.nilable(String)) }
        def authorization_code; end
        # The date the transaction was processed by the card network. This can be different from the date the seller recorded the transaction depending on when the acquirer submits the transaction to the network.
        sig { returns(T.nilable(String)) }
        def processing_date; end
        # Unique identifier for the authorization assigned by the card network used to match subsequent messages, disputes, and transactions.
        sig { returns(T.nilable(String)) }
        def transaction_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class PurchaseDetails < ::Stripe::StripeObject
        class Fleet < ::Stripe::StripeObject
          class CardholderPromptData < ::Stripe::StripeObject
            # Driver ID.
            sig { returns(T.nilable(String)) }
            def driver_id; end
            # Odometer reading.
            sig { returns(T.nilable(Integer)) }
            def odometer; end
            # An alphanumeric ID. This field is used when a vehicle ID, driver ID, or generic ID is entered by the cardholder, but the merchant or card network did not specify the prompt type.
            sig { returns(T.nilable(String)) }
            def unspecified_id; end
            # User ID.
            sig { returns(T.nilable(String)) }
            def user_id; end
            # Vehicle number.
            sig { returns(T.nilable(String)) }
            def vehicle_number; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class ReportedBreakdown < ::Stripe::StripeObject
            class Fuel < ::Stripe::StripeObject
              # Gross fuel amount that should equal Fuel Volume multipled by Fuel Unit Cost, inclusive of taxes.
              sig { returns(T.nilable(String)) }
              def gross_amount_decimal; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class NonFuel < ::Stripe::StripeObject
              # Gross non-fuel amount that should equal the sum of the line items, inclusive of taxes.
              sig { returns(T.nilable(String)) }
              def gross_amount_decimal; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Tax < ::Stripe::StripeObject
              # Amount of state or provincial Sales Tax included in the transaction amount. Null if not reported by merchant or not subject to tax.
              sig { returns(T.nilable(String)) }
              def local_amount_decimal; end
              # Amount of national Sales Tax or VAT included in the transaction amount. Null if not reported by merchant or not subject to tax.
              sig { returns(T.nilable(String)) }
              def national_amount_decimal; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Breakdown of fuel portion of the purchase.
            sig { returns(T.nilable(Fuel)) }
            def fuel; end
            # Breakdown of non-fuel portion of the purchase.
            sig { returns(T.nilable(NonFuel)) }
            def non_fuel; end
            # Information about tax included in this transaction.
            sig { returns(T.nilable(Tax)) }
            def tax; end
            def self.inner_class_types
              @inner_class_types = {fuel: Fuel, non_fuel: NonFuel, tax: Tax}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Answers to prompts presented to cardholder at point of sale.
          sig { returns(T.nilable(CardholderPromptData)) }
          def cardholder_prompt_data; end
          # The type of purchase. One of `fuel_purchase`, `non_fuel_purchase`, or `fuel_and_non_fuel_purchase`.
          sig { returns(T.nilable(String)) }
          def purchase_type; end
          # More information about the total amount. This information is not guaranteed to be accurate as some merchants may provide unreliable data.
          sig { returns(T.nilable(ReportedBreakdown)) }
          def reported_breakdown; end
          # The type of fuel service. One of `non_fuel_transaction`, `full_service`, or `self_service`.
          sig { returns(T.nilable(String)) }
          def service_type; end
          def self.inner_class_types
            @inner_class_types = {
              cardholder_prompt_data: CardholderPromptData,
              reported_breakdown: ReportedBreakdown,
            }
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Flight < ::Stripe::StripeObject
          class Segment < ::Stripe::StripeObject
            # The three-letter IATA airport code of the flight's destination.
            sig { returns(T.nilable(String)) }
            def arrival_airport_code; end
            # The airline carrier code.
            sig { returns(T.nilable(String)) }
            def carrier; end
            # The three-letter IATA airport code that the flight departed from.
            sig { returns(T.nilable(String)) }
            def departure_airport_code; end
            # The flight number.
            sig { returns(T.nilable(String)) }
            def flight_number; end
            # The flight's service class.
            sig { returns(T.nilable(String)) }
            def service_class; end
            # Whether a stopover is allowed on this flight.
            sig { returns(T.nilable(T::Boolean)) }
            def stopover_allowed; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # The time that the flight departed.
          sig { returns(T.nilable(Integer)) }
          def departure_at; end
          # The name of the passenger.
          sig { returns(T.nilable(String)) }
          def passenger_name; end
          # Whether the ticket is refundable.
          sig { returns(T.nilable(T::Boolean)) }
          def refundable; end
          # The legs of the trip.
          sig { returns(T.nilable(T::Array[Segment])) }
          def segments; end
          # The travel agency that issued the ticket.
          sig { returns(T.nilable(String)) }
          def travel_agency; end
          def self.inner_class_types
            @inner_class_types = {segments: Segment}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Fuel < ::Stripe::StripeObject
          # [Conexxus Payment System Product Code](https://www.conexxus.org/conexxus-payment-system-product-codes) identifying the primary fuel product purchased.
          sig { returns(T.nilable(String)) }
          def industry_product_code; end
          # The quantity of `unit`s of fuel that was dispensed, represented as a decimal string with at most 12 decimal places.
          sig { returns(T.nilable(String)) }
          def quantity_decimal; end
          # The type of fuel that was purchased. One of `diesel`, `unleaded_plus`, `unleaded_regular`, `unleaded_super`, or `other`.
          sig { returns(String) }
          def type; end
          # The units for `quantity_decimal`. One of `charging_minute`, `imperial_gallon`, `kilogram`, `kilowatt_hour`, `liter`, `pound`, `us_gallon`, or `other`.
          sig { returns(String) }
          def unit; end
          # The cost in cents per each unit of fuel, represented as a decimal string with at most 12 decimal places.
          sig { returns(String) }
          def unit_cost_decimal; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Lodging < ::Stripe::StripeObject
          # The time of checking into the lodging.
          sig { returns(T.nilable(Integer)) }
          def check_in_at; end
          # The number of nights stayed at the lodging.
          sig { returns(T.nilable(Integer)) }
          def nights; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Receipt < ::Stripe::StripeObject
          # The description of the item. The maximum length of this field is 26 characters.
          sig { returns(T.nilable(String)) }
          def description; end
          # The quantity of the item.
          sig { returns(T.nilable(Float)) }
          def quantity; end
          # The total for this line item in cents.
          sig { returns(T.nilable(Integer)) }
          def total; end
          # The unit cost of the item in cents.
          sig { returns(T.nilable(Integer)) }
          def unit_cost; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Fleet-specific information for transactions using Fleet cards.
        sig { returns(T.nilable(Fleet)) }
        def fleet; end
        # Information about the flight that was purchased with this transaction.
        sig { returns(T.nilable(Flight)) }
        def flight; end
        # Information about fuel that was purchased with this transaction.
        sig { returns(T.nilable(Fuel)) }
        def fuel; end
        # Information about lodging that was purchased with this transaction.
        sig { returns(T.nilable(Lodging)) }
        def lodging; end
        # The line items in the purchase.
        sig { returns(T.nilable(T::Array[Receipt])) }
        def receipt; end
        # A merchant-specific order number.
        sig { returns(T.nilable(String)) }
        def reference; end
        def self.inner_class_types
          @inner_class_types = {
            fleet: Fleet,
            flight: Flight,
            fuel: Fuel,
            lodging: Lodging,
            receipt: Receipt,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Treasury < ::Stripe::StripeObject
        # The Treasury [ReceivedCredit](https://docs.stripe.com/api/treasury/received_credits) representing this Issuing transaction if it is a refund
        sig { returns(T.nilable(String)) }
        def received_credit; end
        # The Treasury [ReceivedDebit](https://docs.stripe.com/api/treasury/received_debits) representing this Issuing transaction if it is a capture
        sig { returns(T.nilable(String)) }
        def received_debit; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The transaction amount, which will be reflected in your balance. This amount is in your currency and in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
      sig { returns(Integer) }
      def amount; end
      # Detailed breakdown of amount components. These amounts are denominated in `currency` and in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
      sig { returns(T.nilable(AmountDetails)) }
      def amount_details; end
      # The `Authorization` object that led to this transaction.
      sig { returns(T.nilable(T.any(String, ::Stripe::Issuing::Authorization))) }
      def authorization; end
      # ID of the [balance transaction](https://docs.stripe.com/api/balance_transactions) associated with this transaction.
      sig { returns(T.nilable(T.any(String, ::Stripe::BalanceTransaction))) }
      def balance_transaction; end
      # The card used to make this transaction.
      sig { returns(T.any(String, ::Stripe::Issuing::Card)) }
      def card; end
      # The cardholder to whom this transaction belongs.
      sig { returns(T.nilable(T.any(String, ::Stripe::Issuing::Cardholder))) }
      def cardholder; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # If you've disputed the transaction, the ID of the dispute.
      sig { returns(T.nilable(T.any(String, ::Stripe::Issuing::Dispute))) }
      def dispute; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # The amount that the merchant will receive, denominated in `merchant_currency` and in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal). It will be different from `amount` if the merchant is taking payment in a different currency.
      sig { returns(Integer) }
      def merchant_amount; end
      # The currency with which the merchant is taking payment.
      sig { returns(String) }
      def merchant_currency; end
      # Attribute for field merchant_data
      sig { returns(MerchantData) }
      def merchant_data; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T::Hash[String, String]) }
      def metadata; end
      # Details about the transaction, such as processing dates, set by the card network.
      sig { returns(T.nilable(NetworkData)) }
      def network_data; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Additional purchase information that is optionally provided by the merchant.
      sig { returns(T.nilable(PurchaseDetails)) }
      def purchase_details; end
      # [Token](https://docs.stripe.com/api/issuing/tokens/object) object used for this transaction. If a network token was not used for this transaction, this field will be null.
      sig { returns(T.nilable(T.any(String, ::Stripe::Issuing::Token))) }
      def token; end
      # [Treasury](https://docs.stripe.com/api/treasury) details related to this transaction if it was created on a [FinancialAccount](/docs/api/treasury/financial_accounts
      sig { returns(T.nilable(Treasury)) }
      def treasury; end
      # The nature of the transaction.
      sig { returns(String) }
      def type; end
      # The digital wallet used for this transaction. One of `apple_pay`, `google_pay`, or `samsung_pay`.
      sig { returns(T.nilable(String)) }
      def wallet; end
      # Returns a list of Issuing Transaction objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
      sig {
        params(params: T.any(::Stripe::Issuing::TransactionListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Updates the specified Issuing Transaction object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
      sig {
        params(transaction: String, params: T.any(::Stripe::Issuing::TransactionUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Transaction)
       }
      def self.update(transaction, params = {}, opts = {}); end
    end
  end
end