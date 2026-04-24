# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class Application < APIResource
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # The name of the application.
    sig { returns(T.nilable(String)) }
    def name; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Always true for a deleted object
    sig { returns(T.nilable(T::Boolean)) }
    def deleted; end
  end
end