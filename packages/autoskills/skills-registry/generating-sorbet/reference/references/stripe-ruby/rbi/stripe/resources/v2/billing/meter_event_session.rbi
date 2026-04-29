# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Billing
      class MeterEventSession < APIResource
        # The authentication token for this session.  Use this token when calling the
        # high-throughput meter event API.
        sig { returns(String) }
        def authentication_token; end
        # The creation time of this session.
        sig { returns(String) }
        def created; end
        # The time at which this session will expire.
        sig { returns(String) }
        def expires_at; end
        # The unique id of this auth session.
        sig { returns(String) }
        def id; end
        # String representing the object's type. Objects of the same type share the same value of the object field.
        sig { returns(String) }
        def object; end
        # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        sig { returns(T::Boolean) }
        def livemode; end
      end
    end
  end
end