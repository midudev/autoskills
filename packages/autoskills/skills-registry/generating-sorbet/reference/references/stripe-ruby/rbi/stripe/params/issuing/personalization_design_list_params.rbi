# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class PersonalizationDesignListParams < ::Stripe::RequestParams
      class Preferences < ::Stripe::RequestParams
        # Only return the personalization design that's set as the default. A connected account uses the Connect platform's default design if no personalization design is set as the default.
        sig { returns(T.nilable(T::Boolean)) }
        def is_default; end
        sig { params(_is_default: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def is_default=(_is_default); end
        # Only return the personalization design that is set as the Connect platform's default. This parameter is only applicable to connected accounts.
        sig { returns(T.nilable(T::Boolean)) }
        def is_platform_default; end
        sig { params(_is_platform_default: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def is_platform_default=(_is_platform_default); end
        sig {
          params(is_default: T.nilable(T::Boolean), is_platform_default: T.nilable(T::Boolean)).void
         }
        def initialize(is_default: nil, is_platform_default: nil); end
      end
      # A cursor for use in pagination. `ending_before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with `obj_bar`, your subsequent call can include `ending_before=obj_bar` in order to fetch the previous page of the list.
      sig { returns(T.nilable(String)) }
      def ending_before; end
      sig { params(_ending_before: T.nilable(String)).returns(T.nilable(String)) }
      def ending_before=(_ending_before); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
      sig { returns(T.nilable(Integer)) }
      def limit; end
      sig { params(_limit: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def limit=(_limit); end
      # Only return personalization designs with the given lookup keys.
      sig { returns(T.nilable(T::Array[String])) }
      def lookup_keys; end
      sig { params(_lookup_keys: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def lookup_keys=(_lookup_keys); end
      # Only return personalization designs with the given preferences.
      sig { returns(T.nilable(Issuing::PersonalizationDesignListParams::Preferences)) }
      def preferences; end
      sig {
        params(_preferences: T.nilable(Issuing::PersonalizationDesignListParams::Preferences)).returns(T.nilable(Issuing::PersonalizationDesignListParams::Preferences))
       }
      def preferences=(_preferences); end
      # A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
      sig { returns(T.nilable(String)) }
      def starting_after; end
      sig { params(_starting_after: T.nilable(String)).returns(T.nilable(String)) }
      def starting_after=(_starting_after); end
      # Only return personalization designs with the given status.
      sig { returns(T.nilable(String)) }
      def status; end
      sig { params(_status: T.nilable(String)).returns(T.nilable(String)) }
      def status=(_status); end
      sig {
        params(ending_before: T.nilable(String), expand: T.nilable(T::Array[String]), limit: T.nilable(Integer), lookup_keys: T.nilable(T::Array[String]), preferences: T.nilable(Issuing::PersonalizationDesignListParams::Preferences), starting_after: T.nilable(String), status: T.nilable(String)).void
       }
      def initialize(
        ending_before: nil,
        expand: nil,
        limit: nil,
        lookup_keys: nil,
        preferences: nil,
        starting_after: nil,
        status: nil
      ); end
    end
  end
end