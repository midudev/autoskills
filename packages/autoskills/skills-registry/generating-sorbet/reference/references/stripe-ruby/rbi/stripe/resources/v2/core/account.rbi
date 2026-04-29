# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      # A V2 Account is a representation of a company or individual that a Stripe user does business with. Accounts contain the contact details, Legal Entity information, and configuration required to enable the Account for use across Stripe products.
      class Account < APIResource
        class Configuration < ::Stripe::StripeObject
          class Customer < ::Stripe::StripeObject
            class AutomaticIndirectTax < ::Stripe::StripeObject
              class Location < ::Stripe::StripeObject
                # The identified tax country of the customer.
                sig { returns(T.nilable(String)) }
                def country; end
                # The identified tax state, county, province, or region of the customer.
                sig { returns(T.nilable(String)) }
                def state; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # The customer account's tax exemption status: `none`, `exempt`, or `reverse`. When `reverse`, invoice and receipt PDFs include "Reverse charge".
              sig { returns(T.nilable(String)) }
              def exempt; end
              # A recent IP address of the customer used for tax reporting and tax location inference.
              sig { returns(T.nilable(String)) }
              def ip_address; end
              # The customer account's identified tax location, derived from `location_source`. Only rendered if the `automatic_indirect_tax` feature is requested and `active`.
              sig { returns(T.nilable(Location)) }
              def location; end
              # Data source used to identify the customer account's tax location. Defaults to `identity_address`. Used for automatic indirect tax calculation.
              sig { returns(T.nilable(String)) }
              def location_source; end
              def self.inner_class_types
                @inner_class_types = {location: Location}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Billing < ::Stripe::StripeObject
              class Invoice < ::Stripe::StripeObject
                class CustomField < ::Stripe::StripeObject
                  # The name of the custom field. This may be up to 40 characters.
                  sig { returns(String) }
                  def name; end
                  # The value of the custom field. This may be up to 140 characters. When updating, pass an empty string to remove previously-defined values.
                  sig { returns(String) }
                  def value; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                class Rendering < ::Stripe::StripeObject
                  # Indicates whether displayed line item prices and amounts on invoice PDFs include inclusive tax amounts. Must be either `include_inclusive_tax` or `exclude_tax`.
                  sig { returns(T.nilable(String)) }
                  def amount_tax_display; end
                  # ID of the invoice rendering template to use for future invoices.
                  sig { returns(T.nilable(String)) }
                  def template; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The list of up to 4 default custom fields to be displayed on invoices for this customer. When updating, pass an empty string to remove previously-defined fields.
                sig { returns(T::Array[CustomField]) }
                def custom_fields; end
                # Default invoice footer.
                sig { returns(T.nilable(String)) }
                def footer; end
                # Sequence number to use on the customer account's next invoice. Defaults to 1.
                sig { returns(T.nilable(Integer)) }
                def next_sequence; end
                # Prefix used to generate unique invoice numbers. Must be 3-12 uppercase letters or numbers.
                sig { returns(T.nilable(String)) }
                def prefix; end
                # Default invoice PDF rendering options.
                sig { returns(T.nilable(Rendering)) }
                def rendering; end
                def self.inner_class_types
                  @inner_class_types = {custom_fields: CustomField, rendering: Rendering}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # ID of a PaymentMethod attached to the customer account to use as the default for invoices and subscriptions.
              sig { returns(T.nilable(String)) }
              def default_payment_method; end
              # Default invoice settings for the customer account.
              sig { returns(T.nilable(Invoice)) }
              def invoice; end
              def self.inner_class_types
                @inner_class_types = {invoice: Invoice}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Capabilities < ::Stripe::StripeObject
              class AutomaticIndirectTax < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # Generates requirements for enabling automatic indirect tax calculation on this customer's invoices or subscriptions. Recommended to request this capability if planning to enable automatic tax calculation on this customer's invoices or subscriptions.
              sig { returns(T.nilable(AutomaticIndirectTax)) }
              def automatic_indirect_tax; end
              def self.inner_class_types
                @inner_class_types = {automatic_indirect_tax: AutomaticIndirectTax}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Shipping < ::Stripe::StripeObject
              class Address < ::Stripe::StripeObject
                # City, district, suburb, town, or village.
                sig { returns(T.nilable(String)) }
                def city; end
                # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
                sig { returns(T.nilable(String)) }
                def country; end
                # Address line 1 (e.g., street, PO Box, or company name).
                sig { returns(T.nilable(String)) }
                def line1; end
                # Address line 2 (e.g., apartment, suite, unit, or building).
                sig { returns(T.nilable(String)) }
                def line2; end
                # ZIP or postal code.
                sig { returns(T.nilable(String)) }
                def postal_code; end
                # State, county, province, or region.
                sig { returns(T.nilable(String)) }
                def state; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # Customer shipping address.
              sig { returns(T.nilable(Address)) }
              def address; end
              # Customer name.
              sig { returns(T.nilable(String)) }
              def name; end
              # Customer phone (including extension).
              sig { returns(T.nilable(String)) }
              def phone; end
              def self.inner_class_types
                @inner_class_types = {address: Address}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Indicates whether the customer configuration is active. You can deactivate or reactivate the customer configuration by updating this property. Deactivating the configuration by setting this value to false will unrequest all capabilities within the configuration. It will not delete any of the configuration's other properties.
            sig { returns(T::Boolean) }
            def applied; end
            # Settings for automatic indirect tax calculation on the customer's invoices, subscriptions, Checkout Sessions, and Payment Links. Available when automatic tax calculation is available for the customer account's location.
            sig { returns(T.nilable(AutomaticIndirectTax)) }
            def automatic_indirect_tax; end
            # Default Billing settings for the customer account, used in Invoices and Subscriptions.
            sig { returns(T.nilable(Billing)) }
            def billing; end
            # Capabilities that have been requested on the Customer Configuration.
            sig { returns(T.nilable(Capabilities)) }
            def capabilities; end
            # The customer's shipping information. Appears on invoices emailed to this customer.
            sig { returns(T.nilable(Shipping)) }
            def shipping; end
            # ID of the test clock to attach to the customer. Can only be set on testmode Accounts, and when the Customer Configuration is first set on an Account.
            sig { returns(T.nilable(String)) }
            def test_clock; end
            def self.inner_class_types
              @inner_class_types = {
                automatic_indirect_tax: AutomaticIndirectTax,
                billing: Billing,
                capabilities: Capabilities,
                shipping: Shipping,
              }
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class Merchant < ::Stripe::StripeObject
            class BacsDebitPayments < ::Stripe::StripeObject
              # Display name for Bacs Direct Debit payments.
              sig { returns(T.nilable(String)) }
              def display_name; end
              # Service User Number (SUN) for Bacs Direct Debit payments.
              sig { returns(T.nilable(String)) }
              def service_user_number; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Branding < ::Stripe::StripeObject
              # ID of a [file upload](https://docs.stripe.com/api/persons/update#create_file): An icon for the merchant. Must be square and at least 128px x 128px.
              sig { returns(T.nilable(String)) }
              def icon; end
              # ID of a [file upload](https://docs.stripe.com/api/persons/update#create_file): A logo for the merchant that will be used in Checkout instead of the icon and without the merchant's name next to it if provided. Must be at least 128px x 128px.
              sig { returns(T.nilable(String)) }
              def logo; end
              # A CSS hex color value representing the primary branding color for the merchant.
              sig { returns(T.nilable(String)) }
              def primary_color; end
              # A CSS hex color value representing the secondary branding color for the merchant.
              sig { returns(T.nilable(String)) }
              def secondary_color; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Capabilities < ::Stripe::StripeObject
              class AchDebitPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class AcssDebitPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class AffirmPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class AfterpayClearpayPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class AlmaPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class AmazonPayPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class AuBecsDebitPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class BacsDebitPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class BancontactPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class BlikPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class BoletoPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class CardPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class CartesBancairesPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class CashappPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class EpsPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class FpxPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class GbBankTransferPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class GrabpayPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class IdealPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class JcbPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class JpBankTransferPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class KakaoPayPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class KlarnaPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class KonbiniPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class KrCardPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class LinkPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class MobilepayPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class MultibancoPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class MxBankTransferPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class NaverPayPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class OxxoPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class P24Payments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class PayByBankPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class PaycoPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class PaynowPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class PromptpayPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class RevolutPayPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class SamsungPayPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class SepaBankTransferPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class SepaDebitPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class StripeBalance < ::Stripe::StripeObject
                class Payouts < ::Stripe::StripeObject
                  class StatusDetail < ::Stripe::StripeObject
                    # Machine-readable code explaining the reason for the Capability to be in its current status.
                    sig { returns(String) }
                    def code; end
                    # Machine-readable code explaining how to make the Capability active.
                    sig { returns(String) }
                    def resolution; end
                    def self.inner_class_types
                      @inner_class_types = {}
                    end
                    def self.field_remappings
                      @field_remappings = {}
                    end
                  end
                  # The status of the Capability.
                  sig { returns(String) }
                  def status; end
                  # Additional details about the capability's status. This value is empty when `status` is `active`.
                  sig { returns(T::Array[StatusDetail]) }
                  def status_details; end
                  def self.inner_class_types
                    @inner_class_types = {status_details: StatusDetail}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # Enables this Account to complete payouts from their Stripe Balance (/v1/balance).
                sig { returns(T.nilable(Payouts)) }
                def payouts; end
                def self.inner_class_types
                  @inner_class_types = {payouts: Payouts}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class SwishPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class TwintPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class UsBankTransferPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class ZipPayments < ::Stripe::StripeObject
                class StatusDetail < ::Stripe::StripeObject
                  # Machine-readable code explaining the reason for the Capability to be in its current status.
                  sig { returns(String) }
                  def code; end
                  # Machine-readable code explaining how to make the Capability active.
                  sig { returns(String) }
                  def resolution; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The status of the Capability.
                sig { returns(String) }
                def status; end
                # Additional details about the capability's status. This value is empty when `status` is `active`.
                sig { returns(T::Array[StatusDetail]) }
                def status_details; end
                def self.inner_class_types
                  @inner_class_types = {status_details: StatusDetail}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # Allow the merchant to process ACH debit payments.
              sig { returns(T.nilable(AchDebitPayments)) }
              def ach_debit_payments; end
              # Allow the merchant to process ACSS debit payments.
              sig { returns(T.nilable(AcssDebitPayments)) }
              def acss_debit_payments; end
              # Allow the merchant to process Affirm payments.
              sig { returns(T.nilable(AffirmPayments)) }
              def affirm_payments; end
              # Allow the merchant to process Afterpay/Clearpay payments.
              sig { returns(T.nilable(AfterpayClearpayPayments)) }
              def afterpay_clearpay_payments; end
              # Allow the merchant to process Alma payments.
              sig { returns(T.nilable(AlmaPayments)) }
              def alma_payments; end
              # Allow the merchant to process Amazon Pay payments.
              sig { returns(T.nilable(AmazonPayPayments)) }
              def amazon_pay_payments; end
              # Allow the merchant to process Australian BECS Direct Debit payments.
              sig { returns(T.nilable(AuBecsDebitPayments)) }
              def au_becs_debit_payments; end
              # Allow the merchant to process BACS Direct Debit payments.
              sig { returns(T.nilable(BacsDebitPayments)) }
              def bacs_debit_payments; end
              # Allow the merchant to process Bancontact payments.
              sig { returns(T.nilable(BancontactPayments)) }
              def bancontact_payments; end
              # Allow the merchant to process BLIK payments.
              sig { returns(T.nilable(BlikPayments)) }
              def blik_payments; end
              # Allow the merchant to process Boleto payments.
              sig { returns(T.nilable(BoletoPayments)) }
              def boleto_payments; end
              # Allow the merchant to collect card payments.
              sig { returns(T.nilable(CardPayments)) }
              def card_payments; end
              # Allow the merchant to process Cartes Bancaires payments.
              sig { returns(T.nilable(CartesBancairesPayments)) }
              def cartes_bancaires_payments; end
              # Allow the merchant to process Cash App payments.
              sig { returns(T.nilable(CashappPayments)) }
              def cashapp_payments; end
              # Allow the merchant to process EPS payments.
              sig { returns(T.nilable(EpsPayments)) }
              def eps_payments; end
              # Allow the merchant to process FPX payments.
              sig { returns(T.nilable(FpxPayments)) }
              def fpx_payments; end
              # Allow the merchant to process UK bank transfer payments.
              sig { returns(T.nilable(GbBankTransferPayments)) }
              def gb_bank_transfer_payments; end
              # Allow the merchant to process GrabPay payments.
              sig { returns(T.nilable(GrabpayPayments)) }
              def grabpay_payments; end
              # Allow the merchant to process iDEAL payments.
              sig { returns(T.nilable(IdealPayments)) }
              def ideal_payments; end
              # Allow the merchant to process JCB card payments.
              sig { returns(T.nilable(JcbPayments)) }
              def jcb_payments; end
              # Allow the merchant to process Japanese bank transfer payments.
              sig { returns(T.nilable(JpBankTransferPayments)) }
              def jp_bank_transfer_payments; end
              # Allow the merchant to process Kakao Pay payments.
              sig { returns(T.nilable(KakaoPayPayments)) }
              def kakao_pay_payments; end
              # Allow the merchant to process Klarna payments.
              sig { returns(T.nilable(KlarnaPayments)) }
              def klarna_payments; end
              # Allow the merchant to process Konbini convenience store payments.
              sig { returns(T.nilable(KonbiniPayments)) }
              def konbini_payments; end
              # Allow the merchant to process Korean card payments.
              sig { returns(T.nilable(KrCardPayments)) }
              def kr_card_payments; end
              # Allow the merchant to process Link payments.
              sig { returns(T.nilable(LinkPayments)) }
              def link_payments; end
              # Allow the merchant to process MobilePay payments.
              sig { returns(T.nilable(MobilepayPayments)) }
              def mobilepay_payments; end
              # Allow the merchant to process Multibanco payments.
              sig { returns(T.nilable(MultibancoPayments)) }
              def multibanco_payments; end
              # Allow the merchant to process Mexican bank transfer payments.
              sig { returns(T.nilable(MxBankTransferPayments)) }
              def mx_bank_transfer_payments; end
              # Allow the merchant to process Naver Pay payments.
              sig { returns(T.nilable(NaverPayPayments)) }
              def naver_pay_payments; end
              # Allow the merchant to process OXXO payments.
              sig { returns(T.nilable(OxxoPayments)) }
              def oxxo_payments; end
              # Allow the merchant to process Przelewy24 (P24) payments.
              sig { returns(T.nilable(P24Payments)) }
              def p24_payments; end
              # Allow the merchant to process Pay by Bank payments.
              sig { returns(T.nilable(PayByBankPayments)) }
              def pay_by_bank_payments; end
              # Allow the merchant to process PAYCO payments.
              sig { returns(T.nilable(PaycoPayments)) }
              def payco_payments; end
              # Allow the merchant to process PayNow payments.
              sig { returns(T.nilable(PaynowPayments)) }
              def paynow_payments; end
              # Allow the merchant to process PromptPay payments.
              sig { returns(T.nilable(PromptpayPayments)) }
              def promptpay_payments; end
              # Allow the merchant to process Revolut Pay payments.
              sig { returns(T.nilable(RevolutPayPayments)) }
              def revolut_pay_payments; end
              # Allow the merchant to process Samsung Pay payments.
              sig { returns(T.nilable(SamsungPayPayments)) }
              def samsung_pay_payments; end
              # Allow the merchant to process SEPA bank transfer payments.
              sig { returns(T.nilable(SepaBankTransferPayments)) }
              def sepa_bank_transfer_payments; end
              # Allow the merchant to process SEPA Direct Debit payments.
              sig { returns(T.nilable(SepaDebitPayments)) }
              def sepa_debit_payments; end
              # Capabilities that enable the merchant to manage their Stripe Balance (/v1/balance).
              sig { returns(T.nilable(StripeBalance)) }
              def stripe_balance; end
              # Allow the merchant to process Swish payments.
              sig { returns(T.nilable(SwishPayments)) }
              def swish_payments; end
              # Allow the merchant to process TWINT payments.
              sig { returns(T.nilable(TwintPayments)) }
              def twint_payments; end
              # Allow the merchant to process US bank transfer payments.
              sig { returns(T.nilable(UsBankTransferPayments)) }
              def us_bank_transfer_payments; end
              # Allow the merchant to process Zip payments.
              sig { returns(T.nilable(ZipPayments)) }
              def zip_payments; end
              def self.inner_class_types
                @inner_class_types = {
                  ach_debit_payments: AchDebitPayments,
                  acss_debit_payments: AcssDebitPayments,
                  affirm_payments: AffirmPayments,
                  afterpay_clearpay_payments: AfterpayClearpayPayments,
                  alma_payments: AlmaPayments,
                  amazon_pay_payments: AmazonPayPayments,
                  au_becs_debit_payments: AuBecsDebitPayments,
                  bacs_debit_payments: BacsDebitPayments,
                  bancontact_payments: BancontactPayments,
                  blik_payments: BlikPayments,
                  boleto_payments: BoletoPayments,
                  card_payments: CardPayments,
                  cartes_bancaires_payments: CartesBancairesPayments,
                  cashapp_payments: CashappPayments,
                  eps_payments: EpsPayments,
                  fpx_payments: FpxPayments,
                  gb_bank_transfer_payments: GbBankTransferPayments,
                  grabpay_payments: GrabpayPayments,
                  ideal_payments: IdealPayments,
                  jcb_payments: JcbPayments,
                  jp_bank_transfer_payments: JpBankTransferPayments,
                  kakao_pay_payments: KakaoPayPayments,
                  klarna_payments: KlarnaPayments,
                  konbini_payments: KonbiniPayments,
                  kr_card_payments: KrCardPayments,
                  link_payments: LinkPayments,
                  mobilepay_payments: MobilepayPayments,
                  multibanco_payments: MultibancoPayments,
                  mx_bank_transfer_payments: MxBankTransferPayments,
                  naver_pay_payments: NaverPayPayments,
                  oxxo_payments: OxxoPayments,
                  p24_payments: P24Payments,
                  pay_by_bank_payments: PayByBankPayments,
                  payco_payments: PaycoPayments,
                  paynow_payments: PaynowPayments,
                  promptpay_payments: PromptpayPayments,
                  revolut_pay_payments: RevolutPayPayments,
                  samsung_pay_payments: SamsungPayPayments,
                  sepa_bank_transfer_payments: SepaBankTransferPayments,
                  sepa_debit_payments: SepaDebitPayments,
                  stripe_balance: StripeBalance,
                  swish_payments: SwishPayments,
                  twint_payments: TwintPayments,
                  us_bank_transfer_payments: UsBankTransferPayments,
                  zip_payments: ZipPayments,
                }
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class CardPayments < ::Stripe::StripeObject
              class DeclineOn < ::Stripe::StripeObject
                # Whether Stripe automatically declines charges with an incorrect ZIP or postal code. This setting only applies when a ZIP or postal code is provided and they fail bank verification.
                sig { returns(T.nilable(T::Boolean)) }
                def avs_failure; end
                # Whether Stripe automatically declines charges with an incorrect CVC. This setting only applies when a CVC is provided and it fails bank verification.
                sig { returns(T.nilable(T::Boolean)) }
                def cvc_failure; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # Automatically declines certain charge types regardless of whether the card issuer accepted or declined the charge.
              sig { returns(T.nilable(DeclineOn)) }
              def decline_on; end
              def self.inner_class_types
                @inner_class_types = {decline_on: DeclineOn}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class KonbiniPayments < ::Stripe::StripeObject
              class Support < ::Stripe::StripeObject
                class Hours < ::Stripe::StripeObject
                  # Support hours end time (JST time of day) for in `HH:MM` format.
                  sig { returns(T.nilable(String)) }
                  def end_time; end
                  # Support hours start time (JST time of day) for in `HH:MM` format.
                  sig { returns(T.nilable(String)) }
                  def start_time; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # Support email address for Konbini payments.
                sig { returns(T.nilable(String)) }
                def email; end
                # Support hours for Konbini payments.
                sig { returns(T.nilable(Hours)) }
                def hours; end
                # Support phone number for Konbini payments.
                sig { returns(T.nilable(String)) }
                def phone; end
                def self.inner_class_types
                  @inner_class_types = {hours: Hours}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # Support for Konbini payments.
              sig { returns(T.nilable(Support)) }
              def support; end
              def self.inner_class_types
                @inner_class_types = {support: Support}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class ScriptStatementDescriptor < ::Stripe::StripeObject
              class Kana < ::Stripe::StripeObject
                # The default text that appears on statements for non-card charges outside of Japan. For card charges, if you don’t set a statement_descriptor_prefix, this text is also used as the statement descriptor prefix. In that case, if concatenating the statement descriptor suffix causes the combined statement descriptor to exceed 22 characters, we truncate the statement_descriptor text to limit the full descriptor to 22 characters. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
                sig { returns(T.nilable(String)) }
                def descriptor; end
                # Default text that appears on statements for card charges outside of Japan, prefixing any dynamic statement_descriptor_suffix specified on the charge. To maximize space for the dynamic part of the descriptor, keep this text short. If you don’t specify this value, statement_descriptor is used as the prefix. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
                sig { returns(T.nilable(String)) }
                def prefix; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class Kanji < ::Stripe::StripeObject
                # The default text that appears on statements for non-card charges outside of Japan. For card charges, if you don’t set a statement_descriptor_prefix, this text is also used as the statement descriptor prefix. In that case, if concatenating the statement descriptor suffix causes the combined statement descriptor to exceed 22 characters, we truncate the statement_descriptor text to limit the full descriptor to 22 characters. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
                sig { returns(T.nilable(String)) }
                def descriptor; end
                # Default text that appears on statements for card charges outside of Japan, prefixing any dynamic statement_descriptor_suffix specified on the charge. To maximize space for the dynamic part of the descriptor, keep this text short. If you don’t specify this value, statement_descriptor is used as the prefix. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
                sig { returns(T.nilable(String)) }
                def prefix; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # The Kana variation of statement_descriptor used for charges in Japan. Japanese statement descriptors have [special requirements](https://docs.stripe.com/get-started/account/statement-descriptors#set-japanese-statement-descriptors).
              sig { returns(T.nilable(Kana)) }
              def kana; end
              # The Kanji variation of statement_descriptor used for charges in Japan. Japanese statement descriptors have [special requirements](https://docs.stripe.com/get-started/account/statement-descriptors#set-japanese-statement-descriptors).
              sig { returns(T.nilable(Kanji)) }
              def kanji; end
              def self.inner_class_types
                @inner_class_types = {kana: Kana, kanji: Kanji}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class SepaDebitPayments < ::Stripe::StripeObject
              # Creditor ID for SEPA Direct Debit payments.
              sig { returns(T.nilable(String)) }
              def creditor_id; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class StatementDescriptor < ::Stripe::StripeObject
              # The default text that appears on statements for non-card charges outside of Japan. For card charges, if you don’t set a statement_descriptor_prefix, this text is also used as the statement descriptor prefix. In that case, if concatenating the statement descriptor suffix causes the combined statement descriptor to exceed 22 characters, we truncate the statement_descriptor text to limit the full descriptor to 22 characters. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
              sig { returns(T.nilable(String)) }
              def descriptor; end
              # Default text that appears on statements for card charges outside of Japan, prefixing any dynamic statement_descriptor_suffix specified on the charge. To maximize space for the dynamic part of the descriptor, keep this text short. If you don’t specify this value, statement_descriptor is used as the prefix. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
              sig { returns(T.nilable(String)) }
              def prefix; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Support < ::Stripe::StripeObject
              class Address < ::Stripe::StripeObject
                # City, district, suburb, town, or village.
                sig { returns(T.nilable(String)) }
                def city; end
                # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
                sig { returns(T.nilable(String)) }
                def country; end
                # Address line 1 (e.g., street, PO Box, or company name).
                sig { returns(T.nilable(String)) }
                def line1; end
                # Address line 2 (e.g., apartment, suite, unit, or building).
                sig { returns(T.nilable(String)) }
                def line2; end
                # ZIP or postal code.
                sig { returns(T.nilable(String)) }
                def postal_code; end
                # State, county, province, or region.
                sig { returns(T.nilable(String)) }
                def state; end
                # Town or district.
                sig { returns(T.nilable(String)) }
                def town; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # A publicly available mailing address for sending support issues to.
              sig { returns(T.nilable(Address)) }
              def address; end
              # A publicly available email address for sending support issues to.
              sig { returns(T.nilable(String)) }
              def email; end
              # A publicly available phone number to call with support issues.
              sig { returns(T.nilable(String)) }
              def phone; end
              # A publicly available website for handling support issues.
              sig { returns(T.nilable(String)) }
              def url; end
              def self.inner_class_types
                @inner_class_types = {address: Address}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Indicates whether the merchant configuration is active. You can deactivate or reactivate the merchant configuration by updating this property. Deactivating the configuration by setting this value to false doesn't delete the configuration's properties.
            sig { returns(T::Boolean) }
            def applied; end
            # Settings for Bacs Direct Debit payments.
            sig { returns(T.nilable(BacsDebitPayments)) }
            def bacs_debit_payments; end
            # Settings used to apply the merchant's branding to email receipts, invoices, Checkout, and other products.
            sig { returns(T.nilable(Branding)) }
            def branding; end
            # Capabilities that have been requested on the Merchant Configuration.
            sig { returns(T.nilable(Capabilities)) }
            def capabilities; end
            # Card payments settings.
            sig { returns(T.nilable(CardPayments)) }
            def card_payments; end
            # Settings specific to Konbini payments on the account.
            sig { returns(T.nilable(KonbiniPayments)) }
            def konbini_payments; end
            # The Merchant Category Code (MCC) for the merchant. MCCs classify businesses based on the goods or services they provide.
            sig { returns(T.nilable(String)) }
            def mcc; end
            # Settings for the default text that appears on statements for language variations.
            sig { returns(T.nilable(ScriptStatementDescriptor)) }
            def script_statement_descriptor; end
            # Settings for SEPA Direct Debit payments.
            sig { returns(T.nilable(SepaDebitPayments)) }
            def sepa_debit_payments; end
            # Statement descriptor.
            sig { returns(T.nilable(StatementDescriptor)) }
            def statement_descriptor; end
            # Publicly available contact information for sending support issues to.
            sig { returns(T.nilable(Support)) }
            def support; end
            def self.inner_class_types
              @inner_class_types = {
                bacs_debit_payments: BacsDebitPayments,
                branding: Branding,
                capabilities: Capabilities,
                card_payments: CardPayments,
                konbini_payments: KonbiniPayments,
                script_statement_descriptor: ScriptStatementDescriptor,
                sepa_debit_payments: SepaDebitPayments,
                statement_descriptor: StatementDescriptor,
                support: Support,
              }
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class Recipient < ::Stripe::StripeObject
            class Capabilities < ::Stripe::StripeObject
              class StripeBalance < ::Stripe::StripeObject
                class Payouts < ::Stripe::StripeObject
                  class StatusDetail < ::Stripe::StripeObject
                    # Machine-readable code explaining the reason for the Capability to be in its current status.
                    sig { returns(String) }
                    def code; end
                    # Machine-readable code explaining how to make the Capability active.
                    sig { returns(String) }
                    def resolution; end
                    def self.inner_class_types
                      @inner_class_types = {}
                    end
                    def self.field_remappings
                      @field_remappings = {}
                    end
                  end
                  # The status of the Capability.
                  sig { returns(String) }
                  def status; end
                  # Additional details about the capability's status. This value is empty when `status` is `active`.
                  sig { returns(T::Array[StatusDetail]) }
                  def status_details; end
                  def self.inner_class_types
                    @inner_class_types = {status_details: StatusDetail}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                class StripeTransfers < ::Stripe::StripeObject
                  class StatusDetail < ::Stripe::StripeObject
                    # Machine-readable code explaining the reason for the Capability to be in its current status.
                    sig { returns(String) }
                    def code; end
                    # Machine-readable code explaining how to make the Capability active.
                    sig { returns(String) }
                    def resolution; end
                    def self.inner_class_types
                      @inner_class_types = {}
                    end
                    def self.field_remappings
                      @field_remappings = {}
                    end
                  end
                  # The status of the Capability.
                  sig { returns(String) }
                  def status; end
                  # Additional details about the capability's status. This value is empty when `status` is `active`.
                  sig { returns(T::Array[StatusDetail]) }
                  def status_details; end
                  def self.inner_class_types
                    @inner_class_types = {status_details: StatusDetail}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # Enables this Account to complete payouts from their Stripe Balance (/v1/balance).
                sig { returns(T.nilable(Payouts)) }
                def payouts; end
                # Enables this Account to receive /v1/transfers into their Stripe Balance (/v1/balance).
                sig { returns(T.nilable(StripeTransfers)) }
                def stripe_transfers; end
                def self.inner_class_types
                  @inner_class_types = {payouts: Payouts, stripe_transfers: StripeTransfers}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # Capabilities that enable the recipient to manage their Stripe Balance (/v1/balance).
              sig { returns(T.nilable(StripeBalance)) }
              def stripe_balance; end
              def self.inner_class_types
                @inner_class_types = {stripe_balance: StripeBalance}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Indicates whether the recipient configuration is active. You can deactivate or reactivate the recipient configuration by updating this property. Deactivating the configuration by setting this value to false  unrequest all capabilities within the configuration. It will not delete any of the configuration's other properties.
            sig { returns(T::Boolean) }
            def applied; end
            # Capabilities that have been requested on the Recipient Configuration.
            sig { returns(T.nilable(Capabilities)) }
            def capabilities; end
            def self.inner_class_types
              @inner_class_types = {capabilities: Capabilities}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # The Customer Configuration allows the Account to be used in inbound payment flows.
          sig { returns(T.nilable(Customer)) }
          def customer; end
          # Enables the Account to act as a connected account and collect payments facilitated by a Connect platform. You must onboard your platform to Connect before you can add this configuration to your connected accounts. Utilize this configuration when the Account will be the Merchant of Record, like with Direct charges or Destination Charges with on_behalf_of set.
          sig { returns(T.nilable(Merchant)) }
          def merchant; end
          # The Recipient Configuration allows the Account to receive funds. Utilize this configuration if the Account will not be the Merchant of Record, like with Separate Charges & Transfers, or Destination Charges without on_behalf_of set.
          sig { returns(T.nilable(Recipient)) }
          def recipient; end
          def self.inner_class_types
            @inner_class_types = {customer: Customer, merchant: Merchant, recipient: Recipient}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Defaults < ::Stripe::StripeObject
          class Profile < ::Stripe::StripeObject
            # The business's publicly-available website.
            sig { returns(T.nilable(String)) }
            def business_url; end
            # The customer-facing business name.
            sig { returns(T.nilable(String)) }
            def doing_business_as; end
            # Internal-only description of the product sold or service provided by the business. It's used by Stripe for risk and underwriting purposes.
            sig { returns(T.nilable(String)) }
            def product_description; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class Responsibilities < ::Stripe::StripeObject
            # Indicates whether the platform or connected account is responsible for paying Stripe fees for pricing-control-eligible products.
            sig { returns(T.nilable(String)) }
            def fees_collector; end
            # A value indicating responsibility for collecting requirements on this account.
            sig { returns(T.nilable(String)) }
            def losses_collector; end
            # A value indicating responsibility for collecting requirements on this account.
            sig { returns(String) }
            def requirements_collector; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
          sig { returns(T.nilable(String)) }
          def currency; end
          # The Account's preferred locales (languages), ordered by preference.
          sig { returns(T.nilable(T::Array[String])) }
          def locales; end
          # Account profile information.
          sig { returns(T.nilable(Profile)) }
          def profile; end
          # Default responsibilities held by either Stripe or the platform.
          sig { returns(Responsibilities) }
          def responsibilities; end
          def self.inner_class_types
            @inner_class_types = {profile: Profile, responsibilities: Responsibilities}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class FutureRequirements < ::Stripe::StripeObject
          class Entry < ::Stripe::StripeObject
            class Error < ::Stripe::StripeObject
              # Machine-readable code describing the error.
              sig { returns(String) }
              def code; end
              # Human-readable description of the error.
              sig { returns(String) }
              def description; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Impact < ::Stripe::StripeObject
              class RestrictsCapability < ::Stripe::StripeObject
                class Deadline < ::Stripe::StripeObject
                  # The current status of the requirement's impact.
                  sig { returns(String) }
                  def status; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The name of the Capability which will be restricted.
                sig { returns(String) }
                def capability; end
                # The configuration which specifies the Capability which will be restricted.
                sig { returns(String) }
                def configuration; end
                # Details about when in the account lifecycle the requirement must be collected by the avoid the Capability restriction.
                sig { returns(Deadline) }
                def deadline; end
                def self.inner_class_types
                  @inner_class_types = {deadline: Deadline}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # The Capabilities that will be restricted if the requirement is not collected and satisfactory to Stripe.
              sig { returns(T.nilable(T::Array[RestrictsCapability])) }
              def restricts_capabilities; end
              def self.inner_class_types
                @inner_class_types = {restricts_capabilities: RestrictsCapability}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class MinimumDeadline < ::Stripe::StripeObject
              # The current status of the requirement's impact.
              sig { returns(String) }
              def status; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Reference < ::Stripe::StripeObject
              # If `inquiry` is the type, the inquiry token.
              sig { returns(T.nilable(String)) }
              def inquiry; end
              # If `resource` is the type, the resource token.
              sig { returns(T.nilable(String)) }
              def resource; end
              # The type of the reference. If the type is "inquiry", the inquiry token can be found in the "inquiry" field.
              # Otherwise the type is an API resource, the token for which can be found in the "resource" field.
              sig { returns(String) }
              def type; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class RequestedReason < ::Stripe::StripeObject
              # Machine-readable description of Stripe's reason for collecting the requirement.
              sig { returns(String) }
              def code; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Indicates whether the platform or Stripe is currently responsible for taking action on the requirement. Value can be `user` or `stripe`.
            sig { returns(String) }
            def awaiting_action_from; end
            # Machine-readable string describing the requirement.
            sig { returns(String) }
            def description; end
            # Descriptions of why the requirement must be collected, or why the collected information isn't satisfactory to Stripe.
            sig { returns(T::Array[Error]) }
            def errors; end
            # A hash describing the impact of not collecting the requirement, or Stripe not being able to verify the collected information.
            sig { returns(Impact) }
            def impact; end
            # The soonest point when the account will be impacted by not providing the requirement.
            sig { returns(MinimumDeadline) }
            def minimum_deadline; end
            # A reference to the location of the requirement.
            sig { returns(T.nilable(Reference)) }
            def reference; end
            # A list of reasons why Stripe is collecting the requirement.
            sig { returns(T::Array[RequestedReason]) }
            def requested_reasons; end
            def self.inner_class_types
              @inner_class_types = {
                errors: Error,
                impact: Impact,
                minimum_deadline: MinimumDeadline,
                reference: Reference,
                requested_reasons: RequestedReason,
              }
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class Summary < ::Stripe::StripeObject
            class MinimumDeadline < ::Stripe::StripeObject
              # The current strictest status of all requirements on the Account.
              sig { returns(String) }
              def status; end
              # The soonest RFC3339 date & time UTC value a requirement can impact the Account.
              sig { returns(T.nilable(String)) }
              def time; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # The soonest date and time a requirement on the Account will become `past due`. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: `2022-09-18T13:22:18.123Z`.
            sig { returns(T.nilable(MinimumDeadline)) }
            def minimum_deadline; end
            def self.inner_class_types
              @inner_class_types = {minimum_deadline: MinimumDeadline}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # A list of requirements for the Account.
          sig { returns(T.nilable(T::Array[Entry])) }
          def entries; end
          # The time at which the future requirements become effective.
          sig { returns(T.nilable(String)) }
          def minimum_transition_date; end
          # An object containing an overview of requirements for the Account.
          sig { returns(T.nilable(Summary)) }
          def summary; end
          def self.inner_class_types
            @inner_class_types = {entries: Entry, summary: Summary}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Identity < ::Stripe::StripeObject
          class Attestations < ::Stripe::StripeObject
            class DirectorshipDeclaration < ::Stripe::StripeObject
              # The time marking when the director attestation was made. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
              sig { returns(T.nilable(String)) }
              def date; end
              # The IP address from which the director attestation was made.
              sig { returns(T.nilable(String)) }
              def ip; end
              # The user agent of the browser from which the director attestation was made.
              sig { returns(T.nilable(String)) }
              def user_agent; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class OwnershipDeclaration < ::Stripe::StripeObject
              # The time marking when the beneficial owner attestation was made. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
              sig { returns(T.nilable(String)) }
              def date; end
              # The IP address from which the beneficial owner attestation was made.
              sig { returns(T.nilable(String)) }
              def ip; end
              # The user agent of the browser from which the beneficial owner attestation was made.
              sig { returns(T.nilable(String)) }
              def user_agent; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class PersonsProvided < ::Stripe::StripeObject
              # Whether the company’s directors have been provided. Set this Boolean to true after creating all the company’s directors with the [Persons API](https://docs.stripe.com/api/v2/core/accounts/createperson).
              sig { returns(T.nilable(T::Boolean)) }
              def directors; end
              # Whether the company’s executives have been provided. Set this Boolean to true after creating all the company’s executives with the [Persons API](https://docs.stripe.com/api/v2/core/accounts/createperson).
              sig { returns(T.nilable(T::Boolean)) }
              def executives; end
              # Whether the company’s owners have been provided. Set this Boolean to true after creating all the company’s owners with the [Persons API](https://docs.stripe.com/api/v2/core/accounts/createperson).
              sig { returns(T.nilable(T::Boolean)) }
              def owners; end
              # Reason for why the company is exempt from providing ownership information.
              sig { returns(T.nilable(String)) }
              def ownership_exemption_reason; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class RepresentativeDeclaration < ::Stripe::StripeObject
              # The time marking when the representative attestation was made. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
              sig { returns(T.nilable(String)) }
              def date; end
              # The IP address from which the representative attestation was made.
              sig { returns(T.nilable(String)) }
              def ip; end
              # The user agent of the browser from which the representative attestation was made.
              sig { returns(T.nilable(String)) }
              def user_agent; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class TermsOfService < ::Stripe::StripeObject
              class Account < ::Stripe::StripeObject
                # The time when the Account's representative accepted the terms of service. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
                sig { returns(T.nilable(String)) }
                def date; end
                # The IP address from which the Account's representative accepted the terms of service.
                sig { returns(T.nilable(String)) }
                def ip; end
                # The user agent of the browser from which the Account's representative accepted the terms of service.
                sig { returns(T.nilable(String)) }
                def user_agent; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # Details on the Account's acceptance of the [Stripe Services Agreement](https://docs.stripe.com/connect/updating-accounts#tos-acceptance).
              sig { returns(T.nilable(Account)) }
              def account; end
              def self.inner_class_types
                @inner_class_types = {account: Account}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # This hash is used to attest that the directors information provided to Stripe is both current and correct.
            sig { returns(T.nilable(DirectorshipDeclaration)) }
            def directorship_declaration; end
            # This hash is used to attest that the beneficial owner information provided to Stripe is both current and correct.
            sig { returns(T.nilable(OwnershipDeclaration)) }
            def ownership_declaration; end
            # Attestation that all Persons with a specific Relationship value have been provided.
            sig { returns(T.nilable(PersonsProvided)) }
            def persons_provided; end
            # This hash is used to attest that the representative is authorized to act as the representative of their legal entity.
            sig { returns(T.nilable(RepresentativeDeclaration)) }
            def representative_declaration; end
            # Attestations of accepted terms of service agreements.
            sig { returns(T.nilable(TermsOfService)) }
            def terms_of_service; end
            def self.inner_class_types
              @inner_class_types = {
                directorship_declaration: DirectorshipDeclaration,
                ownership_declaration: OwnershipDeclaration,
                persons_provided: PersonsProvided,
                representative_declaration: RepresentativeDeclaration,
                terms_of_service: TermsOfService,
              }
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class BusinessDetails < ::Stripe::StripeObject
            class Address < ::Stripe::StripeObject
              # City, district, suburb, town, or village.
              sig { returns(T.nilable(String)) }
              def city; end
              # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
              sig { returns(T.nilable(String)) }
              def country; end
              # Address line 1 (e.g., street, PO Box, or company name).
              sig { returns(T.nilable(String)) }
              def line1; end
              # Address line 2 (e.g., apartment, suite, unit, or building).
              sig { returns(T.nilable(String)) }
              def line2; end
              # ZIP or postal code.
              sig { returns(T.nilable(String)) }
              def postal_code; end
              # State, county, province, or region.
              sig { returns(T.nilable(String)) }
              def state; end
              # Town or district.
              sig { returns(T.nilable(String)) }
              def town; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class AnnualRevenue < ::Stripe::StripeObject
              class Amount < ::Stripe::StripeObject
                # A non-negative integer representing how much to charge in the [smallest currency unit](https://docs.stripe.com/currencies#minor-units).
                sig { returns(T.nilable(Integer)) }
                def value; end
                # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
                sig { returns(T.nilable(String)) }
                def currency; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # Annual revenue amount in minor currency units (for example, '123' for 1.23 USD).
              sig { returns(T.nilable(Amount)) }
              def amount; end
              # The close-out date of the preceding fiscal year in ISO 8601 format. E.g. 2023-12-31 for the 31st of December, 2023.
              sig { returns(T.nilable(String)) }
              def fiscal_year_end; end
              def self.inner_class_types
                @inner_class_types = {amount: Amount}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Documents < ::Stripe::StripeObject
              class BankAccountOwnershipVerification < ::Stripe::StripeObject
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class CompanyLicense < ::Stripe::StripeObject
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class CompanyMemorandumOfAssociation < ::Stripe::StripeObject
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class CompanyMinisterialDecree < ::Stripe::StripeObject
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class CompanyRegistrationVerification < ::Stripe::StripeObject
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class CompanyTaxIdVerification < ::Stripe::StripeObject
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class PrimaryVerification < ::Stripe::StripeObject
                class FrontBack < ::Stripe::StripeObject
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the back of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  sig { returns(T.nilable(String)) }
                  def back; end
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the front of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  sig { returns(String) }
                  def front; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens for the front and back of the verification document.
                sig { returns(FrontBack) }
                def front_back; end
                # The format of the verification document. Currently supports `front_back` only.
                sig { returns(String) }
                def type; end
                def self.inner_class_types
                  @inner_class_types = {front_back: FrontBack}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class ProofOfAddress < ::Stripe::StripeObject
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class ProofOfRegistration < ::Stripe::StripeObject
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class ProofOfUltimateBeneficialOwnership < ::Stripe::StripeObject
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # One or more documents that support the Bank account ownership verification requirement. Must be a document associated with the account’s primary active bank account that displays the last 4 digits of the account number, either a statement or a check.
              sig { returns(T.nilable(BankAccountOwnershipVerification)) }
              def bank_account_ownership_verification; end
              # One or more documents that demonstrate proof of a company’s license to operate.
              sig { returns(T.nilable(CompanyLicense)) }
              def company_license; end
              # One or more documents showing the company’s Memorandum of Association.
              sig { returns(T.nilable(CompanyMemorandumOfAssociation)) }
              def company_memorandum_of_association; end
              # Certain countries only: One or more documents showing the ministerial decree legalizing the company’s establishment.
              sig { returns(T.nilable(CompanyMinisterialDecree)) }
              def company_ministerial_decree; end
              # One or more documents that demonstrate proof of a company’s registration with the appropriate local authorities.
              sig { returns(T.nilable(CompanyRegistrationVerification)) }
              def company_registration_verification; end
              # One or more documents that demonstrate proof of a company’s tax ID.
              sig { returns(T.nilable(CompanyTaxIdVerification)) }
              def company_tax_id_verification; end
              # A document verifying the business.
              sig { returns(T.nilable(PrimaryVerification)) }
              def primary_verification; end
              # One or more documents that demonstrate proof of address.
              sig { returns(T.nilable(ProofOfAddress)) }
              def proof_of_address; end
              # One or more documents showing the company’s proof of registration with the national business registry.
              sig { returns(T.nilable(ProofOfRegistration)) }
              def proof_of_registration; end
              # One or more documents that demonstrate proof of ultimate beneficial ownership.
              sig { returns(T.nilable(ProofOfUltimateBeneficialOwnership)) }
              def proof_of_ultimate_beneficial_ownership; end
              def self.inner_class_types
                @inner_class_types = {
                  bank_account_ownership_verification: BankAccountOwnershipVerification,
                  company_license: CompanyLicense,
                  company_memorandum_of_association: CompanyMemorandumOfAssociation,
                  company_ministerial_decree: CompanyMinisterialDecree,
                  company_registration_verification: CompanyRegistrationVerification,
                  company_tax_id_verification: CompanyTaxIdVerification,
                  primary_verification: PrimaryVerification,
                  proof_of_address: ProofOfAddress,
                  proof_of_registration: ProofOfRegistration,
                  proof_of_ultimate_beneficial_ownership: ProofOfUltimateBeneficialOwnership,
                }
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class IdNumber < ::Stripe::StripeObject
              # The registrar of the ID number (Only valid for DE ID number types).
              sig { returns(T.nilable(String)) }
              def registrar; end
              # Open Enum. The ID number type of a business entity.
              sig { returns(String) }
              def type; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class MonthlyEstimatedRevenue < ::Stripe::StripeObject
              class Amount < ::Stripe::StripeObject
                # A non-negative integer representing how much to charge in the [smallest currency unit](https://docs.stripe.com/currencies#minor-units).
                sig { returns(T.nilable(Integer)) }
                def value; end
                # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
                sig { returns(T.nilable(String)) }
                def currency; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # Estimated monthly revenue amount in minor currency units (for example, '123' for 1.23 USD).
              sig { returns(T.nilable(Amount)) }
              def amount; end
              def self.inner_class_types
                @inner_class_types = {amount: Amount}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class ScriptAddresses < ::Stripe::StripeObject
              class Kana < ::Stripe::StripeObject
                # City, district, suburb, town, or village.
                sig { returns(T.nilable(String)) }
                def city; end
                # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
                sig { returns(T.nilable(String)) }
                def country; end
                # Address line 1 (e.g., street, PO Box, or company name).
                sig { returns(T.nilable(String)) }
                def line1; end
                # Address line 2 (e.g., apartment, suite, unit, or building).
                sig { returns(T.nilable(String)) }
                def line2; end
                # ZIP or postal code.
                sig { returns(T.nilable(String)) }
                def postal_code; end
                # State, county, province, or region.
                sig { returns(T.nilable(String)) }
                def state; end
                # Town or district.
                sig { returns(T.nilable(String)) }
                def town; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class Kanji < ::Stripe::StripeObject
                # City, district, suburb, town, or village.
                sig { returns(T.nilable(String)) }
                def city; end
                # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
                sig { returns(T.nilable(String)) }
                def country; end
                # Address line 1 (e.g., street, PO Box, or company name).
                sig { returns(T.nilable(String)) }
                def line1; end
                # Address line 2 (e.g., apartment, suite, unit, or building).
                sig { returns(T.nilable(String)) }
                def line2; end
                # ZIP or postal code.
                sig { returns(T.nilable(String)) }
                def postal_code; end
                # State, county, province, or region.
                sig { returns(T.nilable(String)) }
                def state; end
                # Town or district.
                sig { returns(T.nilable(String)) }
                def town; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # Kana Address.
              sig { returns(T.nilable(Kana)) }
              def kana; end
              # Kanji Address.
              sig { returns(T.nilable(Kanji)) }
              def kanji; end
              def self.inner_class_types
                @inner_class_types = {kana: Kana, kanji: Kanji}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class ScriptNames < ::Stripe::StripeObject
              class Kana < ::Stripe::StripeObject
                # Registered name of the business.
                sig { returns(T.nilable(String)) }
                def registered_name; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class Kanji < ::Stripe::StripeObject
                # Registered name of the business.
                sig { returns(T.nilable(String)) }
                def registered_name; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # Kana name.
              sig { returns(T.nilable(Kana)) }
              def kana; end
              # Kanji name.
              sig { returns(T.nilable(Kanji)) }
              def kanji; end
              def self.inner_class_types
                @inner_class_types = {kana: Kana, kanji: Kanji}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # The company’s primary address.
            sig { returns(T.nilable(Address)) }
            def address; end
            # The business gross annual revenue for its preceding fiscal year.
            sig { returns(T.nilable(AnnualRevenue)) }
            def annual_revenue; end
            # Documents that may be submitted to satisfy various informational requests.
            sig { returns(T.nilable(Documents)) }
            def documents; end
            # Estimated maximum number of workers currently engaged by the business (including employees, contractors, and vendors).
            sig { returns(T.nilable(Integer)) }
            def estimated_worker_count; end
            # The provided ID numbers of a business entity.
            sig { returns(T.nilable(T::Array[IdNumber])) }
            def id_numbers; end
            # An estimate of the monthly revenue of the business. Only accepted for accounts in Brazil and India.
            sig { returns(T.nilable(MonthlyEstimatedRevenue)) }
            def monthly_estimated_revenue; end
            # The company’s phone number (used for verification).
            sig { returns(T.nilable(String)) }
            def phone; end
            # The business legal name.
            sig { returns(T.nilable(String)) }
            def registered_name; end
            # The business registration address of the business entity in non latin script.
            sig { returns(T.nilable(ScriptAddresses)) }
            def script_addresses; end
            # The business legal name in non latin script.
            sig { returns(T.nilable(ScriptNames)) }
            def script_names; end
            # The category identifying the legal structure of the business.
            sig { returns(T.nilable(String)) }
            def structure; end
            def self.inner_class_types
              @inner_class_types = {
                address: Address,
                annual_revenue: AnnualRevenue,
                documents: Documents,
                id_numbers: IdNumber,
                monthly_estimated_revenue: MonthlyEstimatedRevenue,
                script_addresses: ScriptAddresses,
                script_names: ScriptNames,
              }
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class Individual < ::Stripe::StripeObject
            class AdditionalAddress < ::Stripe::StripeObject
              # City, district, suburb, town, or village.
              sig { returns(T.nilable(String)) }
              def city; end
              # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
              sig { returns(T.nilable(String)) }
              def country; end
              # Address line 1 (e.g., street, PO Box, or company name).
              sig { returns(T.nilable(String)) }
              def line1; end
              # Address line 2 (e.g., apartment, suite, unit, or building).
              sig { returns(T.nilable(String)) }
              def line2; end
              # ZIP or postal code.
              sig { returns(T.nilable(String)) }
              def postal_code; end
              # Purpose of additional address.
              sig { returns(String) }
              def purpose; end
              # State, county, province, or region.
              sig { returns(T.nilable(String)) }
              def state; end
              # Town or district.
              sig { returns(T.nilable(String)) }
              def town; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class AdditionalName < ::Stripe::StripeObject
              # The individual's full name.
              sig { returns(T.nilable(String)) }
              def full_name; end
              # The individual's first or given name.
              sig { returns(T.nilable(String)) }
              def given_name; end
              # The purpose or type of the additional name.
              sig { returns(String) }
              def purpose; end
              # The individual's last or family name.
              sig { returns(T.nilable(String)) }
              def surname; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class AdditionalTermsOfService < ::Stripe::StripeObject
              class Account < ::Stripe::StripeObject
                # The time when the Account's representative accepted the terms of service. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
                sig { returns(T.nilable(String)) }
                def date; end
                # The IP address from which the Account's representative accepted the terms of service.
                sig { returns(T.nilable(String)) }
                def ip; end
                # The user agent of the browser from which the Account's representative accepted the terms of service.
                sig { returns(T.nilable(String)) }
                def user_agent; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # Stripe terms of service agreement.
              sig { returns(T.nilable(Account)) }
              def account; end
              def self.inner_class_types
                @inner_class_types = {account: Account}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Address < ::Stripe::StripeObject
              # City, district, suburb, town, or village.
              sig { returns(T.nilable(String)) }
              def city; end
              # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
              sig { returns(T.nilable(String)) }
              def country; end
              # Address line 1 (e.g., street, PO Box, or company name).
              sig { returns(T.nilable(String)) }
              def line1; end
              # Address line 2 (e.g., apartment, suite, unit, or building).
              sig { returns(T.nilable(String)) }
              def line2; end
              # ZIP or postal code.
              sig { returns(T.nilable(String)) }
              def postal_code; end
              # State, county, province, or region.
              sig { returns(T.nilable(String)) }
              def state; end
              # Town or district.
              sig { returns(T.nilable(String)) }
              def town; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class DateOfBirth < ::Stripe::StripeObject
              # The day of birth, between 1 and 31.
              sig { returns(Integer) }
              def day; end
              # The month of birth, between 1 and 12.
              sig { returns(Integer) }
              def month; end
              # The four-digit year of birth.
              sig { returns(Integer) }
              def year; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Documents < ::Stripe::StripeObject
              class CompanyAuthorization < ::Stripe::StripeObject
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class Passport < ::Stripe::StripeObject
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class PrimaryVerification < ::Stripe::StripeObject
                class FrontBack < ::Stripe::StripeObject
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the back of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  sig { returns(T.nilable(String)) }
                  def back; end
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the front of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  sig { returns(String) }
                  def front; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens for the front and back of the verification document.
                sig { returns(FrontBack) }
                def front_back; end
                # The format of the verification document. Currently supports `front_back` only.
                sig { returns(String) }
                def type; end
                def self.inner_class_types
                  @inner_class_types = {front_back: FrontBack}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class SecondaryVerification < ::Stripe::StripeObject
                class FrontBack < ::Stripe::StripeObject
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the back of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  sig { returns(T.nilable(String)) }
                  def back; end
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the front of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  sig { returns(String) }
                  def front; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens for the front and back of the verification document.
                sig { returns(FrontBack) }
                def front_back; end
                # The format of the verification document. Currently supports `front_back` only.
                sig { returns(String) }
                def type; end
                def self.inner_class_types
                  @inner_class_types = {front_back: FrontBack}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class Visa < ::Stripe::StripeObject
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                sig { returns(T::Array[String]) }
                def files; end
                # The format of the document. Currently supports `files` only.
                sig { returns(String) }
                def type; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # One or more documents that demonstrate proof that this person is authorized to represent the company.
              sig { returns(T.nilable(CompanyAuthorization)) }
              def company_authorization; end
              # One or more documents showing the person’s passport page with photo and personal data.
              sig { returns(T.nilable(Passport)) }
              def passport; end
              # An identifying document showing the person's name, either a passport or local ID card.
              sig { returns(T.nilable(PrimaryVerification)) }
              def primary_verification; end
              # A document showing address, either a passport, local ID card, or utility bill from a well-known utility company.
              sig { returns(T.nilable(SecondaryVerification)) }
              def secondary_verification; end
              # One or more documents showing the person’s visa required for living in the country where they are residing.
              sig { returns(T.nilable(Visa)) }
              def visa; end
              def self.inner_class_types
                @inner_class_types = {
                  company_authorization: CompanyAuthorization,
                  passport: Passport,
                  primary_verification: PrimaryVerification,
                  secondary_verification: SecondaryVerification,
                  visa: Visa,
                }
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class IdNumber < ::Stripe::StripeObject
              # The ID number type of an individual.
              sig { returns(String) }
              def type; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Relationship < ::Stripe::StripeObject
              # Whether the individual is an authorizer of the Account's identity.
              sig { returns(T.nilable(T::Boolean)) }
              def authorizer; end
              # Whether the individual is a director of the Account's identity. Directors are typically members of the governing board of the company or are responsible for making sure that the company meets its regulatory obligations.
              sig { returns(T.nilable(T::Boolean)) }
              def director; end
              # Whether the individual has significant responsibility to control, manage, or direct the organization.
              sig { returns(T.nilable(T::Boolean)) }
              def executive; end
              # Whether the individual is the legal guardian of the Account's representative.
              sig { returns(T.nilable(T::Boolean)) }
              def legal_guardian; end
              # Whether the individual is an owner of the Account's identity.
              sig { returns(T.nilable(T::Boolean)) }
              def owner; end
              # The percentage of the Account's identity that the individual owns.
              sig { returns(T.nilable(String)) }
              def percent_ownership; end
              # Whether the individual is authorized as the primary representative of the Account. This is the person nominated by the business to provide information about themselves, and general information about the account. There can only be one representative at any given time. At the time the account is created, this person should be set to the person responsible for opening the account.
              sig { returns(T.nilable(T::Boolean)) }
              def representative; end
              # The individual's title (e.g., CEO, Support Engineer).
              sig { returns(T.nilable(String)) }
              def title; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class ScriptAddresses < ::Stripe::StripeObject
              class Kana < ::Stripe::StripeObject
                # City, district, suburb, town, or village.
                sig { returns(T.nilable(String)) }
                def city; end
                # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
                sig { returns(T.nilable(String)) }
                def country; end
                # Address line 1 (e.g., street, PO Box, or company name).
                sig { returns(T.nilable(String)) }
                def line1; end
                # Address line 2 (e.g., apartment, suite, unit, or building).
                sig { returns(T.nilable(String)) }
                def line2; end
                # ZIP or postal code.
                sig { returns(T.nilable(String)) }
                def postal_code; end
                # State, county, province, or region.
                sig { returns(T.nilable(String)) }
                def state; end
                # Town or district.
                sig { returns(T.nilable(String)) }
                def town; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class Kanji < ::Stripe::StripeObject
                # City, district, suburb, town, or village.
                sig { returns(T.nilable(String)) }
                def city; end
                # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
                sig { returns(T.nilable(String)) }
                def country; end
                # Address line 1 (e.g., street, PO Box, or company name).
                sig { returns(T.nilable(String)) }
                def line1; end
                # Address line 2 (e.g., apartment, suite, unit, or building).
                sig { returns(T.nilable(String)) }
                def line2; end
                # ZIP or postal code.
                sig { returns(T.nilable(String)) }
                def postal_code; end
                # State, county, province, or region.
                sig { returns(T.nilable(String)) }
                def state; end
                # Town or district.
                sig { returns(T.nilable(String)) }
                def town; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # Kana Address.
              sig { returns(T.nilable(Kana)) }
              def kana; end
              # Kanji Address.
              sig { returns(T.nilable(Kanji)) }
              def kanji; end
              def self.inner_class_types
                @inner_class_types = {kana: Kana, kanji: Kanji}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class ScriptNames < ::Stripe::StripeObject
              class Kana < ::Stripe::StripeObject
                # The person's first or given name.
                sig { returns(T.nilable(String)) }
                def given_name; end
                # The person's last or family name.
                sig { returns(T.nilable(String)) }
                def surname; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class Kanji < ::Stripe::StripeObject
                # The person's first or given name.
                sig { returns(T.nilable(String)) }
                def given_name; end
                # The person's last or family name.
                sig { returns(T.nilable(String)) }
                def surname; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # Persons name in kana script.
              sig { returns(T.nilable(Kana)) }
              def kana; end
              # Persons name in kanji script.
              sig { returns(T.nilable(Kanji)) }
              def kanji; end
              def self.inner_class_types
                @inner_class_types = {kana: Kana, kanji: Kanji}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # The account ID which the individual belongs to.
            sig { returns(String) }
            def account; end
            # Additional addresses associated with the individual.
            sig { returns(T.nilable(T::Array[AdditionalAddress])) }
            def additional_addresses; end
            # Additional names (e.g. aliases) associated with the individual.
            sig { returns(T.nilable(T::Array[AdditionalName])) }
            def additional_names; end
            # Terms of service acceptances.
            sig { returns(T.nilable(AdditionalTermsOfService)) }
            def additional_terms_of_service; end
            # The individual's residential address.
            sig { returns(T.nilable(Address)) }
            def address; end
            # Time at which the object was created. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
            sig { returns(String) }
            def created; end
            # The individual's date of birth.
            sig { returns(T.nilable(DateOfBirth)) }
            def date_of_birth; end
            # Documents that may be submitted to satisfy various informational requests.
            sig { returns(T.nilable(Documents)) }
            def documents; end
            # The individual's email address.
            sig { returns(T.nilable(String)) }
            def email; end
            # The individual's first name.
            sig { returns(T.nilable(String)) }
            def given_name; end
            # Unique identifier for the object.
            sig { returns(String) }
            def id; end
            # The identification numbers (e.g., SSN) associated with the individual.
            sig { returns(T.nilable(T::Array[IdNumber])) }
            def id_numbers; end
            # The individual's gender (International regulations require either "male” or "female").
            sig { returns(T.nilable(String)) }
            def legal_gender; end
            # Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
            sig { returns(T.nilable(T::Hash[String, String])) }
            def metadata; end
            # The countries where the individual is a national. Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
            sig { returns(T.nilable(T::Array[String])) }
            def nationalities; end
            # String representing the object's type. Objects of the same type share the same value.
            sig { returns(String) }
            def object; end
            # The individual's phone number.
            sig { returns(T.nilable(String)) }
            def phone; end
            # Indicates if the individual or any of their representatives, family members, or other closely related persons, declares that they hold or have held an important public job or function, in any jurisdiction.
            sig { returns(T.nilable(String)) }
            def political_exposure; end
            # The relationship that this individual has with the Account's identity.
            sig { returns(T.nilable(Relationship)) }
            def relationship; end
            # The script addresses (e.g., non-Latin characters) associated with the individual.
            sig { returns(T.nilable(ScriptAddresses)) }
            def script_addresses; end
            # The script names (e.g. non-Latin characters) associated with the individual.
            sig { returns(T.nilable(ScriptNames)) }
            def script_names; end
            # The individual's last name.
            sig { returns(T.nilable(String)) }
            def surname; end
            # Time at which the object was last updated.
            sig { returns(String) }
            def updated; end
            def self.inner_class_types
              @inner_class_types = {
                additional_addresses: AdditionalAddress,
                additional_names: AdditionalName,
                additional_terms_of_service: AdditionalTermsOfService,
                address: Address,
                date_of_birth: DateOfBirth,
                documents: Documents,
                id_numbers: IdNumber,
                relationship: Relationship,
                script_addresses: ScriptAddresses,
                script_names: ScriptNames,
              }
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attestations from the identity's key people, e.g. owners, executives, directors, representatives.
          sig { returns(T.nilable(Attestations)) }
          def attestations; end
          # Information about the company or business.
          sig { returns(T.nilable(BusinessDetails)) }
          def business_details; end
          # The country in which the account holder resides, or in which the business is legally established. This should be an [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code.
          sig { returns(T.nilable(String)) }
          def country; end
          # The entity type.
          sig { returns(T.nilable(String)) }
          def entity_type; end
          # Information about the individual represented by the Account. This property is `null` unless `entity_type` is set to `individual`.
          sig { returns(T.nilable(Individual)) }
          def individual; end
          def self.inner_class_types
            @inner_class_types = {
              attestations: Attestations,
              business_details: BusinessDetails,
              individual: Individual,
            }
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Requirements < ::Stripe::StripeObject
          class Entry < ::Stripe::StripeObject
            class Error < ::Stripe::StripeObject
              # Machine-readable code describing the error.
              sig { returns(String) }
              def code; end
              # Human-readable description of the error.
              sig { returns(String) }
              def description; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Impact < ::Stripe::StripeObject
              class RestrictsCapability < ::Stripe::StripeObject
                class Deadline < ::Stripe::StripeObject
                  # The current status of the requirement's impact.
                  sig { returns(String) }
                  def status; end
                  def self.inner_class_types
                    @inner_class_types = {}
                  end
                  def self.field_remappings
                    @field_remappings = {}
                  end
                end
                # The name of the Capability which will be restricted.
                sig { returns(String) }
                def capability; end
                # The configuration which specifies the Capability which will be restricted.
                sig { returns(String) }
                def configuration; end
                # Details about when in the account lifecycle the requirement must be collected by the avoid the Capability restriction.
                sig { returns(Deadline) }
                def deadline; end
                def self.inner_class_types
                  @inner_class_types = {deadline: Deadline}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # The Capabilities that will be restricted if the requirement is not collected and satisfactory to Stripe.
              sig { returns(T.nilable(T::Array[RestrictsCapability])) }
              def restricts_capabilities; end
              def self.inner_class_types
                @inner_class_types = {restricts_capabilities: RestrictsCapability}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class MinimumDeadline < ::Stripe::StripeObject
              # The current status of the requirement's impact.
              sig { returns(String) }
              def status; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Reference < ::Stripe::StripeObject
              # If `inquiry` is the type, the inquiry token.
              sig { returns(T.nilable(String)) }
              def inquiry; end
              # If `resource` is the type, the resource token.
              sig { returns(T.nilable(String)) }
              def resource; end
              # The type of the reference. If the type is "inquiry", the inquiry token can be found in the "inquiry" field.
              # Otherwise the type is an API resource, the token for which can be found in the "resource" field.
              sig { returns(String) }
              def type; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class RequestedReason < ::Stripe::StripeObject
              # Machine-readable description of Stripe's reason for collecting the requirement.
              sig { returns(String) }
              def code; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Indicates whether the platform or Stripe is currently responsible for taking action on the requirement. Value can be `user` or `stripe`.
            sig { returns(String) }
            def awaiting_action_from; end
            # Machine-readable string describing the requirement.
            sig { returns(String) }
            def description; end
            # Descriptions of why the requirement must be collected, or why the collected information isn't satisfactory to Stripe.
            sig { returns(T::Array[Error]) }
            def errors; end
            # A hash describing the impact of not collecting the requirement, or Stripe not being able to verify the collected information.
            sig { returns(Impact) }
            def impact; end
            # The soonest point when the account will be impacted by not providing the requirement.
            sig { returns(MinimumDeadline) }
            def minimum_deadline; end
            # A reference to the location of the requirement.
            sig { returns(T.nilable(Reference)) }
            def reference; end
            # A list of reasons why Stripe is collecting the requirement.
            sig { returns(T::Array[RequestedReason]) }
            def requested_reasons; end
            def self.inner_class_types
              @inner_class_types = {
                errors: Error,
                impact: Impact,
                minimum_deadline: MinimumDeadline,
                reference: Reference,
                requested_reasons: RequestedReason,
              }
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class Summary < ::Stripe::StripeObject
            class MinimumDeadline < ::Stripe::StripeObject
              # The current strictest status of all requirements on the Account.
              sig { returns(String) }
              def status; end
              # The soonest RFC3339 date & time UTC value a requirement can impact the Account.
              sig { returns(T.nilable(String)) }
              def time; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # The soonest date and time a requirement on the Account will become `past due`. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: `2022-09-18T13:22:18.123Z`.
            sig { returns(T.nilable(MinimumDeadline)) }
            def minimum_deadline; end
            def self.inner_class_types
              @inner_class_types = {minimum_deadline: MinimumDeadline}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # A list of requirements for the Account.
          sig { returns(T.nilable(T::Array[Entry])) }
          def entries; end
          # An object containing an overview of requirements for the Account.
          sig { returns(T.nilable(Summary)) }
          def summary; end
          def self.inner_class_types
            @inner_class_types = {entries: Entry, summary: Summary}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The configurations that have been applied to this account.
        sig { returns(T::Array[String]) }
        def applied_configurations; end
        # Indicates whether the account has been closed.
        sig { returns(T.nilable(T::Boolean)) }
        def closed; end
        # An Account represents a company, individual, or other entity that a user interacts with. Accounts store identity information and one or more configurations that enable product-specific capabilities. You can assign configurations at creation or add them later.
        sig { returns(T.nilable(Configuration)) }
        def configuration; end
        # The default contact email address for the Account. Required when configuring the account as a merchant or recipient.
        sig { returns(T.nilable(String)) }
        def contact_email; end
        # Time at which the object was created. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
        sig { returns(String) }
        def created; end
        # A value indicating the Stripe dashboard this Account has access to. This will depend on which configurations are enabled for this account.
        sig { returns(T.nilable(String)) }
        def dashboard; end
        # Default values for settings shared across Account configurations.
        sig { returns(T.nilable(Defaults)) }
        def defaults; end
        # A descriptive name for the Account. This name will be surfaced in the Stripe Dashboard and on any invoices sent to the Account.
        sig { returns(T.nilable(String)) }
        def display_name; end
        # Information about the future requirements for the Account that will eventually come into effect, including what information needs to be collected, and by when.
        sig { returns(T.nilable(FutureRequirements)) }
        def future_requirements; end
        # Unique identifier for the Account.
        sig { returns(String) }
        def id; end
        # Information about the company, individual, and business represented by the Account.
        sig { returns(T.nilable(Identity)) }
        def identity; end
        # Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        sig { returns(T.nilable(T::Hash[String, String])) }
        def metadata; end
        # String representing the object's type. Objects of the same type share the same value of the object field.
        sig { returns(String) }
        def object; end
        # Information about the active requirements for the Account, including what information needs to be collected, and by when.
        sig { returns(T.nilable(Requirements)) }
        def requirements; end
        # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        sig { returns(T::Boolean) }
        def livemode; end
      end
    end
  end
end