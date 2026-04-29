# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    module Terminal
      class ReaderSucceedInputCollectionParams < ::Stripe::RequestParams
        # Specifies which fields in the response should be expanded.
        sig { returns(T.nilable(T::Array[String])) }
        def expand; end
        sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
        def expand=(_expand); end
        # This parameter defines the skip behavior for input collection.
        sig { returns(T.nilable(String)) }
        def skip_non_required_inputs; end
        sig { params(_skip_non_required_inputs: T.nilable(String)).returns(T.nilable(String)) }
        def skip_non_required_inputs=(_skip_non_required_inputs); end
        sig {
          params(expand: T.nilable(T::Array[String]), skip_non_required_inputs: T.nilable(String)).void
         }
        def initialize(expand: nil, skip_non_required_inputs: nil); end
      end
    end
  end
end