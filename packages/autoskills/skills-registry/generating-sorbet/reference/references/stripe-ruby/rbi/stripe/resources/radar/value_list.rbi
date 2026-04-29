# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Radar
    # Value lists allow you to group values together which can then be referenced in rules.
    #
    # Related guide: [Default Stripe lists](https://docs.stripe.com/radar/lists#managing-list-items)
    class ValueList < APIResource
      # The name of the value list for use in rules.
      sig { returns(String) }
      def alias; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # The name or email address of the user who created this value list.
      sig { returns(String) }
      def created_by; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # The type of items in the value list. One of `card_fingerprint`, `card_bin`, `email`, `ip_address`, `country`, `string`, `case_sensitive_string`, `customer_id`, `sepa_debit_fingerprint`, or `us_bank_account_fingerprint`.
      sig { returns(String) }
      def item_type; end
      # List of items contained within this value list.
      sig { returns(::Stripe::ListObject) }
      def list_items; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T::Hash[String, String]) }
      def metadata; end
      # The name of the value list.
      sig { returns(String) }
      def name; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Always true for a deleted object
      sig { returns(T.nilable(T::Boolean)) }
      def deleted; end
      # Creates a new ValueList object, which can then be referenced in rules.
      sig {
        params(params: T.any(::Stripe::Radar::ValueListCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Radar::ValueList)
       }
      def self.create(params = {}, opts = {}); end

      # Deletes a ValueList object, also deleting any items contained within the value list. To be deleted, a value list must not be referenced in any rules.
      sig {
        params(value_list: String, params: T.any(::Stripe::Radar::ValueListDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Radar::ValueList)
       }
      def self.delete(value_list, params = {}, opts = {}); end

      # Deletes a ValueList object, also deleting any items contained within the value list. To be deleted, a value list must not be referenced in any rules.
      sig {
        params(params: T.any(::Stripe::Radar::ValueListDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Radar::ValueList)
       }
      def delete(params = {}, opts = {}); end

      # Returns a list of ValueList objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
      sig {
        params(params: T.any(::Stripe::Radar::ValueListListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Updates a ValueList object by setting the values of the parameters passed. Any parameters not provided will be left unchanged. Note that item_type is immutable.
      sig {
        params(value_list: String, params: T.any(::Stripe::Radar::ValueListUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Radar::ValueList)
       }
      def self.update(value_list, params = {}, opts = {}); end
    end
  end
end