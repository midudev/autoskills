# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    class DeletedObject < APIResource
      # String representing the type of the object that has been deleted. Objects of the same type share the same value of the object field.
      sig { returns(T.nilable(String)) }
      def object; end
      # The ID of the object that's being deleted.
      sig { returns(String) }
      def id; end
    end
  end
end