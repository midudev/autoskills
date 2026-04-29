# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class QuoteService < StripeService
    attr_reader :computed_upfront_line_items
    attr_reader :line_items
    # Accepts the specified quote.
    sig {
      params(quote: String, params: T.any(::Stripe::QuoteAcceptParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Quote)
     }
    def accept(quote, params = {}, opts = {}); end

    # Cancels the quote.
    sig {
      params(quote: String, params: T.any(::Stripe::QuoteCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Quote)
     }
    def cancel(quote, params = {}, opts = {}); end

    # A quote models prices and services for a customer. Default options for header, description, footer, and expires_at can be set in the dashboard via the [quote template](https://dashboard.stripe.com/settings/billing/quote).
    sig {
      params(params: T.any(::Stripe::QuoteCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Quote)
     }
    def create(params = {}, opts = {}); end

    # Finalizes the quote.
    sig {
      params(quote: String, params: T.any(::Stripe::QuoteFinalizeQuoteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Quote)
     }
    def finalize_quote(quote, params = {}, opts = {}); end

    # Returns a list of your quotes.
    sig {
      params(params: T.any(::Stripe::QuoteListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Download the PDF for a finalized quote. Explanation for special handling can be found [here](https://docs.stripe.com/quotes/overview#quote_pdf)
    sig {
      params(quote: String, params: T.any(::Stripe::QuotePdfParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped, read_body_chunk_block: T.untyped).returns(T.untyped)
     }
    def pdf(quote, params = {}, opts = {}, &read_body_chunk_block); end

    # Retrieves the quote with the given ID.
    sig {
      params(quote: String, params: T.any(::Stripe::QuoteRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Quote)
     }
    def retrieve(quote, params = {}, opts = {}); end

    # A quote models prices and services for a customer.
    sig {
      params(quote: String, params: T.any(::Stripe::QuoteUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Quote)
     }
    def update(quote, params = {}, opts = {}); end
  end
end