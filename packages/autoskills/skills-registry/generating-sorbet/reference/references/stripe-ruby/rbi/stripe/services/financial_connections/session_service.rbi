# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module FinancialConnections
    class SessionService < StripeService
      # To launch the Financial Connections authorization flow, create a Session. The session's client_secret can be used to launch the flow using Stripe.js.
      sig {
        params(params: T.any(::Stripe::FinancialConnections::SessionCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FinancialConnections::Session)
       }
      def create(params = {}, opts = {}); end

      # Retrieves the details of a Financial Connections Session
      sig {
        params(session: String, params: T.any(::Stripe::FinancialConnections::SessionRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FinancialConnections::Session)
       }
      def retrieve(session, params = {}, opts = {}); end
    end
  end
end