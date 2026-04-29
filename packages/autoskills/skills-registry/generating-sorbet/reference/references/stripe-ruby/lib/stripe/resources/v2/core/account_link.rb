# File generated from our OpenAPI spec
# frozen_string_literal: true

module Stripe
  module V2
    module Core
      # Account Links let a platform create a temporary, single-use URL that an account can use to access a Stripe-hosted flow for collecting or updating required information.
      class AccountLink < APIResource
        OBJECT_NAME = "v2.core.account_link"
        def self.object_name
          "v2.core.account_link"
        end

        class UseCase < ::Stripe::StripeObject
          class AccountOnboarding < ::Stripe::StripeObject
            class CollectionOptions < ::Stripe::StripeObject
              # Specifies whether the platform collects only currently_due requirements (`currently_due`) or both currently_due and eventually_due requirements (`eventually_due`). If you don’t specify collection_options, the default value is currently_due.
              attr_reader :fields
              # Specifies whether the platform collects future_requirements in addition to requirements in Connect Onboarding. The default value is `omit`.
              attr_reader :future_requirements

              def self.inner_class_types
                @inner_class_types = {}
              end

              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Specifies the requirements that Stripe collects from v2/core/accounts in the Onboarding flow.
            attr_reader :collection_options
            # Open Enum. A v2/core/account can be configured to enable certain functionality. The configuration param targets the v2/core/account_link to collect information for the specified v2/core/account configuration/s.
            attr_reader :configurations
            # The URL the user will be redirected to if the AccountLink is expired, has been used, or is otherwise invalid. The URL you specify should attempt to generate a new AccountLink with the same parameters used to create the original AccountLink, then redirect the user to the new AccountLink’s URL so they can continue the flow. If a new AccountLink cannot be generated or the redirect fails you should display a useful error to the user. Please make sure to implement authentication before redirecting the user in case this URL is leaked to a third party.
            attr_reader :refresh_url
            # The URL that the user will be redirected to upon completing the linked flow.
            attr_reader :return_url

            def self.inner_class_types
              @inner_class_types = { collection_options: CollectionOptions }
            end

            def self.field_remappings
              @field_remappings = {}
            end
          end

          class AccountUpdate < ::Stripe::StripeObject
            class CollectionOptions < ::Stripe::StripeObject
              # Specifies whether the platform collects only currently_due requirements (`currently_due`) or both currently_due and eventually_due requirements (`eventually_due`). The default value is `currently_due`.
              attr_reader :fields
              # Specifies whether the platform collects future_requirements in addition to requirements in Connect Onboarding. The default value is `omit`.
              attr_reader :future_requirements

              def self.inner_class_types
                @inner_class_types = {}
              end

              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Specifies the requirements that Stripe collects from v2/core/accounts in the Onboarding flow.
            attr_reader :collection_options
            # Open Enum. A v2/account can be configured to enable certain functionality. The configuration param targets the v2/account_link to collect information for the specified v2/account configuration/s.
            attr_reader :configurations
            # The URL the user will be redirected to if the Account Link is expired, has been used, or is otherwise invalid. The URL you specify should attempt to generate a new Account Link with the same parameters used to create the original Account Link, then redirect the user to the new Account Link URL so they can continue the flow. Make sure to authenticate the user before redirecting to the new Account Link, in case the URL leaks to a third party. If a new Account Link can't be generated, or if the redirect fails, you should display a useful error to the user.
            attr_reader :refresh_url
            # The URL that the user will be redirected to upon completing the linked flow.
            attr_reader :return_url

            def self.inner_class_types
              @inner_class_types = { collection_options: CollectionOptions }
            end

            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Open Enum. The type of Account Link the user is requesting.
          attr_reader :type
          # Hash containing configuration options for an Account Link object that onboards a new account.
          attr_reader :account_onboarding
          # Hash containing configuration options for an Account Link that updates an existing account.
          attr_reader :account_update

          def self.inner_class_types
            @inner_class_types = {
              account_onboarding: AccountOnboarding,
              account_update: AccountUpdate,
            }
          end

          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The ID of the connected account this Account Link applies to.
        attr_reader :account
        # The timestamp at which this Account Link was created.
        attr_reader :created
        # The timestamp at which this Account Link will expire.
        attr_reader :expires_at
        # String representing the object's type. Objects of the same type share the same value of the object field.
        attr_reader :object
        # The URL at which the account can access the Stripe-hosted flow.
        attr_reader :url
        # Hash containing usage options.
        attr_reader :use_case
        # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        attr_reader :livemode

        def self.inner_class_types
          @inner_class_types = { use_case: UseCase }
        end

        def self.field_remappings
          @field_remappings = {}
        end
      end
    end
  end
end
