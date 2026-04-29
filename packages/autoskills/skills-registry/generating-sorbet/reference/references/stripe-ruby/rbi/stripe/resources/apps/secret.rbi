# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Apps
    # Secret Store is an API that allows Stripe Apps developers to securely persist secrets for use by UI Extensions and app backends.
    #
    # The primary resource in Secret Store is a `secret`. Other apps can't view secrets created by an app. Additionally, secrets are scoped to provide further permission control.
    #
    # All Dashboard users and the app backend share `account` scoped secrets. Use the `account` scope for secrets that don't change per-user, like a third-party API key.
    #
    # A `user` scoped secret is accessible by the app backend and one specific Dashboard user. Use the `user` scope for per-user secrets like per-user OAuth tokens, where different users might have different permissions.
    #
    # Related guide: [Store data between page reloads](https://docs.stripe.com/stripe-apps/store-auth-data-custom-objects)
    class Secret < APIResource
      class Scope < ::Stripe::StripeObject
        # The secret scope type.
        sig { returns(String) }
        def type; end
        # The user ID, if type is set to "user"
        sig { returns(T.nilable(String)) }
        def user; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # If true, indicates that this secret has been deleted
      sig { returns(T.nilable(T::Boolean)) }
      def deleted; end
      # The Unix timestamp for the expiry time of the secret, after which the secret deletes.
      sig { returns(T.nilable(Integer)) }
      def expires_at; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # A name for the secret that's unique within the scope.
      sig { returns(String) }
      def name; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The plaintext secret value to be stored.
      sig { returns(T.nilable(String)) }
      def payload; end
      # Attribute for field scope
      sig { returns(Scope) }
      def scope; end
      # Create or replace a secret in the secret store.
      sig {
        params(params: T.any(::Stripe::Apps::SecretCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Apps::Secret)
       }
      def self.create(params = {}, opts = {}); end

      # Deletes a secret from the secret store by name and scope.
      sig {
        params(params: T.any(::Stripe::Apps::SecretDeleteWhereParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Apps::Secret)
       }
      def self.delete_where(params = {}, opts = {}); end

      # Finds a secret in the secret store by name and scope.
      sig {
        params(params: T.any(::Stripe::Apps::SecretFindParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Apps::Secret)
       }
      def self.find(params = {}, opts = {}); end

      # List all secrets stored on the given scope.
      sig {
        params(params: T.any(::Stripe::Apps::SecretListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end