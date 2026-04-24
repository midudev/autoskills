# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class AuthorizationCaptureParams < ::Stripe::RequestParams
      class PurchaseDetails < ::Stripe::RequestParams
        class Fleet < ::Stripe::RequestParams
          class CardholderPromptData < ::Stripe::RequestParams
            # Driver ID.
            sig { returns(T.nilable(String)) }
            def driver_id; end
            sig { params(_driver_id: T.nilable(String)).returns(T.nilable(String)) }
            def driver_id=(_driver_id); end
            # Odometer reading.
            sig { returns(T.nilable(Integer)) }
            def odometer; end
            sig { params(_odometer: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def odometer=(_odometer); end
            # An alphanumeric ID. This field is used when a vehicle ID, driver ID, or generic ID is entered by the cardholder, but the merchant or card network did not specify the prompt type.
            sig { returns(T.nilable(String)) }
            def unspecified_id; end
            sig { params(_unspecified_id: T.nilable(String)).returns(T.nilable(String)) }
            def unspecified_id=(_unspecified_id); end
            # User ID.
            sig { returns(T.nilable(String)) }
            def user_id; end
            sig { params(_user_id: T.nilable(String)).returns(T.nilable(String)) }
            def user_id=(_user_id); end
            # Vehicle number.
            sig { returns(T.nilable(String)) }
            def vehicle_number; end
            sig { params(_vehicle_number: T.nilable(String)).returns(T.nilable(String)) }
            def vehicle_number=(_vehicle_number); end
            sig {
              params(driver_id: T.nilable(String), odometer: T.nilable(Integer), unspecified_id: T.nilable(String), user_id: T.nilable(String), vehicle_number: T.nilable(String)).void
             }
            def initialize(
              driver_id: nil,
              odometer: nil,
              unspecified_id: nil,
              user_id: nil,
              vehicle_number: nil
            ); end
          end
          class ReportedBreakdown < ::Stripe::RequestParams
            class Fuel < ::Stripe::RequestParams
              # Gross fuel amount that should equal Fuel Volume multipled by Fuel Unit Cost, inclusive of taxes.
              sig { returns(T.nilable(String)) }
              def gross_amount_decimal; end
              sig { params(_gross_amount_decimal: T.nilable(String)).returns(T.nilable(String)) }
              def gross_amount_decimal=(_gross_amount_decimal); end
              sig { params(gross_amount_decimal: T.nilable(String)).void }
              def initialize(gross_amount_decimal: nil); end
            end
            class NonFuel < ::Stripe::RequestParams
              # Gross non-fuel amount that should equal the sum of the line items, inclusive of taxes.
              sig { returns(T.nilable(String)) }
              def gross_amount_decimal; end
              sig { params(_gross_amount_decimal: T.nilable(String)).returns(T.nilable(String)) }
              def gross_amount_decimal=(_gross_amount_decimal); end
              sig { params(gross_amount_decimal: T.nilable(String)).void }
              def initialize(gross_amount_decimal: nil); end
            end
            class Tax < ::Stripe::RequestParams
              # Amount of state or provincial Sales Tax included in the transaction amount. Null if not reported by merchant or not subject to tax.
              sig { returns(T.nilable(String)) }
              def local_amount_decimal; end
              sig { params(_local_amount_decimal: T.nilable(String)).returns(T.nilable(String)) }
              def local_amount_decimal=(_local_amount_decimal); end
              # Amount of national Sales Tax or VAT included in the transaction amount. Null if not reported by merchant or not subject to tax.
              sig { returns(T.nilable(String)) }
              def national_amount_decimal; end
              sig { params(_national_amount_decimal: T.nilable(String)).returns(T.nilable(String)) }
              def national_amount_decimal=(_national_amount_decimal); end
              sig {
                params(local_amount_decimal: T.nilable(String), national_amount_decimal: T.nilable(String)).void
               }
              def initialize(local_amount_decimal: nil, national_amount_decimal: nil); end
            end
            # Breakdown of fuel portion of the purchase.
            sig {
              returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::ReportedBreakdown::Fuel))
             }
            def fuel; end
            sig {
              params(_fuel: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::ReportedBreakdown::Fuel)).returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::ReportedBreakdown::Fuel))
             }
            def fuel=(_fuel); end
            # Breakdown of non-fuel portion of the purchase.
            sig {
              returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::ReportedBreakdown::NonFuel))
             }
            def non_fuel; end
            sig {
              params(_non_fuel: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::ReportedBreakdown::NonFuel)).returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::ReportedBreakdown::NonFuel))
             }
            def non_fuel=(_non_fuel); end
            # Information about tax included in this transaction.
            sig {
              returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::ReportedBreakdown::Tax))
             }
            def tax; end
            sig {
              params(_tax: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::ReportedBreakdown::Tax)).returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::ReportedBreakdown::Tax))
             }
            def tax=(_tax); end
            sig {
              params(fuel: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::ReportedBreakdown::Fuel), non_fuel: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::ReportedBreakdown::NonFuel), tax: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::ReportedBreakdown::Tax)).void
             }
            def initialize(fuel: nil, non_fuel: nil, tax: nil); end
          end
          # Answers to prompts presented to the cardholder at the point of sale. Prompted fields vary depending on the configuration of your physical fleet cards. Typical points of sale support only numeric entry.
          sig {
            returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::CardholderPromptData))
           }
          def cardholder_prompt_data; end
          sig {
            params(_cardholder_prompt_data: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::CardholderPromptData)).returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::CardholderPromptData))
           }
          def cardholder_prompt_data=(_cardholder_prompt_data); end
          # The type of purchase. One of `fuel_purchase`, `non_fuel_purchase`, or `fuel_and_non_fuel_purchase`.
          sig { returns(T.nilable(String)) }
          def purchase_type; end
          sig { params(_purchase_type: T.nilable(String)).returns(T.nilable(String)) }
          def purchase_type=(_purchase_type); end
          # More information about the total amount. This information is not guaranteed to be accurate as some merchants may provide unreliable data.
          sig {
            returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::ReportedBreakdown))
           }
          def reported_breakdown; end
          sig {
            params(_reported_breakdown: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::ReportedBreakdown)).returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::ReportedBreakdown))
           }
          def reported_breakdown=(_reported_breakdown); end
          # The type of fuel service. One of `non_fuel_transaction`, `full_service`, or `self_service`.
          sig { returns(T.nilable(String)) }
          def service_type; end
          sig { params(_service_type: T.nilable(String)).returns(T.nilable(String)) }
          def service_type=(_service_type); end
          sig {
            params(cardholder_prompt_data: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::CardholderPromptData), purchase_type: T.nilable(String), reported_breakdown: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet::ReportedBreakdown), service_type: T.nilable(String)).void
           }
          def initialize(
            cardholder_prompt_data: nil,
            purchase_type: nil,
            reported_breakdown: nil,
            service_type: nil
          ); end
        end
        class Flight < ::Stripe::RequestParams
          class Segment < ::Stripe::RequestParams
            # The three-letter IATA airport code of the flight's destination.
            sig { returns(T.nilable(String)) }
            def arrival_airport_code; end
            sig { params(_arrival_airport_code: T.nilable(String)).returns(T.nilable(String)) }
            def arrival_airport_code=(_arrival_airport_code); end
            # The airline carrier code.
            sig { returns(T.nilable(String)) }
            def carrier; end
            sig { params(_carrier: T.nilable(String)).returns(T.nilable(String)) }
            def carrier=(_carrier); end
            # The three-letter IATA airport code that the flight departed from.
            sig { returns(T.nilable(String)) }
            def departure_airport_code; end
            sig { params(_departure_airport_code: T.nilable(String)).returns(T.nilable(String)) }
            def departure_airport_code=(_departure_airport_code); end
            # The flight number.
            sig { returns(T.nilable(String)) }
            def flight_number; end
            sig { params(_flight_number: T.nilable(String)).returns(T.nilable(String)) }
            def flight_number=(_flight_number); end
            # The flight's service class.
            sig { returns(T.nilable(String)) }
            def service_class; end
            sig { params(_service_class: T.nilable(String)).returns(T.nilable(String)) }
            def service_class=(_service_class); end
            # Whether a stopover is allowed on this flight.
            sig { returns(T.nilable(T::Boolean)) }
            def stopover_allowed; end
            sig { params(_stopover_allowed: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
            def stopover_allowed=(_stopover_allowed); end
            sig {
              params(arrival_airport_code: T.nilable(String), carrier: T.nilable(String), departure_airport_code: T.nilable(String), flight_number: T.nilable(String), service_class: T.nilable(String), stopover_allowed: T.nilable(T::Boolean)).void
             }
            def initialize(
              arrival_airport_code: nil,
              carrier: nil,
              departure_airport_code: nil,
              flight_number: nil,
              service_class: nil,
              stopover_allowed: nil
            ); end
          end
          # The time that the flight departed.
          sig { returns(T.nilable(Integer)) }
          def departure_at; end
          sig { params(_departure_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def departure_at=(_departure_at); end
          # The name of the passenger.
          sig { returns(T.nilable(String)) }
          def passenger_name; end
          sig { params(_passenger_name: T.nilable(String)).returns(T.nilable(String)) }
          def passenger_name=(_passenger_name); end
          # Whether the ticket is refundable.
          sig { returns(T.nilable(T::Boolean)) }
          def refundable; end
          sig { params(_refundable: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
          def refundable=(_refundable); end
          # The legs of the trip.
          sig {
            returns(T.nilable(T::Array[Issuing::AuthorizationCaptureParams::PurchaseDetails::Flight::Segment]))
           }
          def segments; end
          sig {
            params(_segments: T.nilable(T::Array[Issuing::AuthorizationCaptureParams::PurchaseDetails::Flight::Segment])).returns(T.nilable(T::Array[Issuing::AuthorizationCaptureParams::PurchaseDetails::Flight::Segment]))
           }
          def segments=(_segments); end
          # The travel agency that issued the ticket.
          sig { returns(T.nilable(String)) }
          def travel_agency; end
          sig { params(_travel_agency: T.nilable(String)).returns(T.nilable(String)) }
          def travel_agency=(_travel_agency); end
          sig {
            params(departure_at: T.nilable(Integer), passenger_name: T.nilable(String), refundable: T.nilable(T::Boolean), segments: T.nilable(T::Array[Issuing::AuthorizationCaptureParams::PurchaseDetails::Flight::Segment]), travel_agency: T.nilable(String)).void
           }
          def initialize(
            departure_at: nil,
            passenger_name: nil,
            refundable: nil,
            segments: nil,
            travel_agency: nil
          ); end
        end
        class Fuel < ::Stripe::RequestParams
          # [Conexxus Payment System Product Code](https://www.conexxus.org/conexxus-payment-system-product-codes) identifying the primary fuel product purchased.
          sig { returns(T.nilable(String)) }
          def industry_product_code; end
          sig { params(_industry_product_code: T.nilable(String)).returns(T.nilable(String)) }
          def industry_product_code=(_industry_product_code); end
          # The quantity of `unit`s of fuel that was dispensed, represented as a decimal string with at most 12 decimal places.
          sig { returns(T.nilable(String)) }
          def quantity_decimal; end
          sig { params(_quantity_decimal: T.nilable(String)).returns(T.nilable(String)) }
          def quantity_decimal=(_quantity_decimal); end
          # The type of fuel that was purchased. One of `diesel`, `unleaded_plus`, `unleaded_regular`, `unleaded_super`, or `other`.
          sig { returns(T.nilable(String)) }
          def type; end
          sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
          def type=(_type); end
          # The units for `quantity_decimal`. One of `charging_minute`, `imperial_gallon`, `kilogram`, `kilowatt_hour`, `liter`, `pound`, `us_gallon`, or `other`.
          sig { returns(T.nilable(String)) }
          def unit; end
          sig { params(_unit: T.nilable(String)).returns(T.nilable(String)) }
          def unit=(_unit); end
          # The cost in cents per each unit of fuel, represented as a decimal string with at most 12 decimal places.
          sig { returns(T.nilable(String)) }
          def unit_cost_decimal; end
          sig { params(_unit_cost_decimal: T.nilable(String)).returns(T.nilable(String)) }
          def unit_cost_decimal=(_unit_cost_decimal); end
          sig {
            params(industry_product_code: T.nilable(String), quantity_decimal: T.nilable(String), type: T.nilable(String), unit: T.nilable(String), unit_cost_decimal: T.nilable(String)).void
           }
          def initialize(
            industry_product_code: nil,
            quantity_decimal: nil,
            type: nil,
            unit: nil,
            unit_cost_decimal: nil
          ); end
        end
        class Lodging < ::Stripe::RequestParams
          # The time of checking into the lodging.
          sig { returns(T.nilable(Integer)) }
          def check_in_at; end
          sig { params(_check_in_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def check_in_at=(_check_in_at); end
          # The number of nights stayed at the lodging.
          sig { returns(T.nilable(Integer)) }
          def nights; end
          sig { params(_nights: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def nights=(_nights); end
          sig { params(check_in_at: T.nilable(Integer), nights: T.nilable(Integer)).void }
          def initialize(check_in_at: nil, nights: nil); end
        end
        class Receipt < ::Stripe::RequestParams
          # Attribute for param field description
          sig { returns(T.nilable(String)) }
          def description; end
          sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
          def description=(_description); end
          # Attribute for param field quantity
          sig { returns(T.nilable(String)) }
          def quantity; end
          sig { params(_quantity: T.nilable(String)).returns(T.nilable(String)) }
          def quantity=(_quantity); end
          # Attribute for param field total
          sig { returns(T.nilable(Integer)) }
          def total; end
          sig { params(_total: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def total=(_total); end
          # Attribute for param field unit_cost
          sig { returns(T.nilable(Integer)) }
          def unit_cost; end
          sig { params(_unit_cost: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def unit_cost=(_unit_cost); end
          sig {
            params(description: T.nilable(String), quantity: T.nilable(String), total: T.nilable(Integer), unit_cost: T.nilable(Integer)).void
           }
          def initialize(description: nil, quantity: nil, total: nil, unit_cost: nil); end
        end
        # Fleet-specific information for transactions using Fleet cards.
        sig { returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet)) }
        def fleet; end
        sig {
          params(_fleet: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet)).returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet))
         }
        def fleet=(_fleet); end
        # Information about the flight that was purchased with this transaction.
        sig { returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Flight)) }
        def flight; end
        sig {
          params(_flight: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Flight)).returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Flight))
         }
        def flight=(_flight); end
        # Information about fuel that was purchased with this transaction.
        sig { returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fuel)) }
        def fuel; end
        sig {
          params(_fuel: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fuel)).returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fuel))
         }
        def fuel=(_fuel); end
        # Information about lodging that was purchased with this transaction.
        sig { returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Lodging)) }
        def lodging; end
        sig {
          params(_lodging: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Lodging)).returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Lodging))
         }
        def lodging=(_lodging); end
        # The line items in the purchase.
        sig {
          returns(T.nilable(T::Array[Issuing::AuthorizationCaptureParams::PurchaseDetails::Receipt]))
         }
        def receipt; end
        sig {
          params(_receipt: T.nilable(T::Array[Issuing::AuthorizationCaptureParams::PurchaseDetails::Receipt])).returns(T.nilable(T::Array[Issuing::AuthorizationCaptureParams::PurchaseDetails::Receipt]))
         }
        def receipt=(_receipt); end
        # A merchant-specific order number.
        sig { returns(T.nilable(String)) }
        def reference; end
        sig { params(_reference: T.nilable(String)).returns(T.nilable(String)) }
        def reference=(_reference); end
        sig {
          params(fleet: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fleet), flight: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Flight), fuel: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Fuel), lodging: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails::Lodging), receipt: T.nilable(T::Array[Issuing::AuthorizationCaptureParams::PurchaseDetails::Receipt]), reference: T.nilable(String)).void
         }
        def initialize(
          fleet: nil,
          flight: nil,
          fuel: nil,
          lodging: nil,
          receipt: nil,
          reference: nil
        ); end
      end
      # The amount to capture from the authorization. If not provided, the full amount of the authorization will be captured. This amount is in the authorization currency and in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
      sig { returns(T.nilable(Integer)) }
      def capture_amount; end
      sig { params(_capture_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def capture_amount=(_capture_amount); end
      # Whether to close the authorization after capture. Defaults to true. Set to false to enable multi-capture flows.
      sig { returns(T.nilable(T::Boolean)) }
      def close_authorization; end
      sig { params(_close_authorization: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def close_authorization=(_close_authorization); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Additional purchase information that is optionally provided by the merchant.
      sig { returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails)) }
      def purchase_details; end
      sig {
        params(_purchase_details: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails)).returns(T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails))
       }
      def purchase_details=(_purchase_details); end
      sig {
        params(capture_amount: T.nilable(Integer), close_authorization: T.nilable(T::Boolean), expand: T.nilable(T::Array[String]), purchase_details: T.nilable(Issuing::AuthorizationCaptureParams::PurchaseDetails)).void
       }
      def initialize(
        capture_amount: nil,
        close_authorization: nil,
        expand: nil,
        purchase_details: nil
      ); end
    end
  end
end