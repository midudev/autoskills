# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module FinancialConnections
    # Describes an owner of an account.
    class AccountOwner < StripeObject
      # The email address of the owner.
      sig { returns(T.nilable(String)) }
      def email; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # The full name of the owner.
      sig { returns(String) }
      def name; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The ownership object that this owner belongs to.
      sig { returns(String) }
      def ownership; end
      # The raw phone number of the owner.
      sig { returns(T.nilable(String)) }
      def phone; end
      # The raw physical address of the owner.
      sig { returns(T.nilable(String)) }
      def raw_address; end
      # The timestamp of the refresh that updated this owner.
      sig { returns(T.nilable(Integer)) }
      def refreshed_at; end
    end
  end
end