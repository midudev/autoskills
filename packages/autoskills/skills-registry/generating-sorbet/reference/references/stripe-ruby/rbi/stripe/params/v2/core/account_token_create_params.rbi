# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      class AccountTokenCreateParams < ::Stripe::RequestParams
        class Identity < ::Stripe::RequestParams
          class Attestations < ::Stripe::RequestParams
            class DirectorshipDeclaration < ::Stripe::RequestParams
              # A boolean indicating if the directors information has been attested.
              sig { returns(T.nilable(T::Boolean)) }
              def attested; end
              sig { params(_attested: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
              def attested=(_attested); end
              sig { params(attested: T.nilable(T::Boolean)).void }
              def initialize(attested: nil); end
            end
            class OwnershipDeclaration < ::Stripe::RequestParams
              # A boolean indicating if the beneficial owner information has been attested.
              sig { returns(T.nilable(T::Boolean)) }
              def attested; end
              sig { params(_attested: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
              def attested=(_attested); end
              sig { params(attested: T.nilable(T::Boolean)).void }
              def initialize(attested: nil); end
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
              # A boolean indicating if the representative is authorized to act as the representative of their legal entity.
              sig { returns(T.nilable(T::Boolean)) }
              def attested; end
              sig { params(_attested: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
              def attested=(_attested); end
              sig { params(attested: T.nilable(T::Boolean)).void }
              def initialize(attested: nil); end
            end
            class TermsOfService < ::Stripe::RequestParams
              class Account < ::Stripe::RequestParams
                # The boolean value indicating if the terms of service have been accepted.
                sig { returns(T.nilable(T::Boolean)) }
                def shown_and_accepted; end
                sig {
                  params(_shown_and_accepted: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean))
                 }
                def shown_and_accepted=(_shown_and_accepted); end
                sig { params(shown_and_accepted: T.nilable(T::Boolean)).void }
                def initialize(shown_and_accepted: nil); end
              end
              # Details on the Account's acceptance of the [Stripe Services Agreement]; IP, date, and User Agent are expanded by Stripe.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::TermsOfService::Account))
               }
              def account; end
              sig {
                params(_account: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::TermsOfService::Account)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::TermsOfService::Account))
               }
              def account=(_account); end
              sig {
                params(account: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::TermsOfService::Account)).void
               }
              def initialize(account: nil); end
            end
            # This hash is used to attest that the directors information provided to Stripe is both current and correct; IP, date, and User Agent are expanded by Stripe.
            sig {
              returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::DirectorshipDeclaration))
             }
            def directorship_declaration; end
            sig {
              params(_directorship_declaration: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::DirectorshipDeclaration)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::DirectorshipDeclaration))
             }
            def directorship_declaration=(_directorship_declaration); end
            # This hash is used to attest that the beneficial owner information provided to Stripe is both current and correct; IP, date, and User Agent are expanded by Stripe.
            sig {
              returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::OwnershipDeclaration))
             }
            def ownership_declaration; end
            sig {
              params(_ownership_declaration: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::OwnershipDeclaration)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::OwnershipDeclaration))
             }
            def ownership_declaration=(_ownership_declaration); end
            # Attestation that all Persons with a specific Relationship value have been provided.
            sig {
              returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::PersonsProvided))
             }
            def persons_provided; end
            sig {
              params(_persons_provided: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::PersonsProvided)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::PersonsProvided))
             }
            def persons_provided=(_persons_provided); end
            # This hash is used to attest that the representative is authorized to act as the representative of their legal entity; IP, date, and User Agent are expanded by Stripe.
            sig {
              returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::RepresentativeDeclaration))
             }
            def representative_declaration; end
            sig {
              params(_representative_declaration: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::RepresentativeDeclaration)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::RepresentativeDeclaration))
             }
            def representative_declaration=(_representative_declaration); end
            # Attestations of accepted terms of service agreements.
            sig {
              returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::TermsOfService))
             }
            def terms_of_service; end
            sig {
              params(_terms_of_service: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::TermsOfService)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::TermsOfService))
             }
            def terms_of_service=(_terms_of_service); end
            sig {
              params(directorship_declaration: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::DirectorshipDeclaration), ownership_declaration: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::OwnershipDeclaration), persons_provided: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::PersonsProvided), representative_declaration: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::RepresentativeDeclaration), terms_of_service: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations::TermsOfService)).void
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
              # Town or district.
              sig { returns(T.nilable(String)) }
              def town; end
              sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
              def town=(_town); end
              sig {
                params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
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
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::AnnualRevenue::Amount))
               }
              def amount; end
              sig {
                params(_amount: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::AnnualRevenue::Amount)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::AnnualRevenue::Amount))
               }
              def amount=(_amount); end
              # The close-out date of the preceding fiscal year in ISO 8601 format. E.g. 2023-12-31 for the 31st of December, 2023.
              sig { returns(T.nilable(String)) }
              def fiscal_year_end; end
              sig { params(_fiscal_year_end: T.nilable(String)).returns(T.nilable(String)) }
              def fiscal_year_end=(_fiscal_year_end); end
              sig {
                params(amount: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::AnnualRevenue::Amount), fiscal_year_end: T.nilable(String)).void
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
                  sig { returns(T.nilable(String)) }
                  def front; end
                  sig { params(_front: T.nilable(String)).returns(T.nilable(String)) }
                  def front=(_front); end
                  sig { params(back: T.nilable(String), front: T.nilable(String)).void }
                  def initialize(back: nil, front: nil); end
                end
                # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens referring to each side of the document.
                sig {
                  returns(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::PrimaryVerification::FrontBack)
                 }
                def front_back; end
                sig {
                  params(_front_back: V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::PrimaryVerification::FrontBack).returns(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::PrimaryVerification::FrontBack)
                 }
                def front_back=(_front_back); end
                # The format of the verification document. Currently supports `front_back` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig {
                  params(front_back: V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::PrimaryVerification::FrontBack, type: String).void
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
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::BankAccountOwnershipVerification))
               }
              def bank_account_ownership_verification; end
              sig {
                params(_bank_account_ownership_verification: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::BankAccountOwnershipVerification)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::BankAccountOwnershipVerification))
               }
              def bank_account_ownership_verification=(_bank_account_ownership_verification); end
              # One or more documents that demonstrate proof of a company’s license to operate.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyLicense))
               }
              def company_license; end
              sig {
                params(_company_license: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyLicense)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyLicense))
               }
              def company_license=(_company_license); end
              # One or more documents showing the company’s Memorandum of Association.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyMemorandumOfAssociation))
               }
              def company_memorandum_of_association; end
              sig {
                params(_company_memorandum_of_association: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyMemorandumOfAssociation)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyMemorandumOfAssociation))
               }
              def company_memorandum_of_association=(_company_memorandum_of_association); end
              # Certain countries only: One or more documents showing the ministerial decree legalizing the company’s establishment.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyMinisterialDecree))
               }
              def company_ministerial_decree; end
              sig {
                params(_company_ministerial_decree: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyMinisterialDecree)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyMinisterialDecree))
               }
              def company_ministerial_decree=(_company_ministerial_decree); end
              # One or more documents that demonstrate proof of a company’s registration with the appropriate local authorities.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyRegistrationVerification))
               }
              def company_registration_verification; end
              sig {
                params(_company_registration_verification: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyRegistrationVerification)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyRegistrationVerification))
               }
              def company_registration_verification=(_company_registration_verification); end
              # One or more documents that demonstrate proof of a company’s tax ID.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyTaxIdVerification))
               }
              def company_tax_id_verification; end
              sig {
                params(_company_tax_id_verification: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyTaxIdVerification)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyTaxIdVerification))
               }
              def company_tax_id_verification=(_company_tax_id_verification); end
              # A document verifying the business.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::PrimaryVerification))
               }
              def primary_verification; end
              sig {
                params(_primary_verification: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::PrimaryVerification)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::PrimaryVerification))
               }
              def primary_verification=(_primary_verification); end
              # One or more documents that demonstrate proof of address.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::ProofOfAddress))
               }
              def proof_of_address; end
              sig {
                params(_proof_of_address: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::ProofOfAddress)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::ProofOfAddress))
               }
              def proof_of_address=(_proof_of_address); end
              # One or more documents showing the company’s proof of registration with the national business registry.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::ProofOfRegistration))
               }
              def proof_of_registration; end
              sig {
                params(_proof_of_registration: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::ProofOfRegistration)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::ProofOfRegistration))
               }
              def proof_of_registration=(_proof_of_registration); end
              # One or more documents that demonstrate proof of ultimate beneficial ownership.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::ProofOfUltimateBeneficialOwnership))
               }
              def proof_of_ultimate_beneficial_ownership; end
              sig {
                params(_proof_of_ultimate_beneficial_ownership: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::ProofOfUltimateBeneficialOwnership)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::ProofOfUltimateBeneficialOwnership))
               }
              def proof_of_ultimate_beneficial_ownership=(
                _proof_of_ultimate_beneficial_ownership
              ); end
              sig {
                params(bank_account_ownership_verification: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::BankAccountOwnershipVerification), company_license: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyLicense), company_memorandum_of_association: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyMemorandumOfAssociation), company_ministerial_decree: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyMinisterialDecree), company_registration_verification: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyRegistrationVerification), company_tax_id_verification: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::CompanyTaxIdVerification), primary_verification: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::PrimaryVerification), proof_of_address: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::ProofOfAddress), proof_of_registration: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::ProofOfRegistration), proof_of_ultimate_beneficial_ownership: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents::ProofOfUltimateBeneficialOwnership)).void
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
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::MonthlyEstimatedRevenue::Amount))
               }
              def amount; end
              sig {
                params(_amount: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::MonthlyEstimatedRevenue::Amount)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::MonthlyEstimatedRevenue::Amount))
               }
              def amount=(_amount); end
              sig {
                params(amount: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::MonthlyEstimatedRevenue::Amount)).void
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
                # Town or district.
                sig { returns(T.nilable(String)) }
                def town; end
                sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
                def town=(_town); end
                sig {
                  params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
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
                # Town or district.
                sig { returns(T.nilable(String)) }
                def town; end
                sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
                def town=(_town); end
                sig {
                  params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
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
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptAddresses::Kana))
               }
              def kana; end
              sig {
                params(_kana: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptAddresses::Kana)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptAddresses::Kana))
               }
              def kana=(_kana); end
              # Kanji Address.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptAddresses::Kanji))
               }
              def kanji; end
              sig {
                params(_kanji: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptAddresses::Kanji)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptAddresses::Kanji))
               }
              def kanji=(_kanji); end
              sig {
                params(kana: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptAddresses::Kana), kanji: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptAddresses::Kanji)).void
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
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptNames::Kana))
               }
              def kana; end
              sig {
                params(_kana: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptNames::Kana)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptNames::Kana))
               }
              def kana=(_kana); end
              # Kanji name.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptNames::Kanji))
               }
              def kanji; end
              sig {
                params(_kanji: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptNames::Kanji)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptNames::Kanji))
               }
              def kanji=(_kanji); end
              sig {
                params(kana: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptNames::Kana), kanji: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptNames::Kanji)).void
               }
              def initialize(kana: nil, kanji: nil); end
            end
            # The business registration address of the business entity.
            sig {
              returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Address))
             }
            def address; end
            sig {
              params(_address: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Address)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Address))
             }
            def address=(_address); end
            # The business gross annual revenue for its preceding fiscal year.
            sig {
              returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::AnnualRevenue))
             }
            def annual_revenue; end
            sig {
              params(_annual_revenue: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::AnnualRevenue)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::AnnualRevenue))
             }
            def annual_revenue=(_annual_revenue); end
            # A document verifying the business.
            sig {
              returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents))
             }
            def documents; end
            sig {
              params(_documents: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents))
             }
            def documents=(_documents); end
            # Estimated maximum number of workers currently engaged by the business (including employees, contractors, and vendors).
            sig { returns(T.nilable(Integer)) }
            def estimated_worker_count; end
            sig { params(_estimated_worker_count: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def estimated_worker_count=(_estimated_worker_count); end
            # The ID numbers of a business entity.
            sig {
              returns(T.nilable(T::Array[V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::IdNumber]))
             }
            def id_numbers; end
            sig {
              params(_id_numbers: T.nilable(T::Array[V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::IdNumber])).returns(T.nilable(T::Array[V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::IdNumber]))
             }
            def id_numbers=(_id_numbers); end
            # An estimate of the monthly revenue of the business.
            sig {
              returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::MonthlyEstimatedRevenue))
             }
            def monthly_estimated_revenue; end
            sig {
              params(_monthly_estimated_revenue: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::MonthlyEstimatedRevenue)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::MonthlyEstimatedRevenue))
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
              returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptAddresses))
             }
            def script_addresses; end
            sig {
              params(_script_addresses: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptAddresses)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptAddresses))
             }
            def script_addresses=(_script_addresses); end
            # The business legal name in non latin script.
            sig {
              returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptNames))
             }
            def script_names; end
            sig {
              params(_script_names: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptNames)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptNames))
             }
            def script_names=(_script_names); end
            # The category identifying the legal structure of the business.
            sig { returns(T.nilable(String)) }
            def structure; end
            sig { params(_structure: T.nilable(String)).returns(T.nilable(String)) }
            def structure=(_structure); end
            sig {
              params(address: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Address), annual_revenue: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::AnnualRevenue), documents: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::Documents), estimated_worker_count: T.nilable(Integer), id_numbers: T.nilable(T::Array[V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::IdNumber]), monthly_estimated_revenue: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::MonthlyEstimatedRevenue), phone: T.nilable(String), registered_name: T.nilable(String), script_addresses: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptAddresses), script_names: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails::ScriptNames), structure: T.nilable(String)).void
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
                params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), purpose: String, state: T.nilable(String), town: T.nilable(String)).void
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
              # Town or district.
              sig { returns(T.nilable(String)) }
              def town; end
              sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
              def town=(_town); end
              sig {
                params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
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
              # The day of the birth.
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
                  sig { returns(T.nilable(String)) }
                  def front; end
                  sig { params(_front: T.nilable(String)).returns(T.nilable(String)) }
                  def front=(_front); end
                  sig { params(back: T.nilable(String), front: T.nilable(String)).void }
                  def initialize(back: nil, front: nil); end
                end
                # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens referring to each side of the document.
                sig {
                  returns(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::PrimaryVerification::FrontBack)
                 }
                def front_back; end
                sig {
                  params(_front_back: V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::PrimaryVerification::FrontBack).returns(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::PrimaryVerification::FrontBack)
                 }
                def front_back=(_front_back); end
                # The format of the verification document. Currently supports `front_back` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig {
                  params(front_back: V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::PrimaryVerification::FrontBack, type: String).void
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
                  sig { returns(T.nilable(String)) }
                  def front; end
                  sig { params(_front: T.nilable(String)).returns(T.nilable(String)) }
                  def front=(_front); end
                  sig { params(back: T.nilable(String), front: T.nilable(String)).void }
                  def initialize(back: nil, front: nil); end
                end
                # The [file upload](https://docs.stripe.com/api/persons/update#create_file) tokens referring to each side of the document.
                sig {
                  returns(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::SecondaryVerification::FrontBack)
                 }
                def front_back; end
                sig {
                  params(_front_back: V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::SecondaryVerification::FrontBack).returns(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::SecondaryVerification::FrontBack)
                 }
                def front_back=(_front_back); end
                # The format of the verification document. Currently supports `front_back` only.
                sig { returns(String) }
                def type; end
                sig { params(_type: String).returns(String) }
                def type=(_type); end
                sig {
                  params(front_back: V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::SecondaryVerification::FrontBack, type: String).void
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
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::CompanyAuthorization))
               }
              def company_authorization; end
              sig {
                params(_company_authorization: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::CompanyAuthorization)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::CompanyAuthorization))
               }
              def company_authorization=(_company_authorization); end
              # One or more documents showing the person’s passport page with photo and personal data.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::Passport))
               }
              def passport; end
              sig {
                params(_passport: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::Passport)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::Passport))
               }
              def passport=(_passport); end
              # An identifying document showing the person's name, either a passport or local ID card.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::PrimaryVerification))
               }
              def primary_verification; end
              sig {
                params(_primary_verification: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::PrimaryVerification)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::PrimaryVerification))
               }
              def primary_verification=(_primary_verification); end
              # A document showing address, either a passport, local ID card, or utility bill from a well-known utility company.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::SecondaryVerification))
               }
              def secondary_verification; end
              sig {
                params(_secondary_verification: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::SecondaryVerification)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::SecondaryVerification))
               }
              def secondary_verification=(_secondary_verification); end
              # One or more documents showing the person’s visa required for living in the country where they are residing.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::Visa))
               }
              def visa; end
              sig {
                params(_visa: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::Visa)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::Visa))
               }
              def visa=(_visa); end
              sig {
                params(company_authorization: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::CompanyAuthorization), passport: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::Passport), primary_verification: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::PrimaryVerification), secondary_verification: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::SecondaryVerification), visa: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents::Visa)).void
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
                # Town or district.
                sig { returns(T.nilable(String)) }
                def town; end
                sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
                def town=(_town); end
                sig {
                  params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
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
                # Town or district.
                sig { returns(T.nilable(String)) }
                def town; end
                sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
                def town=(_town); end
                sig {
                  params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
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
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptAddresses::Kana))
               }
              def kana; end
              sig {
                params(_kana: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptAddresses::Kana)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptAddresses::Kana))
               }
              def kana=(_kana); end
              # Kanji Address.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptAddresses::Kanji))
               }
              def kanji; end
              sig {
                params(_kanji: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptAddresses::Kanji)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptAddresses::Kanji))
               }
              def kanji=(_kanji); end
              sig {
                params(kana: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptAddresses::Kana), kanji: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptAddresses::Kanji)).void
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
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptNames::Kana))
               }
              def kana; end
              sig {
                params(_kana: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptNames::Kana)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptNames::Kana))
               }
              def kana=(_kana); end
              # Persons name in kanji script.
              sig {
                returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptNames::Kanji))
               }
              def kanji; end
              sig {
                params(_kanji: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptNames::Kanji)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptNames::Kanji))
               }
              def kanji=(_kanji); end
              sig {
                params(kana: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptNames::Kana), kanji: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptNames::Kanji)).void
               }
              def initialize(kana: nil, kanji: nil); end
            end
            # Additional addresses associated with the individual.
            sig {
              returns(T.nilable(T::Array[V2::Core::AccountTokenCreateParams::Identity::Individual::AdditionalAddress]))
             }
            def additional_addresses; end
            sig {
              params(_additional_addresses: T.nilable(T::Array[V2::Core::AccountTokenCreateParams::Identity::Individual::AdditionalAddress])).returns(T.nilable(T::Array[V2::Core::AccountTokenCreateParams::Identity::Individual::AdditionalAddress]))
             }
            def additional_addresses=(_additional_addresses); end
            # Additional names (e.g. aliases) associated with the individual.
            sig {
              returns(T.nilable(T::Array[V2::Core::AccountTokenCreateParams::Identity::Individual::AdditionalName]))
             }
            def additional_names; end
            sig {
              params(_additional_names: T.nilable(T::Array[V2::Core::AccountTokenCreateParams::Identity::Individual::AdditionalName])).returns(T.nilable(T::Array[V2::Core::AccountTokenCreateParams::Identity::Individual::AdditionalName]))
             }
            def additional_names=(_additional_names); end
            # The individual's residential address.
            sig {
              returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Address))
             }
            def address; end
            sig {
              params(_address: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Address)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Address))
             }
            def address=(_address); end
            # The individual's date of birth.
            sig {
              returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::DateOfBirth))
             }
            def date_of_birth; end
            sig {
              params(_date_of_birth: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::DateOfBirth)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::DateOfBirth))
             }
            def date_of_birth=(_date_of_birth); end
            # Documents that may be submitted to satisfy various informational requests.
            sig {
              returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents))
             }
            def documents; end
            sig {
              params(_documents: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents))
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
              returns(T.nilable(T::Array[V2::Core::AccountTokenCreateParams::Identity::Individual::IdNumber]))
             }
            def id_numbers; end
            sig {
              params(_id_numbers: T.nilable(T::Array[V2::Core::AccountTokenCreateParams::Identity::Individual::IdNumber])).returns(T.nilable(T::Array[V2::Core::AccountTokenCreateParams::Identity::Individual::IdNumber]))
             }
            def id_numbers=(_id_numbers); end
            # The individual's gender (International regulations require either "male" or "female").
            sig { returns(T.nilable(String)) }
            def legal_gender; end
            sig { params(_legal_gender: T.nilable(String)).returns(T.nilable(String)) }
            def legal_gender=(_legal_gender); end
            # Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
            sig { returns(T.nilable(T::Hash[String, T.nilable(String)])) }
            def metadata; end
            sig {
              params(_metadata: T.nilable(T::Hash[String, T.nilable(String)])).returns(T.nilable(T::Hash[String, T.nilable(String)]))
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
              returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Relationship))
             }
            def relationship; end
            sig {
              params(_relationship: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Relationship)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Relationship))
             }
            def relationship=(_relationship); end
            # The script addresses (e.g., non-Latin characters) associated with the individual.
            sig {
              returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptAddresses))
             }
            def script_addresses; end
            sig {
              params(_script_addresses: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptAddresses)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptAddresses))
             }
            def script_addresses=(_script_addresses); end
            # The individuals primary name in non latin script.
            sig {
              returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptNames))
             }
            def script_names; end
            sig {
              params(_script_names: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptNames)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptNames))
             }
            def script_names=(_script_names); end
            # The individual's last name.
            sig { returns(T.nilable(String)) }
            def surname; end
            sig { params(_surname: T.nilable(String)).returns(T.nilable(String)) }
            def surname=(_surname); end
            sig {
              params(additional_addresses: T.nilable(T::Array[V2::Core::AccountTokenCreateParams::Identity::Individual::AdditionalAddress]), additional_names: T.nilable(T::Array[V2::Core::AccountTokenCreateParams::Identity::Individual::AdditionalName]), address: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Address), date_of_birth: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::DateOfBirth), documents: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Documents), email: T.nilable(String), given_name: T.nilable(String), id_numbers: T.nilable(T::Array[V2::Core::AccountTokenCreateParams::Identity::Individual::IdNumber]), legal_gender: T.nilable(String), metadata: T.nilable(T::Hash[String, T.nilable(String)]), nationalities: T.nilable(T::Array[String]), phone: T.nilable(String), political_exposure: T.nilable(String), relationship: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::Relationship), script_addresses: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptAddresses), script_names: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual::ScriptNames), surname: T.nilable(String)).void
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
          sig { returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations)) }
          def attestations; end
          sig {
            params(_attestations: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations))
           }
          def attestations=(_attestations); end
          # Information about the company or business.
          sig { returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails)) }
          def business_details; end
          sig {
            params(_business_details: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails))
           }
          def business_details=(_business_details); end
          # The entity type.
          sig { returns(T.nilable(String)) }
          def entity_type; end
          sig { params(_entity_type: T.nilable(String)).returns(T.nilable(String)) }
          def entity_type=(_entity_type); end
          # Information about the person represented by the account.
          sig { returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual)) }
          def individual; end
          sig {
            params(_individual: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual))
           }
          def individual=(_individual); end
          sig {
            params(attestations: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Attestations), business_details: T.nilable(V2::Core::AccountTokenCreateParams::Identity::BusinessDetails), entity_type: T.nilable(String), individual: T.nilable(V2::Core::AccountTokenCreateParams::Identity::Individual)).void
           }
          def initialize(
            attestations: nil,
            business_details: nil,
            entity_type: nil,
            individual: nil
          ); end
        end
        # The default contact email address for the Account. Required when configuring the account as a merchant or recipient.
        sig { returns(T.nilable(String)) }
        def contact_email; end
        sig { params(_contact_email: T.nilable(String)).returns(T.nilable(String)) }
        def contact_email=(_contact_email); end
        # A descriptive name for the Account. This name will be surfaced in the Stripe Dashboard and on any invoices sent to the Account.
        sig { returns(T.nilable(String)) }
        def display_name; end
        sig { params(_display_name: T.nilable(String)).returns(T.nilable(String)) }
        def display_name=(_display_name); end
        # Information about the company, individual, and business represented by the Account.
        sig { returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity)) }
        def identity; end
        sig {
          params(_identity: T.nilable(V2::Core::AccountTokenCreateParams::Identity)).returns(T.nilable(V2::Core::AccountTokenCreateParams::Identity))
         }
        def identity=(_identity); end
        sig {
          params(contact_email: T.nilable(String), display_name: T.nilable(String), identity: T.nilable(V2::Core::AccountTokenCreateParams::Identity)).void
         }
        def initialize(contact_email: nil, display_name: nil, identity: nil); end
      end
    end
  end
end