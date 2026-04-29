# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    # An issuing token object is created when an issued card is added to a digital wallet. As a [card issuer](https://docs.stripe.com/issuing), you can [view and manage these tokens](https://docs.stripe.com/issuing/controls/token-management) through Stripe.
    class Token < APIResource
      class NetworkData < ::Stripe::StripeObject
        class Device < ::Stripe::StripeObject
          # An obfuscated ID derived from the device ID.
          sig { returns(T.nilable(String)) }
          def device_fingerprint; end
          # The IP address of the device at provisioning time.
          sig { returns(T.nilable(String)) }
          def ip_address; end
          # The geographic latitude/longitude coordinates of the device at provisioning time. The format is [+-]decimal/[+-]decimal.
          sig { returns(T.nilable(String)) }
          def location; end
          # The name of the device used for tokenization.
          sig { returns(T.nilable(String)) }
          def name; end
          # The phone number of the device used for tokenization.
          sig { returns(T.nilable(String)) }
          def phone_number; end
          # The type of device used for tokenization.
          sig { returns(T.nilable(String)) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Mastercard < ::Stripe::StripeObject
          # A unique reference ID from MasterCard to represent the card account number.
          sig { returns(T.nilable(String)) }
          def card_reference_id; end
          # The network-unique identifier for the token.
          sig { returns(String) }
          def token_reference_id; end
          # The ID of the entity requesting tokenization, specific to MasterCard.
          sig { returns(String) }
          def token_requestor_id; end
          # The name of the entity requesting tokenization, if known. This is directly provided from MasterCard.
          sig { returns(T.nilable(String)) }
          def token_requestor_name; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Visa < ::Stripe::StripeObject
          # A unique reference ID from Visa to represent the card account number.
          sig { returns(String) }
          def card_reference_id; end
          # The network-unique identifier for the token.
          sig { returns(String) }
          def token_reference_id; end
          # The ID of the entity requesting tokenization, specific to Visa.
          sig { returns(String) }
          def token_requestor_id; end
          # Degree of risk associated with the token between `01` and `99`, with higher number indicating higher risk. A `00` value indicates the token was not scored by Visa.
          sig { returns(T.nilable(String)) }
          def token_risk_score; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class WalletProvider < ::Stripe::StripeObject
          class CardholderAddress < ::Stripe::StripeObject
            # The street address of the cardholder tokenizing the card.
            sig { returns(String) }
            def line1; end
            # The postal code of the cardholder tokenizing the card.
            sig { returns(String) }
            def postal_code; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # The wallet provider-given account ID of the digital wallet the token belongs to.
          sig { returns(T.nilable(String)) }
          def account_id; end
          # An evaluation on the trustworthiness of the wallet account between 1 and 5. A higher score indicates more trustworthy.
          sig { returns(T.nilable(Integer)) }
          def account_trust_score; end
          # The method used for tokenizing a card.
          sig { returns(T.nilable(String)) }
          def card_number_source; end
          # Attribute for field cardholder_address
          sig { returns(T.nilable(CardholderAddress)) }
          def cardholder_address; end
          # The name of the cardholder tokenizing the card.
          sig { returns(T.nilable(String)) }
          def cardholder_name; end
          # An evaluation on the trustworthiness of the device. A higher score indicates more trustworthy.
          sig { returns(T.nilable(Integer)) }
          def device_trust_score; end
          # The hashed email address of the cardholder's account with the wallet provider.
          sig { returns(T.nilable(String)) }
          def hashed_account_email_address; end
          # The reasons for suggested tokenization given by the card network.
          sig { returns(T.nilable(T::Array[String])) }
          def reason_codes; end
          # The recommendation on responding to the tokenization request.
          sig { returns(T.nilable(String)) }
          def suggested_decision; end
          # The version of the standard for mapping reason codes followed by the wallet provider.
          sig { returns(T.nilable(String)) }
          def suggested_decision_version; end
          def self.inner_class_types
            @inner_class_types = {cardholder_address: CardholderAddress}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field device
        sig { returns(T.nilable(Device)) }
        def device; end
        # Attribute for field mastercard
        sig { returns(T.nilable(Mastercard)) }
        def mastercard; end
        # The network that the token is associated with. An additional hash is included with a name matching this value, containing tokenization data specific to the card network.
        sig { returns(String) }
        def type; end
        # Attribute for field visa
        sig { returns(T.nilable(Visa)) }
        def visa; end
        # Attribute for field wallet_provider
        sig { returns(T.nilable(WalletProvider)) }
        def wallet_provider; end
        def self.inner_class_types
          @inner_class_types = {
            device: Device,
            mastercard: Mastercard,
            visa: Visa,
            wallet_provider: WalletProvider,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Card associated with this token.
      sig { returns(T.any(String, ::Stripe::Issuing::Card)) }
      def card; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # The hashed ID derived from the device ID from the card network associated with the token.
      sig { returns(T.nilable(String)) }
      def device_fingerprint; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # The last four digits of the token.
      sig { returns(T.nilable(String)) }
      def last4; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # The token service provider / card network associated with the token.
      sig { returns(String) }
      def network; end
      # Attribute for field network_data
      sig { returns(T.nilable(NetworkData)) }
      def network_data; end
      # Time at which the token was last updated by the card network. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def network_updated_at; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The usage state of the token.
      sig { returns(String) }
      def status; end
      # The digital wallet for this token, if one was used.
      sig { returns(T.nilable(String)) }
      def wallet_provider; end
      # Lists all Issuing Token objects for a given card.
      sig {
        params(params: T.any(::Stripe::Issuing::TokenListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Attempts to update the specified Issuing Token object to the status specified.
      sig {
        params(token: String, params: T.any(::Stripe::Issuing::TokenUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Token)
       }
      def self.update(token, params = {}, opts = {}); end
    end
  end
end