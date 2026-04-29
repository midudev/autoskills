# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Reporting
    class ReportRunCreateParams < ::Stripe::RequestParams
      class Parameters < ::Stripe::RequestParams
        # The set of report columns to include in the report output. If omitted, the Report Type is run with its default column set.
        sig { returns(T.nilable(T::Array[String])) }
        def columns; end
        sig { params(_columns: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
        def columns=(_columns); end
        # Connected account ID to filter for in the report run.
        sig { returns(T.nilable(String)) }
        def connected_account; end
        sig { params(_connected_account: T.nilable(String)).returns(T.nilable(String)) }
        def connected_account=(_connected_account); end
        # Currency of objects to be included in the report run.
        sig { returns(T.nilable(String)) }
        def currency; end
        sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
        def currency=(_currency); end
        # Ending timestamp of data to be included in the report run (exclusive).
        sig { returns(T.nilable(Integer)) }
        def interval_end; end
        sig { params(_interval_end: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def interval_end=(_interval_end); end
        # Starting timestamp of data to be included in the report run.
        sig { returns(T.nilable(Integer)) }
        def interval_start; end
        sig { params(_interval_start: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def interval_start=(_interval_start); end
        # Payout ID by which to filter the report run.
        sig { returns(T.nilable(String)) }
        def payout; end
        sig { params(_payout: T.nilable(String)).returns(T.nilable(String)) }
        def payout=(_payout); end
        # Category of balance transactions to be included in the report run.
        sig { returns(T.nilable(String)) }
        def reporting_category; end
        sig { params(_reporting_category: T.nilable(String)).returns(T.nilable(String)) }
        def reporting_category=(_reporting_category); end
        # Defaults to `Etc/UTC`. The output timezone for all timestamps in the report. A list of possible time zone values is maintained at the [IANA Time Zone Database](http://www.iana.org/time-zones). Has no effect on `interval_start` or `interval_end`.
        sig { returns(T.nilable(String)) }
        def timezone; end
        sig { params(_timezone: T.nilable(String)).returns(T.nilable(String)) }
        def timezone=(_timezone); end
        sig {
          params(columns: T.nilable(T::Array[String]), connected_account: T.nilable(String), currency: T.nilable(String), interval_end: T.nilable(Integer), interval_start: T.nilable(Integer), payout: T.nilable(String), reporting_category: T.nilable(String), timezone: T.nilable(String)).void
         }
        def initialize(
          columns: nil,
          connected_account: nil,
          currency: nil,
          interval_end: nil,
          interval_start: nil,
          payout: nil,
          reporting_category: nil,
          timezone: nil
        ); end
      end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Parameters specifying how the report should be run. Different Report Types have different required and optional parameters, listed in the [API Access to Reports](https://docs.stripe.com/reporting/statements/api) documentation.
      sig { returns(T.nilable(Reporting::ReportRunCreateParams::Parameters)) }
      def parameters; end
      sig {
        params(_parameters: T.nilable(Reporting::ReportRunCreateParams::Parameters)).returns(T.nilable(Reporting::ReportRunCreateParams::Parameters))
       }
      def parameters=(_parameters); end
      # The ID of the [report type](https://docs.stripe.com/reporting/statements/api#report-types) to run, such as `"balance.summary.1"`.
      sig { returns(String) }
      def report_type; end
      sig { params(_report_type: String).returns(String) }
      def report_type=(_report_type); end
      sig {
        params(expand: T.nilable(T::Array[String]), parameters: T.nilable(Reporting::ReportRunCreateParams::Parameters), report_type: String).void
       }
      def initialize(expand: nil, parameters: nil, report_type: nil); end
    end
  end
end