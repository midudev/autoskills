# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class TaxDeductedAtSource < APIResource
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The end of the invoicing period. This TDS applies to Stripe fees collected during this invoicing period.
    sig { returns(Integer) }
    def period_end; end
    # The start of the invoicing period. This TDS applies to Stripe fees collected during this invoicing period.
    sig { returns(Integer) }
    def period_start; end
    # The TAN that was supplied to Stripe when TDS was assessed
    sig { returns(String) }
    def tax_deduction_account_number; end
  end
end