# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      module Accounts
        class PersonListParams < ::Stripe::RequestParams
          # The upper limit on the number of accounts returned by the List Account request.
          sig { returns(T.nilable(Integer)) }
          def limit; end
          sig { params(_limit: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def limit=(_limit); end
          sig { params(limit: T.nilable(Integer)).void }
          def initialize(limit: nil); end
        end
      end
    end
  end
end