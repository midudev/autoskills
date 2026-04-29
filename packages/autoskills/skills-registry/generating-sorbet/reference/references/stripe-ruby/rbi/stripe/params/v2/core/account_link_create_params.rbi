# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      class AccountLinkCreateParams < ::Stripe::RequestParams
        class UseCase < ::Stripe::RequestParams
          class AccountOnboarding < ::Stripe::RequestParams
            class CollectionOptions < ::Stripe::RequestParams
              # Specifies whether the platform collects only currently_due requirements (`currently_due`) or both currently_due and eventually_due requirements (`eventually_due`). If you don’t specify collection_options, the default value is currently_due.
              sig { returns(T.nilable(String)) }
              def fields; end
              sig { params(_fields: T.nilable(String)).returns(T.nilable(String)) }
              def fields=(_fields); end
              # Specifies whether the platform collects future_requirements in addition to requirements in Connect Onboarding. The default value is `omit`.
              sig { returns(T.nilable(String)) }
              def future_requirements; end
              sig { params(_future_requirements: T.nilable(String)).returns(T.nilable(String)) }
              def future_requirements=(_future_requirements); end
              sig { params(fields: T.nilable(String), future_requirements: T.nilable(String)).void }
              def initialize(fields: nil, future_requirements: nil); end
            end
            # Specifies the requirements that Stripe collects from v2/core/accounts in the Onboarding flow.
            sig {
              returns(T.nilable(V2::Core::AccountLinkCreateParams::UseCase::AccountOnboarding::CollectionOptions))
             }
            def collection_options; end
            sig {
              params(_collection_options: T.nilable(V2::Core::AccountLinkCreateParams::UseCase::AccountOnboarding::CollectionOptions)).returns(T.nilable(V2::Core::AccountLinkCreateParams::UseCase::AccountOnboarding::CollectionOptions))
             }
            def collection_options=(_collection_options); end
            # Open Enum. A v2/core/account can be configured to enable certain functionality. The configuration param targets the v2/core/account_link to collect information for the specified v2/core/account configuration/s.
            sig { returns(T::Array[String]) }
            def configurations; end
            sig { params(_configurations: T::Array[String]).returns(T::Array[String]) }
            def configurations=(_configurations); end
            # The URL the user will be redirected to if the AccountLink is expired, has been used, or is otherwise invalid. The URL you specify should attempt to generate a new AccountLink with the same parameters used to create the original AccountLink, then redirect the user to the new AccountLink’s URL so they can continue the flow. If a new AccountLink cannot be generated or the redirect fails you should display a useful error to the user. Please make sure to implement authentication before redirecting the user in case this URL is leaked to a third party.
            sig { returns(String) }
            def refresh_url; end
            sig { params(_refresh_url: String).returns(String) }
            def refresh_url=(_refresh_url); end
            # The URL that the user will be redirected to upon completing the linked flow.
            sig { returns(T.nilable(String)) }
            def return_url; end
            sig { params(_return_url: T.nilable(String)).returns(T.nilable(String)) }
            def return_url=(_return_url); end
            sig {
              params(collection_options: T.nilable(V2::Core::AccountLinkCreateParams::UseCase::AccountOnboarding::CollectionOptions), configurations: T::Array[String], refresh_url: String, return_url: T.nilable(String)).void
             }
            def initialize(
              collection_options: nil,
              configurations: nil,
              refresh_url: nil,
              return_url: nil
            ); end
          end
          class AccountUpdate < ::Stripe::RequestParams
            class CollectionOptions < ::Stripe::RequestParams
              # Specifies whether the platform collects only currently_due requirements (`currently_due`) or both currently_due and eventually_due requirements (`eventually_due`). The default value is `currently_due`.
              sig { returns(T.nilable(String)) }
              def fields; end
              sig { params(_fields: T.nilable(String)).returns(T.nilable(String)) }
              def fields=(_fields); end
              # Specifies whether the platform collects future_requirements in addition to requirements in Connect Onboarding. The default value is `omit`.
              sig { returns(T.nilable(String)) }
              def future_requirements; end
              sig { params(_future_requirements: T.nilable(String)).returns(T.nilable(String)) }
              def future_requirements=(_future_requirements); end
              sig { params(fields: T.nilable(String), future_requirements: T.nilable(String)).void }
              def initialize(fields: nil, future_requirements: nil); end
            end
            # Specifies the requirements that Stripe collects from v2/core/accounts in the Onboarding flow.
            sig {
              returns(T.nilable(V2::Core::AccountLinkCreateParams::UseCase::AccountUpdate::CollectionOptions))
             }
            def collection_options; end
            sig {
              params(_collection_options: T.nilable(V2::Core::AccountLinkCreateParams::UseCase::AccountUpdate::CollectionOptions)).returns(T.nilable(V2::Core::AccountLinkCreateParams::UseCase::AccountUpdate::CollectionOptions))
             }
            def collection_options=(_collection_options); end
            # Open Enum. A v2/account can be configured to enable certain functionality. The configuration param targets the v2/account_link to collect information for the specified v2/account configuration/s.
            sig { returns(T::Array[String]) }
            def configurations; end
            sig { params(_configurations: T::Array[String]).returns(T::Array[String]) }
            def configurations=(_configurations); end
            # The URL the user will be redirected to if the Account Link is expired, has been used, or is otherwise invalid. The URL you specify should attempt to generate a new Account Link with the same parameters used to create the original Account Link, then redirect the user to the new Account Link URL so they can continue the flow. Make sure to authenticate the user before redirecting to the new Account Link, in case the URL leaks to a third party. If a new Account Link can't be generated, or if the redirect fails, you should display a useful error to the user.
            sig { returns(String) }
            def refresh_url; end
            sig { params(_refresh_url: String).returns(String) }
            def refresh_url=(_refresh_url); end
            # The URL that the user will be redirected to upon completing the linked flow.
            sig { returns(T.nilable(String)) }
            def return_url; end
            sig { params(_return_url: T.nilable(String)).returns(T.nilable(String)) }
            def return_url=(_return_url); end
            sig {
              params(collection_options: T.nilable(V2::Core::AccountLinkCreateParams::UseCase::AccountUpdate::CollectionOptions), configurations: T::Array[String], refresh_url: String, return_url: T.nilable(String)).void
             }
            def initialize(
              collection_options: nil,
              configurations: nil,
              refresh_url: nil,
              return_url: nil
            ); end
          end
          # Open Enum. The type of Account Link the user is requesting.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          # Hash containing configuration options for an Account Link object that onboards a new account.
          sig { returns(T.nilable(V2::Core::AccountLinkCreateParams::UseCase::AccountOnboarding)) }
          def account_onboarding; end
          sig {
            params(_account_onboarding: T.nilable(V2::Core::AccountLinkCreateParams::UseCase::AccountOnboarding)).returns(T.nilable(V2::Core::AccountLinkCreateParams::UseCase::AccountOnboarding))
           }
          def account_onboarding=(_account_onboarding); end
          # Hash containing configuration options for an Account Link that updates an existing account.
          sig { returns(T.nilable(V2::Core::AccountLinkCreateParams::UseCase::AccountUpdate)) }
          def account_update; end
          sig {
            params(_account_update: T.nilable(V2::Core::AccountLinkCreateParams::UseCase::AccountUpdate)).returns(T.nilable(V2::Core::AccountLinkCreateParams::UseCase::AccountUpdate))
           }
          def account_update=(_account_update); end
          sig {
            params(type: String, account_onboarding: T.nilable(V2::Core::AccountLinkCreateParams::UseCase::AccountOnboarding), account_update: T.nilable(V2::Core::AccountLinkCreateParams::UseCase::AccountUpdate)).void
           }
          def initialize(type: nil, account_onboarding: nil, account_update: nil); end
        end
        # The ID of the Account to create link for.
        sig { returns(String) }
        def account; end
        sig { params(_account: String).returns(String) }
        def account=(_account); end
        # The use case of the AccountLink.
        sig { returns(V2::Core::AccountLinkCreateParams::UseCase) }
        def use_case; end
        sig {
          params(_use_case: V2::Core::AccountLinkCreateParams::UseCase).returns(V2::Core::AccountLinkCreateParams::UseCase)
         }
        def use_case=(_use_case); end
        sig { params(account: String, use_case: V2::Core::AccountLinkCreateParams::UseCase).void }
        def initialize(account: nil, use_case: nil); end
      end
    end
  end
end