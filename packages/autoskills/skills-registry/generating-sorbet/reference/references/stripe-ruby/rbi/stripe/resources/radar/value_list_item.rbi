# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Radar
    # Value list items allow you to add specific values to a given Radar value list, which can then be used in rules.
    #
    # Related guide: [Managing list items](https://docs.stripe.com/radar/lists#managing-list-items)
    class ValueListItem < APIResource
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # The name or email address of the user who added this item to the value list.
      sig { returns(String) }
      def created_by; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The value of the item.
      sig { returns(String) }
      def value; end
      # The identifier of the value list this item belongs to.
      sig { returns(String) }
      def value_list; end
      # Always true for a deleted object
      sig { returns(T.nilable(T::Boolean)) }
      def deleted; end
      # Creates a new ValueListItem object, which is added to the specified parent value list.
      sig {
        params(params: T.any(::Stripe::Radar::ValueListItemCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Radar::ValueListItem)
       }
      def self.create(params = {}, opts = {}); end

      # Deletes a ValueListItem object, removing it from its parent value list.
      sig {
        params(item: String, params: T.any(::Stripe::Radar::ValueListItemDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Radar::ValueListItem)
       }
      def self.delete(item, params = {}, opts = {}); end

      # Deletes a ValueListItem object, removing it from its parent value list.
      sig {
        params(params: T.any(::Stripe::Radar::ValueListItemDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Radar::ValueListItem)
       }
      def delete(params = {}, opts = {}); end

      # Returns a list of ValueListItem objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
      sig {
        params(params: T.any(::Stripe::Radar::ValueListItemListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end