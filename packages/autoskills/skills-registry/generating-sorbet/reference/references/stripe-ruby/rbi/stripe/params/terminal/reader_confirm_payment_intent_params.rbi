# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    class ReaderConfirmPaymentIntentParams < ::Stripe::RequestParams
      class ConfirmConfig < ::Stripe::RequestParams
        # The URL to redirect your customer back to after they authenticate or cancel their payment on the payment method's app or site. If you'd prefer to redirect to a mobile application, you can alternatively supply an application URI scheme.
        sig { returns(T.nilable(String)) }
        def return_url; end
        sig { params(_return_url: T.nilable(String)).returns(T.nilable(String)) }
        def return_url=(_return_url); end
        sig { params(return_url: T.nilable(String)).void }
        def initialize(return_url: nil); end
      end
      # Configuration overrides for this confirmation, such as surcharge settings and return URL.
      sig { returns(T.nilable(Terminal::ReaderConfirmPaymentIntentParams::ConfirmConfig)) }
      def confirm_config; end
      sig {
        params(_confirm_config: T.nilable(Terminal::ReaderConfirmPaymentIntentParams::ConfirmConfig)).returns(T.nilable(Terminal::ReaderConfirmPaymentIntentParams::ConfirmConfig))
       }
      def confirm_config=(_confirm_config); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # The ID of the PaymentIntent to confirm.
      sig { returns(String) }
      def payment_intent; end
      sig { params(_payment_intent: String).returns(String) }
      def payment_intent=(_payment_intent); end
      sig {
        params(confirm_config: T.nilable(Terminal::ReaderConfirmPaymentIntentParams::ConfirmConfig), expand: T.nilable(T::Array[String]), payment_intent: String).void
       }
      def initialize(confirm_config: nil, expand: nil, payment_intent: nil); end
    end
  end
end