# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    module Issuing
      class PersonalizationDesignRejectParams < ::Stripe::RequestParams
        class RejectionReasons < ::Stripe::RequestParams
          # The reason(s) the card logo was rejected.
          sig { returns(T.nilable(T::Array[String])) }
          def card_logo; end
          sig {
            params(_card_logo: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
           }
          def card_logo=(_card_logo); end
          # The reason(s) the carrier text was rejected.
          sig { returns(T.nilable(T::Array[String])) }
          def carrier_text; end
          sig {
            params(_carrier_text: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
           }
          def carrier_text=(_carrier_text); end
          sig {
            params(card_logo: T.nilable(T::Array[String]), carrier_text: T.nilable(T::Array[String])).void
           }
          def initialize(card_logo: nil, carrier_text: nil); end
        end
        # Specifies which fields in the response should be expanded.
        sig { returns(T.nilable(T::Array[String])) }
        def expand; end
        sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
        def expand=(_expand); end
        # The reason(s) the personalization design was rejected.
        sig { returns(TestHelpers::Issuing::PersonalizationDesignRejectParams::RejectionReasons) }
        def rejection_reasons; end
        sig {
          params(_rejection_reasons: TestHelpers::Issuing::PersonalizationDesignRejectParams::RejectionReasons).returns(TestHelpers::Issuing::PersonalizationDesignRejectParams::RejectionReasons)
         }
        def rejection_reasons=(_rejection_reasons); end
        sig {
          params(expand: T.nilable(T::Array[String]), rejection_reasons: TestHelpers::Issuing::PersonalizationDesignRejectParams::RejectionReasons).void
         }
        def initialize(expand: nil, rejection_reasons: nil); end
      end
    end
  end
end