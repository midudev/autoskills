# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      class AccountCreateParams < ::Stripe::RequestParams
        class Configuration < ::Stripe::RequestParams
          class Customer < ::Stripe::RequestParams
            class AutomaticIndirectTax < ::Stripe::RequestParams
              # Describes the customer's tax exemption status, which is `none`, `exempt`, or `reverse`. When set to reverse, invoice and receipt PDFs include the following text: “Reverse charge”.
              sig { returns(T.nilable(String)) }
              def exempt; end
              sig { params(_exempt: T.nilable(String)).returns(T.nilable(String)) }
              def exempt=(_exempt); end
              # A recent IP address of the customer used for tax reporting and tax location inference.
              sig { returns(T.nilable(String)) }
              def ip_address; end
              sig { params(_ip_address: T.nilable(String)).returns(T.nilable(String)) }
              def ip_address=(_ip_address); end
              sig { params(exempt: T.nilable(String), ip_address: T.nilable(String)).void }
              def initialize(exempt: nil, ip_address: nil); end
            end
            class Billing < ::Stripe::RequestParams
              class Invoice < ::Stripe::RequestParams
                class CustomField < ::Stripe::RequestParams
                  # The name of the custom field. This may be up to 40 characters.
                  sig { returns(String) }
                  def name; end
                  sig { params(_name: String).returns(String) }
                  def name=(_name); end
                  # The value of the custom field. This may be up to 140 characters. When updating, pass an empty string to remove previously-defined values.
                  sig { returns(String) }
                  def value; end
                  sig { params(_value: String).returns(String) }
                  def value=(_value); end
                  sig { params(name: String, value: String).void }
                  def initialize(name: nil, value: nil); end
                end
                class Rendering < ::Stripe::RequestParams
                  # Indicates whether displayed line item prices and amounts on invoice PDFs include inclusive tax amounts. Must be either `include_inclusive_tax` or `exclude_tax`.
                  sig { returns(T.nilable(String)) }
                  def amount_tax_display; end
                  sig { params(_amount_tax_display: T.nilable(String)).returns(T.nilable(String)) }
                  def amount_tax_display=(_amount_tax_display); end
                  # ID of the invoice rendering template to use for future invoices.
                  sig { returns(T.nilable(String)) }
                  def template; end
                  sig { params(_template: T.nilable(String)).returns(T.nilable(String)) }
                  def template=(_template); end
                  sig {
                    params(amount_tax_display: T.nilable(String), template: T.nilable(String)).void
                   }
                  def initialize(amount_tax_display: nil, template: nil); end
                end
                # The list of up to 4 default custom fields to be displayed on invoices for this customer.
                sig {
                  returns(T.nilable(T::Array[V2::Core::AccountCreateParams::Configuration::Customer::Billing::Invoice::CustomField]))
                 }
                def custom_fields; end
                sig {
                  params(_custom_fields: T.nilable(T::Array[V2::Core::AccountCreateParams::Configuration::Customer::Billing::Invoice::CustomField])).returns(T.nilable(T::Array[V2::Core::AccountCreateParams::Configuration::Customer::Billing::Invoice::CustomField]))
                 }
                def custom_fields=(_custom_fields); end
                # Default invoice footer.
                sig { returns(T.nilable(String)) }
                def footer; end
                sig { params(_footer: T.nilable(String)).returns(T.nilable(String)) }
                def footer=(_footer); end
                # Sequence number to use on the customer account's next invoice. Defaults to 1.
                sig { returns(T.nilable(Integer)) }
                def next_sequence; end
                sig { params(_next_sequence: T.nilable(Integer)).returns(T.nilable(Integer)) }
                def next_sequence=(_next_sequence); end
                # Prefix used to generate unique invoice numbers. Must be 3-12 uppercase letters or numbers.
                sig { returns(T.nilable(String)) }
                def prefix; end
                sig { params(_prefix: T.nilable(String)).returns(T.nilable(String)) }
                def prefix=(_prefix); end
                # Default invoice PDF rendering options.
                sig {
                  returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Billing::Invoice::Rendering))
                 }
                def rendering; end
                sig {
                  params(_rendering: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Billing::Invoice::Rendering)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Billing::Invoice::Rendering))
                 }
                def rendering=(_rendering); end
                sig {
                  params(custom_fields: T.nilable(T::Array[V2::Core::AccountCreateParams::Configuration::Customer::Billing::Invoice::CustomField]), footer: T.nilable(String), next_sequence: T.nilable(Integer), prefix: T.nilable(String), rendering: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Billing::Invoice::Rendering)).void
                 }
                def initialize(
                  custom_fields: nil,
                  footer: nil,
                  next_sequence: nil,
                  prefix: nil,
                  rendering: nil
                ); end
              end
              # Default invoice settings for the customer account.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Billing::Invoice))
               }
              def invoice; end
              sig {
                params(_invoice: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Billing::Invoice)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Billing::Invoice))
               }
              def invoice=(_invoice); end
              sig {
                params(invoice: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Billing::Invoice)).void
               }
              def initialize(invoice: nil); end
            end
            class Capabilities < ::Stripe::RequestParams
              class AutomaticIndirectTax < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              # Generates requirements for enabling automatic indirect tax calculation on this customer's invoices or subscriptions. Recommended to request this capability if planning to enable automatic tax calculation on this customer's invoices or subscriptions.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Capabilities::AutomaticIndirectTax))
               }
              def automatic_indirect_tax; end
              sig {
                params(_automatic_indirect_tax: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Capabilities::AutomaticIndirectTax)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Capabilities::AutomaticIndirectTax))
               }
              def automatic_indirect_tax=(_automatic_indirect_tax); end
              sig {
                params(automatic_indirect_tax: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Capabilities::AutomaticIndirectTax)).void
               }
              def initialize(automatic_indirect_tax: nil); end
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
                # Address line 1 (e.g., street, PO Box, or company name).
                sig { returns(T.nilable(String)) }
                def line1; end
                sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
                def line1=(_line1); end
                # Address line 2 (e.g., apartment, suite, unit, or building).
                sig { returns(T.nilable(String)) }
                def line2; end
                sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
                def line2=(_line2); end
                # ZIP or postal code.
                sig { returns(T.nilable(String)) }
                def postal_code; end
                sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
                def postal_code=(_postal_code); end
                # State, county, province, or region.
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
              # Customer shipping address.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Shipping::Address))
               }
              def address; end
              sig {
                params(_address: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Shipping::Address)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Shipping::Address))
               }
              def address=(_address); end
              # Customer name.
              sig { returns(T.nilable(String)) }
              def name; end
              sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
              def name=(_name); end
              # Customer phone (including extension).
              sig { returns(T.nilable(String)) }
              def phone; end
              sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
              def phone=(_phone); end
              sig {
                params(address: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Shipping::Address), name: T.nilable(String), phone: T.nilable(String)).void
               }
              def initialize(address: nil, name: nil, phone: nil); end
            end
            # Automatic indirect tax settings to be used when automatic tax calculation is enabled on the customer's invoices, subscriptions, checkout sessions, or payment links. Surfaces if automatic tax calculation is possible given the current customer location information.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::AutomaticIndirectTax))
             }
            def automatic_indirect_tax; end
            sig {
              params(_automatic_indirect_tax: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::AutomaticIndirectTax)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::AutomaticIndirectTax))
             }
            def automatic_indirect_tax=(_automatic_indirect_tax); end
            # Billing settings - default settings used for this customer in Billing flows such as Invoices and Subscriptions.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Billing))
             }
            def billing; end
            sig {
              params(_billing: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Billing)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Billing))
             }
            def billing=(_billing); end
            # Capabilities that have been requested on the Customer Configuration.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Capabilities))
             }
            def capabilities; end
            sig {
              params(_capabilities: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Capabilities)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Capabilities))
             }
            def capabilities=(_capabilities); end
            # The customer's shipping information. Appears on invoices emailed to this customer.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Shipping))
             }
            def shipping; end
            sig {
              params(_shipping: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Shipping)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Shipping))
             }
            def shipping=(_shipping); end
            # ID of the test clock to attach to the customer. Can only be set on testmode Accounts, and when the Customer Configuration is first set on an Account.
            sig { returns(T.nilable(String)) }
            def test_clock; end
            sig { params(_test_clock: T.nilable(String)).returns(T.nilable(String)) }
            def test_clock=(_test_clock); end
            sig {
              params(automatic_indirect_tax: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::AutomaticIndirectTax), billing: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Billing), capabilities: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Capabilities), shipping: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer::Shipping), test_clock: T.nilable(String)).void
             }
            def initialize(
              automatic_indirect_tax: nil,
              billing: nil,
              capabilities: nil,
              shipping: nil,
              test_clock: nil
            ); end
          end
          class Merchant < ::Stripe::RequestParams
            class BacsDebitPayments < ::Stripe::RequestParams
              # Display name for Bacs Direct Debit payments.
              sig { returns(T.nilable(String)) }
              def display_name; end
              sig { params(_display_name: T.nilable(String)).returns(T.nilable(String)) }
              def display_name=(_display_name); end
              sig { params(display_name: T.nilable(String)).void }
              def initialize(display_name: nil); end
            end
            class Branding < ::Stripe::RequestParams
              # ID of a [file upload](https://docs.stripe.com/api/persons/update#create_file): An icon for the merchant. Must be square and at least 128px x 128px.
              sig { returns(T.nilable(String)) }
              def icon; end
              sig { params(_icon: T.nilable(String)).returns(T.nilable(String)) }
              def icon=(_icon); end
              # ID of a [file upload](https://docs.stripe.com/api/persons/update#create_file): A logo for the merchant that will be used in Checkout instead of the icon and without the merchant's name next to it if provided. Must be at least 128px x 128px.
              sig { returns(T.nilable(String)) }
              def logo; end
              sig { params(_logo: T.nilable(String)).returns(T.nilable(String)) }
              def logo=(_logo); end
              # A CSS hex color value representing the primary branding color for the merchant.
              sig { returns(T.nilable(String)) }
              def primary_color; end
              sig { params(_primary_color: T.nilable(String)).returns(T.nilable(String)) }
              def primary_color=(_primary_color); end
              # A CSS hex color value representing the secondary branding color for the merchant.
              sig { returns(T.nilable(String)) }
              def secondary_color; end
              sig { params(_secondary_color: T.nilable(String)).returns(T.nilable(String)) }
              def secondary_color=(_secondary_color); end
              sig {
                params(icon: T.nilable(String), logo: T.nilable(String), primary_color: T.nilable(String), secondary_color: T.nilable(String)).void
               }
              def initialize(icon: nil, logo: nil, primary_color: nil, secondary_color: nil); end
            end
            class Capabilities < ::Stripe::RequestParams
              class AchDebitPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class AcssDebitPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class AffirmPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class AfterpayClearpayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class AlmaPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class AmazonPayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class AuBecsDebitPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class BacsDebitPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class BancontactPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class BlikPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class BoletoPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class CardPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class CartesBancairesPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class CashappPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class EpsPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class FpxPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class GbBankTransferPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class GrabpayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class IdealPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class JcbPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class JpBankTransferPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class KakaoPayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class KlarnaPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class KonbiniPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class KrCardPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class LinkPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class MobilepayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class MultibancoPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class MxBankTransferPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class NaverPayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class OxxoPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class P24Payments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class PayByBankPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class PaycoPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class PaynowPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class PromptpayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class RevolutPayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class SamsungPayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class SepaBankTransferPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class SepaDebitPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class SwishPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class TwintPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class UsBankTransferPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              class ZipPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                sig { returns(T::Boolean) }
                def requested; end
                sig { params(_requested: T::Boolean).returns(T::Boolean) }
                def requested=(_requested); end
                sig { params(requested: T::Boolean).void }
                def initialize(requested: nil); end
              end
              # Allow the merchant to process ACH debit payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AchDebitPayments))
               }
              def ach_debit_payments; end
              sig {
                params(_ach_debit_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AchDebitPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AchDebitPayments))
               }
              def ach_debit_payments=(_ach_debit_payments); end
              # Allow the merchant to process ACSS debit payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AcssDebitPayments))
               }
              def acss_debit_payments; end
              sig {
                params(_acss_debit_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AcssDebitPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AcssDebitPayments))
               }
              def acss_debit_payments=(_acss_debit_payments); end
              # Allow the merchant to process Affirm payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AffirmPayments))
               }
              def affirm_payments; end
              sig {
                params(_affirm_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AffirmPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AffirmPayments))
               }
              def affirm_payments=(_affirm_payments); end
              # Allow the merchant to process Afterpay/Clearpay payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AfterpayClearpayPayments))
               }
              def afterpay_clearpay_payments; end
              sig {
                params(_afterpay_clearpay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AfterpayClearpayPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AfterpayClearpayPayments))
               }
              def afterpay_clearpay_payments=(_afterpay_clearpay_payments); end
              # Allow the merchant to process Alma payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AlmaPayments))
               }
              def alma_payments; end
              sig {
                params(_alma_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AlmaPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AlmaPayments))
               }
              def alma_payments=(_alma_payments); end
              # Allow the merchant to process Amazon Pay payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AmazonPayPayments))
               }
              def amazon_pay_payments; end
              sig {
                params(_amazon_pay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AmazonPayPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AmazonPayPayments))
               }
              def amazon_pay_payments=(_amazon_pay_payments); end
              # Allow the merchant to process Australian BECS Direct Debit payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AuBecsDebitPayments))
               }
              def au_becs_debit_payments; end
              sig {
                params(_au_becs_debit_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AuBecsDebitPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AuBecsDebitPayments))
               }
              def au_becs_debit_payments=(_au_becs_debit_payments); end
              # Allow the merchant to process BACS Direct Debit payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::BacsDebitPayments))
               }
              def bacs_debit_payments; end
              sig {
                params(_bacs_debit_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::BacsDebitPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::BacsDebitPayments))
               }
              def bacs_debit_payments=(_bacs_debit_payments); end
              # Allow the merchant to process Bancontact payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::BancontactPayments))
               }
              def bancontact_payments; end
              sig {
                params(_bancontact_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::BancontactPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::BancontactPayments))
               }
              def bancontact_payments=(_bancontact_payments); end
              # Allow the merchant to process BLIK payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::BlikPayments))
               }
              def blik_payments; end
              sig {
                params(_blik_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::BlikPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::BlikPayments))
               }
              def blik_payments=(_blik_payments); end
              # Allow the merchant to process Boleto payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::BoletoPayments))
               }
              def boleto_payments; end
              sig {
                params(_boleto_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::BoletoPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::BoletoPayments))
               }
              def boleto_payments=(_boleto_payments); end
              # Allow the merchant to collect card payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::CardPayments))
               }
              def card_payments; end
              sig {
                params(_card_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::CardPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::CardPayments))
               }
              def card_payments=(_card_payments); end
              # Allow the merchant to process Cartes Bancaires payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::CartesBancairesPayments))
               }
              def cartes_bancaires_payments; end
              sig {
                params(_cartes_bancaires_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::CartesBancairesPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::CartesBancairesPayments))
               }
              def cartes_bancaires_payments=(_cartes_bancaires_payments); end
              # Allow the merchant to process Cash App payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::CashappPayments))
               }
              def cashapp_payments; end
              sig {
                params(_cashapp_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::CashappPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::CashappPayments))
               }
              def cashapp_payments=(_cashapp_payments); end
              # Allow the merchant to process EPS payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::EpsPayments))
               }
              def eps_payments; end
              sig {
                params(_eps_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::EpsPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::EpsPayments))
               }
              def eps_payments=(_eps_payments); end
              # Allow the merchant to process FPX payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::FpxPayments))
               }
              def fpx_payments; end
              sig {
                params(_fpx_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::FpxPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::FpxPayments))
               }
              def fpx_payments=(_fpx_payments); end
              # Allow the merchant to process UK bank transfer payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::GbBankTransferPayments))
               }
              def gb_bank_transfer_payments; end
              sig {
                params(_gb_bank_transfer_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::GbBankTransferPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::GbBankTransferPayments))
               }
              def gb_bank_transfer_payments=(_gb_bank_transfer_payments); end
              # Allow the merchant to process GrabPay payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::GrabpayPayments))
               }
              def grabpay_payments; end
              sig {
                params(_grabpay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::GrabpayPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::GrabpayPayments))
               }
              def grabpay_payments=(_grabpay_payments); end
              # Allow the merchant to process iDEAL payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::IdealPayments))
               }
              def ideal_payments; end
              sig {
                params(_ideal_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::IdealPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::IdealPayments))
               }
              def ideal_payments=(_ideal_payments); end
              # Allow the merchant to process JCB card payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::JcbPayments))
               }
              def jcb_payments; end
              sig {
                params(_jcb_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::JcbPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::JcbPayments))
               }
              def jcb_payments=(_jcb_payments); end
              # Allow the merchant to process Japanese bank transfer payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::JpBankTransferPayments))
               }
              def jp_bank_transfer_payments; end
              sig {
                params(_jp_bank_transfer_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::JpBankTransferPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::JpBankTransferPayments))
               }
              def jp_bank_transfer_payments=(_jp_bank_transfer_payments); end
              # Allow the merchant to process Kakao Pay payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::KakaoPayPayments))
               }
              def kakao_pay_payments; end
              sig {
                params(_kakao_pay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::KakaoPayPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::KakaoPayPayments))
               }
              def kakao_pay_payments=(_kakao_pay_payments); end
              # Allow the merchant to process Klarna payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::KlarnaPayments))
               }
              def klarna_payments; end
              sig {
                params(_klarna_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::KlarnaPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::KlarnaPayments))
               }
              def klarna_payments=(_klarna_payments); end
              # Allow the merchant to process Konbini convenience store payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::KonbiniPayments))
               }
              def konbini_payments; end
              sig {
                params(_konbini_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::KonbiniPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::KonbiniPayments))
               }
              def konbini_payments=(_konbini_payments); end
              # Allow the merchant to process Korean card payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::KrCardPayments))
               }
              def kr_card_payments; end
              sig {
                params(_kr_card_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::KrCardPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::KrCardPayments))
               }
              def kr_card_payments=(_kr_card_payments); end
              # Allow the merchant to process Link payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::LinkPayments))
               }
              def link_payments; end
              sig {
                params(_link_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::LinkPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::LinkPayments))
               }
              def link_payments=(_link_payments); end
              # Allow the merchant to process MobilePay payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::MobilepayPayments))
               }
              def mobilepay_payments; end
              sig {
                params(_mobilepay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::MobilepayPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::MobilepayPayments))
               }
              def mobilepay_payments=(_mobilepay_payments); end
              # Allow the merchant to process Multibanco payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::MultibancoPayments))
               }
              def multibanco_payments; end
              sig {
                params(_multibanco_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::MultibancoPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::MultibancoPayments))
               }
              def multibanco_payments=(_multibanco_payments); end
              # Allow the merchant to process Mexican bank transfer payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::MxBankTransferPayments))
               }
              def mx_bank_transfer_payments; end
              sig {
                params(_mx_bank_transfer_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::MxBankTransferPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::MxBankTransferPayments))
               }
              def mx_bank_transfer_payments=(_mx_bank_transfer_payments); end
              # Allow the merchant to process Naver Pay payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::NaverPayPayments))
               }
              def naver_pay_payments; end
              sig {
                params(_naver_pay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::NaverPayPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::NaverPayPayments))
               }
              def naver_pay_payments=(_naver_pay_payments); end
              # Allow the merchant to process OXXO payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::OxxoPayments))
               }
              def oxxo_payments; end
              sig {
                params(_oxxo_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::OxxoPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::OxxoPayments))
               }
              def oxxo_payments=(_oxxo_payments); end
              # Allow the merchant to process Przelewy24 (P24) payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::P24Payments))
               }
              def p24_payments; end
              sig {
                params(_p24_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::P24Payments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::P24Payments))
               }
              def p24_payments=(_p24_payments); end
              # Allow the merchant to process Pay by Bank payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::PayByBankPayments))
               }
              def pay_by_bank_payments; end
              sig {
                params(_pay_by_bank_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::PayByBankPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::PayByBankPayments))
               }
              def pay_by_bank_payments=(_pay_by_bank_payments); end
              # Allow the merchant to process PAYCO payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::PaycoPayments))
               }
              def payco_payments; end
              sig {
                params(_payco_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::PaycoPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::PaycoPayments))
               }
              def payco_payments=(_payco_payments); end
              # Allow the merchant to process PayNow payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::PaynowPayments))
               }
              def paynow_payments; end
              sig {
                params(_paynow_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::PaynowPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::PaynowPayments))
               }
              def paynow_payments=(_paynow_payments); end
              # Allow the merchant to process PromptPay payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::PromptpayPayments))
               }
              def promptpay_payments; end
              sig {
                params(_promptpay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::PromptpayPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::PromptpayPayments))
               }
              def promptpay_payments=(_promptpay_payments); end
              # Allow the merchant to process Revolut Pay payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::RevolutPayPayments))
               }
              def revolut_pay_payments; end
              sig {
                params(_revolut_pay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::RevolutPayPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::RevolutPayPayments))
               }
              def revolut_pay_payments=(_revolut_pay_payments); end
              # Allow the merchant to process Samsung Pay payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::SamsungPayPayments))
               }
              def samsung_pay_payments; end
              sig {
                params(_samsung_pay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::SamsungPayPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::SamsungPayPayments))
               }
              def samsung_pay_payments=(_samsung_pay_payments); end
              # Allow the merchant to process SEPA bank transfer payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::SepaBankTransferPayments))
               }
              def sepa_bank_transfer_payments; end
              sig {
                params(_sepa_bank_transfer_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::SepaBankTransferPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::SepaBankTransferPayments))
               }
              def sepa_bank_transfer_payments=(_sepa_bank_transfer_payments); end
              # Allow the merchant to process SEPA Direct Debit payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::SepaDebitPayments))
               }
              def sepa_debit_payments; end
              sig {
                params(_sepa_debit_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::SepaDebitPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::SepaDebitPayments))
               }
              def sepa_debit_payments=(_sepa_debit_payments); end
              # Allow the merchant to process Swish payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::SwishPayments))
               }
              def swish_payments; end
              sig {
                params(_swish_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::SwishPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::SwishPayments))
               }
              def swish_payments=(_swish_payments); end
              # Allow the merchant to process TWINT payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::TwintPayments))
               }
              def twint_payments; end
              sig {
                params(_twint_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::TwintPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::TwintPayments))
               }
              def twint_payments=(_twint_payments); end
              # Allow the merchant to process US bank transfer payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::UsBankTransferPayments))
               }
              def us_bank_transfer_payments; end
              sig {
                params(_us_bank_transfer_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::UsBankTransferPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::UsBankTransferPayments))
               }
              def us_bank_transfer_payments=(_us_bank_transfer_payments); end
              # Allow the merchant to process Zip payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::ZipPayments))
               }
              def zip_payments; end
              sig {
                params(_zip_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::ZipPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::ZipPayments))
               }
              def zip_payments=(_zip_payments); end
              sig {
                params(ach_debit_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AchDebitPayments), acss_debit_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AcssDebitPayments), affirm_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AffirmPayments), afterpay_clearpay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AfterpayClearpayPayments), alma_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AlmaPayments), amazon_pay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AmazonPayPayments), au_becs_debit_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::AuBecsDebitPayments), bacs_debit_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::BacsDebitPayments), bancontact_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::BancontactPayments), blik_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::BlikPayments), boleto_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::BoletoPayments), card_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::CardPayments), cartes_bancaires_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::CartesBancairesPayments), cashapp_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::CashappPayments), eps_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::EpsPayments), fpx_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::FpxPayments), gb_bank_transfer_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::GbBankTransferPayments), grabpay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::GrabpayPayments), ideal_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::IdealPayments), jcb_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::JcbPayments), jp_bank_transfer_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::JpBankTransferPayments), kakao_pay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::KakaoPayPayments), klarna_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::KlarnaPayments), konbini_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::KonbiniPayments), kr_card_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::KrCardPayments), link_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::LinkPayments), mobilepay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::MobilepayPayments), multibanco_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::MultibancoPayments), mx_bank_transfer_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::MxBankTransferPayments), naver_pay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::NaverPayPayments), oxxo_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::OxxoPayments), p24_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::P24Payments), pay_by_bank_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::PayByBankPayments), payco_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::PaycoPayments), paynow_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::PaynowPayments), promptpay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::PromptpayPayments), revolut_pay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::RevolutPayPayments), samsung_pay_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::SamsungPayPayments), sepa_bank_transfer_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::SepaBankTransferPayments), sepa_debit_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::SepaDebitPayments), swish_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::SwishPayments), twint_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::TwintPayments), us_bank_transfer_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::UsBankTransferPayments), zip_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities::ZipPayments)).void
               }
              def initialize(
                ach_debit_payments: nil,
                acss_debit_payments: nil,
                affirm_payments: nil,
                afterpay_clearpay_payments: nil,
                alma_payments: nil,
                amazon_pay_payments: nil,
                au_becs_debit_payments: nil,
                bacs_debit_payments: nil,
                bancontact_payments: nil,
                blik_payments: nil,
                boleto_payments: nil,
                card_payments: nil,
                cartes_bancaires_payments: nil,
                cashapp_payments: nil,
                eps_payments: nil,
                fpx_payments: nil,
                gb_bank_transfer_payments: nil,
                grabpay_payments: nil,
                ideal_payments: nil,
                jcb_payments: nil,
                jp_bank_transfer_payments: nil,
                kakao_pay_payments: nil,
                klarna_payments: nil,
                konbini_payments: nil,
                kr_card_payments: nil,
                link_payments: nil,
                mobilepay_payments: nil,
                multibanco_payments: nil,
                mx_bank_transfer_payments: nil,
                naver_pay_payments: nil,
                oxxo_payments: nil,
                p24_payments: nil,
                pay_by_bank_payments: nil,
                payco_payments: nil,
                paynow_payments: nil,
                promptpay_payments: nil,
                revolut_pay_payments: nil,
                samsung_pay_payments: nil,
                sepa_bank_transfer_payments: nil,
                sepa_debit_payments: nil,
                swish_payments: nil,
                twint_payments: nil,
                us_bank_transfer_payments: nil,
                zip_payments: nil
              ); end
            end
            class CardPayments < ::Stripe::RequestParams
              class DeclineOn < ::Stripe::RequestParams
                # Whether Stripe automatically declines charges with an incorrect ZIP or postal code. This setting only applies when a ZIP or postal code is provided and they fail bank verification.
                sig { returns(T.nilable(T::Boolean)) }
                def avs_failure; end
                sig { params(_avs_failure: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
                def avs_failure=(_avs_failure); end
                # Whether Stripe automatically declines charges with an incorrect CVC. This setting only applies when a CVC is provided and it fails bank verification.
                sig { returns(T.nilable(T::Boolean)) }
                def cvc_failure; end
                sig { params(_cvc_failure: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
                def cvc_failure=(_cvc_failure); end
                sig {
                  params(avs_failure: T.nilable(T::Boolean), cvc_failure: T.nilable(T::Boolean)).void
                 }
                def initialize(avs_failure: nil, cvc_failure: nil); end
              end
              # Automatically declines certain charge types regardless of whether the card issuer accepted or declined the charge.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::CardPayments::DeclineOn))
               }
              def decline_on; end
              sig {
                params(_decline_on: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::CardPayments::DeclineOn)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::CardPayments::DeclineOn))
               }
              def decline_on=(_decline_on); end
              sig {
                params(decline_on: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::CardPayments::DeclineOn)).void
               }
              def initialize(decline_on: nil); end
            end
            class KonbiniPayments < ::Stripe::RequestParams
              class Support < ::Stripe::RequestParams
                class Hours < ::Stripe::RequestParams
                  # Support hours end time (JST time of day) for in `HH:MM` format.
                  sig { returns(T.nilable(String)) }
                  def end_time; end
                  sig { params(_end_time: T.nilable(String)).returns(T.nilable(String)) }
                  def end_time=(_end_time); end
                  # Support hours start time (JST time of day) for in `HH:MM` format.
                  sig { returns(T.nilable(String)) }
                  def start_time; end
                  sig { params(_start_time: T.nilable(String)).returns(T.nilable(String)) }
                  def start_time=(_start_time); end
                  sig { params(end_time: T.nilable(String), start_time: T.nilable(String)).void }
                  def initialize(end_time: nil, start_time: nil); end
                end
                # Support email address for Konbini payments.
                sig { returns(T.nilable(String)) }
                def email; end
                sig { params(_email: T.nilable(String)).returns(T.nilable(String)) }
                def email=(_email); end
                # Support hours for Konbini payments.
                sig {
                  returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::KonbiniPayments::Support::Hours))
                 }
                def hours; end
                sig {
                  params(_hours: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::KonbiniPayments::Support::Hours)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::KonbiniPayments::Support::Hours))
                 }
                def hours=(_hours); end
                # Support phone number for Konbini payments.
                sig { returns(T.nilable(String)) }
                def phone; end
                sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
                def phone=(_phone); end
                sig {
                  params(email: T.nilable(String), hours: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::KonbiniPayments::Support::Hours), phone: T.nilable(String)).void
                 }
                def initialize(email: nil, hours: nil, phone: nil); end
              end
              # Support for Konbini payments.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::KonbiniPayments::Support))
               }
              def support; end
              sig {
                params(_support: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::KonbiniPayments::Support)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::KonbiniPayments::Support))
               }
              def support=(_support); end
              sig {
                params(support: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::KonbiniPayments::Support)).void
               }
              def initialize(support: nil); end
            end
            class ScriptStatementDescriptor < ::Stripe::RequestParams
              class Kana < ::Stripe::RequestParams
                # The default text that appears on statements for non-card charges outside of Japan. For card charges, if you don’t set a statement_descriptor_prefix, this text is also used as the statement descriptor prefix. In that case, if concatenating the statement descriptor suffix causes the combined statement descriptor to exceed 22 characters, we truncate the statement_descriptor text to limit the full descriptor to 22 characters. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
                sig { returns(T.nilable(String)) }
                def descriptor; end
                sig { params(_descriptor: T.nilable(String)).returns(T.nilable(String)) }
                def descriptor=(_descriptor); end
                # Default text that appears on statements for card charges outside of Japan, prefixing any dynamic statement_descriptor_suffix specified on the charge. To maximize space for the dynamic part of the descriptor, keep this text short. If you don’t specify this value, statement_descriptor is used as the prefix. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
                sig { returns(T.nilable(String)) }
                def prefix; end
                sig { params(_prefix: T.nilable(String)).returns(T.nilable(String)) }
                def prefix=(_prefix); end
                sig { params(descriptor: T.nilable(String), prefix: T.nilable(String)).void }
                def initialize(descriptor: nil, prefix: nil); end
              end
              class Kanji < ::Stripe::RequestParams
                # The default text that appears on statements for non-card charges outside of Japan. For card charges, if you don’t set a statement_descriptor_prefix, this text is also used as the statement descriptor prefix. In that case, if concatenating the statement descriptor suffix causes the combined statement descriptor to exceed 22 characters, we truncate the statement_descriptor text to limit the full descriptor to 22 characters. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
                sig { returns(T.nilable(String)) }
                def descriptor; end
                sig { params(_descriptor: T.nilable(String)).returns(T.nilable(String)) }
                def descriptor=(_descriptor); end
                # Default text that appears on statements for card charges outside of Japan, prefixing any dynamic statement_descriptor_suffix specified on the charge. To maximize space for the dynamic part of the descriptor, keep this text short. If you don’t specify this value, statement_descriptor is used as the prefix. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
                sig { returns(T.nilable(String)) }
                def prefix; end
                sig { params(_prefix: T.nilable(String)).returns(T.nilable(String)) }
                def prefix=(_prefix); end
                sig { params(descriptor: T.nilable(String), prefix: T.nilable(String)).void }
                def initialize(descriptor: nil, prefix: nil); end
              end
              # The Kana variation of statement_descriptor used for charges in Japan. Japanese statement descriptors have [special requirements](https://docs.stripe.com/get-started/account/statement-descriptors#set-japanese-statement-descriptors).
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::ScriptStatementDescriptor::Kana))
               }
              def kana; end
              sig {
                params(_kana: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::ScriptStatementDescriptor::Kana)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::ScriptStatementDescriptor::Kana))
               }
              def kana=(_kana); end
              # The Kanji variation of statement_descriptor used for charges in Japan. Japanese statement descriptors have [special requirements](https://docs.stripe.com/get-started/account/statement-descriptors#set-japanese-statement-descriptors).
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::ScriptStatementDescriptor::Kanji))
               }
              def kanji; end
              sig {
                params(_kanji: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::ScriptStatementDescriptor::Kanji)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::ScriptStatementDescriptor::Kanji))
               }
              def kanji=(_kanji); end
              sig {
                params(kana: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::ScriptStatementDescriptor::Kana), kanji: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::ScriptStatementDescriptor::Kanji)).void
               }
              def initialize(kana: nil, kanji: nil); end
            end
            class StatementDescriptor < ::Stripe::RequestParams
              # The default text that appears on statements for non-card charges outside of Japan. For card charges, if you don’t set a statement_descriptor_prefix, this text is also used as the statement descriptor prefix. In that case, if concatenating the statement descriptor suffix causes the combined statement descriptor to exceed 22 characters, we truncate the statement_descriptor text to limit the full descriptor to 22 characters. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
              sig { returns(T.nilable(String)) }
              def descriptor; end
              sig { params(_descriptor: T.nilable(String)).returns(T.nilable(String)) }
              def descriptor=(_descriptor); end
              # Default text that appears on statements for card charges outside of Japan, prefixing any dynamic statement_descriptor_suffix specified on the charge. To maximize space for the dynamic part of the descriptor, keep this text short. If you don’t specify this value, statement_descriptor is used as the prefix. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
              sig { returns(T.nilable(String)) }
              def prefix; end
              sig { params(_prefix: T.nilable(String)).returns(T.nilable(String)) }
              def prefix=(_prefix); end
              sig { params(descriptor: T.nilable(String), prefix: T.nilable(String)).void }
              def initialize(descriptor: nil, prefix: nil); end
            end
            class Support < ::Stripe::RequestParams
              class Address < ::Stripe::RequestParams
                # City, district, suburb, town, or village.
                sig { returns(T.nilable(String)) }
                def city; end
                sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
                def city=(_city); end
                # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
                sig { returns(String) }
                def country; end
                sig { params(_country: String).returns(String) }
                def country=(_country); end
                # Address line 1 (e.g., street, PO Box, or company name).
                sig { returns(T.nilable(String)) }
                def line1; end
                sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
                def line1=(_line1); end
                # Address line 2 (e.g., apartment, suite, unit, or building).
                sig { returns(T.nilable(String)) }
                def line2; end
                sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
                def line2=(_line2); end
                # ZIP or postal code.
                sig { returns(T.nilable(String)) }
                def postal_code; end
                sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
                def postal_code=(_postal_code); end
                # State, county, province, or region.
                sig { returns(T.nilable(String)) }
                def state; end
                sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
                def state=(_state); end
                # Town or district.
                sig { returns(T.nilable(String)) }
                def town; end
                sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
                def town=(_town); end
                sig {
                  params(city: T.nilable(String), country: String, line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
                 }
                def initialize(
                  city: nil,
                  country: nil,
                  line1: nil,
                  line2: nil,
                  postal_code: nil,
                  state: nil,
                  town: nil
                ); end
              end
              # A publicly available mailing address for sending support issues to.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Support::Address))
               }
              def address; end
              sig {
                params(_address: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Support::Address)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Support::Address))
               }
              def address=(_address); end
              # A publicly available email address for sending support issues to.
              sig { returns(T.nilable(String)) }
              def email; end
              sig { params(_email: T.nilable(String)).returns(T.nilable(String)) }
              def email=(_email); end
              # A publicly available phone number to call with support issues.
              sig { returns(T.nilable(String)) }
              def phone; end
              sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
              def phone=(_phone); end
              # A publicly available website for handling support issues.
              sig { returns(T.nilable(String)) }
              def url; end
              sig { params(_url: T.nilable(String)).returns(T.nilable(String)) }
              def url=(_url); end
              sig {
                params(address: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Support::Address), email: T.nilable(String), phone: T.nilable(String), url: T.nilable(String)).void
               }
              def initialize(address: nil, email: nil, phone: nil, url: nil); end
            end
            # Settings used for Bacs debit payments.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::BacsDebitPayments))
             }
            def bacs_debit_payments; end
            sig {
              params(_bacs_debit_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::BacsDebitPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::BacsDebitPayments))
             }
            def bacs_debit_payments=(_bacs_debit_payments); end
            # Settings used to apply the merchant's branding to email receipts, invoices, Checkout, and other products.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Branding))
             }
            def branding; end
            sig {
              params(_branding: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Branding)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Branding))
             }
            def branding=(_branding); end
            # Capabilities to request on the Merchant Configuration.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities))
             }
            def capabilities; end
            sig {
              params(_capabilities: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities))
             }
            def capabilities=(_capabilities); end
            # Card payments settings.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::CardPayments))
             }
            def card_payments; end
            sig {
              params(_card_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::CardPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::CardPayments))
             }
            def card_payments=(_card_payments); end
            # Settings specific to Konbini payments on the account.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::KonbiniPayments))
             }
            def konbini_payments; end
            sig {
              params(_konbini_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::KonbiniPayments)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::KonbiniPayments))
             }
            def konbini_payments=(_konbini_payments); end
            # The Merchant Category Code (MCC) for the Merchant Configuration. MCCs classify businesses based on the goods or services they provide.
            sig { returns(T.nilable(String)) }
            def mcc; end
            sig { params(_mcc: T.nilable(String)).returns(T.nilable(String)) }
            def mcc=(_mcc); end
            # Settings for the default text that appears on statements for language variations.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::ScriptStatementDescriptor))
             }
            def script_statement_descriptor; end
            sig {
              params(_script_statement_descriptor: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::ScriptStatementDescriptor)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::ScriptStatementDescriptor))
             }
            def script_statement_descriptor=(_script_statement_descriptor); end
            # Statement descriptor.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::StatementDescriptor))
             }
            def statement_descriptor; end
            sig {
              params(_statement_descriptor: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::StatementDescriptor)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::StatementDescriptor))
             }
            def statement_descriptor=(_statement_descriptor); end
            # Publicly available contact information for sending support issues to.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Support))
             }
            def support; end
            sig {
              params(_support: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Support)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Support))
             }
            def support=(_support); end
            sig {
              params(bacs_debit_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::BacsDebitPayments), branding: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Branding), capabilities: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Capabilities), card_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::CardPayments), konbini_payments: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::KonbiniPayments), mcc: T.nilable(String), script_statement_descriptor: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::ScriptStatementDescriptor), statement_descriptor: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::StatementDescriptor), support: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant::Support)).void
             }
            def initialize(
              bacs_debit_payments: nil,
              branding: nil,
              capabilities: nil,
              card_payments: nil,
              konbini_payments: nil,
              mcc: nil,
              script_statement_descriptor: nil,
              statement_descriptor: nil,
              support: nil
            ); end
          end
          class Recipient < ::Stripe::RequestParams
            class Capabilities < ::Stripe::RequestParams
              class StripeBalance < ::Stripe::RequestParams
                class StripeTransfers < ::Stripe::RequestParams
                  # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                  sig { returns(T::Boolean) }
                  def requested; end
                  sig { params(_requested: T::Boolean).returns(T::Boolean) }
                  def requested=(_requested); end
                  sig { params(requested: T::Boolean).void }
                  def initialize(requested: nil); end
                end
                # Enables this Account to receive /v1/transfers into their Stripe Balance (/v1/balance).
                sig {
                  returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Recipient::Capabilities::StripeBalance::StripeTransfers))
                 }
                def stripe_transfers; end
                sig {
                  params(_stripe_transfers: T.nilable(V2::Core::AccountCreateParams::Configuration::Recipient::Capabilities::StripeBalance::StripeTransfers)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Recipient::Capabilities::StripeBalance::StripeTransfers))
                 }
                def stripe_transfers=(_stripe_transfers); end
                sig {
                  params(stripe_transfers: T.nilable(V2::Core::AccountCreateParams::Configuration::Recipient::Capabilities::StripeBalance::StripeTransfers)).void
                 }
                def initialize(stripe_transfers: nil); end
              end
              # Capabilities that enable the recipient to manage their Stripe Balance (/v1/balance).
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Recipient::Capabilities::StripeBalance))
               }
              def stripe_balance; end
              sig {
                params(_stripe_balance: T.nilable(V2::Core::AccountCreateParams::Configuration::Recipient::Capabilities::StripeBalance)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Recipient::Capabilities::StripeBalance))
               }
              def stripe_balance=(_stripe_balance); end
              sig {
                params(stripe_balance: T.nilable(V2::Core::AccountCreateParams::Configuration::Recipient::Capabilities::StripeBalance)).void
               }
              def initialize(stripe_balance: nil); end
            end
            # Capabilities to be requested on the Recipient Configuration.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Recipient::Capabilities))
             }
            def capabilities; end
            sig {
              params(_capabilities: T.nilable(V2::Core::AccountCreateParams::Configuration::Recipient::Capabilities)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Recipient::Capabilities))
             }
            def capabilities=(_capabilities); end
            sig {
              params(capabilities: T.nilable(V2::Core::AccountCreateParams::Configuration::Recipient::Capabilities)).void
             }
            def initialize(capabilities: nil); end
          end
          # The Customer Configuration allows the Account to be used in inbound payment flows.
          sig { returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer)) }
          def customer; end
          sig {
            params(_customer: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Customer))
           }
          def customer=(_customer); end
          # Enables the Account to act as a connected account and collect payments facilitated by a Connect platform. You must onboard your platform to Connect before you can add this configuration to your connected accounts. Utilize this configuration when the Account will be the Merchant of Record, like with Direct charges or Destination Charges with on_behalf_of set.
          sig { returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant)) }
          def merchant; end
          sig {
            params(_merchant: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant))
           }
          def merchant=(_merchant); end
          # The Recipient Configuration allows the Account to receive funds. Utilize this configuration if the Account will not be the Merchant of Record, like with Separate Charges & Transfers, or Destination Charges without on_behalf_of set.
          sig { returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Recipient)) }
          def recipient; end
          sig {
            params(_recipient: T.nilable(V2::Core::AccountCreateParams::Configuration::Recipient)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration::Recipient))
           }
          def recipient=(_recipient); end
          sig {
            params(customer: T.nilable(V2::Core::AccountCreateParams::Configuration::Customer), merchant: T.nilable(V2::Core::AccountCreateParams::Configuration::Merchant), recipient: T.nilable(V2::Core::AccountCreateParams::Configuration::Recipient)).void
           }
          def initialize(customer: nil, merchant: nil, recipient: nil); end
        end
        class Defaults < ::Stripe::RequestParams
          class Profile < ::Stripe::RequestParams
            # The business's publicly-available website.
            sig { returns(T.nilable(String)) }
            def business_url; end
            sig { params(_business_url: T.nilable(String)).returns(T.nilable(String)) }
            def business_url=(_business_url); end
            # The name which is used by the business.
            sig { returns(T.nilable(String)) }
            def doing_business_as; end
            sig { params(_doing_business_as: T.nilable(String)).returns(T.nilable(String)) }
            def doing_business_as=(_doing_business_as); end
            # Internal-only description of the product sold or service provided by the business. It's used by Stripe for risk and underwriting purposes.
            sig { returns(T.nilable(String)) }
            def product_description; end
            sig { params(_product_description: T.nilable(String)).returns(T.nilable(String)) }
            def product_description=(_product_description); end
            sig {
              params(business_url: T.nilable(String), doing_business_as: T.nilable(String), product_description: T.nilable(String)).void
             }
            def initialize(business_url: nil, doing_business_as: nil, product_description: nil); end
          end
          class Responsibilities < ::Stripe::RequestParams
            # A value indicating the party responsible for collecting fees from this account.
            sig { returns(String) }
            def fees_collector; end
            sig { params(_fees_collector: String).returns(String) }
            def fees_collector=(_fees_collector); end
            # A value indicating who is responsible for losses when this Account can’t pay back negative balances from payments.
            sig { returns(String) }
            def losses_collector; end
            sig { params(_losses_collector: String).returns(String) }
            def losses_collector=(_losses_collector); end
            sig { params(fees_collector: String, losses_collector: String).void }
            def initialize(fees_collector: nil, losses_collector: nil); end
          end
          # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
          sig { returns(T.nilable(String)) }
          def currency; end
          sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
          def currency=(_currency); end
          # The Account's preferred locales (languages), ordered by preference.
          sig { returns(T.nilable(T::Array[String])) }
          def locales; end
          sig { params(_locales: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
          def locales=(_locales); end
          # Account profile information.
          sig { returns(T.nilable(V2::Core::AccountCreateParams::Defaults::Profile)) }
          def profile; end
          sig {
            params(_profile: T.nilable(V2::Core::AccountCreateParams::Defaults::Profile)).returns(T.nilable(V2::Core::AccountCreateParams::Defaults::Profile))
           }
          def profile=(_profile); end
          # Default responsibilities held by either Stripe or the platform.
          sig { returns(T.nilable(V2::Core::AccountCreateParams::Defaults::Responsibilities)) }
          def responsibilities; end
          sig {
            params(_responsibilities: T.nilable(V2::Core::AccountCreateParams::Defaults::Responsibilities)).returns(T.nilable(V2::Core::AccountCreateParams::Defaults::Responsibilities))
           }
          def responsibilities=(_responsibilities); end
          sig {
            params(currency: T.nilable(String), locales: T.nilable(T::Array[String]), profile: T.nilable(V2::Core::AccountCreateParams::Defaults::Profile), responsibilities: T.nilable(V2::Core::AccountCreateParams::Defaults::Responsibilities)).void
           }
          def initialize(currency: nil, locales: nil, profile: nil, responsibilities: nil); end
        end
        class Identity < ::Stripe::RequestParams
          class Attestations < ::Stripe::RequestParams
            class DirectorshipDeclaration < ::Stripe::RequestParams
              # The time marking when the director attestation was made. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
              sig { returns(T.nilable(String)) }
              def date; end
              sig { params(_date: T.nilable(String)).returns(T.nilable(String)) }
              def date=(_date); end
              # The IP address from which the director attestation was made.
              sig { returns(T.nilable(String)) }
              def ip; end
              sig { params(_ip: T.nilable(String)).returns(T.nilable(String)) }
              def ip=(_ip); end
              # The user agent of the browser from which the director attestation was made.
              sig { returns(T.nilable(String)) }
              def user_agent; end
              sig { params(_user_agent: T.nilable(String)).returns(T.nilable(String)) }
              def user_agent=(_user_agent); end
              sig {
                params(date: T.nilable(String), ip: T.nilable(String), user_agent: T.nilable(String)).void
               }
              def initialize(date: nil, ip: nil, user_agent: nil); end
            end
            class OwnershipDeclaration < ::Stripe::RequestParams
              # The time marking when the beneficial owner attestation was made. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
              sig { returns(T.nilable(String)) }
              def date; end
              sig { params(_date: T.nilable(String)).returns(T.nilable(String)) }
              def date=(_date); end
              # The IP address from which the beneficial owner attestation was made.
              sig { returns(T.nilable(String)) }
              def ip; end
              sig { params(_ip: T.nilable(String)).returns(T.nilable(String)) }
              def ip=(_ip); end
              # The user agent of the browser from which the beneficial owner attestation was made.
              sig { returns(T.nilable(String)) }
              def user_agent; end
              sig { params(_user_agent: T.nilable(String)).returns(T.nilable(String)) }
              def user_agent=(_user_agent); end
              sig {
                params(date: T.nilable(String), ip: T.nilable(String), user_agent: T.nilable(String)).void
               }
              def initialize(date: nil, ip: nil, user_agent: nil); end
            end
            class PersonsProvided < ::Stripe::RequestParams
              # Whether the company’s directors have been provided. Set this Boolean to true after creating all the company’s directors with the [Persons API](https://docs.stripe.com/api/v2/core/accounts/createperson).
              sig { returns(T.nilable(T::Boolean)) }
              def directors; end
              sig { params(_directors: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
              def directors=(_directors); end
              # Whether the company’s executives have been provided. Set this Boolean to true after creating all the company’s executives with the [Persons API](https://docs.stripe.com/api/v2/core/accounts/createperson).
              sig { returns(T.nilable(T::Boolean)) }
              def executives; end
              sig { params(_executives: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
              def executives=(_executives); end
              # Whether the company’s owners have been provided. Set this Boolean to true after creating all the company’s owners with the [Persons API](https://docs.stripe.com/api/v2/core/accounts/createperson).
              sig { returns(T.nilable(T::Boolean)) }
              def owners; end
              sig { params(_owners: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
              def owners=(_owners); end
              # Reason for why the company is exempt from providing ownership information.
              sig { returns(T.nilable(String)) }
              def ownership_exemption_reason; end
              sig {
                params(_ownership_exemption_reason: T.nilable(String)).returns(T.nilable(String))
               }
              def ownership_exemption_reason=(_ownership_exemption_reason); end
              sig {
                params(directors: T.nilable(T::Boolean), executives: T.nilable(T::Boolean), owners: T.nilable(T::Boolean), ownership_exemption_reason: T.nilable(String)).void
               }
              def initialize(
                directors: nil,
                executives: nil,
                owners: nil,
                ownership_exemption_reason: nil
              ); end
            end
            class RepresentativeDeclaration < ::Stripe::RequestParams
              # The time marking when the representative attestation was made. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
              sig { returns(T.nilable(String)) }
              def date; end
              sig { params(_date: T.nilable(String)).returns(T.nilable(String)) }
              def date=(_date); end
              # The IP address from which the representative attestation was made.
              sig { returns(T.nilable(String)) }
              def ip; end
              sig { params(_ip: T.nilable(String)).returns(T.nilable(String)) }
              def ip=(_ip); end
              # The user agent of the browser from which the representative attestation was made.
              sig { returns(T.nilable(String)) }
              def user_agent; end
              sig { params(_user_agent: T.nilable(String)).returns(T.nilable(String)) }
              def user_agent=(_user_agent); end
              sig {
                params(date: T.nilable(String), ip: T.nilable(String), user_agent: T.nilable(String)).void
               }
              def initialize(date: nil, ip: nil, user_agent: nil); end
            end
            class TermsOfService < ::Stripe::RequestParams
              class Account < ::Stripe::RequestParams
                # The time when the Account's representative accepted the terms of service. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
                sig { returns(String) }
                def date; end
                sig { params(_date: String).returns(String) }
                def date=(_date); end
                # The IP address from which the Account's representative accepted the terms of service.
                sig { returns(String) }
                def ip; end
                sig { params(_ip: String).returns(String) }
                def ip=(_ip); end
                # The user agent of the browser from which the Account's representative accepted the terms of service.
                sig { returns(T.nilable(String)) }
                def user_agent; end
                sig { params(_user_agent: T.nilable(String)).returns(T.nilable(String)) }
                def user_agent=(_user_agent); end
                sig { params(date: String, ip: String, user_agent: T.nilable(String)).void }
                def initialize(date: nil, ip: nil, user_agent: nil); end
              end
              # Details on the Account's acceptance of the [Stripe Services Agreement](https://docs.stripe.com/connect/updating-accounts#tos-acceptance).
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::TermsOfService::Account))
               }
              def account; end
              sig {
                params(_account: T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::TermsOfService::Account)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::TermsOfService::Account))
               }
              def account=(_account); end
              sig {
                params(account: T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::TermsOfService::Account)).void
               }
              def initialize(account: nil); end
            end
            # This hash is used to attest that the directors information provided to Stripe is both current and correct.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::DirectorshipDeclaration))
             }
            def directorship_declaration; end
            sig {
              params(_directorship_declaration: T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::DirectorshipDeclaration)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::DirectorshipDeclaration))
             }
            def directorship_declaration=(_directorship_declaration); end
            # This hash is used to attest that the beneficial owner information provided to Stripe is both current and correct.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::OwnershipDeclaration))
             }
            def ownership_declaration; end
            sig {
              params(_ownership_declaration: T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::OwnershipDeclaration)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::OwnershipDeclaration))
             }
            def ownership_declaration=(_ownership_declaration); end
            # Attestation that all Persons with a specific Relationship value have been provided.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::PersonsProvided))
             }
            def persons_provided; end
            sig {
              params(_persons_provided: T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::PersonsProvided)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::PersonsProvided))
             }
            def persons_provided=(_persons_provided); end
            # This hash is used to attest that the representative is authorized to act as the representative of their legal entity.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::RepresentativeDeclaration))
             }
            def representative_declaration; end
            sig {
              params(_representative_declaration: T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::RepresentativeDeclaration)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::RepresentativeDeclaration))
             }
            def representative_declaration=(_representative_declaration); end
            # Attestations of accepted terms of service agreements.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::TermsOfService))
             }
            def terms_of_service; end
            sig {
              params(_terms_of_service: T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::TermsOfService)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::TermsOfService))
             }
            def terms_of_service=(_terms_of_service); end
            sig {
              params(directorship_declaration: T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::DirectorshipDeclaration), ownership_declaration: T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::OwnershipDeclaration), persons_provided: T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::PersonsProvided), representative_declaration: T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::RepresentativeDeclaration), terms_of_service: T.nilable(V2::Core::AccountCreateParams::Identity::Attestations::TermsOfService)).void
             }
            def initialize(
              directorship_declaration: nil,
              ownership_declaration: nil,
              persons_provided: nil,
              representative_declaration: nil,
              terms_of_service: nil
            ); end
          end
          class BusinessDetails < ::Stripe::RequestParams
            class Address < ::Stripe::RequestParams
              # City, district, suburb, town, or village.
              sig { returns(T.nilable(String)) }
              def city; end
              sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
              def city=(_city); end
              # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
              sig { returns(String) }
              def country; end
              sig { params(_country: String).returns(String) }
              def country=(_country); end
              # Address line 1 (e.g., street, PO Box, or company name).
              sig { returns(T.nilable(String)) }
              def line1; end
              sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
              def line1=(_line1); end
              # Address line 2 (e.g., apartment, suite, unit, or building).
              sig { returns(T.nilable(String)) }
              def line2; end
              sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
              def line2=(_line2); end
              # ZIP or postal code.
              sig { returns(T.nilable(String)) }
              def postal_code; end
              sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
              def postal_code=(_postal_code); end
              # State, county, province, or region.
              sig { returns(T.nilable(String)) }
              def state; end
              sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
              def state=(_state); end
              # Town or district.
              sig { returns(T.nilable(String)) }
              def town; end
              sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
              def town=(_town); end
              sig {
                params(city: T.nilable(String), country: String, line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
               }
              def initialize(
                city: nil,
                country: nil,
                line1: nil,
                line2: nil,
                postal_code: nil,
                state: nil,
                town: nil
              ); end
            end
            class AnnualRevenue < ::Stripe::RequestParams
              class Amount < ::Stripe::RequestParams
                # A non-negative integer representing how much to charge in the [smallest currency unit](https://docs.stripe.com/currencies#minor-units).
                sig { returns(T.nilable(Integer)) }
                def value; end
                sig { params(_value: T.nilable(Integer)).returns(T.nilable(Integer)) }
                def value=(_value); end
                # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
                sig { returns(T.nilable(String)) }
                def currency; end
                sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
                def currency=(_currency); end
                sig { params(value: T.nilable(Integer), currency: T.nilable(String)).void }
                def initialize(value: nil, currency: nil); end
              end
              # A non-negative integer representing the amount in the smallest currency unit.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::AnnualRevenue::Amount))
               }
              def amount; end
              sig {
                params(_amount: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::AnnualRevenue::Amount)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::AnnualRevenue::Amount))
               }
              def amount=(_amount); end
              # The close-out date of the preceding fiscal year in ISO 8601 format. E.g. 2023-12-31 for the 31st of December, 2023.
              sig { returns(T.nilable(String)) }
              def fiscal_year_end; end
              sig { params(_fiscal_year_end: T.nilable(String)).returns(T.nilable(String)) }
              def fiscal_year_end=(_fiscal_year_end); end
              sig {
                params(amount: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::AnnualRevenue::Amount), fiscal_year_end: T.nilable(String)).void
               }
              def initialize(amount: nil, fiscal_year_end: nil); end
            end
            class Documents < ::Stripe::RequestParams
              class BankAccountOwnershipVerification < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                sig { params(_files: T::Array[String]).returns(T::Array[String]) }
                def files=(_files); end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig { params(files: T::Array[String], type: String).void }
                def initialize(files: nil, type: nil); end
              end
              class CompanyLicense < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                sig { params(_files: T::Array[String]).returns(T::Array[String]) }
                def files=(_files); end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig { params(files: T::Array[String], type: String).void }
                def initialize(files: nil, type: nil); end
              end
              class CompanyMemorandumOfAssociation < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                sig { params(_files: T::Array[String]).returns(T::Array[String]) }
                def files=(_files); end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig { params(files: T::Array[String], type: String).void }
                def initialize(files: nil, type: nil); end
              end
              class CompanyMinisterialDecree < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                sig { params(_files: T::Array[String]).returns(T::Array[String]) }
                def files=(_files); end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig { params(files: T::Array[String], type: String).void }
                def initialize(files: nil, type: nil); end
              end
              class CompanyRegistrationVerification < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                sig { params(_files: T::Array[String]).returns(T::Array[String]) }
                def files=(_files); end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig { params(files: T::Array[String], type: String).void }
                def initialize(files: nil, type: nil); end
              end
              class CompanyTaxIdVerification < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                sig { params(_files: T::Array[String]).returns(T::Array[String]) }
                def files=(_files); end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig { params(files: T::Array[String], type: String).void }
                def initialize(files: nil, type: nil); end
              end
              class PrimaryVerification < ::Stripe::RequestParams
                class FrontBack < ::Stripe::RequestParams
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the back of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  sig { returns(T.nilable(String)) }
                  def back; end
                  sig { params(_back: T.nilable(String)).returns(T.nilable(String)) }
                  def back=(_back); end
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the front of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  sig { returns(String) }
                  def front; end
                  sig { params(_front: String).returns(String) }
                  def front=(_front); end
                  sig { params(back: T.nilable(String), front: String).void }
                  def initialize(back: nil, front: nil); end
                end
                # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens referring to each side of the document.
                sig {
                  returns(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::PrimaryVerification::FrontBack)
                 }
                def front_back; end
                sig {
                  params(_front_back: V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::PrimaryVerification::FrontBack).returns(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::PrimaryVerification::FrontBack)
                 }
                def front_back=(_front_back); end
                # The format of the verification document. Currently supports `front_back` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig {
                  params(front_back: V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::PrimaryVerification::FrontBack, type: String).void
                 }
                def initialize(front_back: nil, type: nil); end
              end
              class ProofOfAddress < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                sig { params(_files: T::Array[String]).returns(T::Array[String]) }
                def files=(_files); end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig { params(files: T::Array[String], type: String).void }
                def initialize(files: nil, type: nil); end
              end
              class ProofOfRegistration < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                sig { params(_files: T::Array[String]).returns(T::Array[String]) }
                def files=(_files); end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig { params(files: T::Array[String], type: String).void }
                def initialize(files: nil, type: nil); end
              end
              class ProofOfUltimateBeneficialOwnership < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                sig { params(_files: T::Array[String]).returns(T::Array[String]) }
                def files=(_files); end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig { params(files: T::Array[String], type: String).void }
                def initialize(files: nil, type: nil); end
              end
              # One or more documents that support the bank account ownership verification requirement. Must be a document associated with the account’s primary active bank account that displays the last 4 digits of the account number, either a statement or a check.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::BankAccountOwnershipVerification))
               }
              def bank_account_ownership_verification; end
              sig {
                params(_bank_account_ownership_verification: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::BankAccountOwnershipVerification)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::BankAccountOwnershipVerification))
               }
              def bank_account_ownership_verification=(_bank_account_ownership_verification); end
              # One or more documents that demonstrate proof of a company’s license to operate.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyLicense))
               }
              def company_license; end
              sig {
                params(_company_license: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyLicense)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyLicense))
               }
              def company_license=(_company_license); end
              # One or more documents showing the company’s Memorandum of Association.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyMemorandumOfAssociation))
               }
              def company_memorandum_of_association; end
              sig {
                params(_company_memorandum_of_association: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyMemorandumOfAssociation)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyMemorandumOfAssociation))
               }
              def company_memorandum_of_association=(_company_memorandum_of_association); end
              # Certain countries only: One or more documents showing the ministerial decree legalizing the company’s establishment.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyMinisterialDecree))
               }
              def company_ministerial_decree; end
              sig {
                params(_company_ministerial_decree: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyMinisterialDecree)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyMinisterialDecree))
               }
              def company_ministerial_decree=(_company_ministerial_decree); end
              # One or more documents that demonstrate proof of a company’s registration with the appropriate local authorities.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyRegistrationVerification))
               }
              def company_registration_verification; end
              sig {
                params(_company_registration_verification: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyRegistrationVerification)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyRegistrationVerification))
               }
              def company_registration_verification=(_company_registration_verification); end
              # One or more documents that demonstrate proof of a company’s tax ID.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyTaxIdVerification))
               }
              def company_tax_id_verification; end
              sig {
                params(_company_tax_id_verification: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyTaxIdVerification)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyTaxIdVerification))
               }
              def company_tax_id_verification=(_company_tax_id_verification); end
              # A document verifying the business.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::PrimaryVerification))
               }
              def primary_verification; end
              sig {
                params(_primary_verification: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::PrimaryVerification)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::PrimaryVerification))
               }
              def primary_verification=(_primary_verification); end
              # One or more documents that demonstrate proof of address.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::ProofOfAddress))
               }
              def proof_of_address; end
              sig {
                params(_proof_of_address: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::ProofOfAddress)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::ProofOfAddress))
               }
              def proof_of_address=(_proof_of_address); end
              # One or more documents showing the company’s proof of registration with the national business registry.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::ProofOfRegistration))
               }
              def proof_of_registration; end
              sig {
                params(_proof_of_registration: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::ProofOfRegistration)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::ProofOfRegistration))
               }
              def proof_of_registration=(_proof_of_registration); end
              # One or more documents that demonstrate proof of ultimate beneficial ownership.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::ProofOfUltimateBeneficialOwnership))
               }
              def proof_of_ultimate_beneficial_ownership; end
              sig {
                params(_proof_of_ultimate_beneficial_ownership: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::ProofOfUltimateBeneficialOwnership)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::ProofOfUltimateBeneficialOwnership))
               }
              def proof_of_ultimate_beneficial_ownership=(
                _proof_of_ultimate_beneficial_ownership
              ); end
              sig {
                params(bank_account_ownership_verification: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::BankAccountOwnershipVerification), company_license: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyLicense), company_memorandum_of_association: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyMemorandumOfAssociation), company_ministerial_decree: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyMinisterialDecree), company_registration_verification: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyRegistrationVerification), company_tax_id_verification: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::CompanyTaxIdVerification), primary_verification: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::PrimaryVerification), proof_of_address: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::ProofOfAddress), proof_of_registration: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::ProofOfRegistration), proof_of_ultimate_beneficial_ownership: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents::ProofOfUltimateBeneficialOwnership)).void
               }
              def initialize(
                bank_account_ownership_verification: nil,
                company_license: nil,
                company_memorandum_of_association: nil,
                company_ministerial_decree: nil,
                company_registration_verification: nil,
                company_tax_id_verification: nil,
                primary_verification: nil,
                proof_of_address: nil,
                proof_of_registration: nil,
                proof_of_ultimate_beneficial_ownership: nil
              ); end
            end
            class IdNumber < ::Stripe::RequestParams
              # The registrar of the ID number (Only valid for DE ID number types).
              sig { returns(T.nilable(String)) }
              def registrar; end
              sig { params(_registrar: T.nilable(String)).returns(T.nilable(String)) }
              def registrar=(_registrar); end
              # Open Enum. The ID number type of a business entity.
              sig { returns(String) }
              def type; end
              sig { params(_type: String).returns(String) }
              def type=(_type); end
              # The value of the ID number.
              sig { returns(String) }
              def value; end
              sig { params(_value: String).returns(String) }
              def value=(_value); end
              sig { params(registrar: T.nilable(String), type: String, value: String).void }
              def initialize(registrar: nil, type: nil, value: nil); end
            end
            class MonthlyEstimatedRevenue < ::Stripe::RequestParams
              class Amount < ::Stripe::RequestParams
                # A non-negative integer representing how much to charge in the [smallest currency unit](https://docs.stripe.com/currencies#minor-units).
                sig { returns(T.nilable(Integer)) }
                def value; end
                sig { params(_value: T.nilable(Integer)).returns(T.nilable(Integer)) }
                def value=(_value); end
                # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
                sig { returns(T.nilable(String)) }
                def currency; end
                sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
                def currency=(_currency); end
                sig { params(value: T.nilable(Integer), currency: T.nilable(String)).void }
                def initialize(value: nil, currency: nil); end
              end
              # A non-negative integer representing the amount in the smallest currency unit.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::MonthlyEstimatedRevenue::Amount))
               }
              def amount; end
              sig {
                params(_amount: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::MonthlyEstimatedRevenue::Amount)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::MonthlyEstimatedRevenue::Amount))
               }
              def amount=(_amount); end
              sig {
                params(amount: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::MonthlyEstimatedRevenue::Amount)).void
               }
              def initialize(amount: nil); end
            end
            class ScriptAddresses < ::Stripe::RequestParams
              class Kana < ::Stripe::RequestParams
                # City, district, suburb, town, or village.
                sig { returns(T.nilable(String)) }
                def city; end
                sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
                def city=(_city); end
                # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
                sig { returns(String) }
                def country; end
                sig { params(_country: String).returns(String) }
                def country=(_country); end
                # Address line 1 (e.g., street, PO Box, or company name).
                sig { returns(T.nilable(String)) }
                def line1; end
                sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
                def line1=(_line1); end
                # Address line 2 (e.g., apartment, suite, unit, or building).
                sig { returns(T.nilable(String)) }
                def line2; end
                sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
                def line2=(_line2); end
                # ZIP or postal code.
                sig { returns(T.nilable(String)) }
                def postal_code; end
                sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
                def postal_code=(_postal_code); end
                # State, county, province, or region.
                sig { returns(T.nilable(String)) }
                def state; end
                sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
                def state=(_state); end
                # Town or district.
                sig { returns(T.nilable(String)) }
                def town; end
                sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
                def town=(_town); end
                sig {
                  params(city: T.nilable(String), country: String, line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
                 }
                def initialize(
                  city: nil,
                  country: nil,
                  line1: nil,
                  line2: nil,
                  postal_code: nil,
                  state: nil,
                  town: nil
                ); end
              end
              class Kanji < ::Stripe::RequestParams
                # City, district, suburb, town, or village.
                sig { returns(T.nilable(String)) }
                def city; end
                sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
                def city=(_city); end
                # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
                sig { returns(String) }
                def country; end
                sig { params(_country: String).returns(String) }
                def country=(_country); end
                # Address line 1 (e.g., street, PO Box, or company name).
                sig { returns(T.nilable(String)) }
                def line1; end
                sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
                def line1=(_line1); end
                # Address line 2 (e.g., apartment, suite, unit, or building).
                sig { returns(T.nilable(String)) }
                def line2; end
                sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
                def line2=(_line2); end
                # ZIP or postal code.
                sig { returns(T.nilable(String)) }
                def postal_code; end
                sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
                def postal_code=(_postal_code); end
                # State, county, province, or region.
                sig { returns(T.nilable(String)) }
                def state; end
                sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
                def state=(_state); end
                # Town or district.
                sig { returns(T.nilable(String)) }
                def town; end
                sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
                def town=(_town); end
                sig {
                  params(city: T.nilable(String), country: String, line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
                 }
                def initialize(
                  city: nil,
                  country: nil,
                  line1: nil,
                  line2: nil,
                  postal_code: nil,
                  state: nil,
                  town: nil
                ); end
              end
              # Kana Address.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptAddresses::Kana))
               }
              def kana; end
              sig {
                params(_kana: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptAddresses::Kana)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptAddresses::Kana))
               }
              def kana=(_kana); end
              # Kanji Address.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptAddresses::Kanji))
               }
              def kanji; end
              sig {
                params(_kanji: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptAddresses::Kanji)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptAddresses::Kanji))
               }
              def kanji=(_kanji); end
              sig {
                params(kana: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptAddresses::Kana), kanji: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptAddresses::Kanji)).void
               }
              def initialize(kana: nil, kanji: nil); end
            end
            class ScriptNames < ::Stripe::RequestParams
              class Kana < ::Stripe::RequestParams
                # Registered name of the business.
                sig { returns(T.nilable(String)) }
                def registered_name; end
                sig { params(_registered_name: T.nilable(String)).returns(T.nilable(String)) }
                def registered_name=(_registered_name); end
                sig { params(registered_name: T.nilable(String)).void }
                def initialize(registered_name: nil); end
              end
              class Kanji < ::Stripe::RequestParams
                # Registered name of the business.
                sig { returns(T.nilable(String)) }
                def registered_name; end
                sig { params(_registered_name: T.nilable(String)).returns(T.nilable(String)) }
                def registered_name=(_registered_name); end
                sig { params(registered_name: T.nilable(String)).void }
                def initialize(registered_name: nil); end
              end
              # Kana name.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptNames::Kana))
               }
              def kana; end
              sig {
                params(_kana: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptNames::Kana)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptNames::Kana))
               }
              def kana=(_kana); end
              # Kanji name.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptNames::Kanji))
               }
              def kanji; end
              sig {
                params(_kanji: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptNames::Kanji)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptNames::Kanji))
               }
              def kanji=(_kanji); end
              sig {
                params(kana: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptNames::Kana), kanji: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptNames::Kanji)).void
               }
              def initialize(kana: nil, kanji: nil); end
            end
            # The business registration address of the business entity.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Address))
             }
            def address; end
            sig {
              params(_address: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Address)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Address))
             }
            def address=(_address); end
            # The business gross annual revenue for its preceding fiscal year.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::AnnualRevenue))
             }
            def annual_revenue; end
            sig {
              params(_annual_revenue: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::AnnualRevenue)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::AnnualRevenue))
             }
            def annual_revenue=(_annual_revenue); end
            # A document verifying the business.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents))
             }
            def documents; end
            sig {
              params(_documents: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents))
             }
            def documents=(_documents); end
            # Estimated maximum number of workers currently engaged by the business (including employees, contractors, and vendors).
            sig { returns(T.nilable(Integer)) }
            def estimated_worker_count; end
            sig { params(_estimated_worker_count: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def estimated_worker_count=(_estimated_worker_count); end
            # The ID numbers of a business entity.
            sig {
              returns(T.nilable(T::Array[V2::Core::AccountCreateParams::Identity::BusinessDetails::IdNumber]))
             }
            def id_numbers; end
            sig {
              params(_id_numbers: T.nilable(T::Array[V2::Core::AccountCreateParams::Identity::BusinessDetails::IdNumber])).returns(T.nilable(T::Array[V2::Core::AccountCreateParams::Identity::BusinessDetails::IdNumber]))
             }
            def id_numbers=(_id_numbers); end
            # An estimate of the monthly revenue of the business.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::MonthlyEstimatedRevenue))
             }
            def monthly_estimated_revenue; end
            sig {
              params(_monthly_estimated_revenue: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::MonthlyEstimatedRevenue)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::MonthlyEstimatedRevenue))
             }
            def monthly_estimated_revenue=(_monthly_estimated_revenue); end
            # The phone number of the Business Entity.
            sig { returns(T.nilable(String)) }
            def phone; end
            sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
            def phone=(_phone); end
            # The business legal name.
            sig { returns(T.nilable(String)) }
            def registered_name; end
            sig { params(_registered_name: T.nilable(String)).returns(T.nilable(String)) }
            def registered_name=(_registered_name); end
            # The business registration address of the business entity in non latin script.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptAddresses))
             }
            def script_addresses; end
            sig {
              params(_script_addresses: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptAddresses)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptAddresses))
             }
            def script_addresses=(_script_addresses); end
            # The business legal name in non latin script.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptNames))
             }
            def script_names; end
            sig {
              params(_script_names: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptNames)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptNames))
             }
            def script_names=(_script_names); end
            # The category identifying the legal structure of the business.
            sig { returns(T.nilable(String)) }
            def structure; end
            sig { params(_structure: T.nilable(String)).returns(T.nilable(String)) }
            def structure=(_structure); end
            sig {
              params(address: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Address), annual_revenue: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::AnnualRevenue), documents: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::Documents), estimated_worker_count: T.nilable(Integer), id_numbers: T.nilable(T::Array[V2::Core::AccountCreateParams::Identity::BusinessDetails::IdNumber]), monthly_estimated_revenue: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::MonthlyEstimatedRevenue), phone: T.nilable(String), registered_name: T.nilable(String), script_addresses: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptAddresses), script_names: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails::ScriptNames), structure: T.nilable(String)).void
             }
            def initialize(
              address: nil,
              annual_revenue: nil,
              documents: nil,
              estimated_worker_count: nil,
              id_numbers: nil,
              monthly_estimated_revenue: nil,
              phone: nil,
              registered_name: nil,
              script_addresses: nil,
              script_names: nil,
              structure: nil
            ); end
          end
          class Individual < ::Stripe::RequestParams
            class AdditionalAddress < ::Stripe::RequestParams
              # City, district, suburb, town, or village.
              sig { returns(T.nilable(String)) }
              def city; end
              sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
              def city=(_city); end
              # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
              sig { returns(String) }
              def country; end
              sig { params(_country: String).returns(String) }
              def country=(_country); end
              # Address line 1 (e.g., street, PO Box, or company name).
              sig { returns(T.nilable(String)) }
              def line1; end
              sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
              def line1=(_line1); end
              # Address line 2 (e.g., apartment, suite, unit, or building).
              sig { returns(T.nilable(String)) }
              def line2; end
              sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
              def line2=(_line2); end
              # ZIP or postal code.
              sig { returns(T.nilable(String)) }
              def postal_code; end
              sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
              def postal_code=(_postal_code); end
              # Purpose of additional address.
              sig { returns(String) }
              def purpose; end
              sig { params(_purpose: String).returns(String) }
              def purpose=(_purpose); end
              # State, county, province, or region.
              sig { returns(T.nilable(String)) }
              def state; end
              sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
              def state=(_state); end
              # Town or district.
              sig { returns(T.nilable(String)) }
              def town; end
              sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
              def town=(_town); end
              sig {
                params(city: T.nilable(String), country: String, line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), purpose: String, state: T.nilable(String), town: T.nilable(String)).void
               }
              def initialize(
                city: nil,
                country: nil,
                line1: nil,
                line2: nil,
                postal_code: nil,
                purpose: nil,
                state: nil,
                town: nil
              ); end
            end
            class AdditionalName < ::Stripe::RequestParams
              # The person's full name.
              sig { returns(T.nilable(String)) }
              def full_name; end
              sig { params(_full_name: T.nilable(String)).returns(T.nilable(String)) }
              def full_name=(_full_name); end
              # The person's first or given name.
              sig { returns(T.nilable(String)) }
              def given_name; end
              sig { params(_given_name: T.nilable(String)).returns(T.nilable(String)) }
              def given_name=(_given_name); end
              # The purpose or type of the additional name.
              sig { returns(String) }
              def purpose; end
              sig { params(_purpose: String).returns(String) }
              def purpose=(_purpose); end
              # The person's last or family name.
              sig { returns(T.nilable(String)) }
              def surname; end
              sig { params(_surname: T.nilable(String)).returns(T.nilable(String)) }
              def surname=(_surname); end
              sig {
                params(full_name: T.nilable(String), given_name: T.nilable(String), purpose: String, surname: T.nilable(String)).void
               }
              def initialize(full_name: nil, given_name: nil, purpose: nil, surname: nil); end
            end
            class Address < ::Stripe::RequestParams
              # City, district, suburb, town, or village.
              sig { returns(T.nilable(String)) }
              def city; end
              sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
              def city=(_city); end
              # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
              sig { returns(String) }
              def country; end
              sig { params(_country: String).returns(String) }
              def country=(_country); end
              # Address line 1 (e.g., street, PO Box, or company name).
              sig { returns(T.nilable(String)) }
              def line1; end
              sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
              def line1=(_line1); end
              # Address line 2 (e.g., apartment, suite, unit, or building).
              sig { returns(T.nilable(String)) }
              def line2; end
              sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
              def line2=(_line2); end
              # ZIP or postal code.
              sig { returns(T.nilable(String)) }
              def postal_code; end
              sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
              def postal_code=(_postal_code); end
              # State, county, province, or region.
              sig { returns(T.nilable(String)) }
              def state; end
              sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
              def state=(_state); end
              # Town or district.
              sig { returns(T.nilable(String)) }
              def town; end
              sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
              def town=(_town); end
              sig {
                params(city: T.nilable(String), country: String, line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
               }
              def initialize(
                city: nil,
                country: nil,
                line1: nil,
                line2: nil,
                postal_code: nil,
                state: nil,
                town: nil
              ); end
            end
            class DateOfBirth < ::Stripe::RequestParams
              # The day of birth.
              sig { returns(Integer) }
              def day; end
              sig { params(_day: Integer).returns(Integer) }
              def day=(_day); end
              # The month of birth.
              sig { returns(Integer) }
              def month; end
              sig { params(_month: Integer).returns(Integer) }
              def month=(_month); end
              # The year of birth.
              sig { returns(Integer) }
              def year; end
              sig { params(_year: Integer).returns(Integer) }
              def year=(_year); end
              sig { params(day: Integer, month: Integer, year: Integer).void }
              def initialize(day: nil, month: nil, year: nil); end
            end
            class Documents < ::Stripe::RequestParams
              class CompanyAuthorization < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                sig { params(_files: T::Array[String]).returns(T::Array[String]) }
                def files=(_files); end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig { params(files: T::Array[String], type: String).void }
                def initialize(files: nil, type: nil); end
              end
              class Passport < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                sig { params(_files: T::Array[String]).returns(T::Array[String]) }
                def files=(_files); end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig { params(files: T::Array[String], type: String).void }
                def initialize(files: nil, type: nil); end
              end
              class PrimaryVerification < ::Stripe::RequestParams
                class FrontBack < ::Stripe::RequestParams
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the back of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  sig { returns(T.nilable(String)) }
                  def back; end
                  sig { params(_back: T.nilable(String)).returns(T.nilable(String)) }
                  def back=(_back); end
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the front of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  sig { returns(String) }
                  def front; end
                  sig { params(_front: String).returns(String) }
                  def front=(_front); end
                  sig { params(back: T.nilable(String), front: String).void }
                  def initialize(back: nil, front: nil); end
                end
                # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens referring to each side of the document.
                sig {
                  returns(V2::Core::AccountCreateParams::Identity::Individual::Documents::PrimaryVerification::FrontBack)
                 }
                def front_back; end
                sig {
                  params(_front_back: V2::Core::AccountCreateParams::Identity::Individual::Documents::PrimaryVerification::FrontBack).returns(V2::Core::AccountCreateParams::Identity::Individual::Documents::PrimaryVerification::FrontBack)
                 }
                def front_back=(_front_back); end
                # The format of the verification document. Currently supports `front_back` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig {
                  params(front_back: V2::Core::AccountCreateParams::Identity::Individual::Documents::PrimaryVerification::FrontBack, type: String).void
                 }
                def initialize(front_back: nil, type: nil); end
              end
              class SecondaryVerification < ::Stripe::RequestParams
                class FrontBack < ::Stripe::RequestParams
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the back of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  sig { returns(T.nilable(String)) }
                  def back; end
                  sig { params(_back: T.nilable(String)).returns(T.nilable(String)) }
                  def back=(_back); end
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the front of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  sig { returns(String) }
                  def front; end
                  sig { params(_front: String).returns(String) }
                  def front=(_front); end
                  sig { params(back: T.nilable(String), front: String).void }
                  def initialize(back: nil, front: nil); end
                end
                # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens referring to each side of the document.
                sig {
                  returns(V2::Core::AccountCreateParams::Identity::Individual::Documents::SecondaryVerification::FrontBack)
                 }
                def front_back; end
                sig {
                  params(_front_back: V2::Core::AccountCreateParams::Identity::Individual::Documents::SecondaryVerification::FrontBack).returns(V2::Core::AccountCreateParams::Identity::Individual::Documents::SecondaryVerification::FrontBack)
                 }
                def front_back=(_front_back); end
                # The format of the verification document. Currently supports `front_back` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig {
                  params(front_back: V2::Core::AccountCreateParams::Identity::Individual::Documents::SecondaryVerification::FrontBack, type: String).void
                 }
                def initialize(front_back: nil, type: nil); end
              end
              class Visa < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                sig { params(_files: T::Array[String]).returns(T::Array[String]) }
                def files=(_files); end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig { params(files: T::Array[String], type: String).void }
                def initialize(files: nil, type: nil); end
              end
              # One or more documents that demonstrate proof that this person is authorized to represent the company.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::CompanyAuthorization))
               }
              def company_authorization; end
              sig {
                params(_company_authorization: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::CompanyAuthorization)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::CompanyAuthorization))
               }
              def company_authorization=(_company_authorization); end
              # One or more documents showing the person’s passport page with photo and personal data.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::Passport))
               }
              def passport; end
              sig {
                params(_passport: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::Passport)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::Passport))
               }
              def passport=(_passport); end
              # An identifying document showing the person's name, either a passport or local ID card.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::PrimaryVerification))
               }
              def primary_verification; end
              sig {
                params(_primary_verification: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::PrimaryVerification)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::PrimaryVerification))
               }
              def primary_verification=(_primary_verification); end
              # A document showing address, either a passport, local ID card, or utility bill from a well-known utility company.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::SecondaryVerification))
               }
              def secondary_verification; end
              sig {
                params(_secondary_verification: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::SecondaryVerification)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::SecondaryVerification))
               }
              def secondary_verification=(_secondary_verification); end
              # One or more documents showing the person’s visa required for living in the country where they are residing.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::Visa))
               }
              def visa; end
              sig {
                params(_visa: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::Visa)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::Visa))
               }
              def visa=(_visa); end
              sig {
                params(company_authorization: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::CompanyAuthorization), passport: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::Passport), primary_verification: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::PrimaryVerification), secondary_verification: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::SecondaryVerification), visa: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents::Visa)).void
               }
              def initialize(
                company_authorization: nil,
                passport: nil,
                primary_verification: nil,
                secondary_verification: nil,
                visa: nil
              ); end
            end
            class IdNumber < ::Stripe::RequestParams
              # The ID number type of an individual.
              sig { returns(String) }
              def type; end
              sig { params(_type: String).returns(String) }
              def type=(_type); end
              # The value of the ID number.
              sig { returns(String) }
              def value; end
              sig { params(_value: String).returns(String) }
              def value=(_value); end
              sig { params(type: String, value: String).void }
              def initialize(type: nil, value: nil); end
            end
            class Relationship < ::Stripe::RequestParams
              # Whether the person is a director of the account's identity. Directors are typically members of the governing board of the company, or responsible for ensuring the company meets its regulatory obligations.
              sig { returns(T.nilable(T::Boolean)) }
              def director; end
              sig { params(_director: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
              def director=(_director); end
              # Whether the person has significant responsibility to control, manage, or direct the organization.
              sig { returns(T.nilable(T::Boolean)) }
              def executive; end
              sig { params(_executive: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
              def executive=(_executive); end
              # Whether the person is an owner of the account’s identity.
              sig { returns(T.nilable(T::Boolean)) }
              def owner; end
              sig { params(_owner: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
              def owner=(_owner); end
              # The percent owned by the person of the account's legal entity.
              sig { returns(T.nilable(String)) }
              def percent_ownership; end
              sig { params(_percent_ownership: T.nilable(String)).returns(T.nilable(String)) }
              def percent_ownership=(_percent_ownership); end
              # The person's title (e.g., CEO, Support Engineer).
              sig { returns(T.nilable(String)) }
              def title; end
              sig { params(_title: T.nilable(String)).returns(T.nilable(String)) }
              def title=(_title); end
              sig {
                params(director: T.nilable(T::Boolean), executive: T.nilable(T::Boolean), owner: T.nilable(T::Boolean), percent_ownership: T.nilable(String), title: T.nilable(String)).void
               }
              def initialize(
                director: nil,
                executive: nil,
                owner: nil,
                percent_ownership: nil,
                title: nil
              ); end
            end
            class ScriptAddresses < ::Stripe::RequestParams
              class Kana < ::Stripe::RequestParams
                # City, district, suburb, town, or village.
                sig { returns(T.nilable(String)) }
                def city; end
                sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
                def city=(_city); end
                # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
                sig { returns(String) }
                def country; end
                sig { params(_country: String).returns(String) }
                def country=(_country); end
                # Address line 1 (e.g., street, PO Box, or company name).
                sig { returns(T.nilable(String)) }
                def line1; end
                sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
                def line1=(_line1); end
                # Address line 2 (e.g., apartment, suite, unit, or building).
                sig { returns(T.nilable(String)) }
                def line2; end
                sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
                def line2=(_line2); end
                # ZIP or postal code.
                sig { returns(T.nilable(String)) }
                def postal_code; end
                sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
                def postal_code=(_postal_code); end
                # State, county, province, or region.
                sig { returns(T.nilable(String)) }
                def state; end
                sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
                def state=(_state); end
                # Town or district.
                sig { returns(T.nilable(String)) }
                def town; end
                sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
                def town=(_town); end
                sig {
                  params(city: T.nilable(String), country: String, line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
                 }
                def initialize(
                  city: nil,
                  country: nil,
                  line1: nil,
                  line2: nil,
                  postal_code: nil,
                  state: nil,
                  town: nil
                ); end
              end
              class Kanji < ::Stripe::RequestParams
                # City, district, suburb, town, or village.
                sig { returns(T.nilable(String)) }
                def city; end
                sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
                def city=(_city); end
                # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
                sig { returns(String) }
                def country; end
                sig { params(_country: String).returns(String) }
                def country=(_country); end
                # Address line 1 (e.g., street, PO Box, or company name).
                sig { returns(T.nilable(String)) }
                def line1; end
                sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
                def line1=(_line1); end
                # Address line 2 (e.g., apartment, suite, unit, or building).
                sig { returns(T.nilable(String)) }
                def line2; end
                sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
                def line2=(_line2); end
                # ZIP or postal code.
                sig { returns(T.nilable(String)) }
                def postal_code; end
                sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
                def postal_code=(_postal_code); end
                # State, county, province, or region.
                sig { returns(T.nilable(String)) }
                def state; end
                sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
                def state=(_state); end
                # Town or district.
                sig { returns(T.nilable(String)) }
                def town; end
                sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
                def town=(_town); end
                sig {
                  params(city: T.nilable(String), country: String, line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
                 }
                def initialize(
                  city: nil,
                  country: nil,
                  line1: nil,
                  line2: nil,
                  postal_code: nil,
                  state: nil,
                  town: nil
                ); end
              end
              # Kana Address.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptAddresses::Kana))
               }
              def kana; end
              sig {
                params(_kana: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptAddresses::Kana)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptAddresses::Kana))
               }
              def kana=(_kana); end
              # Kanji Address.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptAddresses::Kanji))
               }
              def kanji; end
              sig {
                params(_kanji: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptAddresses::Kanji)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptAddresses::Kanji))
               }
              def kanji=(_kanji); end
              sig {
                params(kana: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptAddresses::Kana), kanji: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptAddresses::Kanji)).void
               }
              def initialize(kana: nil, kanji: nil); end
            end
            class ScriptNames < ::Stripe::RequestParams
              class Kana < ::Stripe::RequestParams
                # The person's first or given name.
                sig { returns(T.nilable(String)) }
                def given_name; end
                sig { params(_given_name: T.nilable(String)).returns(T.nilable(String)) }
                def given_name=(_given_name); end
                # The person's last or family name.
                sig { returns(T.nilable(String)) }
                def surname; end
                sig { params(_surname: T.nilable(String)).returns(T.nilable(String)) }
                def surname=(_surname); end
                sig { params(given_name: T.nilable(String), surname: T.nilable(String)).void }
                def initialize(given_name: nil, surname: nil); end
              end
              class Kanji < ::Stripe::RequestParams
                # The person's first or given name.
                sig { returns(T.nilable(String)) }
                def given_name; end
                sig { params(_given_name: T.nilable(String)).returns(T.nilable(String)) }
                def given_name=(_given_name); end
                # The person's last or family name.
                sig { returns(T.nilable(String)) }
                def surname; end
                sig { params(_surname: T.nilable(String)).returns(T.nilable(String)) }
                def surname=(_surname); end
                sig { params(given_name: T.nilable(String), surname: T.nilable(String)).void }
                def initialize(given_name: nil, surname: nil); end
              end
              # Persons name in kana script.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptNames::Kana))
               }
              def kana; end
              sig {
                params(_kana: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptNames::Kana)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptNames::Kana))
               }
              def kana=(_kana); end
              # Persons name in kanji script.
              sig {
                returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptNames::Kanji))
               }
              def kanji; end
              sig {
                params(_kanji: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptNames::Kanji)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptNames::Kanji))
               }
              def kanji=(_kanji); end
              sig {
                params(kana: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptNames::Kana), kanji: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptNames::Kanji)).void
               }
              def initialize(kana: nil, kanji: nil); end
            end
            # Additional addresses associated with the individual.
            sig {
              returns(T.nilable(T::Array[V2::Core::AccountCreateParams::Identity::Individual::AdditionalAddress]))
             }
            def additional_addresses; end
            sig {
              params(_additional_addresses: T.nilable(T::Array[V2::Core::AccountCreateParams::Identity::Individual::AdditionalAddress])).returns(T.nilable(T::Array[V2::Core::AccountCreateParams::Identity::Individual::AdditionalAddress]))
             }
            def additional_addresses=(_additional_addresses); end
            # Additional names (e.g. aliases) associated with the individual.
            sig {
              returns(T.nilable(T::Array[V2::Core::AccountCreateParams::Identity::Individual::AdditionalName]))
             }
            def additional_names; end
            sig {
              params(_additional_names: T.nilable(T::Array[V2::Core::AccountCreateParams::Identity::Individual::AdditionalName])).returns(T.nilable(T::Array[V2::Core::AccountCreateParams::Identity::Individual::AdditionalName]))
             }
            def additional_names=(_additional_names); end
            # The individual's residential address.
            sig { returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Address)) }
            def address; end
            sig {
              params(_address: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Address)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Address))
             }
            def address=(_address); end
            # The individual's date of birth.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::DateOfBirth))
             }
            def date_of_birth; end
            sig {
              params(_date_of_birth: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::DateOfBirth)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::DateOfBirth))
             }
            def date_of_birth=(_date_of_birth); end
            # Documents that may be submitted to satisfy various informational requests.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents))
             }
            def documents; end
            sig {
              params(_documents: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents))
             }
            def documents=(_documents); end
            # The individual's email address.
            sig { returns(T.nilable(String)) }
            def email; end
            sig { params(_email: T.nilable(String)).returns(T.nilable(String)) }
            def email=(_email); end
            # The individual's first name.
            sig { returns(T.nilable(String)) }
            def given_name; end
            sig { params(_given_name: T.nilable(String)).returns(T.nilable(String)) }
            def given_name=(_given_name); end
            # The identification numbers (e.g., SSN) associated with the individual.
            sig {
              returns(T.nilable(T::Array[V2::Core::AccountCreateParams::Identity::Individual::IdNumber]))
             }
            def id_numbers; end
            sig {
              params(_id_numbers: T.nilable(T::Array[V2::Core::AccountCreateParams::Identity::Individual::IdNumber])).returns(T.nilable(T::Array[V2::Core::AccountCreateParams::Identity::Individual::IdNumber]))
             }
            def id_numbers=(_id_numbers); end
            # The individual's gender (International regulations require either "male" or "female").
            sig { returns(T.nilable(String)) }
            def legal_gender; end
            sig { params(_legal_gender: T.nilable(String)).returns(T.nilable(String)) }
            def legal_gender=(_legal_gender); end
            # Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
            sig { returns(T.nilable(T::Hash[String, String])) }
            def metadata; end
            sig {
              params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
             }
            def metadata=(_metadata); end
            # The countries where the individual is a national. Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
            sig { returns(T.nilable(T::Array[String])) }
            def nationalities; end
            sig {
              params(_nationalities: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
             }
            def nationalities=(_nationalities); end
            # The individual's phone number.
            sig { returns(T.nilable(String)) }
            def phone; end
            sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
            def phone=(_phone); end
            # The individual's political exposure.
            sig { returns(T.nilable(String)) }
            def political_exposure; end
            sig { params(_political_exposure: T.nilable(String)).returns(T.nilable(String)) }
            def political_exposure=(_political_exposure); end
            # The relationship that this individual has with the account's identity.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Relationship))
             }
            def relationship; end
            sig {
              params(_relationship: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Relationship)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Relationship))
             }
            def relationship=(_relationship); end
            # The script addresses (e.g., non-Latin characters) associated with the individual.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptAddresses))
             }
            def script_addresses; end
            sig {
              params(_script_addresses: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptAddresses)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptAddresses))
             }
            def script_addresses=(_script_addresses); end
            # The individuals primary name in non latin script.
            sig {
              returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptNames))
             }
            def script_names; end
            sig {
              params(_script_names: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptNames)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptNames))
             }
            def script_names=(_script_names); end
            # The individual's last name.
            sig { returns(T.nilable(String)) }
            def surname; end
            sig { params(_surname: T.nilable(String)).returns(T.nilable(String)) }
            def surname=(_surname); end
            sig {
              params(additional_addresses: T.nilable(T::Array[V2::Core::AccountCreateParams::Identity::Individual::AdditionalAddress]), additional_names: T.nilable(T::Array[V2::Core::AccountCreateParams::Identity::Individual::AdditionalName]), address: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Address), date_of_birth: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::DateOfBirth), documents: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Documents), email: T.nilable(String), given_name: T.nilable(String), id_numbers: T.nilable(T::Array[V2::Core::AccountCreateParams::Identity::Individual::IdNumber]), legal_gender: T.nilable(String), metadata: T.nilable(T::Hash[String, String]), nationalities: T.nilable(T::Array[String]), phone: T.nilable(String), political_exposure: T.nilable(String), relationship: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::Relationship), script_addresses: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptAddresses), script_names: T.nilable(V2::Core::AccountCreateParams::Identity::Individual::ScriptNames), surname: T.nilable(String)).void
             }
            def initialize(
              additional_addresses: nil,
              additional_names: nil,
              address: nil,
              date_of_birth: nil,
              documents: nil,
              email: nil,
              given_name: nil,
              id_numbers: nil,
              legal_gender: nil,
              metadata: nil,
              nationalities: nil,
              phone: nil,
              political_exposure: nil,
              relationship: nil,
              script_addresses: nil,
              script_names: nil,
              surname: nil
            ); end
          end
          # Attestations from the identity's key people, e.g. owners, executives, directors, representatives.
          sig { returns(T.nilable(V2::Core::AccountCreateParams::Identity::Attestations)) }
          def attestations; end
          sig {
            params(_attestations: T.nilable(V2::Core::AccountCreateParams::Identity::Attestations)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Attestations))
           }
          def attestations=(_attestations); end
          # Information about the company or business.
          sig { returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails)) }
          def business_details; end
          sig {
            params(_business_details: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails))
           }
          def business_details=(_business_details); end
          # The country in which the account holder resides, or in which the business is legally established. This should be an [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code.
          sig { returns(T.nilable(String)) }
          def country; end
          sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
          def country=(_country); end
          # The entity type.
          sig { returns(T.nilable(String)) }
          def entity_type; end
          sig { params(_entity_type: T.nilable(String)).returns(T.nilable(String)) }
          def entity_type=(_entity_type); end
          # Information about the person represented by the account.
          sig { returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual)) }
          def individual; end
          sig {
            params(_individual: T.nilable(V2::Core::AccountCreateParams::Identity::Individual)).returns(T.nilable(V2::Core::AccountCreateParams::Identity::Individual))
           }
          def individual=(_individual); end
          sig {
            params(attestations: T.nilable(V2::Core::AccountCreateParams::Identity::Attestations), business_details: T.nilable(V2::Core::AccountCreateParams::Identity::BusinessDetails), country: T.nilable(String), entity_type: T.nilable(String), individual: T.nilable(V2::Core::AccountCreateParams::Identity::Individual)).void
           }
          def initialize(
            attestations: nil,
            business_details: nil,
            country: nil,
            entity_type: nil,
            individual: nil
          ); end
        end
        # The account token generated by the account token api.
        sig { returns(T.nilable(String)) }
        def account_token; end
        sig { params(_account_token: T.nilable(String)).returns(T.nilable(String)) }
        def account_token=(_account_token); end
        # An Account Configuration which allows the Account to take on a key persona across Stripe products.
        sig { returns(T.nilable(V2::Core::AccountCreateParams::Configuration)) }
        def configuration; end
        sig {
          params(_configuration: T.nilable(V2::Core::AccountCreateParams::Configuration)).returns(T.nilable(V2::Core::AccountCreateParams::Configuration))
         }
        def configuration=(_configuration); end
        # The default contact email address for the Account. Required when configuring the account as a merchant or recipient.
        sig { returns(T.nilable(String)) }
        def contact_email; end
        sig { params(_contact_email: T.nilable(String)).returns(T.nilable(String)) }
        def contact_email=(_contact_email); end
        # A value indicating the Stripe dashboard this Account has access to. This will depend on which configurations are enabled for this account.
        sig { returns(T.nilable(String)) }
        def dashboard; end
        sig { params(_dashboard: T.nilable(String)).returns(T.nilable(String)) }
        def dashboard=(_dashboard); end
        # Default values to be used on Account Configurations.
        sig { returns(T.nilable(V2::Core::AccountCreateParams::Defaults)) }
        def defaults; end
        sig {
          params(_defaults: T.nilable(V2::Core::AccountCreateParams::Defaults)).returns(T.nilable(V2::Core::AccountCreateParams::Defaults))
         }
        def defaults=(_defaults); end
        # A descriptive name for the Account. This name will be surfaced in the Stripe Dashboard and on any invoices sent to the Account.
        sig { returns(T.nilable(String)) }
        def display_name; end
        sig { params(_display_name: T.nilable(String)).returns(T.nilable(String)) }
        def display_name=(_display_name); end
        # Information about the company, individual, and business represented by the Account.
        sig { returns(T.nilable(V2::Core::AccountCreateParams::Identity)) }
        def identity; end
        sig {
          params(_identity: T.nilable(V2::Core::AccountCreateParams::Identity)).returns(T.nilable(V2::Core::AccountCreateParams::Identity))
         }
        def identity=(_identity); end
        # Additional fields to include in the response.
        sig { returns(T.nilable(T::Array[String])) }
        def include; end
        sig { params(_include: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
        def include=(_include); end
        # Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        sig { returns(T.nilable(T::Hash[String, String])) }
        def metadata; end
        sig {
          params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
         }
        def metadata=(_metadata); end
        sig {
          params(account_token: T.nilable(String), configuration: T.nilable(V2::Core::AccountCreateParams::Configuration), contact_email: T.nilable(String), dashboard: T.nilable(String), defaults: T.nilable(V2::Core::AccountCreateParams::Defaults), display_name: T.nilable(String), identity: T.nilable(V2::Core::AccountCreateParams::Identity), include: T.nilable(T::Array[String]), metadata: T.nilable(T::Hash[String, String])).void
         }
        def initialize(
          account_token: nil,
          configuration: nil,
          contact_email: nil,
          dashboard: nil,
          defaults: nil,
          display_name: nil,
          identity: nil,
          include: nil,
          metadata: nil
        ); end
      end
    end
  end
end