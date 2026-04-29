# File generated from our OpenAPI spec
# frozen_string_literal: true

module Stripe
  module V2
    module Core
      class AccountTokenCreateParams < ::Stripe::RequestParams
        class Identity < ::Stripe::RequestParams
          class Attestations < ::Stripe::RequestParams
            class DirectorshipDeclaration < ::Stripe::RequestParams
              # A boolean indicating if the directors information has been attested.
              attr_accessor :attested

              def initialize(attested: nil)
                @attested = attested
              end
            end

            class OwnershipDeclaration < ::Stripe::RequestParams
              # A boolean indicating if the beneficial owner information has been attested.
              attr_accessor :attested

              def initialize(attested: nil)
                @attested = attested
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
              # A boolean indicating if the representative is authorized to act as the representative of their legal entity.
              attr_accessor :attested

              def initialize(attested: nil)
                @attested = attested
              end
            end

            class TermsOfService < ::Stripe::RequestParams
              class Account < ::Stripe::RequestParams
                # The boolean value indicating if the terms of service have been accepted.
                attr_accessor :shown_and_accepted

                def initialize(shown_and_accepted: nil)
                  @shown_and_accepted = shown_and_accepted
                end
              end
              # Details on the Account's acceptance of the [Stripe Services Agreement]; IP, date, and User Agent are expanded by Stripe.
              attr_accessor :account

              def initialize(account: nil)
                @account = account
              end
            end
            # This hash is used to attest that the directors information provided to Stripe is both current and correct; IP, date, and User Agent are expanded by Stripe.
            attr_accessor :directorship_declaration
            # This hash is used to attest that the beneficial owner information provided to Stripe is both current and correct; IP, date, and User Agent are expanded by Stripe.
            attr_accessor :ownership_declaration
            # Attestation that all Persons with a specific Relationship value have been provided.
            attr_accessor :persons_provided
            # This hash is used to attest that the representative is authorized to act as the representative of their legal entity; IP, date, and User Agent are expanded by Stripe.
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
          # The entity type.
          attr_accessor :entity_type
          # Information about the person represented by the account.
          attr_accessor :individual

          def initialize(
            attestations: nil,
            business_details: nil,
            entity_type: nil,
            individual: nil
          )
            @attestations = attestations
            @business_details = business_details
            @entity_type = entity_type
            @individual = individual
          end
        end
        # The default contact email address for the Account. Required when configuring the account as a merchant or recipient.
        attr_accessor :contact_email
        # A descriptive name for the Account. This name will be surfaced in the Stripe Dashboard and on any invoices sent to the Account.
        attr_accessor :display_name
        # Information about the company, individual, and business represented by the Account.
        attr_accessor :identity

        def initialize(contact_email: nil, display_name: nil, identity: nil)
          @contact_email = contact_email
          @display_name = display_name
          @identity = identity
        end
      end
    end
  end
end
