# File generated from our OpenAPI spec
# frozen_string_literal: true

module Stripe
  module V2
    module Core
      class AccountUpdateParams < ::Stripe::RequestParams
        class Configuration < ::Stripe::RequestParams
          class Customer < ::Stripe::RequestParams
            class AutomaticIndirectTax < ::Stripe::RequestParams
              # The customer account's tax exemption status: `none`, `exempt`, or `reverse`. When `reverse`, invoice and receipt PDFs include "Reverse charge".
              attr_accessor :exempt
              # A recent IP address of the customer used for tax reporting and tax location inference.
              attr_accessor :ip_address
              # A per-request flag that indicates when Stripe should validate the customer tax location - defaults to `auto`.
              attr_accessor :validate_location

              def initialize(exempt: nil, ip_address: nil, validate_location: nil)
                @exempt = exempt
                @ip_address = ip_address
                @validate_location = validate_location
              end
            end

            class Billing < ::Stripe::RequestParams
              class Invoice < ::Stripe::RequestParams
                class CustomField < ::Stripe::RequestParams
                  # The name of the custom field. This may be up to 40 characters.
                  attr_accessor :name
                  # The value of the custom field. This may be up to 140 characters. When updating, pass an empty string to remove previously-defined values.
                  attr_accessor :value

                  def initialize(name: nil, value: nil)
                    @name = name
                    @value = value
                  end
                end

                class Rendering < ::Stripe::RequestParams
                  # Indicates whether displayed line item prices and amounts on invoice PDFs include inclusive tax amounts. Must be either `include_inclusive_tax` or `exclude_tax`.
                  attr_accessor :amount_tax_display
                  # ID of the invoice rendering template to use for future invoices.
                  attr_accessor :template

                  def initialize(amount_tax_display: nil, template: nil)
                    @amount_tax_display = amount_tax_display
                    @template = template
                  end
                end
                # The list of up to 4 default custom fields to be displayed on invoices for this customer.
                attr_accessor :custom_fields
                # Default invoice footer.
                attr_accessor :footer
                # Sequence number to use on the customer account's next invoice. Defaults to 1.
                attr_accessor :next_sequence
                # Prefix used to generate unique invoice numbers. Must be 3-12 uppercase letters or numbers.
                attr_accessor :prefix
                # Default invoice PDF rendering options.
                attr_accessor :rendering

                def initialize(
                  custom_fields: nil,
                  footer: nil,
                  next_sequence: nil,
                  prefix: nil,
                  rendering: nil
                )
                  @custom_fields = custom_fields
                  @footer = footer
                  @next_sequence = next_sequence
                  @prefix = prefix
                  @rendering = rendering
                end
              end
              # ID of a PaymentMethod attached to the customer account to use as the default for invoices and subscriptions.
              attr_accessor :default_payment_method
              # Default invoice settings for the customer account.
              attr_accessor :invoice

              def initialize(default_payment_method: nil, invoice: nil)
                @default_payment_method = default_payment_method
                @invoice = invoice
              end
            end

            class Capabilities < ::Stripe::RequestParams
              class AutomaticIndirectTax < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end
              # Generates requirements for enabling automatic indirect tax calculation on this customer's invoices or subscriptions. Recommended to request this capability if planning to enable automatic tax calculation on this customer's invoices or subscriptions.
              attr_accessor :automatic_indirect_tax

              def initialize(automatic_indirect_tax: nil)
                @automatic_indirect_tax = automatic_indirect_tax
              end
            end

            class Shipping < ::Stripe::RequestParams
              class Address < ::Stripe::RequestParams
                # City, district, suburb, town, or village.
                attr_accessor :city
                # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
                attr_accessor :country
                # Address line 1 (e.g., street, PO Box, or company name).
                attr_accessor :line1
                # Address line 2 (e.g., apartment, suite, unit, or building).
                attr_accessor :line2
                # ZIP or postal code.
                attr_accessor :postal_code
                # State, county, province, or region.
                attr_accessor :state

                def initialize(
                  city: nil,
                  country: nil,
                  line1: nil,
                  line2: nil,
                  postal_code: nil,
                  state: nil
                )
                  @city = city
                  @country = country
                  @line1 = line1
                  @line2 = line2
                  @postal_code = postal_code
                  @state = state
                end
              end
              # Customer shipping address.
              attr_accessor :address
              # Customer name.
              attr_accessor :name
              # Customer phone (including extension).
              attr_accessor :phone

              def initialize(address: nil, name: nil, phone: nil)
                @address = address
                @name = name
                @phone = phone
              end
            end
            # Represents the state of the configuration, and can be updated to deactivate or re-apply a configuration.
            attr_accessor :applied
            # Automatic indirect tax settings to be used when automatic tax calculation is enabled on the customer's invoices, subscriptions, checkout sessions, or payment links. Surfaces if automatic tax calculation is possible given the current customer location information.
            attr_accessor :automatic_indirect_tax
            # Billing settings - default settings used for this customer in Billing flows such as Invoices and Subscriptions.
            attr_accessor :billing
            # Capabilities that have been requested on the Customer Configuration.
            attr_accessor :capabilities
            # The customer's shipping information. Appears on invoices emailed to this customer.
            attr_accessor :shipping
            # ID of the test clock to attach to the customer. Can only be set on testmode Accounts, and when the Customer Configuration is first set on an Account.
            attr_accessor :test_clock

            def initialize(
              applied: nil,
              automatic_indirect_tax: nil,
              billing: nil,
              capabilities: nil,
              shipping: nil,
              test_clock: nil
            )
              @applied = applied
              @automatic_indirect_tax = automatic_indirect_tax
              @billing = billing
              @capabilities = capabilities
              @shipping = shipping
              @test_clock = test_clock
            end
          end

          class Merchant < ::Stripe::RequestParams
            class BacsDebitPayments < ::Stripe::RequestParams
              # Display name for Bacs Direct Debit payments.
              attr_accessor :display_name

              def initialize(display_name: nil)
                @display_name = display_name
              end
            end

            class Branding < ::Stripe::RequestParams
              # ID of a [file upload](https://docs.stripe.com/api/persons/update#create_file): An icon for the merchant. Must be square and at least 128px x 128px.
              attr_accessor :icon
              # ID of a [file upload](https://docs.stripe.com/api/persons/update#create_file): A logo for the merchant that will be used in Checkout instead of the icon and without the merchant's name next to it if provided. Must be at least 128px x 128px.
              attr_accessor :logo
              # A CSS hex color value representing the primary branding color for the merchant.
              attr_accessor :primary_color
              # A CSS hex color value representing the secondary branding color for the merchant.
              attr_accessor :secondary_color

              def initialize(icon: nil, logo: nil, primary_color: nil, secondary_color: nil)
                @icon = icon
                @logo = logo
                @primary_color = primary_color
                @secondary_color = secondary_color
              end
            end

            class Capabilities < ::Stripe::RequestParams
              class AchDebitPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class AcssDebitPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class AffirmPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class AfterpayClearpayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class AlmaPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class AmazonPayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class AuBecsDebitPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class BacsDebitPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class BancontactPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class BlikPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class BoletoPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class CardPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class CartesBancairesPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class CashappPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class EpsPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class FpxPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class GbBankTransferPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class GrabpayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class IdealPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class JcbPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class JpBankTransferPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class KakaoPayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class KlarnaPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class KonbiniPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class KrCardPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class LinkPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class MobilepayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class MultibancoPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class MxBankTransferPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class NaverPayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class OxxoPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class P24Payments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class PayByBankPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class PaycoPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class PaynowPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class PromptpayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class RevolutPayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class SamsungPayPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class SepaBankTransferPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class SepaDebitPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class SwishPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class TwintPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class UsBankTransferPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end

              class ZipPayments < ::Stripe::RequestParams
                # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                attr_accessor :requested

                def initialize(requested: nil)
                  @requested = requested
                end
              end
              # Allow the merchant to process ACH debit payments.
              attr_accessor :ach_debit_payments
              # Allow the merchant to process ACSS debit payments.
              attr_accessor :acss_debit_payments
              # Allow the merchant to process Affirm payments.
              attr_accessor :affirm_payments
              # Allow the merchant to process Afterpay/Clearpay payments.
              attr_accessor :afterpay_clearpay_payments
              # Allow the merchant to process Alma payments.
              attr_accessor :alma_payments
              # Allow the merchant to process Amazon Pay payments.
              attr_accessor :amazon_pay_payments
              # Allow the merchant to process Australian BECS Direct Debit payments.
              attr_accessor :au_becs_debit_payments
              # Allow the merchant to process BACS Direct Debit payments.
              attr_accessor :bacs_debit_payments
              # Allow the merchant to process Bancontact payments.
              attr_accessor :bancontact_payments
              # Allow the merchant to process BLIK payments.
              attr_accessor :blik_payments
              # Allow the merchant to process Boleto payments.
              attr_accessor :boleto_payments
              # Allow the merchant to collect card payments.
              attr_accessor :card_payments
              # Allow the merchant to process Cartes Bancaires payments.
              attr_accessor :cartes_bancaires_payments
              # Allow the merchant to process Cash App payments.
              attr_accessor :cashapp_payments
              # Allow the merchant to process EPS payments.
              attr_accessor :eps_payments
              # Allow the merchant to process FPX payments.
              attr_accessor :fpx_payments
              # Allow the merchant to process UK bank transfer payments.
              attr_accessor :gb_bank_transfer_payments
              # Allow the merchant to process GrabPay payments.
              attr_accessor :grabpay_payments
              # Allow the merchant to process iDEAL payments.
              attr_accessor :ideal_payments
              # Allow the merchant to process JCB card payments.
              attr_accessor :jcb_payments
              # Allow the merchant to process Japanese bank transfer payments.
              attr_accessor :jp_bank_transfer_payments
              # Allow the merchant to process Kakao Pay payments.
              attr_accessor :kakao_pay_payments
              # Allow the merchant to process Klarna payments.
              attr_accessor :klarna_payments
              # Allow the merchant to process Konbini convenience store payments.
              attr_accessor :konbini_payments
              # Allow the merchant to process Korean card payments.
              attr_accessor :kr_card_payments
              # Allow the merchant to process Link payments.
              attr_accessor :link_payments
              # Allow the merchant to process MobilePay payments.
              attr_accessor :mobilepay_payments
              # Allow the merchant to process Multibanco payments.
              attr_accessor :multibanco_payments
              # Allow the merchant to process Mexican bank transfer payments.
              attr_accessor :mx_bank_transfer_payments
              # Allow the merchant to process Naver Pay payments.
              attr_accessor :naver_pay_payments
              # Allow the merchant to process OXXO payments.
              attr_accessor :oxxo_payments
              # Allow the merchant to process Przelewy24 (P24) payments.
              attr_accessor :p24_payments
              # Allow the merchant to process Pay by Bank payments.
              attr_accessor :pay_by_bank_payments
              # Allow the merchant to process PAYCO payments.
              attr_accessor :payco_payments
              # Allow the merchant to process PayNow payments.
              attr_accessor :paynow_payments
              # Allow the merchant to process PromptPay payments.
              attr_accessor :promptpay_payments
              # Allow the merchant to process Revolut Pay payments.
              attr_accessor :revolut_pay_payments
              # Allow the merchant to process Samsung Pay payments.
              attr_accessor :samsung_pay_payments
              # Allow the merchant to process SEPA bank transfer payments.
              attr_accessor :sepa_bank_transfer_payments
              # Allow the merchant to process SEPA Direct Debit payments.
              attr_accessor :sepa_debit_payments
              # Allow the merchant to process Swish payments.
              attr_accessor :swish_payments
              # Allow the merchant to process TWINT payments.
              attr_accessor :twint_payments
              # Allow the merchant to process US bank transfer payments.
              attr_accessor :us_bank_transfer_payments
              # Allow the merchant to process Zip payments.
              attr_accessor :zip_payments

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
              )
                @ach_debit_payments = ach_debit_payments
                @acss_debit_payments = acss_debit_payments
                @affirm_payments = affirm_payments
                @afterpay_clearpay_payments = afterpay_clearpay_payments
                @alma_payments = alma_payments
                @amazon_pay_payments = amazon_pay_payments
                @au_becs_debit_payments = au_becs_debit_payments
                @bacs_debit_payments = bacs_debit_payments
                @bancontact_payments = bancontact_payments
                @blik_payments = blik_payments
                @boleto_payments = boleto_payments
                @card_payments = card_payments
                @cartes_bancaires_payments = cartes_bancaires_payments
                @cashapp_payments = cashapp_payments
                @eps_payments = eps_payments
                @fpx_payments = fpx_payments
                @gb_bank_transfer_payments = gb_bank_transfer_payments
                @grabpay_payments = grabpay_payments
                @ideal_payments = ideal_payments
                @jcb_payments = jcb_payments
                @jp_bank_transfer_payments = jp_bank_transfer_payments
                @kakao_pay_payments = kakao_pay_payments
                @klarna_payments = klarna_payments
                @konbini_payments = konbini_payments
                @kr_card_payments = kr_card_payments
                @link_payments = link_payments
                @mobilepay_payments = mobilepay_payments
                @multibanco_payments = multibanco_payments
                @mx_bank_transfer_payments = mx_bank_transfer_payments
                @naver_pay_payments = naver_pay_payments
                @oxxo_payments = oxxo_payments
                @p24_payments = p24_payments
                @pay_by_bank_payments = pay_by_bank_payments
                @payco_payments = payco_payments
                @paynow_payments = paynow_payments
                @promptpay_payments = promptpay_payments
                @revolut_pay_payments = revolut_pay_payments
                @samsung_pay_payments = samsung_pay_payments
                @sepa_bank_transfer_payments = sepa_bank_transfer_payments
                @sepa_debit_payments = sepa_debit_payments
                @swish_payments = swish_payments
                @twint_payments = twint_payments
                @us_bank_transfer_payments = us_bank_transfer_payments
                @zip_payments = zip_payments
              end
            end

            class CardPayments < ::Stripe::RequestParams
              class DeclineOn < ::Stripe::RequestParams
                # Whether Stripe automatically declines charges with an incorrect ZIP or postal code. This setting only applies when a ZIP or postal code is provided and they fail bank verification.
                attr_accessor :avs_failure
                # Whether Stripe automatically declines charges with an incorrect CVC. This setting only applies when a CVC is provided and it fails bank verification.
                attr_accessor :cvc_failure

                def initialize(avs_failure: nil, cvc_failure: nil)
                  @avs_failure = avs_failure
                  @cvc_failure = cvc_failure
                end
              end
              # Automatically declines certain charge types regardless of whether the card issuer accepted or declined the charge.
              attr_accessor :decline_on

              def initialize(decline_on: nil)
                @decline_on = decline_on
              end
            end

            class KonbiniPayments < ::Stripe::RequestParams
              class Support < ::Stripe::RequestParams
                class Hours < ::Stripe::RequestParams
                  # Support hours end time (JST time of day) for in `HH:MM` format.
                  attr_accessor :end_time
                  # Support hours start time (JST time of day) for in `HH:MM` format.
                  attr_accessor :start_time

                  def initialize(end_time: nil, start_time: nil)
                    @end_time = end_time
                    @start_time = start_time
                  end
                end
                # Support email address for Konbini payments.
                attr_accessor :email
                # Support hours for Konbini payments.
                attr_accessor :hours
                # Support phone number for Konbini payments.
                attr_accessor :phone

                def initialize(email: nil, hours: nil, phone: nil)
                  @email = email
                  @hours = hours
                  @phone = phone
                end
              end
              # Support for Konbini payments.
              attr_accessor :support

              def initialize(support: nil)
                @support = support
              end
            end

            class ScriptStatementDescriptor < ::Stripe::RequestParams
              class Kana < ::Stripe::RequestParams
                # The default text that appears on statements for non-card charges outside of Japan. For card charges, if you don’t set a statement_descriptor_prefix, this text is also used as the statement descriptor prefix. In that case, if concatenating the statement descriptor suffix causes the combined statement descriptor to exceed 22 characters, we truncate the statement_descriptor text to limit the full descriptor to 22 characters. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
                attr_accessor :descriptor
                # Default text that appears on statements for card charges outside of Japan, prefixing any dynamic statement_descriptor_suffix specified on the charge. To maximize space for the dynamic part of the descriptor, keep this text short. If you don’t specify this value, statement_descriptor is used as the prefix. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
                attr_accessor :prefix

                def initialize(descriptor: nil, prefix: nil)
                  @descriptor = descriptor
                  @prefix = prefix
                end
              end

              class Kanji < ::Stripe::RequestParams
                # The default text that appears on statements for non-card charges outside of Japan. For card charges, if you don’t set a statement_descriptor_prefix, this text is also used as the statement descriptor prefix. In that case, if concatenating the statement descriptor suffix causes the combined statement descriptor to exceed 22 characters, we truncate the statement_descriptor text to limit the full descriptor to 22 characters. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
                attr_accessor :descriptor
                # Default text that appears on statements for card charges outside of Japan, prefixing any dynamic statement_descriptor_suffix specified on the charge. To maximize space for the dynamic part of the descriptor, keep this text short. If you don’t specify this value, statement_descriptor is used as the prefix. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
                attr_accessor :prefix

                def initialize(descriptor: nil, prefix: nil)
                  @descriptor = descriptor
                  @prefix = prefix
                end
              end
              # The Kana variation of statement_descriptor used for charges in Japan. Japanese statement descriptors have [special requirements](https://docs.stripe.com/get-started/account/statement-descriptors#set-japanese-statement-descriptors).
              attr_accessor :kana
              # The Kanji variation of statement_descriptor used for charges in Japan. Japanese statement descriptors have [special requirements](https://docs.stripe.com/get-started/account/statement-descriptors#set-japanese-statement-descriptors).
              attr_accessor :kanji

              def initialize(kana: nil, kanji: nil)
                @kana = kana
                @kanji = kanji
              end
            end

            class StatementDescriptor < ::Stripe::RequestParams
              # The default text that appears on statements for non-card charges outside of Japan. For card charges, if you don’t set a statement_descriptor_prefix, this text is also used as the statement descriptor prefix. In that case, if concatenating the statement descriptor suffix causes the combined statement descriptor to exceed 22 characters, we truncate the statement_descriptor text to limit the full descriptor to 22 characters. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
              attr_accessor :descriptor
              # Default text that appears on statements for card charges outside of Japan, prefixing any dynamic statement_descriptor_suffix specified on the charge. To maximize space for the dynamic part of the descriptor, keep this text short. If you don’t specify this value, statement_descriptor is used as the prefix. For more information about statement descriptors and their requirements, see the Merchant Configuration settings documentation.
              attr_accessor :prefix

              def initialize(descriptor: nil, prefix: nil)
                @descriptor = descriptor
                @prefix = prefix
              end
            end

            class Support < ::Stripe::RequestParams
              class Address < ::Stripe::RequestParams
                # City, district, suburb, town, or village.
                attr_accessor :city
                # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
                attr_accessor :country
                # Address line 1 (e.g., street, PO Box, or company name).
                attr_accessor :line1
                # Address line 2 (e.g., apartment, suite, unit, or building).
                attr_accessor :line2
                # ZIP or postal code.
                attr_accessor :postal_code
                # State, county, province, or region.
                attr_accessor :state
                # Town or district.
                attr_accessor :town

                def initialize(
                  city: nil,
                  country: nil,
                  line1: nil,
                  line2: nil,
                  postal_code: nil,
                  state: nil,
                  town: nil
                )
                  @city = city
                  @country = country
                  @line1 = line1
                  @line2 = line2
                  @postal_code = postal_code
                  @state = state
                  @town = town
                end
              end
              # A publicly available mailing address for sending support issues to.
              attr_accessor :address
              # A publicly available email address for sending support issues to.
              attr_accessor :email
              # A publicly available phone number to call with support issues.
              attr_accessor :phone
              # A publicly available website for handling support issues.
              attr_accessor :url

              def initialize(address: nil, email: nil, phone: nil, url: nil)
                @address = address
                @email = email
                @phone = phone
                @url = url
              end
            end
            # Represents the state of the configuration, and can be updated to deactivate or re-apply a configuration.
            attr_accessor :applied
            # Settings for Bacs Direct Debit payments.
            attr_accessor :bacs_debit_payments
            # Settings used to apply the merchant's branding to email receipts, invoices, Checkout, and other products.
            attr_accessor :branding
            # Capabilities to request on the Merchant Configuration.
            attr_accessor :capabilities
            # Card payments settings.
            attr_accessor :card_payments
            # Settings specific to Konbini payments on the account.
            attr_accessor :konbini_payments
            # The Merchant Category Code (MCC) for the merchant. MCCs classify businesses based on the goods or services they provide.
            attr_accessor :mcc
            # Settings for the default text that appears on statements for language variations.
            attr_accessor :script_statement_descriptor
            # Settings for the default [statement descriptor](/connect/statement-descriptors) text.
            attr_accessor :statement_descriptor
            # Publicly available contact information for sending support issues to.
            attr_accessor :support

            def initialize(
              applied: nil,
              bacs_debit_payments: nil,
              branding: nil,
              capabilities: nil,
              card_payments: nil,
              konbini_payments: nil,
              mcc: nil,
              script_statement_descriptor: nil,
              statement_descriptor: nil,
              support: nil
            )
              @applied = applied
              @bacs_debit_payments = bacs_debit_payments
              @branding = branding
              @capabilities = capabilities
              @card_payments = card_payments
              @konbini_payments = konbini_payments
              @mcc = mcc
              @script_statement_descriptor = script_statement_descriptor
              @statement_descriptor = statement_descriptor
              @support = support
            end
          end

          class Recipient < ::Stripe::RequestParams
            class Capabilities < ::Stripe::RequestParams
              class StripeBalance < ::Stripe::RequestParams
                class StripeTransfers < ::Stripe::RequestParams
                  # To request a new Capability for an account, pass true. There can be a delay before the requested Capability becomes active.
                  attr_accessor :requested

                  def initialize(requested: nil)
                    @requested = requested
                  end
                end
                # Enables this Account to receive /v1/transfers into their Stripe Balance (/v1/balance).
                attr_accessor :stripe_transfers

                def initialize(stripe_transfers: nil)
                  @stripe_transfers = stripe_transfers
                end
              end
              # Capabilities that enable the recipient to manage their Stripe Balance (/v1/balance).
              attr_accessor :stripe_balance

              def initialize(stripe_balance: nil)
                @stripe_balance = stripe_balance
              end
            end
            # Represents the state of the configuration, and can be updated to deactivate or re-apply a configuration.
            attr_accessor :applied
            # Capabilities to request on the Recipient Configuration.
            attr_accessor :capabilities

            def initialize(applied: nil, capabilities: nil)
              @applied = applied
              @capabilities = capabilities
            end
          end
          # The Customer Configuration allows the Account to be charged.
          attr_accessor :customer
          # Enables the Account to act as a connected account and collect payments facilitated by a Connect platform. You must onboard your platform to Connect before you can add this configuration to your connected accounts. Utilize this configuration when the Account will be the Merchant of Record, like with Direct charges or Destination Charges with on_behalf_of set.
          attr_accessor :merchant
          # The Recipient Configuration allows the Account to receive funds. Utilize this configuration if the Account will not be the Merchant of Record, like with Separate Charges & Transfers, or Destination Charges without on_behalf_of set.
          attr_accessor :recipient

          def initialize(customer: nil, merchant: nil, recipient: nil)
            @customer = customer
            @merchant = merchant
            @recipient = recipient
          end
        end

        class Defaults < ::Stripe::RequestParams
          class Profile < ::Stripe::RequestParams
            # The business's publicly-available website.
            attr_accessor :business_url
            # The name which is used by the business.
            attr_accessor :doing_business_as
            # Internal-only description of the product sold or service provided by the business. It's used by Stripe for risk and underwriting purposes.
            attr_accessor :product_description

            def initialize(business_url: nil, doing_business_as: nil, product_description: nil)
              @business_url = business_url
              @doing_business_as = doing_business_as
              @product_description = product_description
            end
          end

          class Responsibilities < ::Stripe::RequestParams
            # A value indicating the party responsible for collecting fees from this account.
            attr_accessor :fees_collector
            # A value indicating who is responsible for losses when this Account can’t pay back negative balances from payments.
            attr_accessor :losses_collector

            def initialize(fees_collector: nil, losses_collector: nil)
              @fees_collector = fees_collector
              @losses_collector = losses_collector
            end
          end
          # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
          attr_accessor :currency
          # The Account's preferred locales (languages), ordered by preference.
          attr_accessor :locales
          # Account profile information.
          attr_accessor :profile
          # Default responsibilities held by either Stripe or the platform.
          attr_accessor :responsibilities

          def initialize(currency: nil, locales: nil, profile: nil, responsibilities: nil)
            @currency = currency
            @locales = locales
            @profile = profile
            @responsibilities = responsibilities
          end
        end

        class Identity < ::Stripe::RequestParams
          class Attestations < ::Stripe::RequestParams
            class DirectorshipDeclaration < ::Stripe::RequestParams
              # The time marking when the director attestation was made. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
              attr_accessor :date
              # The IP address from which the director attestation was made.
              attr_accessor :ip
              # The user agent of the browser from which the director attestation was made.
              attr_accessor :user_agent

              def initialize(date: nil, ip: nil, user_agent: nil)
                @date = date
                @ip = ip
                @user_agent = user_agent
              end
            end

            class OwnershipDeclaration < ::Stripe::RequestParams
              # The time marking when the beneficial owner attestation was made. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
              attr_accessor :date
              # The IP address from which the beneficial owner attestation was made.
              attr_accessor :ip
              # The user agent of the browser from which the beneficial owner attestation was made.
              attr_accessor :user_agent

              def initialize(date: nil, ip: nil, user_agent: nil)
                @date = date
                @ip = ip
                @user_agent = user_agent
              end
            end

            class PersonsProvided < ::Stripe::RequestParams
              # Whether the company’s directors have been provided. Set this Boolean to true after creating all the company’s directors with the [Persons API](https://docs.stripe.com/api/v2/core/accounts/createperson).
              attr_accessor :directors
              # Whether the company’s executives have been provided. Set this Boolean to true after creating all the company’s executives with the [Persons API](https://docs.stripe.com/api/v2/core/accounts/createperson).
              attr_accessor :executives
              # Whether the company’s owners have been provided. Set this Boolean to true after creating all the company’s owners with the [Persons API](https://docs.stripe.com/api/v2/core/accounts/createperson).
              attr_accessor :owners
              # Reason for why the company is exempt from providing ownership information.
              attr_accessor :ownership_exemption_reason

              def initialize(
                directors: nil,
                executives: nil,
                owners: nil,
                ownership_exemption_reason: nil
              )
                @directors = directors
                @executives = executives
                @owners = owners
                @ownership_exemption_reason = ownership_exemption_reason
              end
            end

            class RepresentativeDeclaration < ::Stripe::RequestParams
              # The time marking when the representative attestation was made. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
              attr_accessor :date
              # The IP address from which the representative attestation was made.
              attr_accessor :ip
              # The user agent of the browser from which the representative attestation was made.
              attr_accessor :user_agent

              def initialize(date: nil, ip: nil, user_agent: nil)
                @date = date
                @ip = ip
                @user_agent = user_agent
              end
            end

            class TermsOfService < ::Stripe::RequestParams
              class Account < ::Stripe::RequestParams
                # The time when the Account's representative accepted the terms of service. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
                attr_accessor :date
                # The IP address from which the Account's representative accepted the terms of service.
                attr_accessor :ip
                # The user agent of the browser from which the Account's representative accepted the terms of service.
                attr_accessor :user_agent

                def initialize(date: nil, ip: nil, user_agent: nil)
                  @date = date
                  @ip = ip
                  @user_agent = user_agent
                end
              end

              class CryptoStorer < ::Stripe::RequestParams
                # The time when the Account's representative accepted the terms of service. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
                attr_accessor :date
                # The IP address from which the Account's representative accepted the terms of service.
                attr_accessor :ip
                # The user agent of the browser from which the Account's representative accepted the terms of service.
                attr_accessor :user_agent

                def initialize(date: nil, ip: nil, user_agent: nil)
                  @date = date
                  @ip = ip
                  @user_agent = user_agent
                end
              end

              class Storer < ::Stripe::RequestParams
                # The time when the Account's representative accepted the terms of service. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
                attr_accessor :date
                # The IP address from which the Account's representative accepted the terms of service.
                attr_accessor :ip
                # The user agent of the browser from which the Account's representative accepted the terms of service.
                attr_accessor :user_agent

                def initialize(date: nil, ip: nil, user_agent: nil)
                  @date = date
                  @ip = ip
                  @user_agent = user_agent
                end
              end
              # Details on the Account's acceptance of the [Stripe Services Agreement](https://docs.stripe.com/connect/updating-accounts#tos-acceptance).
              attr_accessor :account
              # Details on the Account's acceptance of Crypto-storer-specific terms of service.
              attr_accessor :crypto_storer
              # Details on the Account's acceptance of Treasury-specific terms of service.
              attr_accessor :storer

              def initialize(account: nil, crypto_storer: nil, storer: nil)
                @account = account
                @crypto_storer = crypto_storer
                @storer = storer
              end
            end
            # This hash is used to attest that the directors information provided to Stripe is both current and correct.
            attr_accessor :directorship_declaration
            # This hash is used to attest that the beneficial owner information provided to Stripe is both current and correct.
            attr_accessor :ownership_declaration
            # Attestation that all Persons with a specific Relationship value have been provided.
            attr_accessor :persons_provided
            # This hash is used to attest that the representative is authorized to act as the representative of their legal entity.
            attr_accessor :representative_declaration
            # Attestations of accepted terms of service agreements.
            attr_accessor :terms_of_service

            def initialize(
              directorship_declaration: nil,
              ownership_declaration: nil,
              persons_provided: nil,
              representative_declaration: nil,
              terms_of_service: nil
            )
              @directorship_declaration = directorship_declaration
              @ownership_declaration = ownership_declaration
              @persons_provided = persons_provided
              @representative_declaration = representative_declaration
              @terms_of_service = terms_of_service
            end
          end

          class BusinessDetails < ::Stripe::RequestParams
            class Address < ::Stripe::RequestParams
              # City, district, suburb, town, or village.
              attr_accessor :city
              # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
              attr_accessor :country
              # Address line 1 (e.g., street, PO Box, or company name).
              attr_accessor :line1
              # Address line 2 (e.g., apartment, suite, unit, or building).
              attr_accessor :line2
              # ZIP or postal code.
              attr_accessor :postal_code
              # State, county, province, or region.
              attr_accessor :state
              # Town or district.
              attr_accessor :town

              def initialize(
                city: nil,
                country: nil,
                line1: nil,
                line2: nil,
                postal_code: nil,
                state: nil,
                town: nil
              )
                @city = city
                @country = country
                @line1 = line1
                @line2 = line2
                @postal_code = postal_code
                @state = state
                @town = town
              end
            end

            class AnnualRevenue < ::Stripe::RequestParams
              class Amount < ::Stripe::RequestParams
                # A non-negative integer representing how much to charge in the [smallest currency unit](https://docs.stripe.com/currencies#minor-units).
                attr_accessor :value
                # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
                attr_accessor :currency

                def initialize(value: nil, currency: nil)
                  @value = value
                  @currency = currency
                end
              end
              # A non-negative integer representing the amount in the smallest currency unit.
              attr_accessor :amount
              # The close-out date of the preceding fiscal year in ISO 8601 format. E.g. 2023-12-31 for the 31st of December, 2023.
              attr_accessor :fiscal_year_end

              def initialize(amount: nil, fiscal_year_end: nil)
                @amount = amount
                @fiscal_year_end = fiscal_year_end
              end
            end

            class Documents < ::Stripe::RequestParams
              class BankAccountOwnershipVerification < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                attr_accessor :files
                # The format of the document. Currently supports `files` only.
                attr_accessor :type

                def initialize(files: nil, type: nil)
                  @files = files
                  @type = type
                end
              end

              class CompanyLicense < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                attr_accessor :files
                # The format of the document. Currently supports `files` only.
                attr_accessor :type

                def initialize(files: nil, type: nil)
                  @files = files
                  @type = type
                end
              end

              class CompanyMemorandumOfAssociation < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                attr_accessor :files
                # The format of the document. Currently supports `files` only.
                attr_accessor :type

                def initialize(files: nil, type: nil)
                  @files = files
                  @type = type
                end
              end

              class CompanyMinisterialDecree < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                attr_accessor :files
                # The format of the document. Currently supports `files` only.
                attr_accessor :type

                def initialize(files: nil, type: nil)
                  @files = files
                  @type = type
                end
              end

              class CompanyRegistrationVerification < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                attr_accessor :files
                # The format of the document. Currently supports `files` only.
                attr_accessor :type

                def initialize(files: nil, type: nil)
                  @files = files
                  @type = type
                end
              end

              class CompanyTaxIdVerification < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                attr_accessor :files
                # The format of the document. Currently supports `files` only.
                attr_accessor :type

                def initialize(files: nil, type: nil)
                  @files = files
                  @type = type
                end
              end

              class PrimaryVerification < ::Stripe::RequestParams
                class FrontBack < ::Stripe::RequestParams
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the back of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  attr_accessor :back
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the front of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  attr_accessor :front

                  def initialize(back: nil, front: nil)
                    @back = back
                    @front = front
                  end
                end
                # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens referring to each side of the document.
                attr_accessor :front_back
                # The format of the verification document. Currently supports `front_back` only.
                attr_accessor :type

                def initialize(front_back: nil, type: nil)
                  @front_back = front_back
                  @type = type
                end
              end

              class ProofOfAddress < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                attr_accessor :files
                # The format of the document. Currently supports `files` only.
                attr_accessor :type

                def initialize(files: nil, type: nil)
                  @files = files
                  @type = type
                end
              end

              class ProofOfRegistration < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                attr_accessor :files
                # The format of the document. Currently supports `files` only.
                attr_accessor :type

                def initialize(files: nil, type: nil)
                  @files = files
                  @type = type
                end
              end

              class ProofOfUltimateBeneficialOwnership < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                attr_accessor :files
                # The format of the document. Currently supports `files` only.
                attr_accessor :type

                def initialize(files: nil, type: nil)
                  @files = files
                  @type = type
                end
              end
              # One or more documents that support the bank account ownership verification requirement. Must be a document associated with the account’s primary active bank account that displays the last 4 digits of the account number, either a statement or a check.
              attr_accessor :bank_account_ownership_verification
              # One or more documents that demonstrate proof of a company’s license to operate.
              attr_accessor :company_license
              # One or more documents showing the company’s Memorandum of Association.
              attr_accessor :company_memorandum_of_association
              # Certain countries only: One or more documents showing the ministerial decree legalizing the company’s establishment.
              attr_accessor :company_ministerial_decree
              # One or more documents that demonstrate proof of a company’s registration with the appropriate local authorities.
              attr_accessor :company_registration_verification
              # One or more documents that demonstrate proof of a company’s tax ID.
              attr_accessor :company_tax_id_verification
              # A document verifying the business.
              attr_accessor :primary_verification
              # One or more documents that demonstrate proof of address.
              attr_accessor :proof_of_address
              # One or more documents showing the company’s proof of registration with the national business registry.
              attr_accessor :proof_of_registration
              # One or more documents that demonstrate proof of ultimate beneficial ownership.
              attr_accessor :proof_of_ultimate_beneficial_ownership

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
              )
                @bank_account_ownership_verification = bank_account_ownership_verification
                @company_license = company_license
                @company_memorandum_of_association = company_memorandum_of_association
                @company_ministerial_decree = company_ministerial_decree
                @company_registration_verification = company_registration_verification
                @company_tax_id_verification = company_tax_id_verification
                @primary_verification = primary_verification
                @proof_of_address = proof_of_address
                @proof_of_registration = proof_of_registration
                @proof_of_ultimate_beneficial_ownership = proof_of_ultimate_beneficial_ownership
              end
            end

            class IdNumber < ::Stripe::RequestParams
              # The registrar of the ID number (Only valid for DE ID number types).
              attr_accessor :registrar
              # Open Enum. The ID number type of a business entity.
              attr_accessor :type
              # The value of the ID number.
              attr_accessor :value

              def initialize(registrar: nil, type: nil, value: nil)
                @registrar = registrar
                @type = type
                @value = value
              end
            end

            class MonthlyEstimatedRevenue < ::Stripe::RequestParams
              class Amount < ::Stripe::RequestParams
                # A non-negative integer representing how much to charge in the [smallest currency unit](https://docs.stripe.com/currencies#minor-units).
                attr_accessor :value
                # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
                attr_accessor :currency

                def initialize(value: nil, currency: nil)
                  @value = value
                  @currency = currency
                end
              end
              # A non-negative integer representing the amount in the smallest currency unit.
              attr_accessor :amount

              def initialize(amount: nil)
                @amount = amount
              end
            end

            class ScriptAddresses < ::Stripe::RequestParams
              class Kana < ::Stripe::RequestParams
                # City, district, suburb, town, or village.
                attr_accessor :city
                # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
                attr_accessor :country
                # Address line 1 (e.g., street, PO Box, or company name).
                attr_accessor :line1
                # Address line 2 (e.g., apartment, suite, unit, or building).
                attr_accessor :line2
                # ZIP or postal code.
                attr_accessor :postal_code
                # State, county, province, or region.
                attr_accessor :state
                # Town or district.
                attr_accessor :town

                def initialize(
                  city: nil,
                  country: nil,
                  line1: nil,
                  line2: nil,
                  postal_code: nil,
                  state: nil,
                  town: nil
                )
                  @city = city
                  @country = country
                  @line1 = line1
                  @line2 = line2
                  @postal_code = postal_code
                  @state = state
                  @town = town
                end
              end

              class Kanji < ::Stripe::RequestParams
                # City, district, suburb, town, or village.
                attr_accessor :city
                # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
                attr_accessor :country
                # Address line 1 (e.g., street, PO Box, or company name).
                attr_accessor :line1
                # Address line 2 (e.g., apartment, suite, unit, or building).
                attr_accessor :line2
                # ZIP or postal code.
                attr_accessor :postal_code
                # State, county, province, or region.
                attr_accessor :state
                # Town or district.
                attr_accessor :town

                def initialize(
                  city: nil,
                  country: nil,
                  line1: nil,
                  line2: nil,
                  postal_code: nil,
                  state: nil,
                  town: nil
                )
                  @city = city
                  @country = country
                  @line1 = line1
                  @line2 = line2
                  @postal_code = postal_code
                  @state = state
                  @town = town
                end
              end
              # Kana Address.
              attr_accessor :kana
              # Kanji Address.
              attr_accessor :kanji

              def initialize(kana: nil, kanji: nil)
                @kana = kana
                @kanji = kanji
              end
            end

            class ScriptNames < ::Stripe::RequestParams
              class Kana < ::Stripe::RequestParams
                # Registered name of the business.
                attr_accessor :registered_name

                def initialize(registered_name: nil)
                  @registered_name = registered_name
                end
              end

              class Kanji < ::Stripe::RequestParams
                # Registered name of the business.
                attr_accessor :registered_name

                def initialize(registered_name: nil)
                  @registered_name = registered_name
                end
              end
              # Kana name.
              attr_accessor :kana
              # Kanji name.
              attr_accessor :kanji

              def initialize(kana: nil, kanji: nil)
                @kana = kana
                @kanji = kanji
              end
            end
            # The business registration address of the business entity.
            attr_accessor :address
            # The business gross annual revenue for its preceding fiscal year.
            attr_accessor :annual_revenue
            # A document verifying the business.
            attr_accessor :documents
            # Estimated maximum number of workers currently engaged by the business (including employees, contractors, and vendors).
            attr_accessor :estimated_worker_count
            # The ID numbers of a business entity.
            attr_accessor :id_numbers
            # An estimate of the monthly revenue of the business.
            attr_accessor :monthly_estimated_revenue
            # The phone number of the Business Entity.
            attr_accessor :phone
            # The business legal name.
            attr_accessor :registered_name
            # The business registration address of the business entity in non latin script.
            attr_accessor :script_addresses
            # The business legal name in non latin script.
            attr_accessor :script_names
            # The category identifying the legal structure of the business.
            attr_accessor :structure

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
            )
              @address = address
              @annual_revenue = annual_revenue
              @documents = documents
              @estimated_worker_count = estimated_worker_count
              @id_numbers = id_numbers
              @monthly_estimated_revenue = monthly_estimated_revenue
              @phone = phone
              @registered_name = registered_name
              @script_addresses = script_addresses
              @script_names = script_names
              @structure = structure
            end
          end

          class Individual < ::Stripe::RequestParams
            class AdditionalAddress < ::Stripe::RequestParams
              # City, district, suburb, town, or village.
              attr_accessor :city
              # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
              attr_accessor :country
              # Address line 1 (e.g., street, PO Box, or company name).
              attr_accessor :line1
              # Address line 2 (e.g., apartment, suite, unit, or building).
              attr_accessor :line2
              # ZIP or postal code.
              attr_accessor :postal_code
              # Purpose of additional address.
              attr_accessor :purpose
              # State, county, province, or region.
              attr_accessor :state
              # Town or district.
              attr_accessor :town

              def initialize(
                city: nil,
                country: nil,
                line1: nil,
                line2: nil,
                postal_code: nil,
                purpose: nil,
                state: nil,
                town: nil
              )
                @city = city
                @country = country
                @line1 = line1
                @line2 = line2
                @postal_code = postal_code
                @purpose = purpose
                @state = state
                @town = town
              end
            end

            class AdditionalName < ::Stripe::RequestParams
              # The person's full name.
              attr_accessor :full_name
              # The person's first or given name.
              attr_accessor :given_name
              # The purpose or type of the additional name.
              attr_accessor :purpose
              # The person's last or family name.
              attr_accessor :surname

              def initialize(full_name: nil, given_name: nil, purpose: nil, surname: nil)
                @full_name = full_name
                @given_name = given_name
                @purpose = purpose
                @surname = surname
              end
            end

            class Address < ::Stripe::RequestParams
              # City, district, suburb, town, or village.
              attr_accessor :city
              # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
              attr_accessor :country
              # Address line 1 (e.g., street, PO Box, or company name).
              attr_accessor :line1
              # Address line 2 (e.g., apartment, suite, unit, or building).
              attr_accessor :line2
              # ZIP or postal code.
              attr_accessor :postal_code
              # State, county, province, or region.
              attr_accessor :state
              # Town or district.
              attr_accessor :town

              def initialize(
                city: nil,
                country: nil,
                line1: nil,
                line2: nil,
                postal_code: nil,
                state: nil,
                town: nil
              )
                @city = city
                @country = country
                @line1 = line1
                @line2 = line2
                @postal_code = postal_code
                @state = state
                @town = town
              end
            end

            class DateOfBirth < ::Stripe::RequestParams
              # The day of the birth.
              attr_accessor :day
              # The month of birth.
              attr_accessor :month
              # The year of birth.
              attr_accessor :year

              def initialize(day: nil, month: nil, year: nil)
                @day = day
                @month = month
                @year = year
              end
            end

            class Documents < ::Stripe::RequestParams
              class CompanyAuthorization < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                attr_accessor :files
                # The format of the document. Currently supports `files` only.
                attr_accessor :type

                def initialize(files: nil, type: nil)
                  @files = files
                  @type = type
                end
              end

              class Passport < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                attr_accessor :files
                # The format of the document. Currently supports `files` only.
                attr_accessor :type

                def initialize(files: nil, type: nil)
                  @files = files
                  @type = type
                end
              end

              class PrimaryVerification < ::Stripe::RequestParams
                class FrontBack < ::Stripe::RequestParams
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the back of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  attr_accessor :back
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the front of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  attr_accessor :front

                  def initialize(back: nil, front: nil)
                    @back = back
                    @front = front
                  end
                end
                # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens referring to each side of the document.
                attr_accessor :front_back
                # The format of the verification document. Currently supports `front_back` only.
                attr_accessor :type

                def initialize(front_back: nil, type: nil)
                  @front_back = front_back
                  @type = type
                end
              end

              class SecondaryVerification < ::Stripe::RequestParams
                class FrontBack < ::Stripe::RequestParams
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the back of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  attr_accessor :back
                  # A [file upload](https://docs.stripe.com/api/persons/update#create_file) token representing the front of the verification document. The purpose of the uploaded file should be 'identity_document'. The uploaded file needs to be a color image (smaller than 8,000px by 8,000px), in JPG, PNG, or PDF format, and less than 10 MB in size.
                  attr_accessor :front

                  def initialize(back: nil, front: nil)
                    @back = back
                    @front = front
                  end
                end
                # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens referring to each side of the document.
                attr_accessor :front_back
                # The format of the verification document. Currently supports `front_back` only.
                attr_accessor :type

                def initialize(front_back: nil, type: nil)
                  @front_back = front_back
                  @type = type
                end
              end

              class Visa < ::Stripe::RequestParams
                # One or more document IDs returned by a [file upload](https://docs.stripe.com/api/persons/update#create_file) with a purpose value of `account_requirement`.
                attr_accessor :files
                # The format of the document. Currently supports `files` only.
                attr_accessor :type

                def initialize(files: nil, type: nil)
                  @files = files
                  @type = type
                end
              end
              # One or more documents that demonstrate proof that this person is authorized to represent the company.
              attr_accessor :company_authorization
              # One or more documents showing the person’s passport page with photo and personal data.
              attr_accessor :passport
              # An identifying document showing the person's name, either a passport or local ID card.
              attr_accessor :primary_verification
              # A document showing address, either a passport, local ID card, or utility bill from a well-known utility company.
              attr_accessor :secondary_verification
              # One or more documents showing the person’s visa required for living in the country where they are residing.
              attr_accessor :visa

              def initialize(
                company_authorization: nil,
                passport: nil,
                primary_verification: nil,
                secondary_verification: nil,
                visa: nil
              )
                @company_authorization = company_authorization
                @passport = passport
                @primary_verification = primary_verification
                @secondary_verification = secondary_verification
                @visa = visa
              end
            end

            class IdNumber < ::Stripe::RequestParams
              # The ID number type of an individual.
              attr_accessor :type
              # The value of the ID number.
              attr_accessor :value

              def initialize(type: nil, value: nil)
                @type = type
                @value = value
              end
            end

            class Relationship < ::Stripe::RequestParams
              # Whether the person is a director of the account's identity. Directors are typically members of the governing board of the company, or responsible for ensuring the company meets its regulatory obligations.
              attr_accessor :director
              # Whether the person has significant responsibility to control, manage, or direct the organization.
              attr_accessor :executive
              # Whether the person is an owner of the account’s identity.
              attr_accessor :owner
              # The percent owned by the person of the account's legal entity.
              attr_accessor :percent_ownership
              # The person's title (e.g., CEO, Support Engineer).
              attr_accessor :title

              def initialize(
                director: nil,
                executive: nil,
                owner: nil,
                percent_ownership: nil,
                title: nil
              )
                @director = director
                @executive = executive
                @owner = owner
                @percent_ownership = percent_ownership
                @title = title
              end
            end

            class ScriptAddresses < ::Stripe::RequestParams
              class Kana < ::Stripe::RequestParams
                # City, district, suburb, town, or village.
                attr_accessor :city
                # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
                attr_accessor :country
                # Address line 1 (e.g., street, PO Box, or company name).
                attr_accessor :line1
                # Address line 2 (e.g., apartment, suite, unit, or building).
                attr_accessor :line2
                # ZIP or postal code.
                attr_accessor :postal_code
                # State, county, province, or region.
                attr_accessor :state
                # Town or district.
                attr_accessor :town

                def initialize(
                  city: nil,
                  country: nil,
                  line1: nil,
                  line2: nil,
                  postal_code: nil,
                  state: nil,
                  town: nil
                )
                  @city = city
                  @country = country
                  @line1 = line1
                  @line2 = line2
                  @postal_code = postal_code
                  @state = state
                  @town = town
                end
              end

              class Kanji < ::Stripe::RequestParams
                # City, district, suburb, town, or village.
                attr_accessor :city
                # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
                attr_accessor :country
                # Address line 1 (e.g., street, PO Box, or company name).
                attr_accessor :line1
                # Address line 2 (e.g., apartment, suite, unit, or building).
                attr_accessor :line2
                # ZIP or postal code.
                attr_accessor :postal_code
                # State, county, province, or region.
                attr_accessor :state
                # Town or district.
                attr_accessor :town

                def initialize(
                  city: nil,
                  country: nil,
                  line1: nil,
                  line2: nil,
                  postal_code: nil,
                  state: nil,
                  town: nil
                )
                  @city = city
                  @country = country
                  @line1 = line1
                  @line2 = line2
                  @postal_code = postal_code
                  @state = state
                  @town = town
                end
              end
              # Kana Address.
              attr_accessor :kana
              # Kanji Address.
              attr_accessor :kanji

              def initialize(kana: nil, kanji: nil)
                @kana = kana
                @kanji = kanji
              end
            end

            class ScriptNames < ::Stripe::RequestParams
              class Kana < ::Stripe::RequestParams
                # The person's first or given name.
                attr_accessor :given_name
                # The person's last or family name.
                attr_accessor :surname

                def initialize(given_name: nil, surname: nil)
                  @given_name = given_name
                  @surname = surname
                end
              end

              class Kanji < ::Stripe::RequestParams
                # The person's first or given name.
                attr_accessor :given_name
                # The person's last or family name.
                attr_accessor :surname

                def initialize(given_name: nil, surname: nil)
                  @given_name = given_name
                  @surname = surname
                end
              end
              # Persons name in kana script.
              attr_accessor :kana
              # Persons name in kanji script.
              attr_accessor :kanji

              def initialize(kana: nil, kanji: nil)
                @kana = kana
                @kanji = kanji
              end
            end
            # Additional addresses associated with the individual.
            attr_accessor :additional_addresses
            # Additional names (e.g. aliases) associated with the individual.
            attr_accessor :additional_names
            # The individual's residential address.
            attr_accessor :address
            # The individual's date of birth.
            attr_accessor :date_of_birth
            # Documents that may be submitted to satisfy various informational requests.
            attr_accessor :documents
            # The individual's email address.
            attr_accessor :email
            # The individual's first name.
            attr_accessor :given_name
            # The identification numbers (e.g., SSN) associated with the individual.
            attr_accessor :id_numbers
            # The individual's gender (International regulations require either "male" or "female").
            attr_accessor :legal_gender
            # Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
            attr_accessor :metadata
            # The countries where the individual is a national. Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
            attr_accessor :nationalities
            # The individual's phone number.
            attr_accessor :phone
            # The individual's political exposure.
            attr_accessor :political_exposure
            # The relationship that this individual has with the account's identity.
            attr_accessor :relationship
            # The script addresses (e.g., non-Latin characters) associated with the individual.
            attr_accessor :script_addresses
            # The individuals primary name in non latin script.
            attr_accessor :script_names
            # The individual's last name.
            attr_accessor :surname

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
            )
              @additional_addresses = additional_addresses
              @additional_names = additional_names
              @address = address
              @date_of_birth = date_of_birth
              @documents = documents
              @email = email
              @given_name = given_name
              @id_numbers = id_numbers
              @legal_gender = legal_gender
              @metadata = metadata
              @nationalities = nationalities
              @phone = phone
              @political_exposure = political_exposure
              @relationship = relationship
              @script_addresses = script_addresses
              @script_names = script_names
              @surname = surname
            end
          end
          # Attestations from the identity's key people, e.g. owners, executives, directors, representatives.
          attr_accessor :attestations
          # Information about the company or business.
          attr_accessor :business_details
          # The country in which the account holder resides, or in which the business is legally established. This should be an [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) country code.
          attr_accessor :country
          # The entity type.
          attr_accessor :entity_type
          # Information about the individual represented by the Account. This property is `null` unless `entity_type` is set to `individual`.
          attr_accessor :individual

          def initialize(
            attestations: nil,
            business_details: nil,
            country: nil,
            entity_type: nil,
            individual: nil
          )
            @attestations = attestations
            @business_details = business_details
            @country = country
            @entity_type = entity_type
            @individual = individual
          end
        end
        # The account token generated by the account token api.
        attr_accessor :account_token
        # An Account Configuration which allows the Account to take on a key persona across Stripe products.
        attr_accessor :configuration
        # The default contact email address for the Account. Required when configuring the account as a merchant or recipient.
        attr_accessor :contact_email
        # A value indicating the Stripe dashboard this Account has access to. This will depend on which configurations are enabled for this account.
        attr_accessor :dashboard
        # Default values to be used on Account Configurations.
        attr_accessor :defaults
        # A descriptive name for the Account. This name will be surfaced in the Stripe Dashboard and on any invoices sent to the Account.
        attr_accessor :display_name
        # Information about the company, individual, and business represented by the Account.
        attr_accessor :identity
        # Additional fields to include in the response.
        attr_accessor :include
        # Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        attr_accessor :metadata

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
        )
          @account_token = account_token
          @configuration = configuration
          @contact_email = contact_email
          @dashboard = dashboard
          @defaults = defaults
          @display_name = display_name
          @identity = identity
          @include = include
          @metadata = metadata
        end
      end
    end
  end
end
