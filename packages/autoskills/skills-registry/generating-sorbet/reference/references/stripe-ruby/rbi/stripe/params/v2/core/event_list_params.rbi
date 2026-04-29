# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      class EventListParams < ::Stripe::RequestParams
        class Created < ::Stripe::RequestParams
          # Filter for events created after the specified timestamp.
          sig { returns(T.nilable(String)) }
          def gt; end
          sig { params(_gt: T.nilable(String)).returns(T.nilable(String)) }
          def gt=(_gt); end
          # Filter for events created at or after the specified timestamp.
          sig { returns(T.nilable(String)) }
          def gte; end
          sig { params(_gte: T.nilable(String)).returns(T.nilable(String)) }
          def gte=(_gte); end
          # Filter for events created before the specified timestamp.
          sig { returns(T.nilable(String)) }
          def lt; end
          sig { params(_lt: T.nilable(String)).returns(T.nilable(String)) }
          def lt=(_lt); end
          # Filter for events created at or before the specified timestamp.
          sig { returns(T.nilable(String)) }
          def lte; end
          sig { params(_lte: T.nilable(String)).returns(T.nilable(String)) }
          def lte=(_lte); end
          sig {
            params(gt: T.nilable(String), gte: T.nilable(String), lt: T.nilable(String), lte: T.nilable(String)).void
           }
          def initialize(gt: nil, gte: nil, lt: nil, lte: nil); end
        end
        # Set of filters to query events within a range of `created` timestamps.
        sig { returns(T.nilable(V2::Core::EventListParams::Created)) }
        def created; end
        sig {
          params(_created: T.nilable(V2::Core::EventListParams::Created)).returns(T.nilable(V2::Core::EventListParams::Created))
         }
        def created=(_created); end
        # The page size.
        sig { returns(T.nilable(Integer)) }
        def limit; end
        sig { params(_limit: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def limit=(_limit); end
        # Primary object ID used to retrieve related events.
        #
        # To avoid conflict with Ruby's ':object_id', this attribute has been renamed. If using a hash parameter map instead, please use the original name ':object_id' with NO trailing underscore as the provided param key.
        sig { returns(T.nilable(String)) }
        def object_id_; end
        sig { params(_object_id_: T.nilable(String)).returns(T.nilable(String)) }
        def object_id_=(_object_id_); end
        # An array of up to 20 strings containing specific event names.
        sig { returns(T.nilable(T::Array[String])) }
        def types; end
        sig { params(_types: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
        def types=(_types); end
        sig {
          params(created: T.nilable(V2::Core::EventListParams::Created), limit: T.nilable(Integer), object_id_: T.nilable(String), types: T.nilable(T::Array[String])).void
         }
        def initialize(created: nil, limit: nil, object_id_: nil, types: nil); end
      end
    end
  end
end