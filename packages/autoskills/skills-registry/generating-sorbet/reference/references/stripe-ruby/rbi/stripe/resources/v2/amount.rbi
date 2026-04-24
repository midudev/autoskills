# frozen_string_literal: true
# typed: true

module Stripe
  module V2
    class Amount
      sig { returns(Integer) }
      attr_reader :value

      sig { returns(String) }
      attr_reader :currency
    end
  end
end