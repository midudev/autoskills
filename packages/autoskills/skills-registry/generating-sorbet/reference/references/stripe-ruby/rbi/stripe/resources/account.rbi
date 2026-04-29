# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # This is an object representing a Stripe account. You can retrieve it to see
  # properties on the account like its current requirements or if the account is
  # enabled to make live charges or receive payouts.
  #
  # For accounts where [controller.requirement_collection](https://docs.stripe.com/api/accounts/object#account_object-controller-requirement_collection)
  # is `application`, which includes Custom accounts, the properties below are always
  # returned.
  #
  # For accounts where [controller.requirement_collection](https://docs.stripe.com/api/accounts/object#account_object-controller-requirement_collection)
  # is `stripe`, which includes Standard and Express accounts, some properties are only returned
  # until you create an [Account Link](https://docs.stripe.com/api/account_links) or [Account Session](https://docs.stripe.com/api/account_sessions)
  # to start Connect Onboarding. Learn about the [differences between accounts](https://docs.stripe.com/connect/accounts).
  class Account < APIResource
    class BusinessProfile < ::Stripe::StripeObject
      class AnnualRevenue < ::Stripe::StripeObject
        # A non-negative integer representing the amount in the [smallest currency unit](/currencies#zero-decimal).
        sig { returns(T.nilable(Integer)) }
        def amount; end
        # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
        sig { returns(T.nilable(String)) }
        def currency; end
        # The close-out date of the preceding fiscal year in ISO 8601 format. E.g. 2023-12-31 for the 31st of December, 2023.
        sig { returns(T.nilable(String)) }
        def fiscal_year_end; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class MonthlyEstimatedRevenue < ::Stripe::StripeObject
        # A non-negative integer representing how much to charge in the [smallest currency unit](/currencies#zero-decimal).
        sig { returns(Integer) }
        def amount; end
        # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
        sig { returns(String) }
        def currency; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class SupportAddress < ::Stripe::StripeObject
        # City, district, suburb, town, or village.
        sig { returns(T.nilable(String)) }
        def city; end
        # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        sig { returns(T.nilable(String)) }
        def country; end
        # Address line 1, such as the street, PO Box, or company name.
        sig { returns(T.nilable(String)) }
        def line1; end
        # Address line 2, such as the apartment, suite, unit, or building.
        sig { returns(T.nilable(String)) }
        def line2; end
        # ZIP or postal code.
        sig { returns(T.nilable(String)) }
        def postal_code; end
        # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
        sig { returns(T.nilable(String)) }
        def state; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The applicant's gross annual revenue for its preceding fiscal year.
      sig { returns(T.nilable(AnnualRevenue)) }
      def annual_revenue; end
      # An estimated upper bound of employees, contractors, vendors, etc. currently working for the business.
      sig { returns(T.nilable(Integer)) }
      def estimated_worker_count; end
      # [The merchant category code for the account](/connect/setting-mcc). MCCs are used to classify businesses based on the goods or services they provide.
      sig { returns(T.nilable(String)) }
      def mcc; end
      # Whether the business is a minority-owned, women-owned, and/or LGBTQI+ -owned business.
      sig { returns(T.nilable(T::Array[String])) }
      def minority_owned_business_designation; end
      # Attribute for field monthly_estimated_revenue
      sig { returns(T.nilable(MonthlyEstimatedRevenue)) }
      def monthly_estimated_revenue; end
      # The customer-facing business name.
      sig { returns(T.nilable(String)) }
      def name; end
      # Internal-only description of the product sold or service provided by the business. It's used by Stripe for risk and underwriting purposes.
      sig { returns(T.nilable(String)) }
      def product_description; end
      # A publicly available mailing address for sending support issues to.
      sig { returns(T.nilable(SupportAddress)) }
      def support_address; end
      # A publicly available email address for sending support issues to.
      sig { returns(T.nilable(String)) }
      def support_email; end
      # A publicly available phone number to call with support issues.
      sig { returns(T.nilable(String)) }
      def support_phone; end
      # A publicly available website for handling support issues.
      sig { returns(T.nilable(String)) }
      def support_url; end
      # The business's publicly available website.
      sig { returns(T.nilable(String)) }
      def url; end
      def self.inner_class_types
        @inner_class_types = {
          annual_revenue: AnnualRevenue,
          monthly_estimated_revenue: MonthlyEstimatedRevenue,
          support_address: SupportAddress,
        }
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Capabilities < ::Stripe::StripeObject
      # The status of the Canadian pre-authorized debits payments capability of the account, or whether the account can directly process Canadian pre-authorized debits charges.
      sig { returns(T.nilable(String)) }
      def acss_debit_payments; end
      # The status of the Affirm capability of the account, or whether the account can directly process Affirm charges.
      sig { returns(T.nilable(String)) }
      def affirm_payments; end
      # The status of the Afterpay Clearpay capability of the account, or whether the account can directly process Afterpay Clearpay charges.
      sig { returns(T.nilable(String)) }
      def afterpay_clearpay_payments; end
      # The status of the Alma capability of the account, or whether the account can directly process Alma payments.
      sig { returns(T.nilable(String)) }
      def alma_payments; end
      # The status of the AmazonPay capability of the account, or whether the account can directly process AmazonPay payments.
      sig { returns(T.nilable(String)) }
      def amazon_pay_payments; end
      # The status of the BECS Direct Debit (AU) payments capability of the account, or whether the account can directly process BECS Direct Debit (AU) charges.
      sig { returns(T.nilable(String)) }
      def au_becs_debit_payments; end
      # The status of the Bacs Direct Debits payments capability of the account, or whether the account can directly process Bacs Direct Debits charges.
      sig { returns(T.nilable(String)) }
      def bacs_debit_payments; end
      # The status of the Bancontact payments capability of the account, or whether the account can directly process Bancontact charges.
      sig { returns(T.nilable(String)) }
      def bancontact_payments; end
      # The status of the customer_balance payments capability of the account, or whether the account can directly process customer_balance charges.
      sig { returns(T.nilable(String)) }
      def bank_transfer_payments; end
      # The status of the Billie capability of the account, or whether the account can directly process Billie payments.
      sig { returns(T.nilable(String)) }
      def billie_payments; end
      # The status of the blik payments capability of the account, or whether the account can directly process blik charges.
      sig { returns(T.nilable(String)) }
      def blik_payments; end
      # The status of the boleto payments capability of the account, or whether the account can directly process boleto charges.
      sig { returns(T.nilable(String)) }
      def boleto_payments; end
      # The status of the card issuing capability of the account, or whether you can use Issuing to distribute funds on cards
      sig { returns(T.nilable(String)) }
      def card_issuing; end
      # The status of the card payments capability of the account, or whether the account can directly process credit and debit card charges.
      sig { returns(T.nilable(String)) }
      def card_payments; end
      # The status of the Cartes Bancaires payments capability of the account, or whether the account can directly process Cartes Bancaires card charges in EUR currency.
      sig { returns(T.nilable(String)) }
      def cartes_bancaires_payments; end
      # The status of the Cash App Pay capability of the account, or whether the account can directly process Cash App Pay payments.
      sig { returns(T.nilable(String)) }
      def cashapp_payments; end
      # The status of the Crypto capability of the account, or whether the account can directly process Crypto payments.
      sig { returns(T.nilable(String)) }
      def crypto_payments; end
      # The status of the EPS payments capability of the account, or whether the account can directly process EPS charges.
      sig { returns(T.nilable(String)) }
      def eps_payments; end
      # The status of the FPX payments capability of the account, or whether the account can directly process FPX charges.
      sig { returns(T.nilable(String)) }
      def fpx_payments; end
      # The status of the GB customer_balance payments (GBP currency) capability of the account, or whether the account can directly process GB customer_balance charges.
      sig { returns(T.nilable(String)) }
      def gb_bank_transfer_payments; end
      # The status of the giropay payments capability of the account, or whether the account can directly process giropay charges.
      sig { returns(T.nilable(String)) }
      def giropay_payments; end
      # The status of the GrabPay payments capability of the account, or whether the account can directly process GrabPay charges.
      sig { returns(T.nilable(String)) }
      def grabpay_payments; end
      # The status of the iDEAL payments capability of the account, or whether the account can directly process iDEAL charges.
      sig { returns(T.nilable(String)) }
      def ideal_payments; end
      # The status of the india_international_payments capability of the account, or whether the account can process international charges (non INR) in India.
      sig { returns(T.nilable(String)) }
      def india_international_payments; end
      # The status of the JCB payments capability of the account, or whether the account (Japan only) can directly process JCB credit card charges in JPY currency.
      sig { returns(T.nilable(String)) }
      def jcb_payments; end
      # The status of the Japanese customer_balance payments (JPY currency) capability of the account, or whether the account can directly process Japanese customer_balance charges.
      sig { returns(T.nilable(String)) }
      def jp_bank_transfer_payments; end
      # The status of the KakaoPay capability of the account, or whether the account can directly process KakaoPay payments.
      sig { returns(T.nilable(String)) }
      def kakao_pay_payments; end
      # The status of the Klarna payments capability of the account, or whether the account can directly process Klarna charges.
      sig { returns(T.nilable(String)) }
      def klarna_payments; end
      # The status of the konbini payments capability of the account, or whether the account can directly process konbini charges.
      sig { returns(T.nilable(String)) }
      def konbini_payments; end
      # The status of the KrCard capability of the account, or whether the account can directly process KrCard payments.
      sig { returns(T.nilable(String)) }
      def kr_card_payments; end
      # The status of the legacy payments capability of the account.
      sig { returns(T.nilable(String)) }
      def legacy_payments; end
      # The status of the link_payments capability of the account, or whether the account can directly process Link charges.
      sig { returns(T.nilable(String)) }
      def link_payments; end
      # The status of the MB WAY payments capability of the account, or whether the account can directly process MB WAY charges.
      sig { returns(T.nilable(String)) }
      def mb_way_payments; end
      # The status of the MobilePay capability of the account, or whether the account can directly process MobilePay charges.
      sig { returns(T.nilable(String)) }
      def mobilepay_payments; end
      # The status of the Multibanco payments capability of the account, or whether the account can directly process Multibanco charges.
      sig { returns(T.nilable(String)) }
      def multibanco_payments; end
      # The status of the Mexican customer_balance payments (MXN currency) capability of the account, or whether the account can directly process Mexican customer_balance charges.
      sig { returns(T.nilable(String)) }
      def mx_bank_transfer_payments; end
      # The status of the NaverPay capability of the account, or whether the account can directly process NaverPay payments.
      sig { returns(T.nilable(String)) }
      def naver_pay_payments; end
      # The status of the New Zealand BECS Direct Debit payments capability of the account, or whether the account can directly process New Zealand BECS Direct Debit charges.
      sig { returns(T.nilable(String)) }
      def nz_bank_account_becs_debit_payments; end
      # The status of the OXXO payments capability of the account, or whether the account can directly process OXXO charges.
      sig { returns(T.nilable(String)) }
      def oxxo_payments; end
      # The status of the P24 payments capability of the account, or whether the account can directly process P24 charges.
      sig { returns(T.nilable(String)) }
      def p24_payments; end
      # The status of the pay_by_bank payments capability of the account, or whether the account can directly process pay_by_bank charges.
      sig { returns(T.nilable(String)) }
      def pay_by_bank_payments; end
      # The status of the Payco capability of the account, or whether the account can directly process Payco payments.
      sig { returns(T.nilable(String)) }
      def payco_payments; end
      # The status of the paynow payments capability of the account, or whether the account can directly process paynow charges.
      sig { returns(T.nilable(String)) }
      def paynow_payments; end
      # The status of the PayTo capability of the account, or whether the account can directly process PayTo charges.
      sig { returns(T.nilable(String)) }
      def payto_payments; end
      # The status of the pix payments capability of the account, or whether the account can directly process pix charges.
      sig { returns(T.nilable(String)) }
      def pix_payments; end
      # The status of the promptpay payments capability of the account, or whether the account can directly process promptpay charges.
      sig { returns(T.nilable(String)) }
      def promptpay_payments; end
      # The status of the RevolutPay capability of the account, or whether the account can directly process RevolutPay payments.
      sig { returns(T.nilable(String)) }
      def revolut_pay_payments; end
      # The status of the SamsungPay capability of the account, or whether the account can directly process SamsungPay payments.
      sig { returns(T.nilable(String)) }
      def samsung_pay_payments; end
      # The status of the Satispay capability of the account, or whether the account can directly process Satispay payments.
      sig { returns(T.nilable(String)) }
      def satispay_payments; end
      # The status of the SEPA customer_balance payments (EUR currency) capability of the account, or whether the account can directly process SEPA customer_balance charges.
      sig { returns(T.nilable(String)) }
      def sepa_bank_transfer_payments; end
      # The status of the SEPA Direct Debits payments capability of the account, or whether the account can directly process SEPA Direct Debits charges.
      sig { returns(T.nilable(String)) }
      def sepa_debit_payments; end
      # The status of the Sofort payments capability of the account, or whether the account can directly process Sofort charges.
      sig { returns(T.nilable(String)) }
      def sofort_payments; end
      # The status of the Swish capability of the account, or whether the account can directly process Swish payments.
      sig { returns(T.nilable(String)) }
      def swish_payments; end
      # The status of the tax reporting 1099-K (US) capability of the account.
      sig { returns(T.nilable(String)) }
      def tax_reporting_us_1099_k; end
      # The status of the tax reporting 1099-MISC (US) capability of the account.
      sig { returns(T.nilable(String)) }
      def tax_reporting_us_1099_misc; end
      # The status of the transfers capability of the account, or whether your platform can transfer funds to the account.
      sig { returns(T.nilable(String)) }
      def transfers; end
      # The status of the banking capability, or whether the account can have bank accounts.
      sig { returns(T.nilable(String)) }
      def treasury; end
      # The status of the TWINT capability of the account, or whether the account can directly process TWINT charges.
      sig { returns(T.nilable(String)) }
      def twint_payments; end
      # The status of the US bank account ACH payments capability of the account, or whether the account can directly process US bank account charges.
      sig { returns(T.nilable(String)) }
      def us_bank_account_ach_payments; end
      # The status of the US customer_balance payments (USD currency) capability of the account, or whether the account can directly process US customer_balance charges.
      sig { returns(T.nilable(String)) }
      def us_bank_transfer_payments; end
      # The status of the Zip capability of the account, or whether the account can directly process Zip charges.
      sig { returns(T.nilable(String)) }
      def zip_payments; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Company < ::Stripe::StripeObject
      class Address < ::Stripe::StripeObject
        # City, district, suburb, town, or village.
        sig { returns(T.nilable(String)) }
        def city; end
        # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        sig { returns(T.nilable(String)) }
        def country; end
        # Address line 1, such as the street, PO Box, or company name.
        sig { returns(T.nilable(String)) }
        def line1; end
        # Address line 2, such as the apartment, suite, unit, or building.
        sig { returns(T.nilable(String)) }
        def line2; end
        # ZIP or postal code.
        sig { returns(T.nilable(String)) }
        def postal_code; end
        # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
        sig { returns(T.nilable(String)) }
        def state; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class AddressKana < ::Stripe::StripeObject
        # City/Ward.
        sig { returns(T.nilable(String)) }
        def city; end
        # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        sig { returns(T.nilable(String)) }
        def country; end
        # Block/Building number.
        sig { returns(T.nilable(String)) }
        def line1; end
        # Building details.
        sig { returns(T.nilable(String)) }
        def line2; end
        # ZIP or postal code.
        sig { returns(T.nilable(String)) }
        def postal_code; end
        # Prefecture.
        sig { returns(T.nilable(String)) }
        def state; end
        # Town/cho-me.
        sig { returns(T.nilable(String)) }
        def town; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class AddressKanji < ::Stripe::StripeObject
        # City/Ward.
        sig { returns(T.nilable(String)) }
        def city; end
        # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        sig { returns(T.nilable(String)) }
        def country; end
        # Block/Building number.
        sig { returns(T.nilable(String)) }
        def line1; end
        # Building details.
        sig { returns(T.nilable(String)) }
        def line2; end
        # ZIP or postal code.
        sig { returns(T.nilable(String)) }
        def postal_code; end
        # Prefecture.
        sig { returns(T.nilable(String)) }
        def state; end
        # Town/cho-me.
        sig { returns(T.nilable(String)) }
        def town; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class DirectorshipDeclaration < ::Stripe::StripeObject
        # The Unix timestamp marking when the directorship declaration attestation was made.
        sig { returns(T.nilable(Integer)) }
        def date; end
        # The IP address from which the directorship declaration attestation was made.
        sig { returns(T.nilable(String)) }
        def ip; end
        # The user-agent string from the browser where the directorship declaration attestation was made.
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
        # The Unix timestamp marking when the beneficial owner attestation was made.
        sig { returns(T.nilable(Integer)) }
        def date; end
        # The IP address from which the beneficial owner attestation was made.
        sig { returns(T.nilable(String)) }
        def ip; end
        # The user-agent string from the browser where the beneficial owner attestation was made.
        sig { returns(T.nilable(String)) }
        def user_agent; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class RegistrationDate < ::Stripe::StripeObject
        # The day of registration, between 1 and 31.
        sig { returns(T.nilable(Integer)) }
        def day; end
        # The month of registration, between 1 and 12.
        sig { returns(T.nilable(Integer)) }
        def month; end
        # The four-digit year of registration.
        sig { returns(T.nilable(Integer)) }
        def year; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class RepresentativeDeclaration < ::Stripe::StripeObject
        # The Unix timestamp marking when the representative declaration attestation was made.
        sig { returns(T.nilable(Integer)) }
        def date; end
        # The IP address from which the representative declaration attestation was made.
        sig { returns(T.nilable(String)) }
        def ip; end
        # The user-agent string from the browser where the representative declaration attestation was made.
        sig { returns(T.nilable(String)) }
        def user_agent; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Verification < ::Stripe::StripeObject
        class Document < ::Stripe::StripeObject
          # The back of a document returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `additional_verification`. Note that `additional_verification` files are [not downloadable](/file-upload#uploading-a-file).
          sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
          def back; end
          # A user-displayable string describing the verification state of this document.
          sig { returns(T.nilable(String)) }
          def details; end
          # One of `document_corrupt`, `document_expired`, `document_failed_copy`, `document_failed_greyscale`, `document_failed_other`, `document_failed_test_mode`, `document_fraudulent`, `document_incomplete`, `document_invalid`, `document_manipulated`, `document_not_readable`, `document_not_uploaded`, `document_type_not_supported`, or `document_too_large`. A machine-readable code specifying the verification state for this document.
          sig { returns(T.nilable(String)) }
          def details_code; end
          # The front of a document returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `additional_verification`. Note that `additional_verification` files are [not downloadable](/file-upload#uploading-a-file).
          sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
          def front; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field document
        sig { returns(Document) }
        def document; end
        def self.inner_class_types
          @inner_class_types = {document: Document}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field address
      sig { returns(T.nilable(Address)) }
      def address; end
      # The Kana variation of the company's primary address (Japan only).
      sig { returns(T.nilable(AddressKana)) }
      def address_kana; end
      # The Kanji variation of the company's primary address (Japan only).
      sig { returns(T.nilable(AddressKanji)) }
      def address_kanji; end
      # Whether the company's directors have been provided. This Boolean will be `true` if you've manually indicated that all directors are provided via [the `directors_provided` parameter](https://docs.stripe.com/api/accounts/update#update_account-company-directors_provided).
      sig { returns(T.nilable(T::Boolean)) }
      def directors_provided; end
      # This hash is used to attest that the director information provided to Stripe is both current and correct.
      sig { returns(T.nilable(DirectorshipDeclaration)) }
      def directorship_declaration; end
      # Whether the company's executives have been provided. This Boolean will be `true` if you've manually indicated that all executives are provided via [the `executives_provided` parameter](https://docs.stripe.com/api/accounts/update#update_account-company-executives_provided), or if Stripe determined that sufficient executives were provided.
      sig { returns(T.nilable(T::Boolean)) }
      def executives_provided; end
      # The export license ID number of the company, also referred as Import Export Code (India only).
      sig { returns(T.nilable(String)) }
      def export_license_id; end
      # The purpose code to use for export transactions (India only).
      sig { returns(T.nilable(String)) }
      def export_purpose_code; end
      # The company's legal name. Also available for accounts where [controller.requirement_collection](/api/accounts/object#account_object-controller-requirement_collection) is `stripe`.
      sig { returns(T.nilable(String)) }
      def name; end
      # The Kana variation of the company's legal name (Japan only). Also available for accounts where [controller.requirement_collection](/api/accounts/object#account_object-controller-requirement_collection) is `stripe`.
      sig { returns(T.nilable(String)) }
      def name_kana; end
      # The Kanji variation of the company's legal name (Japan only). Also available for accounts where [controller.requirement_collection](/api/accounts/object#account_object-controller-requirement_collection) is `stripe`.
      sig { returns(T.nilable(String)) }
      def name_kanji; end
      # Whether the company's owners have been provided. This Boolean will be `true` if you've manually indicated that all owners are provided via [the `owners_provided` parameter](https://docs.stripe.com/api/accounts/update#update_account-company-owners_provided), or if Stripe determined that sufficient owners were provided. Stripe determines ownership requirements using both the number of owners provided and their total percent ownership (calculated by adding the `percent_ownership` of each owner together).
      sig { returns(T.nilable(T::Boolean)) }
      def owners_provided; end
      # This hash is used to attest that the beneficial owner information provided to Stripe is both current and correct.
      sig { returns(T.nilable(OwnershipDeclaration)) }
      def ownership_declaration; end
      # This value is used to determine if a business is exempt from providing ultimate beneficial owners. See [this support article](https://support.stripe.com/questions/exemption-from-providing-ownership-details) and [changelog](https://docs.stripe.com/changelog/acacia/2025-01-27/ownership-exemption-reason-accounts-api) for more details.
      sig { returns(T.nilable(String)) }
      def ownership_exemption_reason; end
      # The company's phone number (used for verification).
      sig { returns(T.nilable(String)) }
      def phone; end
      # Attribute for field registration_date
      sig { returns(T.nilable(RegistrationDate)) }
      def registration_date; end
      # This hash is used to attest that the representative is authorized to act as the representative of their legal entity.
      sig { returns(T.nilable(RepresentativeDeclaration)) }
      def representative_declaration; end
      # The category identifying the legal structure of the company or legal entity. Also available for accounts where [controller.requirement_collection](/api/accounts/object#account_object-controller-requirement_collection) is `stripe`. See [Business structure](https://docs.stripe.com/connect/identity-verification#business-structure) for more details.
      sig { returns(T.nilable(String)) }
      def structure; end
      # Whether the company's business ID number was provided.
      sig { returns(T.nilable(T::Boolean)) }
      def tax_id_provided; end
      # The jurisdiction in which the `tax_id` is registered (Germany-based companies only).
      sig { returns(T.nilable(String)) }
      def tax_id_registrar; end
      # Whether the company's business VAT number was provided.
      sig { returns(T.nilable(T::Boolean)) }
      def vat_id_provided; end
      # Information on the verification state of the company.
      sig { returns(T.nilable(Verification)) }
      def verification; end
      def self.inner_class_types
        @inner_class_types = {
          address: Address,
          address_kana: AddressKana,
          address_kanji: AddressKanji,
          directorship_declaration: DirectorshipDeclaration,
          ownership_declaration: OwnershipDeclaration,
          registration_date: RegistrationDate,
          representative_declaration: RepresentativeDeclaration,
          verification: Verification,
        }
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Controller < ::Stripe::StripeObject
      class Fees < ::Stripe::StripeObject
        # A value indicating the responsible payer of a bundle of Stripe fees for pricing-control eligible products on this account. Learn more about [fee behavior on connected accounts](https://docs.stripe.com/connect/direct-charges-fee-payer-behavior).
        sig { returns(String) }
        def payer; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Losses < ::Stripe::StripeObject
        # A value indicating who is liable when this account can't pay back negative balances from payments.
        sig { returns(String) }
        def payments; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class StripeDashboard < ::Stripe::StripeObject
        # A value indicating the Stripe dashboard this account has access to independent of the Connect application.
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field fees
      sig { returns(T.nilable(Fees)) }
      def fees; end
      # `true` if the Connect application retrieving the resource controls the account and can therefore exercise [platform controls](https://docs.stripe.com/connect/platform-controls-for-standard-accounts). Otherwise, this field is null.
      sig { returns(T.nilable(T::Boolean)) }
      def is_controller; end
      # Attribute for field losses
      sig { returns(T.nilable(Losses)) }
      def losses; end
      # A value indicating responsibility for collecting requirements on this account. Only returned when the Connect application retrieving the resource controls the account.
      sig { returns(T.nilable(String)) }
      def requirement_collection; end
      # Attribute for field stripe_dashboard
      sig { returns(T.nilable(StripeDashboard)) }
      def stripe_dashboard; end
      # The controller type. Can be `application`, if a Connect application controls the account, or `account`, if the account controls itself.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {fees: Fees, losses: Losses, stripe_dashboard: StripeDashboard}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class FutureRequirements < ::Stripe::StripeObject
      class Alternative < ::Stripe::StripeObject
        # Fields that can be provided to resolve all fields in `original_fields_due`.
        sig { returns(T::Array[String]) }
        def alternative_fields_due; end
        # Fields that are due and can be resolved by providing all fields in `alternative_fields_due`.
        sig { returns(T::Array[String]) }
        def original_fields_due; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Error < ::Stripe::StripeObject
        # The code for the type of error.
        sig { returns(String) }
        def code; end
        # An informative message that indicates the error type and provides additional details about the error.
        sig { returns(String) }
        def reason; end
        # The specific user onboarding requirement field (in the requirements hash) that needs to be resolved.
        sig { returns(String) }
        def requirement; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Fields that are due and can be resolved by providing the corresponding alternative fields instead. Many alternatives can list the same `original_fields_due`, and any of these alternatives can serve as a pathway for attempting to resolve the fields again. Re-providing `original_fields_due` also serves as a pathway for attempting to resolve the fields again.
      sig { returns(T.nilable(T::Array[Alternative])) }
      def alternatives; end
      # Date on which `future_requirements` becomes the main `requirements` hash and `future_requirements` becomes empty. After the transition, `currently_due` requirements may immediately become `past_due`, but the account may also be given a grace period depending on its enablement state prior to transitioning.
      sig { returns(T.nilable(Integer)) }
      def current_deadline; end
      # Fields that need to be resolved to keep the account enabled. If not resolved by `future_requirements[current_deadline]`, these fields will transition to the main `requirements` hash.
      sig { returns(T.nilable(T::Array[String])) }
      def currently_due; end
      # This is typed as an enum for consistency with `requirements.disabled_reason`.
      sig { returns(T.nilable(String)) }
      def disabled_reason; end
      # Details about validation and verification failures for `due` requirements that must be resolved.
      sig { returns(T.nilable(T::Array[Error])) }
      def errors; end
      # Fields you must collect when all thresholds are reached. As they become required, they appear in `currently_due` as well.
      sig { returns(T.nilable(T::Array[String])) }
      def eventually_due; end
      # Fields that haven't been resolved by `requirements.current_deadline`. These fields need to be resolved to enable the capability on the account. `future_requirements.past_due` is a subset of `requirements.past_due`.
      sig { returns(T.nilable(T::Array[String])) }
      def past_due; end
      # Fields that are being reviewed, or might become required depending on the results of a review. If the review fails, these fields can move to `eventually_due`, `currently_due`, `past_due` or `alternatives`. Fields might appear in `eventually_due`, `currently_due`, `past_due` or `alternatives` and in `pending_verification` if one verification fails but another is still pending.
      sig { returns(T.nilable(T::Array[String])) }
      def pending_verification; end
      def self.inner_class_types
        @inner_class_types = {alternatives: Alternative, errors: Error}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Groups < ::Stripe::StripeObject
      # The group the account is in to determine their payments pricing, and null if the account is on customized pricing. [See the Platform pricing tool documentation](https://docs.stripe.com/connect/platform-pricing-tools) for details.
      sig { returns(T.nilable(String)) }
      def payments_pricing; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Requirements < ::Stripe::StripeObject
      class Alternative < ::Stripe::StripeObject
        # Fields that can be provided to resolve all fields in `original_fields_due`.
        sig { returns(T::Array[String]) }
        def alternative_fields_due; end
        # Fields that are due and can be resolved by providing all fields in `alternative_fields_due`.
        sig { returns(T::Array[String]) }
        def original_fields_due; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Error < ::Stripe::StripeObject
        # The code for the type of error.
        sig { returns(String) }
        def code; end
        # An informative message that indicates the error type and provides additional details about the error.
        sig { returns(String) }
        def reason; end
        # The specific user onboarding requirement field (in the requirements hash) that needs to be resolved.
        sig { returns(String) }
        def requirement; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Fields that are due and can be resolved by providing the corresponding alternative fields instead. Many alternatives can list the same `original_fields_due`, and any of these alternatives can serve as a pathway for attempting to resolve the fields again. Re-providing `original_fields_due` also serves as a pathway for attempting to resolve the fields again.
      sig { returns(T.nilable(T::Array[Alternative])) }
      def alternatives; end
      # Date by which the fields in `currently_due` must be collected to keep the account enabled. These fields may disable the account sooner if the next threshold is reached before they are collected.
      sig { returns(T.nilable(Integer)) }
      def current_deadline; end
      # Fields that need to be resolved to keep the account enabled. If not resolved by `current_deadline`, these fields will appear in `past_due` as well, and the account is disabled.
      sig { returns(T.nilable(T::Array[String])) }
      def currently_due; end
      # If the account is disabled, this enum describes why. [Learn more about handling verification issues](https://docs.stripe.com/connect/handling-api-verification).
      sig { returns(T.nilable(String)) }
      def disabled_reason; end
      # Details about validation and verification failures for `due` requirements that must be resolved.
      sig { returns(T.nilable(T::Array[Error])) }
      def errors; end
      # Fields you must collect when all thresholds are reached. As they become required, they appear in `currently_due` as well, and `current_deadline` becomes set.
      sig { returns(T.nilable(T::Array[String])) }
      def eventually_due; end
      # Fields that haven't been resolved by `current_deadline`. These fields need to be resolved to enable the account.
      sig { returns(T.nilable(T::Array[String])) }
      def past_due; end
      # Fields that are being reviewed, or might become required depending on the results of a review. If the review fails, these fields can move to `eventually_due`, `currently_due`, `past_due` or `alternatives`. Fields might appear in `eventually_due`, `currently_due`, `past_due` or `alternatives` and in `pending_verification` if one verification fails but another is still pending.
      sig { returns(T.nilable(T::Array[String])) }
      def pending_verification; end
      def self.inner_class_types
        @inner_class_types = {alternatives: Alternative, errors: Error}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Settings < ::Stripe::StripeObject
      class BacsDebitPayments < ::Stripe::StripeObject
        # The Bacs Direct Debit display name for this account. For payments made with Bacs Direct Debit, this name appears on the mandate as the statement descriptor. Mobile banking apps display it as the name of the business. To use custom branding, set the Bacs Direct Debit Display Name during or right after creation. Custom branding incurs an additional monthly fee for the platform. The fee appears 5 business days after requesting Bacs. If you don't set the display name before requesting Bacs capability, it's automatically set as "Stripe" and the account is onboarded to Stripe branding, which is free.
        sig { returns(T.nilable(String)) }
        def display_name; end
        # The Bacs Direct Debit Service user number for this account. For payments made with Bacs Direct Debit, this number is a unique identifier of the account with our banking partners.
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
        # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) An icon for the account. Must be square and at least 128px x 128px.
        sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
        def icon; end
        # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) A logo for the account that will be used in Checkout instead of the icon and without the account's name next to it if provided. Must be at least 128px x 128px.
        sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
        def logo; end
        # A CSS hex color value representing the primary branding color for this account
        sig { returns(T.nilable(String)) }
        def primary_color; end
        # A CSS hex color value representing the secondary branding color for this account
        sig { returns(T.nilable(String)) }
        def secondary_color; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class CardIssuing < ::Stripe::StripeObject
        class TosAcceptance < ::Stripe::StripeObject
          # The Unix timestamp marking when the account representative accepted the service agreement.
          sig { returns(T.nilable(Integer)) }
          def date; end
          # The IP address from which the account representative accepted the service agreement.
          sig { returns(T.nilable(String)) }
          def ip; end
          # The user agent of the browser from which the account representative accepted the service agreement.
          sig { returns(T.nilable(String)) }
          def user_agent; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field tos_acceptance
        sig { returns(T.nilable(TosAcceptance)) }
        def tos_acceptance; end
        def self.inner_class_types
          @inner_class_types = {tos_acceptance: TosAcceptance}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class CardPayments < ::Stripe::StripeObject
        class DeclineOn < ::Stripe::StripeObject
          # Whether Stripe automatically declines charges with an incorrect ZIP or postal code. This setting only applies when a ZIP or postal code is provided and they fail bank verification.
          sig { returns(T::Boolean) }
          def avs_failure; end
          # Whether Stripe automatically declines charges with an incorrect CVC. This setting only applies when a CVC is provided and it fails bank verification.
          sig { returns(T::Boolean) }
          def cvc_failure; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field decline_on
        sig { returns(T.nilable(DeclineOn)) }
        def decline_on; end
        # The default text that appears on credit card statements when a charge is made. This field prefixes any dynamic `statement_descriptor` specified on the charge. `statement_descriptor_prefix` is useful for maximizing descriptor space for the dynamic portion.
        sig { returns(T.nilable(String)) }
        def statement_descriptor_prefix; end
        # The Kana variation of the default text that appears on credit card statements when a charge is made (Japan only). This field prefixes any dynamic `statement_descriptor_suffix_kana` specified on the charge. `statement_descriptor_prefix_kana` is useful for maximizing descriptor space for the dynamic portion.
        sig { returns(T.nilable(String)) }
        def statement_descriptor_prefix_kana; end
        # The Kanji variation of the default text that appears on credit card statements when a charge is made (Japan only). This field prefixes any dynamic `statement_descriptor_suffix_kanji` specified on the charge. `statement_descriptor_prefix_kanji` is useful for maximizing descriptor space for the dynamic portion.
        sig { returns(T.nilable(String)) }
        def statement_descriptor_prefix_kanji; end
        def self.inner_class_types
          @inner_class_types = {decline_on: DeclineOn}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Dashboard < ::Stripe::StripeObject
        # The display name for this account. This is used on the Stripe Dashboard to differentiate between accounts.
        sig { returns(T.nilable(String)) }
        def display_name; end
        # The timezone used in the Stripe Dashboard for this account. A list of possible time zone values is maintained at the [IANA Time Zone Database](http://www.iana.org/time-zones).
        sig { returns(T.nilable(String)) }
        def timezone; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Invoices < ::Stripe::StripeObject
        # The list of default Account Tax IDs to automatically include on invoices. Account Tax IDs get added when an invoice is finalized.
        sig { returns(T.nilable(T::Array[T.any(String, ::Stripe::TaxId)])) }
        def default_account_tax_ids; end
        # Whether to save the payment method after a payment is completed for a one-time invoice or a subscription invoice when the customer already has a default payment method on the hosted invoice page.
        sig { returns(T.nilable(String)) }
        def hosted_payment_method_save; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Payments < ::Stripe::StripeObject
        # The default text that appears on credit card statements when a charge is made. This field prefixes any dynamic `statement_descriptor` specified on the charge.
        sig { returns(T.nilable(String)) }
        def statement_descriptor; end
        # The Kana variation of `statement_descriptor` used for charges in Japan. Japanese statement descriptors have [special requirements](https://docs.stripe.com/get-started/account/statement-descriptors#set-japanese-statement-descriptors).
        sig { returns(T.nilable(String)) }
        def statement_descriptor_kana; end
        # The Kanji variation of `statement_descriptor` used for charges in Japan. Japanese statement descriptors have [special requirements](https://docs.stripe.com/get-started/account/statement-descriptors#set-japanese-statement-descriptors).
        sig { returns(T.nilable(String)) }
        def statement_descriptor_kanji; end
        # The Kana variation of `statement_descriptor_prefix` used for card charges in Japan. Japanese statement descriptors have [special requirements](https://docs.stripe.com/get-started/account/statement-descriptors#set-japanese-statement-descriptors).
        sig { returns(T.nilable(String)) }
        def statement_descriptor_prefix_kana; end
        # The Kanji variation of `statement_descriptor_prefix` used for card charges in Japan. Japanese statement descriptors have [special requirements](https://docs.stripe.com/get-started/account/statement-descriptors#set-japanese-statement-descriptors).
        sig { returns(T.nilable(String)) }
        def statement_descriptor_prefix_kanji; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Payouts < ::Stripe::StripeObject
        class Schedule < ::Stripe::StripeObject
          # The number of days charges for the account will be held before being paid out.
          sig { returns(Integer) }
          def delay_days; end
          # How frequently funds will be paid out. One of `manual` (payouts only created via API call), `daily`, `weekly`, or `monthly`.
          sig { returns(String) }
          def interval; end
          # The day of the month funds will be paid out. Only shown if `interval` is monthly. Payouts scheduled between the 29th and 31st of the month are sent on the last day of shorter months.
          sig { returns(T.nilable(Integer)) }
          def monthly_anchor; end
          # The days of the month funds will be paid out. Only shown if `interval` is monthly. Payouts scheduled between the 29th and 31st of the month are sent on the last day of shorter months.
          sig { returns(T.nilable(T::Array[Integer])) }
          def monthly_payout_days; end
          # The day of the week funds will be paid out, of the style 'monday', 'tuesday', etc. Only shown if `interval` is weekly.
          sig { returns(T.nilable(String)) }
          def weekly_anchor; end
          # The days of the week when available funds are paid out, specified as an array, for example, [`monday`, `tuesday`]. Only shown if `interval` is weekly.
          sig { returns(T.nilable(T::Array[String])) }
          def weekly_payout_days; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # A Boolean indicating if Stripe should try to reclaim negative balances from an attached bank account. See [Understanding Connect account balances](/connect/account-balances) for details. The default value is `false` when [controller.requirement_collection](/api/accounts/object#account_object-controller-requirement_collection) is `application`, which includes Custom accounts, otherwise `true`.
        sig { returns(T::Boolean) }
        def debit_negative_balances; end
        # Attribute for field schedule
        sig { returns(Schedule) }
        def schedule; end
        # The text that appears on the bank account statement for payouts. If not set, this defaults to the platform's bank descriptor as set in the Dashboard.
        sig { returns(T.nilable(String)) }
        def statement_descriptor; end
        def self.inner_class_types
          @inner_class_types = {schedule: Schedule}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class SepaDebitPayments < ::Stripe::StripeObject
        # SEPA creditor identifier that identifies the company making the payment.
        sig { returns(T.nilable(String)) }
        def creditor_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Treasury < ::Stripe::StripeObject
        class TosAcceptance < ::Stripe::StripeObject
          # The Unix timestamp marking when the account representative accepted the service agreement.
          sig { returns(T.nilable(Integer)) }
          def date; end
          # The IP address from which the account representative accepted the service agreement.
          sig { returns(T.nilable(String)) }
          def ip; end
          # The user agent of the browser from which the account representative accepted the service agreement.
          sig { returns(T.nilable(String)) }
          def user_agent; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field tos_acceptance
        sig { returns(T.nilable(TosAcceptance)) }
        def tos_acceptance; end
        def self.inner_class_types
          @inner_class_types = {tos_acceptance: TosAcceptance}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field bacs_debit_payments
      sig { returns(T.nilable(BacsDebitPayments)) }
      def bacs_debit_payments; end
      # Attribute for field branding
      sig { returns(Branding) }
      def branding; end
      # Attribute for field card_issuing
      sig { returns(T.nilable(CardIssuing)) }
      def card_issuing; end
      # Attribute for field card_payments
      sig { returns(CardPayments) }
      def card_payments; end
      # Attribute for field dashboard
      sig { returns(Dashboard) }
      def dashboard; end
      # Attribute for field invoices
      sig { returns(T.nilable(Invoices)) }
      def invoices; end
      # Attribute for field payments
      sig { returns(Payments) }
      def payments; end
      # Attribute for field payouts
      sig { returns(T.nilable(Payouts)) }
      def payouts; end
      # Attribute for field sepa_debit_payments
      sig { returns(T.nilable(SepaDebitPayments)) }
      def sepa_debit_payments; end
      # Attribute for field treasury
      sig { returns(T.nilable(Treasury)) }
      def treasury; end
      def self.inner_class_types
        @inner_class_types = {
          bacs_debit_payments: BacsDebitPayments,
          branding: Branding,
          card_issuing: CardIssuing,
          card_payments: CardPayments,
          dashboard: Dashboard,
          invoices: Invoices,
          payments: Payments,
          payouts: Payouts,
          sepa_debit_payments: SepaDebitPayments,
          treasury: Treasury,
        }
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class TosAcceptance < ::Stripe::StripeObject
      # The Unix timestamp marking when the account representative accepted their service agreement
      sig { returns(T.nilable(Integer)) }
      def date; end
      # The IP address from which the account representative accepted their service agreement
      sig { returns(T.nilable(String)) }
      def ip; end
      # The user's service agreement type
      sig { returns(T.nilable(String)) }
      def service_agreement; end
      # The user agent of the browser from which the account representative accepted their service agreement
      sig { returns(T.nilable(String)) }
      def user_agent; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Business information about the account.
    sig { returns(T.nilable(BusinessProfile)) }
    def business_profile; end
    # The business type.
    sig { returns(T.nilable(String)) }
    def business_type; end
    # Attribute for field capabilities
    sig { returns(T.nilable(Capabilities)) }
    def capabilities; end
    # Whether the account can process charges.
    sig { returns(T.nilable(T::Boolean)) }
    def charges_enabled; end
    # Attribute for field company
    sig { returns(T.nilable(Company)) }
    def company; end
    # Attribute for field controller
    sig { returns(T.nilable(Controller)) }
    def controller; end
    # The account's country.
    sig { returns(T.nilable(String)) }
    def country; end
    # Time at which the account was connected. Measured in seconds since the Unix epoch.
    sig { returns(T.nilable(Integer)) }
    def created; end
    # Three-letter ISO currency code representing the default currency for the account. This must be a currency that [Stripe supports in the account's country](https://stripe.com/docs/payouts).
    sig { returns(T.nilable(String)) }
    def default_currency; end
    # Whether account details have been submitted. Accounts with Stripe Dashboard access, which includes Standard accounts, cannot receive payouts before this is true. Accounts where this is false should be directed to [an onboarding flow](/connect/onboarding) to finish submitting account details.
    sig { returns(T.nilable(T::Boolean)) }
    def details_submitted; end
    # An email address associated with the account. It's not used for authentication and Stripe doesn't market to this field without explicit approval from the platform.
    sig { returns(T.nilable(String)) }
    def email; end
    # External accounts (bank accounts and debit cards) currently attached to this account. External accounts are only returned for requests where `controller[is_controller]` is true.
    sig { returns(T.nilable(::Stripe::ListObject)) }
    def external_accounts; end
    # Attribute for field future_requirements
    sig { returns(T.nilable(FutureRequirements)) }
    def future_requirements; end
    # The groups associated with the account.
    sig { returns(T.nilable(Groups)) }
    def groups; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # This is an object representing a person associated with a Stripe account.
    #
    # A platform can only access a subset of data in a person for an account where [account.controller.requirement_collection](/api/accounts/object#account_object-controller-requirement_collection) is `stripe`, which includes Standard and Express accounts, after creating an Account Link or Account Session to start Connect onboarding.
    #
    # See the [Standard onboarding](/connect/standard-accounts) or [Express onboarding](/connect/express-accounts) documentation for information about prefilling information and account onboarding steps. Learn more about [handling identity verification with the API](/connect/handling-api-verification#person-information).
    sig { returns(T.nilable(::Stripe::Person)) }
    def individual; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Whether the funds in this account can be paid out.
    sig { returns(T.nilable(T::Boolean)) }
    def payouts_enabled; end
    # Attribute for field requirements
    sig { returns(T.nilable(Requirements)) }
    def requirements; end
    # Options for customizing how the account functions within Stripe.
    sig { returns(T.nilable(Settings)) }
    def settings; end
    # Attribute for field tos_acceptance
    sig { returns(T.nilable(TosAcceptance)) }
    def tos_acceptance; end
    # The Stripe account type. Can be `standard`, `express`, `custom`, or `none`.
    sig { returns(T.nilable(String)) }
    def type; end
    # Always true for a deleted object
    sig { returns(T.nilable(T::Boolean)) }
    def deleted; end
    # With [Connect](https://docs.stripe.com/docs/connect), you can create Stripe accounts for your users.
    # To do this, you'll first need to [register your platform](https://dashboard.stripe.com/account/applications/settings).
    #
    # If you've already collected information for your connected accounts, you [can prefill that information](https://docs.stripe.com/docs/connect/best-practices#onboarding) when
    # creating the account. Connect Onboarding won't ask for the prefilled information during account onboarding.
    # You can prefill any information on the account.
    sig {
      params(params: T.any(::Stripe::AccountCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Account)
     }
    def self.create(params = {}, opts = {}); end

    # With [Connect](https://docs.stripe.com/connect), you can delete accounts you manage.
    #
    # Test-mode accounts can be deleted at any time.
    #
    # Live-mode accounts that have access to the standard dashboard and Stripe is responsible for negative account balances cannot be deleted, which includes Standard accounts. All other Live-mode accounts, can be deleted when all [balances](https://docs.stripe.com/api/balance/balance_object) are zero.
    #
    # If you want to delete your own account, use the [account information tab in your account settings](https://dashboard.stripe.com/settings/account) instead.
    sig {
      params(account: String, params: T.any(::Stripe::AccountDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Account)
     }
    def self.delete(account, params = {}, opts = {}); end

    # With [Connect](https://docs.stripe.com/connect), you can delete accounts you manage.
    #
    # Test-mode accounts can be deleted at any time.
    #
    # Live-mode accounts that have access to the standard dashboard and Stripe is responsible for negative account balances cannot be deleted, which includes Standard accounts. All other Live-mode accounts, can be deleted when all [balances](https://docs.stripe.com/api/balance/balance_object) are zero.
    #
    # If you want to delete your own account, use the [account information tab in your account settings](https://dashboard.stripe.com/settings/account) instead.
    sig {
      params(params: T.any(::Stripe::AccountDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Account)
     }
    def delete(params = {}, opts = {}); end

    # Returns a list of accounts connected to your platform via [Connect](https://docs.stripe.com/docs/connect). If you're not a platform, the list is empty.
    sig {
      params(params: T.any(::Stripe::AccountListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Returns a list of people associated with the account's legal entity. The people are returned sorted by creation date, with the most recent people appearing first.
    sig {
      params(params: T.any(::Stripe::AccountPersonsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def persons(params = {}, opts = {}); end

    # Returns a list of people associated with the account's legal entity. The people are returned sorted by creation date, with the most recent people appearing first.
    sig {
      params(account: String, params: T.any(::Stripe::AccountPersonsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.persons(account, params = {}, opts = {}); end

    # With [Connect](https://docs.stripe.com/connect), you can reject accounts that you have flagged as suspicious.
    #
    # Only accounts where your platform is liable for negative account balances, which includes Custom and Express accounts, can be rejected. Test-mode accounts can be rejected at any time. Live-mode accounts can only be rejected after all balances are zero.
    sig {
      params(params: T.any(::Stripe::AccountRejectParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Account)
     }
    def reject(params = {}, opts = {}); end

    # With [Connect](https://docs.stripe.com/connect), you can reject accounts that you have flagged as suspicious.
    #
    # Only accounts where your platform is liable for negative account balances, which includes Custom and Express accounts, can be rejected. Test-mode accounts can be rejected at any time. Live-mode accounts can only be rejected after all balances are zero.
    sig {
      params(account: String, params: T.any(::Stripe::AccountRejectParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Account)
     }
    def self.reject(account, params = {}, opts = {}); end

    # Updates a [connected account](https://docs.stripe.com/connect/accounts) by setting the values of the parameters passed. Any parameters not provided are
    # left unchanged.
    #
    # For accounts where [controller.requirement_collection](https://docs.stripe.com/api/accounts/object#account_object-controller-requirement_collection)
    # is application, which includes Custom accounts, you can update any information on the account.
    #
    # For accounts where [controller.requirement_collection](https://docs.stripe.com/api/accounts/object#account_object-controller-requirement_collection)
    # is stripe, which includes Standard and Express accounts, you can update all information until you create
    # an [Account Link or <a href="/api/account_sessions">Account Session](https://docs.stripe.com/api/account_links) to start Connect onboarding,
    # after which some properties can no longer be updated.
    #
    # To update your own account, use the [Dashboard](https://dashboard.stripe.com/settings/account). Refer to our
    # [Connect](https://docs.stripe.com/docs/connect/updating-accounts) documentation to learn more about updating accounts.
    sig {
      params(account: String, params: T.any(::Stripe::AccountUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Account)
     }
    def self.update(account, params = {}, opts = {}); end
  end
end