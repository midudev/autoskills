# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    module Issuing
      class AuthorizationFinalizeAmountParams < ::Stripe::RequestParams
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
              returns(T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::ReportedBreakdown::Fuel))
             }
            def fuel; end
            sig {
              params(_fuel: T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::ReportedBreakdown::Fuel)).returns(T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::ReportedBreakdown::Fuel))
             }
            def fuel=(_fuel); end
            # Breakdown of non-fuel portion of the purchase.
            sig {
              returns(T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::ReportedBreakdown::NonFuel))
             }
            def non_fuel; end
            sig {
              params(_non_fuel: T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::ReportedBreakdown::NonFuel)).returns(T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::ReportedBreakdown::NonFuel))
             }
            def non_fuel=(_non_fuel); end
            # Information about tax included in this transaction.
            sig {
              returns(T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::ReportedBreakdown::Tax))
             }
            def tax; end
            sig {
              params(_tax: T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::ReportedBreakdown::Tax)).returns(T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::ReportedBreakdown::Tax))
             }
            def tax=(_tax); end
            sig {
              params(fuel: T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::ReportedBreakdown::Fuel), non_fuel: T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::ReportedBreakdown::NonFuel), tax: T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::ReportedBreakdown::Tax)).void
             }
            def initialize(fuel: nil, non_fuel: nil, tax: nil); end
          end
          # Answers to prompts presented to the cardholder at the point of sale. Prompted fields vary depending on the configuration of your physical fleet cards. Typical points of sale support only numeric entry.
          sig {
            returns(T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::CardholderPromptData))
           }
          def cardholder_prompt_data; end
          sig {
            params(_cardholder_prompt_data: T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::CardholderPromptData)).returns(T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::CardholderPromptData))
           }
          def cardholder_prompt_data=(_cardholder_prompt_data); end
          # The type of purchase. One of `fuel_purchase`, `non_fuel_purchase`, or `fuel_and_non_fuel_purchase`.
          sig { returns(T.nilable(String)) }
          def purchase_type; end
          sig { params(_purchase_type: T.nilable(String)).returns(T.nilable(String)) }
          def purchase_type=(_purchase_type); end
          # More information about the total amount. This information is not guaranteed to be accurate as some merchants may provide unreliable data.
          sig {
            returns(T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::ReportedBreakdown))
           }
          def reported_breakdown; end
          sig {
            params(_reported_breakdown: T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::ReportedBreakdown)).returns(T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::ReportedBreakdown))
           }
          def reported_breakdown=(_reported_breakdown); end
          # The type of fuel service. One of `non_fuel_transaction`, `full_service`, or `self_service`.
          sig { returns(T.nilable(String)) }
          def service_type; end
          sig { params(_service_type: T.nilable(String)).returns(T.nilable(String)) }
          def service_type=(_service_type); end
          sig {
            params(cardholder_prompt_data: T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::CardholderPromptData), purchase_type: T.nilable(String), reported_breakdown: T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet::ReportedBreakdown), service_type: T.nilable(String)).void
           }
          def initialize(
            cardholder_prompt_data: nil,
            purchase_type: nil,
            reported_breakdown: nil,
            service_type: nil
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
        # Specifies which fields in the response should be expanded.
        sig { returns(T.nilable(T::Array[String])) }
        def expand; end
        sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
        def expand=(_expand); end
        # The final authorization amount that will be captured by the merchant. This amount is in the authorization currency and in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
        sig { returns(Integer) }
        def final_amount; end
        sig { params(_final_amount: Integer).returns(Integer) }
        def final_amount=(_final_amount); end
        # Fleet-specific information for authorizations using Fleet cards.
        sig { returns(T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet)) }
        def fleet; end
        sig {
          params(_fleet: T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet)).returns(T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet))
         }
        def fleet=(_fleet); end
        # Information about fuel that was purchased with this transaction.
        sig { returns(T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fuel)) }
        def fuel; end
        sig {
          params(_fuel: T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fuel)).returns(T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fuel))
         }
        def fuel=(_fuel); end
        sig {
          params(expand: T.nilable(T::Array[String]), final_amount: Integer, fleet: T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fleet), fuel: T.nilable(TestHelpers::Issuing::AuthorizationFinalizeAmountParams::Fuel)).void
         }
        def initialize(expand: nil, final_amount: nil, fleet: nil, fuel: nil); end
      end
    end
  end
end