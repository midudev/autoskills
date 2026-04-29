# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class ReceivedCreditListParams < ::Stripe::RequestParams
      class LinkedFlows < ::Stripe::RequestParams
        # The source flow type.
        sig { returns(String) }
        def source_flow_type; end
        sig { params(_source_flow_type: String).returns(String) }
        def source_flow_type=(_source_flow_type); end
        sig { params(source_flow_type: String).void }
        def initialize(source_flow_type: nil); end
      end
      # A cursor for use in pagination. `ending_before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with `obj_bar`, your subsequent call can include `ending_before=obj_bar` in order to fetch the previous page of the list.
      sig { returns(T.nilable(String)) }
      def ending_before; end
      sig { params(_ending_before: T.nilable(String)).returns(T.nilable(String)) }
      def ending_before=(_ending_before); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # The FinancialAccount that received the funds.
      sig { returns(String) }
      def financial_account; end
      sig { params(_financial_account: String).returns(String) }
      def financial_account=(_financial_account); end
      # A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
      sig { returns(T.nilable(Integer)) }
      def limit; end
      sig { params(_limit: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def limit=(_limit); end
      # Only return ReceivedCredits described by the flow.
      sig { returns(T.nilable(Treasury::ReceivedCreditListParams::LinkedFlows)) }
      def linked_flows; end
      sig {
        params(_linked_flows: T.nilable(Treasury::ReceivedCreditListParams::LinkedFlows)).returns(T.nilable(Treasury::ReceivedCreditListParams::LinkedFlows))
       }
      def linked_flows=(_linked_flows); end
      # A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
      sig { returns(T.nilable(String)) }
      def starting_after; end
      sig { params(_starting_after: T.nilable(String)).returns(T.nilable(String)) }
      def starting_after=(_starting_after); end
      # Only return ReceivedCredits that have the given status: `succeeded` or `failed`.
      sig { returns(T.nilable(String)) }
      def status; end
      sig { params(_status: T.nilable(String)).returns(T.nilable(String)) }
      def status=(_status); end
      sig {
        params(ending_before: T.nilable(String), expand: T.nilable(T::Array[String]), financial_account: String, limit: T.nilable(Integer), linked_flows: T.nilable(Treasury::ReceivedCreditListParams::LinkedFlows), starting_after: T.nilable(String), status: T.nilable(String)).void
       }
      def initialize(
        ending_before: nil,
        expand: nil,
        financial_account: nil,
        limit: nil,
        linked_flows: nil,
        starting_after: nil,
        status: nil
      ); end
    end
  end
end