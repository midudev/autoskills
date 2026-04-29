# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Apps
    class SecretFindParams < ::Stripe::RequestParams
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
      # A name for the secret that's unique within the scope.
      sig { returns(String) }
      def name; end
      sig { params(_name: String).returns(String) }
      def name=(_name); end
      # Specifies the scoping of the secret. Requests originating from UI extensions can only access account-scoped secrets or secrets scoped to their own user.
      sig { returns(Apps::SecretFindParams::Scope) }
      def scope; end
      sig { params(_scope: Apps::SecretFindParams::Scope).returns(Apps::SecretFindParams::Scope) }
      def scope=(_scope); end
      sig {
        params(expand: T.nilable(T::Array[String]), name: String, scope: Apps::SecretFindParams::Scope).void
       }
      def initialize(expand: nil, name: nil, scope: nil); end
    end
  end
end