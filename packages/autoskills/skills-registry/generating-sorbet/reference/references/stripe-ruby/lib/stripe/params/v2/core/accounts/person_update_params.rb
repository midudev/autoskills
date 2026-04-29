# File generated from our OpenAPI spec
# frozen_string_literal: true

module Stripe
  module V2
    module Core
      module Accounts
        class PersonUpdateParams < ::Stripe::RequestParams
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

          class AdditionalTermsOfService < ::Stripe::RequestParams
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
            # Stripe terms of service agreement.
            attr_accessor :account

            def initialize(account: nil)
              @account = account
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
            # Whether the individual is an authorizer of the Account's identity.
            attr_accessor :authorizer
            # Indicates whether the person is a director of the associated legal entity.
            attr_accessor :director
            # Indicates whether the person is an executive of the associated legal entity.
            attr_accessor :executive
            # Indicates whether the person is a legal guardian of the associated legal entity.
            attr_accessor :legal_guardian
            # Indicates whether the person is an owner of the associated legal entity.
            attr_accessor :owner
            # The percentage of ownership the person has in the associated legal entity.
            attr_accessor :percent_ownership
            # Indicates whether the person is a representative of the associated legal entity.
            attr_accessor :representative
            # The title or position the person holds in the associated legal entity.
            attr_accessor :title

            def initialize(
              authorizer: nil,
              director: nil,
              executive: nil,
              legal_guardian: nil,
              owner: nil,
              percent_ownership: nil,
              representative: nil,
              title: nil
            )
              @authorizer = authorizer
              @director = director
              @executive = executive
              @legal_guardian = legal_guardian
              @owner = owner
              @percent_ownership = percent_ownership
              @representative = representative
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
          # Additional addresses associated with the person.
          attr_accessor :additional_addresses
          # Additional names (e.g. aliases) associated with the person.
          attr_accessor :additional_names
          # Attestations of accepted terms of service agreements.
          attr_accessor :additional_terms_of_service
          # The primary address associated with the person.
          attr_accessor :address
          # The person's date of birth.
          attr_accessor :date_of_birth
          # Documents that may be submitted to satisfy various informational requests.
          attr_accessor :documents
          # Email.
          attr_accessor :email
          # The person's first name.
          attr_accessor :given_name
          # The identification numbers (e.g., SSN) associated with the person.
          attr_accessor :id_numbers
          # The person's gender (International regulations require either "male" or "female").
          attr_accessor :legal_gender
          # Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
          attr_accessor :metadata
          # The nationalities (countries) this person is associated with.
          attr_accessor :nationalities
          # The person token generated by the person token api.
          attr_accessor :person_token
          # The phone number for this person.
          attr_accessor :phone
          # The person's political exposure.
          attr_accessor :political_exposure
          # The relationship that this person has with the Account's business or legal entity.
          attr_accessor :relationship
          # The script addresses (e.g., non-Latin characters) associated with the person.
          attr_accessor :script_addresses
          # The script names (e.g. non-Latin characters) associated with the person.
          attr_accessor :script_names
          # The person's last name.
          attr_accessor :surname

          def initialize(
            additional_addresses: nil,
            additional_names: nil,
            additional_terms_of_service: nil,
            address: nil,
            date_of_birth: nil,
            documents: nil,
            email: nil,
            given_name: nil,
            id_numbers: nil,
            legal_gender: nil,
            metadata: nil,
            nationalities: nil,
            person_token: nil,
            phone: nil,
            political_exposure: nil,
            relationship: nil,
            script_addresses: nil,
            script_names: nil,
            surname: nil
          )
            @additional_addresses = additional_addresses
            @additional_names = additional_names
            @additional_terms_of_service = additional_terms_of_service
            @address = address
            @date_of_birth = date_of_birth
            @documents = documents
            @email = email
            @given_name = given_name
            @id_numbers = id_numbers
            @legal_gender = legal_gender
            @metadata = metadata
            @nationalities = nationalities
            @person_token = person_token
            @phone = phone
            @political_exposure = political_exposure
            @relationship = relationship
            @script_addresses = script_addresses
            @script_names = script_names
            @surname = surname
          end
        end
      end
    end
  end
end
