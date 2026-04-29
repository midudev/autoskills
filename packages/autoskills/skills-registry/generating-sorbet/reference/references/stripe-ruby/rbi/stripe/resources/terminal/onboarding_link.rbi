# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    # Returns redirect links used for onboarding onto Tap to Pay on iPhone.
    class OnboardingLink < APIResource
      class LinkOptions < ::Stripe::StripeObject
        class AppleTermsAndConditions < ::Stripe::StripeObject
          # Whether the link should also support users relinking their Apple account.
          sig { returns(T.nilable(T::Boolean)) }
          def allow_relinking; end
          # The business name of the merchant accepting Apple's Terms and Conditions.
          sig { returns(String) }
          def merchant_display_name; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The options associated with the Apple Terms and Conditions link type.
        sig { returns(T.nilable(AppleTermsAndConditions)) }
        def apple_terms_and_conditions; end
        def self.inner_class_types
          @inner_class_types = {apple_terms_and_conditions: AppleTermsAndConditions}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Link type options associated with the current onboarding link object.
      sig { returns(LinkOptions) }
      def link_options; end
      # The type of link being generated.
      sig { returns(String) }
      def link_type; end
      # Attribute for field object
      sig { returns(String) }
      def object; end
      # Stripe account ID to generate the link for.
      sig { returns(T.nilable(String)) }
      def on_behalf_of; end
      # The link passed back to the user for their onboarding.
      sig { returns(String) }
      def redirect_url; end
      # Creates a new OnboardingLink object that contains a redirect_url used for onboarding onto Tap to Pay on iPhone.
      sig {
        params(params: T.any(::Stripe::Terminal::OnboardingLinkCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::OnboardingLink)
       }
      def self.create(params = {}, opts = {}); end
    end
  end
end