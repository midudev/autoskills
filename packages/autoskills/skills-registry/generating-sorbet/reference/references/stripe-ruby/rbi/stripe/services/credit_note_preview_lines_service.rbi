# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CreditNotePreviewLinesService < StripeService
    # When retrieving a credit note preview, you'll get a lines property containing the first handful of those items. This URL you can retrieve the full (paginated) list of line items.
    sig {
      params(params: T.any(::Stripe::CreditNotePreviewLinesListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end
  end
end