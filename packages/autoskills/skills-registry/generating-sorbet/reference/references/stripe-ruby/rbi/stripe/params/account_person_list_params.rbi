# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class AccountPersonListParams < ::Stripe::RequestParams
    class Relationship < ::Stripe::RequestParams
      # A filter on the list of people returned based on whether these people are authorizers of the account's representative.
      sig { returns(T.nilable(T::Boolean)) }
      def authorizer; end
      sig { params(_authorizer: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def authorizer=(_authorizer); end
      # A filter on the list of people returned based on whether these people are directors of the account's company.
      sig { returns(T.nilable(T::Boolean)) }
      def director; end
      sig { params(_director: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def director=(_director); end
      # A filter on the list of people returned based on whether these people are executives of the account's company.
      sig { returns(T.nilable(T::Boolean)) }
      def executive; end
      sig { params(_executive: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def executive=(_executive); end
      # A filter on the list of people returned based on whether these people are legal guardians of the account's representative.
      sig { returns(T.nilable(T::Boolean)) }
      def legal_guardian; end
      sig { params(_legal_guardian: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def legal_guardian=(_legal_guardian); end
      # A filter on the list of people returned based on whether these people are owners of the account's company.
      sig { returns(T.nilable(T::Boolean)) }
      def owner; end
      sig { params(_owner: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def owner=(_owner); end
      # A filter on the list of people returned based on whether these people are the representative of the account's company.
      sig { returns(T.nilable(T::Boolean)) }
      def representative; end
      sig { params(_representative: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def representative=(_representative); end
      sig {
        params(authorizer: T.nilable(T::Boolean), director: T.nilable(T::Boolean), executive: T.nilable(T::Boolean), legal_guardian: T.nilable(T::Boolean), owner: T.nilable(T::Boolean), representative: T.nilable(T::Boolean)).void
       }
      def initialize(
        authorizer: nil,
        director: nil,
        executive: nil,
        legal_guardian: nil,
        owner: nil,
        representative: nil
      ); end
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
    # Filters on the list of people returned based on the person's relationship to the account's company.
    sig { returns(T.nilable(AccountPersonListParams::Relationship)) }
    def relationship; end
    sig {
      params(_relationship: T.nilable(AccountPersonListParams::Relationship)).returns(T.nilable(AccountPersonListParams::Relationship))
     }
    def relationship=(_relationship); end
    # A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
    sig { returns(T.nilable(String)) }
    def starting_after; end
    sig { params(_starting_after: T.nilable(String)).returns(T.nilable(String)) }
    def starting_after=(_starting_after); end
    sig {
      params(ending_before: T.nilable(String), expand: T.nilable(T::Array[String]), limit: T.nilable(Integer), relationship: T.nilable(AccountPersonListParams::Relationship), starting_after: T.nilable(String)).void
     }
    def initialize(
      ending_before: nil,
      expand: nil,
      limit: nil,
      relationship: nil,
      starting_after: nil
    ); end
  end
end