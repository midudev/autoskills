# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class AuthorizationCreateParams < ::Stripe::RequestParams
      class AmountDetails < ::Stripe::RequestParams
        # The ATM withdrawal fee.
        sig { returns(T.nilable(Integer)) }
        def atm_fee; end
        sig { params(_atm_fee: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def atm_fee=(_atm_fee); end
        # The amount of cash requested by the cardholder.
        sig { returns(T.nilable(Integer)) }
        def cashback_amount; end
        sig { params(_cashback_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def cashback_amount=(_cashback_amount); end
        sig { params(atm_fee: T.nilable(Integer), cashback_amount: T.nilable(Integer)).void }
        def initialize(atm_fee: nil, cashback_amount: nil); end
      end
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
            returns(T.nilable(Issuing::AuthorizationCreateParams::Fleet::ReportedBreakdown::Fuel))
           }
          def fuel; end
          sig {
            params(_fuel: T.nilable(Issuing::AuthorizationCreateParams::Fleet::ReportedBreakdown::Fuel)).returns(T.nilable(Issuing::AuthorizationCreateParams::Fleet::ReportedBreakdown::Fuel))
           }
          def fuel=(_fuel); end
          # Breakdown of non-fuel portion of the purchase.
          sig {
            returns(T.nilable(Issuing::AuthorizationCreateParams::Fleet::ReportedBreakdown::NonFuel))
           }
          def non_fuel; end
          sig {
            params(_non_fuel: T.nilable(Issuing::AuthorizationCreateParams::Fleet::ReportedBreakdown::NonFuel)).returns(T.nilable(Issuing::AuthorizationCreateParams::Fleet::ReportedBreakdown::NonFuel))
           }
          def non_fuel=(_non_fuel); end
          # Information about tax included in this transaction.
          sig {
            returns(T.nilable(Issuing::AuthorizationCreateParams::Fleet::ReportedBreakdown::Tax))
           }
          def tax; end
          sig {
            params(_tax: T.nilable(Issuing::AuthorizationCreateParams::Fleet::ReportedBreakdown::Tax)).returns(T.nilable(Issuing::AuthorizationCreateParams::Fleet::ReportedBreakdown::Tax))
           }
          def tax=(_tax); end
          sig {
            params(fuel: T.nilable(Issuing::AuthorizationCreateParams::Fleet::ReportedBreakdown::Fuel), non_fuel: T.nilable(Issuing::AuthorizationCreateParams::Fleet::ReportedBreakdown::NonFuel), tax: T.nilable(Issuing::AuthorizationCreateParams::Fleet::ReportedBreakdown::Tax)).void
           }
          def initialize(fuel: nil, non_fuel: nil, tax: nil); end
        end
        # Answers to prompts presented to the cardholder at the point of sale. Prompted fields vary depending on the configuration of your physical fleet cards. Typical points of sale support only numeric entry.
        sig { returns(T.nilable(Issuing::AuthorizationCreateParams::Fleet::CardholderPromptData)) }
        def cardholder_prompt_data; end
        sig {
          params(_cardholder_prompt_data: T.nilable(Issuing::AuthorizationCreateParams::Fleet::CardholderPromptData)).returns(T.nilable(Issuing::AuthorizationCreateParams::Fleet::CardholderPromptData))
         }
        def cardholder_prompt_data=(_cardholder_prompt_data); end
        # The type of purchase. One of `fuel_purchase`, `non_fuel_purchase`, or `fuel_and_non_fuel_purchase`.
        sig { returns(T.nilable(String)) }
        def purchase_type; end
        sig { params(_purchase_type: T.nilable(String)).returns(T.nilable(String)) }
        def purchase_type=(_purchase_type); end
        # More information about the total amount. This information is not guaranteed to be accurate as some merchants may provide unreliable data.
        sig { returns(T.nilable(Issuing::AuthorizationCreateParams::Fleet::ReportedBreakdown)) }
        def reported_breakdown; end
        sig {
          params(_reported_breakdown: T.nilable(Issuing::AuthorizationCreateParams::Fleet::ReportedBreakdown)).returns(T.nilable(Issuing::AuthorizationCreateParams::Fleet::ReportedBreakdown))
         }
        def reported_breakdown=(_reported_breakdown); end
        # The type of fuel service. One of `non_fuel_transaction`, `full_service`, or `self_service`.
        sig { returns(T.nilable(String)) }
        def service_type; end
        sig { params(_service_type: T.nilable(String)).returns(T.nilable(String)) }
        def service_type=(_service_type); end
        sig {
          params(cardholder_prompt_data: T.nilable(Issuing::AuthorizationCreateParams::Fleet::CardholderPromptData), purchase_type: T.nilable(String), reported_breakdown: T.nilable(Issuing::AuthorizationCreateParams::Fleet::ReportedBreakdown), service_type: T.nilable(String)).void
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
      class MerchantData < ::Stripe::RequestParams
        # A categorization of the seller's type of business. See our [merchant categories guide](https://docs.stripe.com/issuing/merchant-categories) for a list of possible values.
        sig { returns(T.nilable(String)) }
        def category; end
        sig { params(_category: T.nilable(String)).returns(T.nilable(String)) }
        def category=(_category); end
        # City where the seller is located
        sig { returns(T.nilable(String)) }
        def city; end
        sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
        def city=(_city); end
        # Country where the seller is located
        sig { returns(T.nilable(String)) }
        def country; end
        sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
        def country=(_country); end
        # Name of the seller
        sig { returns(T.nilable(String)) }
        def name; end
        sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
        def name=(_name); end
        # Identifier assigned to the seller by the card network. Different card networks may assign different network_id fields to the same merchant.
        sig { returns(T.nilable(String)) }
        def network_id; end
        sig { params(_network_id: T.nilable(String)).returns(T.nilable(String)) }
        def network_id=(_network_id); end
        # Postal code where the seller is located
        sig { returns(T.nilable(String)) }
        def postal_code; end
        sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
        def postal_code=(_postal_code); end
        # State where the seller is located
        sig { returns(T.nilable(String)) }
        def state; end
        sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
        def state=(_state); end
        # An ID assigned by the seller to the location of the sale.
        sig { returns(T.nilable(String)) }
        def terminal_id; end
        sig { params(_terminal_id: T.nilable(String)).returns(T.nilable(String)) }
        def terminal_id=(_terminal_id); end
        # URL provided by the merchant on a 3DS request
        sig { returns(T.nilable(String)) }
        def url; end
        sig { params(_url: T.nilable(String)).returns(T.nilable(String)) }
        def url=(_url); end
        sig {
          params(category: T.nilable(String), city: T.nilable(String), country: T.nilable(String), name: T.nilable(String), network_id: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), terminal_id: T.nilable(String), url: T.nilable(String)).void
         }
        def initialize(
          category: nil,
          city: nil,
          country: nil,
          name: nil,
          network_id: nil,
          postal_code: nil,
          state: nil,
          terminal_id: nil,
          url: nil
        ); end
      end
      class NetworkData < ::Stripe::RequestParams
        # Identifier assigned to the acquirer by the card network.
        sig { returns(T.nilable(String)) }
        def acquiring_institution_id; end
        sig { params(_acquiring_institution_id: T.nilable(String)).returns(T.nilable(String)) }
        def acquiring_institution_id=(_acquiring_institution_id); end
        sig { params(acquiring_institution_id: T.nilable(String)).void }
        def initialize(acquiring_institution_id: nil); end
      end
      class RiskAssessment < ::Stripe::RequestParams
        class CardTestingRisk < ::Stripe::RequestParams
          # The % of declines due to a card number not existing in the past hour, taking place at the same merchant. Higher rates correspond to a greater probability of card testing activity, meaning bad actors may be attempting different card number combinations to guess a correct one. Takes on values between 0 and 100.
          sig { returns(T.nilable(Integer)) }
          def invalid_account_number_decline_rate_past_hour; end
          sig {
            params(_invalid_account_number_decline_rate_past_hour: T.nilable(Integer)).returns(T.nilable(Integer))
           }
          def invalid_account_number_decline_rate_past_hour=(
            _invalid_account_number_decline_rate_past_hour
          ); end
          # The % of declines due to incorrect verification data (like CVV or expiry) in the past hour, taking place at the same merchant. Higher rates correspond to a greater probability of bad actors attempting to utilize valid card credentials at merchants with verification requirements. Takes on values between 0 and 100.
          sig { returns(T.nilable(Integer)) }
          def invalid_credentials_decline_rate_past_hour; end
          sig {
            params(_invalid_credentials_decline_rate_past_hour: T.nilable(Integer)).returns(T.nilable(Integer))
           }
          def invalid_credentials_decline_rate_past_hour=(
            _invalid_credentials_decline_rate_past_hour
          ); end
          # The likelihood that this authorization is associated with card testing activity. This is assessed by evaluating decline activity over the last hour.
          sig { returns(String) }
          def risk_level; end
          sig { params(_risk_level: String).returns(String) }
          def risk_level=(_risk_level); end
          sig {
            params(invalid_account_number_decline_rate_past_hour: T.nilable(Integer), invalid_credentials_decline_rate_past_hour: T.nilable(Integer), risk_level: String).void
           }
          def initialize(
            invalid_account_number_decline_rate_past_hour: nil,
            invalid_credentials_decline_rate_past_hour: nil,
            risk_level: nil
          ); end
        end
        class FraudRisk < ::Stripe::RequestParams
          # Stripe’s assessment of the likelihood of fraud on an authorization.
          sig { returns(String) }
          def level; end
          sig { params(_level: String).returns(String) }
          def level=(_level); end
          # Stripe’s numerical model score assessing the likelihood of fraudulent activity. A higher score means a higher likelihood of fraudulent activity, and anything above 25 is considered high risk.
          sig { returns(T.nilable(Float)) }
          def score; end
          sig { params(_score: T.nilable(Float)).returns(T.nilable(Float)) }
          def score=(_score); end
          sig { params(level: String, score: T.nilable(Float)).void }
          def initialize(level: nil, score: nil); end
        end
        class MerchantDisputeRisk < ::Stripe::RequestParams
          # The dispute rate observed across all Stripe Issuing authorizations for this merchant. For example, a value of 50 means 50% of authorizations from this merchant on Stripe Issuing have resulted in a dispute. Higher values mean a higher likelihood the authorization is disputed. Takes on values between 0 and 100.
          sig { returns(T.nilable(Integer)) }
          def dispute_rate; end
          sig { params(_dispute_rate: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def dispute_rate=(_dispute_rate); end
          # The likelihood that authorizations from this merchant will result in a dispute based on their history on Stripe Issuing.
          sig { returns(String) }
          def risk_level; end
          sig { params(_risk_level: String).returns(String) }
          def risk_level=(_risk_level); end
          sig { params(dispute_rate: T.nilable(Integer), risk_level: String).void }
          def initialize(dispute_rate: nil, risk_level: nil); end
        end
        # Stripe's assessment of this authorization's likelihood of being card testing activity.
        sig {
          returns(T.nilable(Issuing::AuthorizationCreateParams::RiskAssessment::CardTestingRisk))
         }
        def card_testing_risk; end
        sig {
          params(_card_testing_risk: T.nilable(Issuing::AuthorizationCreateParams::RiskAssessment::CardTestingRisk)).returns(T.nilable(Issuing::AuthorizationCreateParams::RiskAssessment::CardTestingRisk))
         }
        def card_testing_risk=(_card_testing_risk); end
        # Stripe’s assessment of this authorization’s likelihood to be fraudulent.
        sig { returns(T.nilable(Issuing::AuthorizationCreateParams::RiskAssessment::FraudRisk)) }
        def fraud_risk; end
        sig {
          params(_fraud_risk: T.nilable(Issuing::AuthorizationCreateParams::RiskAssessment::FraudRisk)).returns(T.nilable(Issuing::AuthorizationCreateParams::RiskAssessment::FraudRisk))
         }
        def fraud_risk=(_fraud_risk); end
        # The dispute risk of the merchant (the seller on a purchase) on an authorization based on all Stripe Issuing activity.
        sig {
          returns(T.nilable(Issuing::AuthorizationCreateParams::RiskAssessment::MerchantDisputeRisk))
         }
        def merchant_dispute_risk; end
        sig {
          params(_merchant_dispute_risk: T.nilable(Issuing::AuthorizationCreateParams::RiskAssessment::MerchantDisputeRisk)).returns(T.nilable(Issuing::AuthorizationCreateParams::RiskAssessment::MerchantDisputeRisk))
         }
        def merchant_dispute_risk=(_merchant_dispute_risk); end
        sig {
          params(card_testing_risk: T.nilable(Issuing::AuthorizationCreateParams::RiskAssessment::CardTestingRisk), fraud_risk: T.nilable(Issuing::AuthorizationCreateParams::RiskAssessment::FraudRisk), merchant_dispute_risk: T.nilable(Issuing::AuthorizationCreateParams::RiskAssessment::MerchantDisputeRisk)).void
         }
        def initialize(card_testing_risk: nil, fraud_risk: nil, merchant_dispute_risk: nil); end
      end
      class VerificationData < ::Stripe::RequestParams
        class AuthenticationExemption < ::Stripe::RequestParams
          # The entity that requested the exemption, either the acquiring merchant or the Issuing user.
          sig { returns(String) }
          def claimed_by; end
          sig { params(_claimed_by: String).returns(String) }
          def claimed_by=(_claimed_by); end
          # The specific exemption claimed for this authorization.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(claimed_by: String, type: String).void }
          def initialize(claimed_by: nil, type: nil); end
        end
        class ThreeDSecure < ::Stripe::RequestParams
          # The outcome of the 3D Secure authentication request.
          sig { returns(String) }
          def result; end
          sig { params(_result: String).returns(String) }
          def result=(_result); end
          sig { params(result: String).void }
          def initialize(result: nil); end
        end
        # Whether the cardholder provided an address first line and if it matched the cardholder’s `billing.address.line1`.
        sig { returns(T.nilable(String)) }
        def address_line1_check; end
        sig { params(_address_line1_check: T.nilable(String)).returns(T.nilable(String)) }
        def address_line1_check=(_address_line1_check); end
        # Whether the cardholder provided a postal code and if it matched the cardholder’s `billing.address.postal_code`.
        sig { returns(T.nilable(String)) }
        def address_postal_code_check; end
        sig { params(_address_postal_code_check: T.nilable(String)).returns(T.nilable(String)) }
        def address_postal_code_check=(_address_postal_code_check); end
        # The exemption applied to this authorization.
        sig {
          returns(T.nilable(Issuing::AuthorizationCreateParams::VerificationData::AuthenticationExemption))
         }
        def authentication_exemption; end
        sig {
          params(_authentication_exemption: T.nilable(Issuing::AuthorizationCreateParams::VerificationData::AuthenticationExemption)).returns(T.nilable(Issuing::AuthorizationCreateParams::VerificationData::AuthenticationExemption))
         }
        def authentication_exemption=(_authentication_exemption); end
        # Whether the cardholder provided a CVC and if it matched Stripe’s record.
        sig { returns(T.nilable(String)) }
        def cvc_check; end
        sig { params(_cvc_check: T.nilable(String)).returns(T.nilable(String)) }
        def cvc_check=(_cvc_check); end
        # Whether the cardholder provided an expiry date and if it matched Stripe’s record.
        sig { returns(T.nilable(String)) }
        def expiry_check; end
        sig { params(_expiry_check: T.nilable(String)).returns(T.nilable(String)) }
        def expiry_check=(_expiry_check); end
        # 3D Secure details.
        sig {
          returns(T.nilable(Issuing::AuthorizationCreateParams::VerificationData::ThreeDSecure))
         }
        def three_d_secure; end
        sig {
          params(_three_d_secure: T.nilable(Issuing::AuthorizationCreateParams::VerificationData::ThreeDSecure)).returns(T.nilable(Issuing::AuthorizationCreateParams::VerificationData::ThreeDSecure))
         }
        def three_d_secure=(_three_d_secure); end
        sig {
          params(address_line1_check: T.nilable(String), address_postal_code_check: T.nilable(String), authentication_exemption: T.nilable(Issuing::AuthorizationCreateParams::VerificationData::AuthenticationExemption), cvc_check: T.nilable(String), expiry_check: T.nilable(String), three_d_secure: T.nilable(Issuing::AuthorizationCreateParams::VerificationData::ThreeDSecure)).void
         }
        def initialize(
          address_line1_check: nil,
          address_postal_code_check: nil,
          authentication_exemption: nil,
          cvc_check: nil,
          expiry_check: nil,
          three_d_secure: nil
        ); end
      end
      # The total amount to attempt to authorize. This amount is in the provided currency, or defaults to the card's currency, and in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
      sig { returns(T.nilable(Integer)) }
      def amount; end
      sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def amount=(_amount); end
      # Detailed breakdown of amount components. These amounts are denominated in `currency` and in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
      sig { returns(T.nilable(Issuing::AuthorizationCreateParams::AmountDetails)) }
      def amount_details; end
      sig {
        params(_amount_details: T.nilable(Issuing::AuthorizationCreateParams::AmountDetails)).returns(T.nilable(Issuing::AuthorizationCreateParams::AmountDetails))
       }
      def amount_details=(_amount_details); end
      # How the card details were provided. Defaults to online.
      sig { returns(T.nilable(String)) }
      def authorization_method; end
      sig { params(_authorization_method: T.nilable(String)).returns(T.nilable(String)) }
      def authorization_method=(_authorization_method); end
      # Card associated with this authorization.
      sig { returns(String) }
      def card; end
      sig { params(_card: String).returns(String) }
      def card=(_card); end
      # The currency of the authorization. If not provided, defaults to the currency of the card. Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(T.nilable(String)) }
      def currency; end
      sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
      def currency=(_currency); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Fleet-specific information for authorizations using Fleet cards.
      sig { returns(T.nilable(Issuing::AuthorizationCreateParams::Fleet)) }
      def fleet; end
      sig {
        params(_fleet: T.nilable(Issuing::AuthorizationCreateParams::Fleet)).returns(T.nilable(Issuing::AuthorizationCreateParams::Fleet))
       }
      def fleet=(_fleet); end
      # Probability that this transaction can be disputed in the event of fraud. Assessed by comparing the characteristics of the authorization to card network rules.
      sig { returns(T.nilable(String)) }
      def fraud_disputability_likelihood; end
      sig { params(_fraud_disputability_likelihood: T.nilable(String)).returns(T.nilable(String)) }
      def fraud_disputability_likelihood=(_fraud_disputability_likelihood); end
      # Information about fuel that was purchased with this transaction.
      sig { returns(T.nilable(Issuing::AuthorizationCreateParams::Fuel)) }
      def fuel; end
      sig {
        params(_fuel: T.nilable(Issuing::AuthorizationCreateParams::Fuel)).returns(T.nilable(Issuing::AuthorizationCreateParams::Fuel))
       }
      def fuel=(_fuel); end
      # If set `true`, you may provide [amount](https://docs.stripe.com/api/issuing/authorizations/approve#approve_issuing_authorization-amount) to control how much to hold for the authorization.
      sig { returns(T.nilable(T::Boolean)) }
      def is_amount_controllable; end
      sig { params(_is_amount_controllable: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def is_amount_controllable=(_is_amount_controllable); end
      # The total amount to attempt to authorize. This amount is in the provided merchant currency, and in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
      sig { returns(T.nilable(Integer)) }
      def merchant_amount; end
      sig { params(_merchant_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def merchant_amount=(_merchant_amount); end
      # The currency of the authorization. If not provided, defaults to the currency of the card. Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(T.nilable(String)) }
      def merchant_currency; end
      sig { params(_merchant_currency: T.nilable(String)).returns(T.nilable(String)) }
      def merchant_currency=(_merchant_currency); end
      # Details about the seller (grocery store, e-commerce website, etc.) where the card authorization happened.
      sig { returns(T.nilable(Issuing::AuthorizationCreateParams::MerchantData)) }
      def merchant_data; end
      sig {
        params(_merchant_data: T.nilable(Issuing::AuthorizationCreateParams::MerchantData)).returns(T.nilable(Issuing::AuthorizationCreateParams::MerchantData))
       }
      def merchant_data=(_merchant_data); end
      # Details about the authorization, such as identifiers, set by the card network.
      sig { returns(T.nilable(Issuing::AuthorizationCreateParams::NetworkData)) }
      def network_data; end
      sig {
        params(_network_data: T.nilable(Issuing::AuthorizationCreateParams::NetworkData)).returns(T.nilable(Issuing::AuthorizationCreateParams::NetworkData))
       }
      def network_data=(_network_data); end
      # Stripe’s assessment of the fraud risk for this authorization.
      sig { returns(T.nilable(Issuing::AuthorizationCreateParams::RiskAssessment)) }
      def risk_assessment; end
      sig {
        params(_risk_assessment: T.nilable(Issuing::AuthorizationCreateParams::RiskAssessment)).returns(T.nilable(Issuing::AuthorizationCreateParams::RiskAssessment))
       }
      def risk_assessment=(_risk_assessment); end
      # Verifications that Stripe performed on information that the cardholder provided to the merchant.
      sig { returns(T.nilable(Issuing::AuthorizationCreateParams::VerificationData)) }
      def verification_data; end
      sig {
        params(_verification_data: T.nilable(Issuing::AuthorizationCreateParams::VerificationData)).returns(T.nilable(Issuing::AuthorizationCreateParams::VerificationData))
       }
      def verification_data=(_verification_data); end
      # The digital wallet used for this transaction. One of `apple_pay`, `google_pay`, or `samsung_pay`. Will populate as `null` when no digital wallet was utilized.
      sig { returns(T.nilable(String)) }
      def wallet; end
      sig { params(_wallet: T.nilable(String)).returns(T.nilable(String)) }
      def wallet=(_wallet); end
      sig {
        params(amount: T.nilable(Integer), amount_details: T.nilable(Issuing::AuthorizationCreateParams::AmountDetails), authorization_method: T.nilable(String), card: String, currency: T.nilable(String), expand: T.nilable(T::Array[String]), fleet: T.nilable(Issuing::AuthorizationCreateParams::Fleet), fraud_disputability_likelihood: T.nilable(String), fuel: T.nilable(Issuing::AuthorizationCreateParams::Fuel), is_amount_controllable: T.nilable(T::Boolean), merchant_amount: T.nilable(Integer), merchant_currency: T.nilable(String), merchant_data: T.nilable(Issuing::AuthorizationCreateParams::MerchantData), network_data: T.nilable(Issuing::AuthorizationCreateParams::NetworkData), risk_assessment: T.nilable(Issuing::AuthorizationCreateParams::RiskAssessment), verification_data: T.nilable(Issuing::AuthorizationCreateParams::VerificationData), wallet: T.nilable(String)).void
       }
      def initialize(
        amount: nil,
        amount_details: nil,
        authorization_method: nil,
        card: nil,
        currency: nil,
        expand: nil,
        fleet: nil,
        fraud_disputability_likelihood: nil,
        fuel: nil,
        is_amount_controllable: nil,
        merchant_amount: nil,
        merchant_currency: nil,
        merchant_data: nil,
        network_data: nil,
        risk_assessment: nil,
        verification_data: nil,
        wallet: nil
      ); end
    end
  end
end