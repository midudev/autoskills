# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Apps
    class SecretCreateParams < ::Stripe::RequestParams
      class Scope < ::Stripe::RequestParams
        # The secret scope type.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        # The user ID. This field is required if `type` is set to `user`, and should not be provided if `type` is set to `account`.
        sig { returns(T.nilable(String)) }
        def user; end
        sig { params(_user: T.nilable(String)).returns(T.nilable(String)) }
        def user=(_user); end
        sig { params(type: String, user: T.nilable(String)).void }
        def initialize(type: nil, user: nil); end
      end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # The Unix timestamp for the expiry time of the secret, after which the secret deletes.
      sig { returns(T.nilable(Integer)) }
      def expires_at; end
      sig { params(_expires_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def expires_at=(_expires_at); end
      # A name for the secret that's unique within the scope.
      sig { returns(String) }
      def name; end
      sig { params(_name: String).returns(String) }
      def name=(_name); end
      # The plaintext secret value to be stored.
      sig { returns(String) }
      def payload; end
      sig { params(_payload: String).returns(String) }
      def payload=(_payload); end
      # Specifies the scoping of the secret. Requests originating from UI extensions can only access account-scoped secrets or secrets scoped to their own user.
      sig { returns(Apps::SecretCreateParams::Scope) }
      def scope; end
      sig {
        params(_scope: Apps::SecretCreateParams::Scope).returns(Apps::SecretCreateParams::Scope)
       }
      def scope=(_scope); end
      sig {
        params(expand: T.nilable(T::Array[String]), expires_at: T.nilable(Integer), name: String, payload: String, scope: Apps::SecretCreateParams::Scope).void
       }
      def initialize(expand: nil, expires_at: nil, name: nil, payload: nil, scope: nil); end
    end
  end
end