# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SourceUpdateParams < ::Stripe::RequestParams
    class Mandate < ::Stripe::RequestParams
      class Acceptance < ::Stripe::RequestParams
        class Offline < ::Stripe::RequestParams
          # An email to contact you with if a copy of the mandate is requested, required if `type` is `offline`.
          sig { returns(String) }
          def contact_email; end
          sig { params(_contact_email: String).returns(String) }
          def contact_email=(_contact_email); end
          sig { params(contact_email: String).void }
          def initialize(contact_email: nil); end
        end
        class Online < ::Stripe::RequestParams
          # The Unix timestamp (in seconds) when the mandate was accepted or refused by the customer.
          sig { returns(T.nilable(Integer)) }
          def date; end
          sig { params(_date: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def date=(_date); end
          # The IP address from which the mandate was accepted or refused by the customer.
          sig { returns(T.nilable(String)) }
          def ip; end
          sig { params(_ip: T.nilable(String)).returns(T.nilable(String)) }
          def ip=(_ip); end
          # The user agent of the browser from which the mandate was accepted or refused by the customer.
          sig { returns(T.nilable(String)) }
          def user_agent; end
          sig { params(_user_agent: T.nilable(String)).returns(T.nilable(String)) }
          def user_agent=(_user_agent); end
          sig {
            params(date: T.nilable(Integer), ip: T.nilable(String), user_agent: T.nilable(String)).void
           }
          def initialize(date: nil, ip: nil, user_agent: nil); end
        end
        # The Unix timestamp (in seconds) when the mandate was accepted or refused by the customer.
        sig { returns(T.nilable(Integer)) }
        def date; end
        sig { params(_date: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def date=(_date); end
        # The IP address from which the mandate was accepted or refused by the customer.
        sig { returns(T.nilable(String)) }
        def ip; end
        sig { params(_ip: T.nilable(String)).returns(T.nilable(String)) }
        def ip=(_ip); end
        # The parameters required to store a mandate accepted offline. Should only be set if `mandate[type]` is `offline`
        sig { returns(T.nilable(SourceUpdateParams::Mandate::Acceptance::Offline)) }
        def offline; end
        sig {
          params(_offline: T.nilable(SourceUpdateParams::Mandate::Acceptance::Offline)).returns(T.nilable(SourceUpdateParams::Mandate::Acceptance::Offline))
         }
        def offline=(_offline); end
        # The parameters required to store a mandate accepted online. Should only be set if `mandate[type]` is `online`
        sig { returns(T.nilable(SourceUpdateParams::Mandate::Acceptance::Online)) }
        def online; end
        sig {
          params(_online: T.nilable(SourceUpdateParams::Mandate::Acceptance::Online)).returns(T.nilable(SourceUpdateParams::Mandate::Acceptance::Online))
         }
        def online=(_online); end
        # The status of the mandate acceptance. Either `accepted` (the mandate was accepted) or `refused` (the mandate was refused).
        sig { returns(String) }
        def status; end
        sig { params(_status: String).returns(String) }
        def status=(_status); end
        # The type of acceptance information included with the mandate. Either `online` or `offline`
        sig { returns(T.nilable(String)) }
        def type; end
        sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
        def type=(_type); end
        # The user agent of the browser from which the mandate was accepted or refused by the customer.
        sig { returns(T.nilable(String)) }
        def user_agent; end
        sig { params(_user_agent: T.nilable(String)).returns(T.nilable(String)) }
        def user_agent=(_user_agent); end
        sig {
          params(date: T.nilable(Integer), ip: T.nilable(String), offline: T.nilable(SourceUpdateParams::Mandate::Acceptance::Offline), online: T.nilable(SourceUpdateParams::Mandate::Acceptance::Online), status: String, type: T.nilable(String), user_agent: T.nilable(String)).void
         }
        def initialize(
          date: nil,
          ip: nil,
          offline: nil,
          online: nil,
          status: nil,
          type: nil,
          user_agent: nil
        ); end
      end
      # The parameters required to notify Stripe of a mandate acceptance or refusal by the customer.
      sig { returns(T.nilable(SourceUpdateParams::Mandate::Acceptance)) }
      def acceptance; end
      sig {
        params(_acceptance: T.nilable(SourceUpdateParams::Mandate::Acceptance)).returns(T.nilable(SourceUpdateParams::Mandate::Acceptance))
       }
      def acceptance=(_acceptance); end
      # The amount specified by the mandate. (Leave null for a mandate covering all amounts)
      sig { returns(T.nilable(T.any(String, Integer))) }
      def amount; end
      sig {
        params(_amount: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
       }
      def amount=(_amount); end
      # The currency specified by the mandate. (Must match `currency` of the source)
      sig { returns(T.nilable(String)) }
      def currency; end
      sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
      def currency=(_currency); end
      # The interval of debits permitted by the mandate. Either `one_time` (just permitting a single debit), `scheduled` (with debits on an agreed schedule or for clearly-defined events), or `variable`(for debits with any frequency)
      sig { returns(T.nilable(String)) }
      def interval; end
      sig { params(_interval: T.nilable(String)).returns(T.nilable(String)) }
      def interval=(_interval); end
      # The method Stripe should use to notify the customer of upcoming debit instructions and/or mandate confirmation as required by the underlying debit network. Either `email` (an email is sent directly to the customer), `manual` (a `source.mandate_notification` event is sent to your webhooks endpoint and you should handle the notification) or `none` (the underlying debit network does not require any notification).
      sig { returns(T.nilable(String)) }
      def notification_method; end
      sig { params(_notification_method: T.nilable(String)).returns(T.nilable(String)) }
      def notification_method=(_notification_method); end
      sig {
        params(acceptance: T.nilable(SourceUpdateParams::Mandate::Acceptance), amount: T.nilable(T.any(String, Integer)), currency: T.nilable(String), interval: T.nilable(String), notification_method: T.nilable(String)).void
       }
      def initialize(
        acceptance: nil,
        amount: nil,
        currency: nil,
        interval: nil,
        notification_method: nil
      ); end
    end
    class Owner < ::Stripe::RequestParams
      class Address < ::Stripe::RequestParams
        # City, district, suburb, town, or village.
        sig { returns(T.nilable(String)) }
        def city; end
        sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
        def city=(_city); end
        # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        sig { returns(T.nilable(String)) }
        def country; end
        sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
        def country=(_country); end
        # Address line 1, such as the street, PO Box, or company name.
        sig { returns(T.nilable(String)) }
        def line1; end
        sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
        def line1=(_line1); end
        # Address line 2, such as the apartment, suite, unit, or building.
        sig { returns(T.nilable(String)) }
        def line2; end
        sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
        def line2=(_line2); end
        # ZIP or postal code.
        sig { returns(T.nilable(String)) }
        def postal_code; end
        sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
        def postal_code=(_postal_code); end
        # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
        sig { returns(T.nilable(String)) }
        def state; end
        sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
        def state=(_state); end
        sig {
          params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String)).void
         }
        def initialize(
          city: nil,
          country: nil,
          line1: nil,
          line2: nil,
          postal_code: nil,
          state: nil
        ); end
      end
      # Owner's address.
      sig { returns(T.nilable(SourceUpdateParams::Owner::Address)) }
      def address; end
      sig {
        params(_address: T.nilable(SourceUpdateParams::Owner::Address)).returns(T.nilable(SourceUpdateParams::Owner::Address))
       }
      def address=(_address); end
      # Owner's email address.
      sig { returns(T.nilable(String)) }
      def email; end
      sig { params(_email: T.nilable(String)).returns(T.nilable(String)) }
      def email=(_email); end
      # Owner's full name.
      sig { returns(T.nilable(String)) }
      def name; end
      sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
      def name=(_name); end
      # Owner's phone number.
      sig { returns(T.nilable(String)) }
      def phone; end
      sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
      def phone=(_phone); end
      sig {
        params(address: T.nilable(SourceUpdateParams::Owner::Address), email: T.nilable(String), name: T.nilable(String), phone: T.nilable(String)).void
       }
      def initialize(address: nil, email: nil, name: nil, phone: nil); end
    end
    class SourceOrder < ::Stripe::RequestParams
      class Item < ::Stripe::RequestParams
        # Attribute for param field amount
        sig { returns(T.nilable(Integer)) }
        def amount; end
        sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def amount=(_amount); end
        # Attribute for param field currency
        sig { returns(T.nilable(String)) }
        def currency; end
        sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
        def currency=(_currency); end
        # Attribute for param field description
        sig { returns(T.nilable(String)) }
        def description; end
        sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
        def description=(_description); end
        # The ID of the SKU being ordered.
        sig { returns(T.nilable(String)) }
        def parent; end
        sig { params(_parent: T.nilable(String)).returns(T.nilable(String)) }
        def parent=(_parent); end
        # The quantity of this order item. When type is `sku`, this is the number of instances of the SKU to be ordered.
        sig { returns(T.nilable(Integer)) }
        def quantity; end
        sig { params(_quantity: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def quantity=(_quantity); end
        # Attribute for param field type
        sig { returns(T.nilable(String)) }
        def type; end
        sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
        def type=(_type); end
        sig {
          params(amount: T.nilable(Integer), currency: T.nilable(String), description: T.nilable(String), parent: T.nilable(String), quantity: T.nilable(Integer), type: T.nilable(String)).void
         }
        def initialize(
          amount: nil,
          currency: nil,
          description: nil,
          parent: nil,
          quantity: nil,
          type: nil
        ); end
      end
      class Shipping < ::Stripe::RequestParams
        class Address < ::Stripe::RequestParams
          # City, district, suburb, town, or village.
          sig { returns(T.nilable(String)) }
          def city; end
          sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
          def city=(_city); end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(T.nilable(String)) }
          def country; end
          sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
          def country=(_country); end
          # Address line 1, such as the street, PO Box, or company name.
          sig { returns(String) }
          def line1; end
          sig { params(_line1: String).returns(String) }
          def line1=(_line1); end
          # Address line 2, such as the apartment, suite, unit, or building.
          sig { returns(T.nilable(String)) }
          def line2; end
          sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
          def line2=(_line2); end
          # ZIP or postal code.
          sig { returns(T.nilable(String)) }
          def postal_code; end
          sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
          def postal_code=(_postal_code); end
          # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
          sig { returns(T.nilable(String)) }
          def state; end
          sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
          def state=(_state); end
          sig {
            params(city: T.nilable(String), country: T.nilable(String), line1: String, line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String)).void
           }
          def initialize(
            city: nil,
            country: nil,
            line1: nil,
            line2: nil,
            postal_code: nil,
            state: nil
          ); end
        end
        # Shipping address.
        sig { returns(SourceUpdateParams::SourceOrder::Shipping::Address) }
        def address; end
        sig {
          params(_address: SourceUpdateParams::SourceOrder::Shipping::Address).returns(SourceUpdateParams::SourceOrder::Shipping::Address)
         }
        def address=(_address); end
        # The delivery service that shipped a physical product, such as Fedex, UPS, USPS, etc.
        sig { returns(T.nilable(String)) }
        def carrier; end
        sig { params(_carrier: T.nilable(String)).returns(T.nilable(String)) }
        def carrier=(_carrier); end
        # Recipient name.
        sig { returns(T.nilable(String)) }
        def name; end
        sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
        def name=(_name); end
        # Recipient phone (including extension).
        sig { returns(T.nilable(String)) }
        def phone; end
        sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
        def phone=(_phone); end
        # The tracking number for a physical product, obtained from the delivery service. If multiple tracking numbers were generated for this purchase, please separate them with commas.
        sig { returns(T.nilable(String)) }
        def tracking_number; end
        sig { params(_tracking_number: T.nilable(String)).returns(T.nilable(String)) }
        def tracking_number=(_tracking_number); end
        sig {
          params(address: SourceUpdateParams::SourceOrder::Shipping::Address, carrier: T.nilable(String), name: T.nilable(String), phone: T.nilable(String), tracking_number: T.nilable(String)).void
         }
        def initialize(address: nil, carrier: nil, name: nil, phone: nil, tracking_number: nil); end
      end
      # List of items constituting the order.
      sig { returns(T.nilable(T::Array[SourceUpdateParams::SourceOrder::Item])) }
      def items; end
      sig {
        params(_items: T.nilable(T::Array[SourceUpdateParams::SourceOrder::Item])).returns(T.nilable(T::Array[SourceUpdateParams::SourceOrder::Item]))
       }
      def items=(_items); end
      # Shipping address for the order. Required if any of the SKUs are for products that have `shippable` set to true.
      sig { returns(T.nilable(SourceUpdateParams::SourceOrder::Shipping)) }
      def shipping; end
      sig {
        params(_shipping: T.nilable(SourceUpdateParams::SourceOrder::Shipping)).returns(T.nilable(SourceUpdateParams::SourceOrder::Shipping))
       }
      def shipping=(_shipping); end
      sig {
        params(items: T.nilable(T::Array[SourceUpdateParams::SourceOrder::Item]), shipping: T.nilable(SourceUpdateParams::SourceOrder::Shipping)).void
       }
      def initialize(items: nil, shipping: nil); end
    end
    # Amount associated with the source.
    sig { returns(T.nilable(Integer)) }
    def amount; end
    sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def amount=(_amount); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Information about a mandate possibility attached to a source object (generally for bank debits) as well as its acceptance status.
    sig { returns(T.nilable(SourceUpdateParams::Mandate)) }
    def mandate; end
    sig {
      params(_mandate: T.nilable(SourceUpdateParams::Mandate)).returns(T.nilable(SourceUpdateParams::Mandate))
     }
    def mandate=(_mandate); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # Information about the owner of the payment instrument that may be used or required by particular source types.
    sig { returns(T.nilable(SourceUpdateParams::Owner)) }
    def owner; end
    sig {
      params(_owner: T.nilable(SourceUpdateParams::Owner)).returns(T.nilable(SourceUpdateParams::Owner))
     }
    def owner=(_owner); end
    # Information about the items and shipping associated with the source. Required for transactional credit (for example Klarna) sources before you can charge it.
    sig { returns(T.nilable(SourceUpdateParams::SourceOrder)) }
    def source_order; end
    sig {
      params(_source_order: T.nilable(SourceUpdateParams::SourceOrder)).returns(T.nilable(SourceUpdateParams::SourceOrder))
     }
    def source_order=(_source_order); end
    sig {
      params(amount: T.nilable(Integer), expand: T.nilable(T::Array[String]), mandate: T.nilable(SourceUpdateParams::Mandate), metadata: T.nilable(T.any(String, T::Hash[String, String])), owner: T.nilable(SourceUpdateParams::Owner), source_order: T.nilable(SourceUpdateParams::SourceOrder)).void
     }
    def initialize(
      amount: nil,
      expand: nil,
      mandate: nil,
      metadata: nil,
      owner: nil,
      source_order: nil
    ); end
  end
end