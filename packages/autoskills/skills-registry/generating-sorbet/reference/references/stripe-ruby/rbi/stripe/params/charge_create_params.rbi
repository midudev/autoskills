# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ChargeCreateParams < ::Stripe::RequestParams
    class Destination < ::Stripe::RequestParams
      # ID of an existing, connected Stripe account.
      sig { returns(String) }
      def account; end
      sig { params(_account: String).returns(String) }
      def account=(_account); end
      # The amount to transfer to the destination account without creating an `Application Fee` object. Cannot be combined with the `application_fee` parameter. Must be less than or equal to the charge amount.
      sig { returns(T.nilable(Integer)) }
      def amount; end
      sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def amount=(_amount); end
      sig { params(account: String, amount: T.nilable(Integer)).void }
      def initialize(account: nil, amount: nil); end
    end
    class RadarOptions < ::Stripe::RequestParams
      # A [Radar Session](https://docs.stripe.com/radar/radar-session) is a snapshot of the browser metadata and device details that help Radar make more accurate predictions on your payments.
      sig { returns(T.nilable(String)) }
      def session; end
      sig { params(_session: T.nilable(String)).returns(T.nilable(String)) }
      def session=(_session); end
      sig { params(session: T.nilable(String)).void }
      def initialize(session: nil); end
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
      # Shipping address.
      sig { returns(ChargeCreateParams::Shipping::Address) }
      def address; end
      sig {
        params(_address: ChargeCreateParams::Shipping::Address).returns(ChargeCreateParams::Shipping::Address)
       }
      def address=(_address); end
      # The delivery service that shipped a physical product, such as Fedex, UPS, USPS, etc.
      sig { returns(T.nilable(String)) }
      def carrier; end
      sig { params(_carrier: T.nilable(String)).returns(T.nilable(String)) }
      def carrier=(_carrier); end
      # Recipient name.
      sig { returns(String) }
      def name; end
      sig { params(_name: String).returns(String) }
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
        params(address: ChargeCreateParams::Shipping::Address, carrier: T.nilable(String), name: String, phone: T.nilable(String), tracking_number: T.nilable(String)).void
       }
      def initialize(address: nil, carrier: nil, name: nil, phone: nil, tracking_number: nil); end
    end
    class TransferData < ::Stripe::RequestParams
      # The amount transferred to the destination account, if specified. By default, the entire charge amount is transferred to the destination account.
      sig { returns(T.nilable(Integer)) }
      def amount; end
      sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def amount=(_amount); end
      # ID of an existing, connected Stripe account.
      sig { returns(String) }
      def destination; end
      sig { params(_destination: String).returns(String) }
      def destination=(_destination); end
      sig { params(amount: T.nilable(Integer), destination: String).void }
      def initialize(amount: nil, destination: nil); end
    end
    # Amount intended to be collected by this payment. A positive integer representing how much to charge in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal) (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or [equivalent in charge currency](https://docs.stripe.com/currencies#minimum-and-maximum-charge-amounts). The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99).
    sig { returns(T.nilable(Integer)) }
    def amount; end
    sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def amount=(_amount); end
    # Attribute for param field application_fee
    sig { returns(T.nilable(Integer)) }
    def application_fee; end
    sig { params(_application_fee: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def application_fee=(_application_fee); end
    # A fee in cents (or local equivalent) that will be applied to the charge and transferred to the application owner's Stripe account. The request must be made with an OAuth key or the `Stripe-Account` header in order to take an application fee. For more information, see the application fees [documentation](https://docs.stripe.com/connect/direct-charges#collect-fees).
    sig { returns(T.nilable(Integer)) }
    def application_fee_amount; end
    sig { params(_application_fee_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def application_fee_amount=(_application_fee_amount); end
    # Whether to immediately capture the charge. Defaults to `true`. When `false`, the charge issues an authorization (or pre-authorization), and will need to be [captured](https://api.stripe.com#capture_charge) later. Uncaptured charges expire after a set number of days (7 by default). For more information, see the [authorizing charges and settling later](https://docs.stripe.com/charges/placing-a-hold) documentation.
    sig { returns(T.nilable(T::Boolean)) }
    def capture; end
    sig { params(_capture: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def capture=(_capture); end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(T.nilable(String)) }
    def currency; end
    sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
    def currency=(_currency); end
    # The ID of an existing customer that will be charged in this request.
    sig { returns(T.nilable(String)) }
    def customer; end
    sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
    def customer=(_customer); end
    # An arbitrary string which you can attach to a `Charge` object. It is displayed when in the web interface alongside the charge. Note that if you use Stripe to send automatic email receipts to your customers, your receipt emails will include the `description` of the charge(s) that they are describing.
    sig { returns(T.nilable(String)) }
    def description; end
    sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
    def description=(_description); end
    # Attribute for param field destination
    sig { returns(T.nilable(ChargeCreateParams::Destination)) }
    def destination; end
    sig {
      params(_destination: T.nilable(ChargeCreateParams::Destination)).returns(T.nilable(ChargeCreateParams::Destination))
     }
    def destination=(_destination); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # The Stripe account ID for which these funds are intended. You can specify the business of record as the connected account using the `on_behalf_of` attribute on the charge. For details, see [Creating Separate Charges and Transfers](https://docs.stripe.com/connect/separate-charges-and-transfers#settlement-merchant).
    sig { returns(T.nilable(String)) }
    def on_behalf_of; end
    sig { params(_on_behalf_of: T.nilable(String)).returns(T.nilable(String)) }
    def on_behalf_of=(_on_behalf_of); end
    # Options to configure Radar. See [Radar Session](https://docs.stripe.com/radar/radar-session) for more information.
    sig { returns(T.nilable(ChargeCreateParams::RadarOptions)) }
    def radar_options; end
    sig {
      params(_radar_options: T.nilable(ChargeCreateParams::RadarOptions)).returns(T.nilable(ChargeCreateParams::RadarOptions))
     }
    def radar_options=(_radar_options); end
    # The email address to which this charge's [receipt](https://docs.stripe.com/dashboard/receipts) will be sent. The receipt will not be sent until the charge is paid, and no receipts will be sent for test mode charges. If this charge is for a [Customer](https://docs.stripe.com/api/customers/object), the email address specified here will override the customer's email address. If `receipt_email` is specified for a charge in live mode, a receipt will be sent regardless of your [email settings](https://dashboard.stripe.com/account/emails).
    sig { returns(T.nilable(String)) }
    def receipt_email; end
    sig { params(_receipt_email: T.nilable(String)).returns(T.nilable(String)) }
    def receipt_email=(_receipt_email); end
    # Shipping information for the charge. Helps prevent fraud on charges for physical goods.
    sig { returns(T.nilable(ChargeCreateParams::Shipping)) }
    def shipping; end
    sig {
      params(_shipping: T.nilable(ChargeCreateParams::Shipping)).returns(T.nilable(ChargeCreateParams::Shipping))
     }
    def shipping=(_shipping); end
    # A payment source to be charged. This can be the ID of a [card](https://docs.stripe.com/api#cards) (i.e., credit or debit card), a [bank account](https://docs.stripe.com/api#bank_accounts), a [source](https://docs.stripe.com/api#sources), a [token](https://docs.stripe.com/api#tokens), or a [connected account](https://docs.stripe.com/connect/account-debits#charging-a-connected-account). For certain sources---namely, [cards](https://docs.stripe.com/api#cards), [bank accounts](https://docs.stripe.com/api#bank_accounts), and attached [sources](https://docs.stripe.com/api#sources)---you must also pass the ID of the associated customer.
    sig { returns(T.nilable(String)) }
    def source; end
    sig { params(_source: T.nilable(String)).returns(T.nilable(String)) }
    def source=(_source); end
    # For a non-card charge, text that appears on the customer's statement as the statement descriptor. This value overrides the account's default statement descriptor. For information about requirements, including the 22-character limit, see [the Statement Descriptor docs](https://docs.stripe.com/get-started/account/statement-descriptors).
    #
    # For a card charge, this value is ignored unless you don't specify a `statement_descriptor_suffix`, in which case this value is used as the suffix.
    sig { returns(T.nilable(String)) }
    def statement_descriptor; end
    sig { params(_statement_descriptor: T.nilable(String)).returns(T.nilable(String)) }
    def statement_descriptor=(_statement_descriptor); end
    # Provides information about a card charge. Concatenated to the account's [statement descriptor prefix](https://docs.stripe.com/get-started/account/statement-descriptors#static) to form the complete statement descriptor that appears on the customer's statement. If the account has no prefix value, the suffix is concatenated to the account's statement descriptor.
    sig { returns(T.nilable(String)) }
    def statement_descriptor_suffix; end
    sig { params(_statement_descriptor_suffix: T.nilable(String)).returns(T.nilable(String)) }
    def statement_descriptor_suffix=(_statement_descriptor_suffix); end
    # An optional dictionary including the account to automatically transfer to as part of a destination charge. [See the Connect documentation](https://docs.stripe.com/connect/destination-charges) for details.
    sig { returns(T.nilable(ChargeCreateParams::TransferData)) }
    def transfer_data; end
    sig {
      params(_transfer_data: T.nilable(ChargeCreateParams::TransferData)).returns(T.nilable(ChargeCreateParams::TransferData))
     }
    def transfer_data=(_transfer_data); end
    # A string that identifies this transaction as part of a group. For details, see [Grouping transactions](https://docs.stripe.com/connect/separate-charges-and-transfers#transfer-options).
    sig { returns(T.nilable(String)) }
    def transfer_group; end
    sig { params(_transfer_group: T.nilable(String)).returns(T.nilable(String)) }
    def transfer_group=(_transfer_group); end
    sig {
      params(amount: T.nilable(Integer), application_fee: T.nilable(Integer), application_fee_amount: T.nilable(Integer), capture: T.nilable(T::Boolean), currency: T.nilable(String), customer: T.nilable(String), description: T.nilable(String), destination: T.nilable(ChargeCreateParams::Destination), expand: T.nilable(T::Array[String]), metadata: T.nilable(T.any(String, T::Hash[String, String])), on_behalf_of: T.nilable(String), radar_options: T.nilable(ChargeCreateParams::RadarOptions), receipt_email: T.nilable(String), shipping: T.nilable(ChargeCreateParams::Shipping), source: T.nilable(String), statement_descriptor: T.nilable(String), statement_descriptor_suffix: T.nilable(String), transfer_data: T.nilable(ChargeCreateParams::TransferData), transfer_group: T.nilable(String)).void
     }
    def initialize(
      amount: nil,
      application_fee: nil,
      application_fee_amount: nil,
      capture: nil,
      currency: nil,
      customer: nil,
      description: nil,
      destination: nil,
      expand: nil,
      metadata: nil,
      on_behalf_of: nil,
      radar_options: nil,
      receipt_email: nil,
      shipping: nil,
      source: nil,
      statement_descriptor: nil,
      statement_descriptor_suffix: nil,
      transfer_data: nil,
      transfer_group: nil
    ); end
  end
end