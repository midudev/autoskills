# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Reporting
    # The Report Type resource corresponds to a particular type of report, such as
    # the "Activity summary" or "Itemized payouts" reports. These objects are
    # identified by an ID belonging to a set of enumerated values. See
    # [API Access to Reports documentation](https://docs.stripe.com/reporting/statements/api)
    # for those Report Type IDs, along with required and optional parameters.
    #
    # Note that certain report types can only be run based on your live-mode data (not test-mode
    # data), and will error when queried without a [live-mode API key](https://docs.stripe.com/keys#test-live-modes).
    class ReportType < APIResource
      # Most recent time for which this Report Type is available. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def data_available_end; end
      # Earliest time for which this Report Type is available. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def data_available_start; end
      # List of column names that are included by default when this Report Type gets run. (If the Report Type doesn't support the `columns` parameter, this will be null.)
      sig { returns(T.nilable(T::Array[String])) }
      def default_columns; end
      # The [ID of the Report Type](https://docs.stripe.com/reporting/statements/api#available-report-types), such as `balance.summary.1`.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # Human-readable name of the Report Type
      sig { returns(String) }
      def name; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # When this Report Type was latest updated. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def updated; end
      # Version of the Report Type. Different versions report with the same ID will have the same purpose, but may take different run parameters or have different result schemas.
      sig { returns(Integer) }
      def version; end
      # Returns a full list of Report Types.
      sig {
        params(params: T.any(::Stripe::Reporting::ReportTypeListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end