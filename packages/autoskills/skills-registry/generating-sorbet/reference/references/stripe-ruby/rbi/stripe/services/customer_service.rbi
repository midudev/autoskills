# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CustomerService < StripeService
    attr_reader :balance_transactions
    attr_reader :cash_balance
    attr_reader :cash_balance_transactions
    attr_reader :funding_instructions
    attr_reader :payment_methods
    attr_reader :payment_sources
    attr_reader :tax_ids
    # Creates a new customer object.
    sig {
      params(params: T.any(::Stripe::CustomerCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Customer)
     }
    def create(params = {}, opts = {}); end

    # Permanently deletes a customer. It cannot be undone. Also immediately cancels any active subscriptions on the customer.
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Customer)
     }
    def delete(customer, params = {}, opts = {}); end

    # Removes the currently applied discount on a customer.
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerDeleteDiscountParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Discount)
     }
    def delete_discount(customer, params = {}, opts = {}); end

    # Returns a list of your customers. The customers are returned sorted by creation date, with the most recent customers appearing first.
    sig {
      params(params: T.any(::Stripe::CustomerListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves a Customer object.
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Customer)
     }
    def retrieve(customer, params = {}, opts = {}); end

    # Search for customers you've previously created using Stripe's [Search Query Language](https://docs.stripe.com/docs/search#search-query-language).
    # Don't use search in read-after-write flows where strict consistency is necessary. Under normal operating
    # conditions, data is searchable in less than a minute. Occasionally, propagation of new or updated data can be up
    # to an hour behind during outages. Search functionality is not available to merchants in India.
    sig {
      params(params: T.any(::Stripe::CustomerSearchParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SearchResultObject)
     }
    def search(params = {}, opts = {}); end

    # Updates the specified customer by setting the values of the parameters passed. Any parameters not provided will be left unchanged. For example, if you pass the source parameter, that becomes the customer's active source (e.g., a card) to be used for all charges in the future. When you update a customer to a new valid card source by passing the source parameter: for each of the customer's current subscriptions, if the subscription bills automatically and is in the past_due state, then the latest open invoice for the subscription with automatic collection enabled will be retried. This retry will not count as an automatic retry, and will not affect the next regularly scheduled payment for the invoice. Changing the default_source for a customer will not trigger this behavior.
    #
    # This request accepts mostly the same arguments as the customer creation call.
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Customer)
     }
    def update(customer, params = {}, opts = {}); end
  end
end