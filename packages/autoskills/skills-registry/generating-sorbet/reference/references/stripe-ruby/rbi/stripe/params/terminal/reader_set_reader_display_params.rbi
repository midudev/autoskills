# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    class ReaderSetReaderDisplayParams < ::Stripe::RequestParams
      class Cart < ::Stripe::RequestParams
        class LineItem < ::Stripe::RequestParams
          # The price of the item in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
          sig { returns(Integer) }
          def amount; end
          sig { params(_amount: Integer).returns(Integer) }
          def amount=(_amount); end
          # The description or name of the item.
          sig { returns(String) }
          def description; end
          sig { params(_description: String).returns(String) }
          def description=(_description); end
          # The quantity of the line item being purchased.
          sig { returns(Integer) }
          def quantity; end
          sig { params(_quantity: Integer).returns(Integer) }
          def quantity=(_quantity); end
          sig { params(amount: Integer, description: String, quantity: Integer).void }
          def initialize(amount: nil, description: nil, quantity: nil); end
        end
        # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
        sig { returns(String) }
        def currency; end
        sig { params(_currency: String).returns(String) }
        def currency=(_currency); end
        # Array of line items to display.
        sig { returns(T::Array[Terminal::ReaderSetReaderDisplayParams::Cart::LineItem]) }
        def line_items; end
        sig {
          params(_line_items: T::Array[Terminal::ReaderSetReaderDisplayParams::Cart::LineItem]).returns(T::Array[Terminal::ReaderSetReaderDisplayParams::Cart::LineItem])
         }
        def line_items=(_line_items); end
        # The amount of tax in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
        sig { returns(T.nilable(Integer)) }
        def tax; end
        sig { params(_tax: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def tax=(_tax); end
        # Total balance of cart due in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
        sig { returns(Integer) }
        def total; end
        sig { params(_total: Integer).returns(Integer) }
        def total=(_total); end
        sig {
          params(currency: String, line_items: T::Array[Terminal::ReaderSetReaderDisplayParams::Cart::LineItem], tax: T.nilable(Integer), total: Integer).void
         }
        def initialize(currency: nil, line_items: nil, tax: nil, total: nil); end
      end
      # Cart details to display on the reader screen, including line items, amounts, and currency.
      sig { returns(T.nilable(Terminal::ReaderSetReaderDisplayParams::Cart)) }
      def cart; end
      sig {
        params(_cart: T.nilable(Terminal::ReaderSetReaderDisplayParams::Cart)).returns(T.nilable(Terminal::ReaderSetReaderDisplayParams::Cart))
       }
      def cart=(_cart); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Type of information to display. Only `cart` is currently supported.
      sig { returns(String) }
      def type; end
      sig { params(_type: String).returns(String) }
      def type=(_type); end
      sig {
        params(cart: T.nilable(Terminal::ReaderSetReaderDisplayParams::Cart), expand: T.nilable(T::Array[String]), type: String).void
       }
      def initialize(cart: nil, expand: nil, type: nil); end
    end
  end
end