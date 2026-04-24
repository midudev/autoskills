# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Entitlements
    # A summary of a customer's active entitlements.
    class ActiveEntitlementSummary < APIResource
      # The customer that is entitled to this feature.
      sig { returns(String) }
      def customer; end
      # The list of entitlements this customer has.
      sig { returns(::Stripe::ListObject) }
      def entitlements; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
    end
  end
end