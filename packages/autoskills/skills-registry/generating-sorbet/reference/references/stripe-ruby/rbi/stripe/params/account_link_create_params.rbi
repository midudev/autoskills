# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class AccountLinkCreateParams < ::Stripe::RequestParams
    class CollectionOptions < ::Stripe::RequestParams
      # Specifies whether the platform collects only currently_due requirements (`currently_due`) or both currently_due and eventually_due requirements (`eventually_due`). If you don't specify `collection_options`, the default value is `currently_due`.
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
    # The identifier of the account to create an account link for.
    sig { returns(String) }
    def account; end
    sig { params(_account: String).returns(String) }
    def account=(_account); end
    # The collect parameter is deprecated. Use `collection_options` instead.
    sig { returns(T.nilable(String)) }
    def collect; end
    sig { params(_collect: T.nilable(String)).returns(T.nilable(String)) }
    def collect=(_collect); end
    # Specifies the requirements that Stripe collects from connected accounts in the Connect Onboarding flow.
    sig { returns(T.nilable(AccountLinkCreateParams::CollectionOptions)) }
    def collection_options; end
    sig {
      params(_collection_options: T.nilable(AccountLinkCreateParams::CollectionOptions)).returns(T.nilable(AccountLinkCreateParams::CollectionOptions))
     }
    def collection_options=(_collection_options); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # The URL the user will be redirected to if the account link is expired, has been previously-visited, or is otherwise invalid. The URL you specify should attempt to generate a new account link with the same parameters used to create the original account link, then redirect the user to the new account link's URL so they can continue with Connect Onboarding. If a new account link cannot be generated or the redirect fails you should display a useful error to the user.
    sig { returns(T.nilable(String)) }
    def refresh_url; end
    sig { params(_refresh_url: T.nilable(String)).returns(T.nilable(String)) }
    def refresh_url=(_refresh_url); end
    # The URL that the user will be redirected to upon leaving or completing the linked flow.
    sig { returns(T.nilable(String)) }
    def return_url; end
    sig { params(_return_url: T.nilable(String)).returns(T.nilable(String)) }
    def return_url=(_return_url); end
    # The type of account link the user is requesting.
    #
    # You can create Account Links of type `account_update` only for connected accounts where your platform is responsible for collecting requirements, including Custom accounts. You can't create them for accounts that have access to a Stripe-hosted Dashboard. If you use [Connect embedded components](/connect/get-started-connect-embedded-components), you can include components that allow your connected accounts to update their own information. For an account without Stripe-hosted Dashboard access where Stripe is liable for negative balances, you must use embedded components.
    sig { returns(String) }
    def type; end
    sig { params(_type: String).returns(String) }
    def type=(_type); end
    sig {
      params(account: String, collect: T.nilable(String), collection_options: T.nilable(AccountLinkCreateParams::CollectionOptions), expand: T.nilable(T::Array[String]), refresh_url: T.nilable(String), return_url: T.nilable(String), type: String).void
     }
    def initialize(
      account: nil,
      collect: nil,
      collection_options: nil,
      expand: nil,
      refresh_url: nil,
      return_url: nil,
      type: nil
    ); end
  end
end