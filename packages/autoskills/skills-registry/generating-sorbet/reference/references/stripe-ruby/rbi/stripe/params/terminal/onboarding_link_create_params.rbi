# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    class OnboardingLinkCreateParams < ::Stripe::RequestParams
      class LinkOptions < ::Stripe::RequestParams
        class AppleTermsAndConditions < ::Stripe::RequestParams
          # Whether the link should also support users relinking their Apple account.
          sig { returns(T.nilable(T::Boolean)) }
          def allow_relinking; end
          sig { params(_allow_relinking: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
          def allow_relinking=(_allow_relinking); end
          # The business name of the merchant accepting Apple's Terms and Conditions.
          sig { returns(String) }
          def merchant_display_name; end
          sig { params(_merchant_display_name: String).returns(String) }
          def merchant_display_name=(_merchant_display_name); end
          sig { params(allow_relinking: T.nilable(T::Boolean), merchant_display_name: String).void }
          def initialize(allow_relinking: nil, merchant_display_name: nil); end
        end
        # The options associated with the Apple Terms and Conditions link type.
        sig {
          returns(T.nilable(Terminal::OnboardingLinkCreateParams::LinkOptions::AppleTermsAndConditions))
         }
        def apple_terms_and_conditions; end
        sig {
          params(_apple_terms_and_conditions: T.nilable(Terminal::OnboardingLinkCreateParams::LinkOptions::AppleTermsAndConditions)).returns(T.nilable(Terminal::OnboardingLinkCreateParams::LinkOptions::AppleTermsAndConditions))
         }
        def apple_terms_and_conditions=(_apple_terms_and_conditions); end
        sig {
          params(apple_terms_and_conditions: T.nilable(Terminal::OnboardingLinkCreateParams::LinkOptions::AppleTermsAndConditions)).void
         }
        def initialize(apple_terms_and_conditions: nil); end
      end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Specific fields needed to generate the desired link type.
      sig { returns(Terminal::OnboardingLinkCreateParams::LinkOptions) }
      def link_options; end
      sig {
        params(_link_options: Terminal::OnboardingLinkCreateParams::LinkOptions).returns(Terminal::OnboardingLinkCreateParams::LinkOptions)
       }
      def link_options=(_link_options); end
      # The type of link being generated.
      sig { returns(String) }
      def link_type; end
      sig { params(_link_type: String).returns(String) }
      def link_type=(_link_type); end
      # Stripe account ID to generate the link for.
      sig { returns(T.nilable(String)) }
      def on_behalf_of; end
      sig { params(_on_behalf_of: T.nilable(String)).returns(T.nilable(String)) }
      def on_behalf_of=(_on_behalf_of); end
      sig {
        params(expand: T.nilable(T::Array[String]), link_options: Terminal::OnboardingLinkCreateParams::LinkOptions, link_type: String, on_behalf_of: T.nilable(String)).void
       }
      def initialize(expand: nil, link_options: nil, link_type: nil, on_behalf_of: nil); end
    end
  end
end