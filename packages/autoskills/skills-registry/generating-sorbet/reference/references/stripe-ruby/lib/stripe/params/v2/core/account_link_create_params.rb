# File generated from our OpenAPI spec
# frozen_string_literal: true

module Stripe
  module V2
    module Core
      class AccountLinkCreateParams < ::Stripe::RequestParams
        class UseCase < ::Stripe::RequestParams
          class AccountOnboarding < ::Stripe::RequestParams
            class CollectionOptions < ::Stripe::RequestParams
              # Specifies whether the platform collects only currently_due requirements (`currently_due`) or both currently_due and eventually_due requirements (`eventually_due`). If you don’t specify collection_options, the default value is currently_due.
              attr_accessor :fields
              # Specifies whether the platform collects future_requirements in addition to requirements in Connect Onboarding. The default value is `omit`.
              attr_accessor :future_requirements

              def initialize(fields: nil, future_requirements: nil)
                @fields = fields
                @future_requirements = future_requirements
              end
            end
            # Specifies the requirements that Stripe collects from v2/core/accounts in the Onboarding flow.
            attr_accessor :collection_options
            # Open Enum. A v2/core/account can be configured to enable certain functionality. The configuration param targets the v2/core/account_link to collect information for the specified v2/core/account configuration/s.
            attr_accessor :configurations
            # The URL the user will be redirected to if the AccountLink is expired, has been used, or is otherwise invalid. The URL you specify should attempt to generate a new AccountLink with the same parameters used to create the original AccountLink, then redirect the user to the new AccountLink’s URL so they can continue the flow. If a new AccountLink cannot be generated or the redirect fails you should display a useful error to the user. Please make sure to implement authentication before redirecting the user in case this URL is leaked to a third party.
            attr_accessor :refresh_url
            # The URL that the user will be redirected to upon completing the linked flow.
            attr_accessor :return_url

            def initialize(
              collection_options: nil,
              configurations: nil,
              refresh_url: nil,
              return_url: nil
            )
              @collection_options = collection_options
              @configurations = configurations
              @refresh_url = refresh_url
              @return_url = return_url
            end
          end

          class AccountUpdate < ::Stripe::RequestParams
            class CollectionOptions < ::Stripe::RequestParams
              # Specifies whether the platform collects only currently_due requirements (`currently_due`) or both currently_due and eventually_due requirements (`eventually_due`). The default value is `currently_due`.
              attr_accessor :fields
              # Specifies whether the platform collects future_requirements in addition to requirements in Connect Onboarding. The default value is `omit`.
              attr_accessor :future_requirements

              def initialize(fields: nil, future_requirements: nil)
                @fields = fields
                @future_requirements = future_requirements
              end
            end
            # Specifies the requirements that Stripe collects from v2/core/accounts in the Onboarding flow.
            attr_accessor :collection_options
            # Open Enum. A v2/account can be configured to enable certain functionality. The configuration param targets the v2/account_link to collect information for the specified v2/account configuration/s.
            attr_accessor :configurations
            # The URL the user will be redirected to if the Account Link is expired, has been used, or is otherwise invalid. The URL you specify should attempt to generate a new Account Link with the same parameters used to create the original Account Link, then redirect the user to the new Account Link URL so they can continue the flow. Make sure to authenticate the user before redirecting to the new Account Link, in case the URL leaks to a third party. If a new Account Link can't be generated, or if the redirect fails, you should display a useful error to the user.
            attr_accessor :refresh_url
            # The URL that the user will be redirected to upon completing the linked flow.
            attr_accessor :return_url

            def initialize(
              collection_options: nil,
              configurations: nil,
              refresh_url: nil,
              return_url: nil
            )
              @collection_options = collection_options
              @configurations = configurations
              @refresh_url = refresh_url
              @return_url = return_url
            end
          end
          # Open Enum. The type of Account Link the user is requesting.
          attr_accessor :type
          # Hash containing configuration options for an Account Link object that onboards a new account.
          attr_accessor :account_onboarding
          # Hash containing configuration options for an Account Link that updates an existing account.
          attr_accessor :account_update

          def initialize(type: nil, account_onboarding: nil, account_update: nil)
            @type = type
            @account_onboarding = account_onboarding
            @account_update = account_update
          end
        end
        # The ID of the Account to create link for.
        attr_accessor :account
        # The use case of the AccountLink.
        attr_accessor :use_case

        def initialize(account: nil, use_case: nil)
          @account = account
          @use_case = use_case
        end
      end
    end
  end
end
