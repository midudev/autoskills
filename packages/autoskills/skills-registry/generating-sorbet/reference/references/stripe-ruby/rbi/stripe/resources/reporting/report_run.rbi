# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Reporting
    # The Report Run object represents an instance of a report type generated with
    # specific run parameters. Once the object is created, Stripe begins processing the report.
    # When the report has finished running, it will give you a reference to a file
    # where you can retrieve your results. For an overview, see
    # [API Access to Reports](https://docs.stripe.com/reporting/statements/api).
    #
    # Note that certain report types can only be run based on your live-mode data (not test-mode
    # data), and will error when queried without a [live-mode API key](https://docs.stripe.com/keys#test-live-modes).
    class ReportRun < APIResource
      class Parameters < ::Stripe::StripeObject
        # The set of output columns requested for inclusion in the report run.
        sig { returns(T.nilable(T::Array[String])) }
        def columns; end
        # Connected account ID by which to filter the report run.
        sig { returns(T.nilable(String)) }
        def connected_account; end
        # Currency of objects to be included in the report run.
        sig { returns(T.nilable(String)) }
        def currency; end
        # Ending timestamp of data to be included in the report run. Can be any UTC timestamp between 1 second after the user specified `interval_start` and 1 second before this report's last `data_available_end` value.
        sig { returns(T.nilable(Integer)) }
        def interval_end; end
        # Starting timestamp of data to be included in the report run. Can be any UTC timestamp between 1 second after this report's `data_available_start` and 1 second before the user specified `interval_end` value.
        sig { returns(T.nilable(Integer)) }
        def interval_start; end
        # Payout ID by which to filter the report run.
        sig { returns(T.nilable(String)) }
        def payout; end
        # Category of balance transactions to be included in the report run.
        sig { returns(T.nilable(String)) }
        def reporting_category; end
        # Defaults to `Etc/UTC`. The output timezone for all timestamps in the report. A list of possible time zone values is maintained at the [IANA Time Zone Database](http://www.iana.org/time-zones). Has no effect on `interval_start` or `interval_end`.
        sig { returns(T.nilable(String)) }
        def timezone; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # If something should go wrong during the run, a message about the failure (populated when
      #  `status=failed`).
      sig { returns(T.nilable(String)) }
      def error; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # `true` if the report is run on live mode data and `false` if it is run on test mode data.
      sig { returns(T::Boolean) }
      def livemode; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Attribute for field parameters
      sig { returns(Parameters) }
      def parameters; end
      # The ID of the [report type](https://docs.stripe.com/reports/report-types) to run, such as `"balance.summary.1"`.
      sig { returns(String) }
      def report_type; end
      # The file object representing the result of the report run (populated when
      #  `status=succeeded`).
      sig { returns(T.nilable(::Stripe::File)) }
      def result; end
      # Status of this report run. This will be `pending` when the run is initially created.
      #  When the run finishes, this will be set to `succeeded` and the `result` field will be populated.
      #  Rarely, we may encounter an error, at which point this will be set to `failed` and the `error` field will be populated.
      sig { returns(String) }
      def status; end
      # Timestamp at which this run successfully finished (populated when
      #  `status=succeeded`). Measured in seconds since the Unix epoch.
      sig { returns(T.nilable(Integer)) }
      def succeeded_at; end
      # Creates a new object and begin running the report. (Certain report types require a [live-mode API key](https://stripe.com/docs/keys#test-live-modes).)
      sig {
        params(params: T.any(::Stripe::Reporting::ReportRunCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Reporting::ReportRun)
       }
      def self.create(params = {}, opts = {}); end

      # Returns a list of Report Runs, with the most recent appearing first.
      sig {
        params(params: T.any(::Stripe::Reporting::ReportRunListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end