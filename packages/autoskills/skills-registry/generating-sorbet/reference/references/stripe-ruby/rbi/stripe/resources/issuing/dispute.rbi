# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    # As a [card issuer](https://docs.stripe.com/issuing), you can dispute transactions that the cardholder does not recognize, suspects to be fraudulent, or has other issues with.
    #
    # Related guide: [Issuing disputes](https://docs.stripe.com/issuing/purchases/disputes)
    class Dispute < APIResource
      class Evidence < ::Stripe::StripeObject
        class Canceled < ::Stripe::StripeObject
          # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Additional documentation supporting the dispute.
          sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
          def additional_documentation; end
          # Date when order was canceled.
          sig { returns(T.nilable(Integer)) }
          def canceled_at; end
          # Whether the cardholder was provided with a cancellation policy.
          sig { returns(T.nilable(T::Boolean)) }
          def cancellation_policy_provided; end
          # Reason for canceling the order.
          sig { returns(T.nilable(String)) }
          def cancellation_reason; end
          # Date when the cardholder expected to receive the product.
          sig { returns(T.nilable(Integer)) }
          def expected_at; end
          # Explanation of why the cardholder is disputing this transaction.
          sig { returns(T.nilable(String)) }
          def explanation; end
          # Description of the merchandise or service that was purchased.
          sig { returns(T.nilable(String)) }
          def product_description; end
          # Whether the product was a merchandise or service.
          sig { returns(T.nilable(String)) }
          def product_type; end
          # Result of cardholder's attempt to return the product.
          sig { returns(T.nilable(String)) }
          def return_status; end
          # Date when the product was returned or attempted to be returned.
          sig { returns(T.nilable(Integer)) }
          def returned_at; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Duplicate < ::Stripe::StripeObject
          # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Additional documentation supporting the dispute.
          sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
          def additional_documentation; end
          # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Copy of the card statement showing that the product had already been paid for.
          sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
          def card_statement; end
          # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Copy of the receipt showing that the product had been paid for in cash.
          sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
          def cash_receipt; end
          # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Image of the front and back of the check that was used to pay for the product.
          sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
          def check_image; end
          # Explanation of why the cardholder is disputing this transaction.
          sig { returns(T.nilable(String)) }
          def explanation; end
          # Transaction (e.g., ipi_...) that the disputed transaction is a duplicate of. Of the two or more transactions that are copies of each other, this is original undisputed one.
          sig { returns(T.nilable(String)) }
          def original_transaction; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Fraudulent < ::Stripe::StripeObject
          # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Additional documentation supporting the dispute.
          sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
          def additional_documentation; end
          # Explanation of why the cardholder is disputing this transaction.
          sig { returns(T.nilable(String)) }
          def explanation; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class MerchandiseNotAsDescribed < ::Stripe::StripeObject
          # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Additional documentation supporting the dispute.
          sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
          def additional_documentation; end
          # Explanation of why the cardholder is disputing this transaction.
          sig { returns(T.nilable(String)) }
          def explanation; end
          # Date when the product was received.
          sig { returns(T.nilable(Integer)) }
          def received_at; end
          # Description of the cardholder's attempt to return the product.
          sig { returns(T.nilable(String)) }
          def return_description; end
          # Result of cardholder's attempt to return the product.
          sig { returns(T.nilable(String)) }
          def return_status; end
          # Date when the product was returned or attempted to be returned.
          sig { returns(T.nilable(Integer)) }
          def returned_at; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class NoValidAuthorization < ::Stripe::StripeObject
          # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Additional documentation supporting the dispute.
          sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
          def additional_documentation; end
          # Explanation of why the cardholder is disputing this transaction.
          sig { returns(T.nilable(String)) }
          def explanation; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class NotReceived < ::Stripe::StripeObject
          # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Additional documentation supporting the dispute.
          sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
          def additional_documentation; end
          # Date when the cardholder expected to receive the product.
          sig { returns(T.nilable(Integer)) }
          def expected_at; end
          # Explanation of why the cardholder is disputing this transaction.
          sig { returns(T.nilable(String)) }
          def explanation; end
          # Description of the merchandise or service that was purchased.
          sig { returns(T.nilable(String)) }
          def product_description; end
          # Whether the product was a merchandise or service.
          sig { returns(T.nilable(String)) }
          def product_type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Other < ::Stripe::StripeObject
          # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Additional documentation supporting the dispute.
          sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
          def additional_documentation; end
          # Explanation of why the cardholder is disputing this transaction.
          sig { returns(T.nilable(String)) }
          def explanation; end
          # Description of the merchandise or service that was purchased.
          sig { returns(T.nilable(String)) }
          def product_description; end
          # Whether the product was a merchandise or service.
          sig { returns(T.nilable(String)) }
          def product_type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class ServiceNotAsDescribed < ::Stripe::StripeObject
          # (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Additional documentation supporting the dispute.
          sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
          def additional_documentation; end
          # Date when order was canceled.
          sig { returns(T.nilable(Integer)) }
          def canceled_at; end
          # Reason for canceling the order.
          sig { returns(T.nilable(String)) }
          def cancellation_reason; end
          # Explanation of why the cardholder is disputing this transaction.
          sig { returns(T.nilable(String)) }
          def explanation; end
          # Date when the product was received.
          sig { returns(T.nilable(Integer)) }
          def received_at; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field canceled
        sig { returns(T.nilable(Canceled)) }
        def canceled; end
        # Attribute for field duplicate
        sig { returns(T.nilable(Duplicate)) }
        def duplicate; end
        # Attribute for field fraudulent
        sig { returns(T.nilable(Fraudulent)) }
        def fraudulent; end
        # Attribute for field merchandise_not_as_described
        sig { returns(T.nilable(MerchandiseNotAsDescribed)) }
        def merchandise_not_as_described; end
        # Attribute for field no_valid_authorization
        sig { returns(T.nilable(NoValidAuthorization)) }
        def no_valid_authorization; end
        # Attribute for field not_received
        sig { returns(T.nilable(NotReceived)) }
        def not_received; end
        # Attribute for field other
        sig { returns(T.nilable(Other)) }
        def other; end
        # The reason for filing the dispute. Its value will match the field containing the evidence.
        sig { returns(String) }
        def reason; end
        # Attribute for field service_not_as_described
        sig { returns(T.nilable(ServiceNotAsDescribed)) }
        def service_not_as_described; end
        def self.inner_class_types
          @inner_class_types = {
            canceled: Canceled,
            duplicate: Duplicate,
            fraudulent: Fraudulent,
            merchandise_not_as_described: MerchandiseNotAsDescribed,
            no_valid_authorization: NoValidAuthorization,
            not_received: NotReceived,
            other: Other,
            service_not_as_described: ServiceNotAsDescribed,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Treasury < ::Stripe::StripeObject
        # The Treasury [DebitReversal](https://docs.stripe.com/api/treasury/debit_reversals) representing this Issuing dispute
        sig { returns(T.nilable(String)) }
        def debit_reversal; end
        # The Treasury [ReceivedDebit](https://docs.stripe.com/api/treasury/received_debits) that is being disputed.
        sig { returns(String) }
        def received_debit; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Disputed amount in the card's currency and in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal). Usually the amount of the `transaction`, but can differ (usually because of currency fluctuation).
      sig { returns(Integer) }
      def amount; end
      # List of balance transactions associated with the dispute.
      sig { returns(T.nilable(T::Array[::Stripe::BalanceTransaction])) }
      def balance_transactions; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # The currency the `transaction` was made in.
      sig { returns(String) }
      def currency; end
      # Attribute for field evidence
      sig { returns(Evidence) }
      def evidence; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # The enum that describes the dispute loss outcome. If the dispute is not lost, this field will be absent. New enum values may be added in the future, so be sure to handle unknown values.
      sig { returns(T.nilable(String)) }
      def loss_reason; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T::Hash[String, String]) }
      def metadata; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Current status of the dispute.
      sig { returns(String) }
      def status; end
      # The transaction being disputed.
      sig { returns(T.any(String, ::Stripe::Issuing::Transaction)) }
      def transaction; end
      # [Treasury](https://docs.stripe.com/api/treasury) details related to this dispute if it was created on a [FinancialAccount](/docs/api/treasury/financial_accounts
      sig { returns(T.nilable(Treasury)) }
      def treasury; end
      # Creates an Issuing Dispute object. Individual pieces of evidence within the evidence object are optional at this point. Stripe only validates that required evidence is present during submission. Refer to [Dispute reasons and evidence](https://docs.stripe.com/docs/issuing/purchases/disputes#dispute-reasons-and-evidence) for more details about evidence requirements.
      sig {
        params(params: T.any(::Stripe::Issuing::DisputeCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Dispute)
       }
      def self.create(params = {}, opts = {}); end

      # Returns a list of Issuing Dispute objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
      sig {
        params(params: T.any(::Stripe::Issuing::DisputeListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Submits an Issuing Dispute to the card network. Stripe validates that all evidence fields required for the dispute's reason are present. For more details, see [Dispute reasons and evidence](https://docs.stripe.com/docs/issuing/purchases/disputes#dispute-reasons-and-evidence).
      sig {
        params(params: T.any(::Stripe::Issuing::DisputeSubmitParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Dispute)
       }
      def submit(params = {}, opts = {}); end

      # Submits an Issuing Dispute to the card network. Stripe validates that all evidence fields required for the dispute's reason are present. For more details, see [Dispute reasons and evidence](https://docs.stripe.com/docs/issuing/purchases/disputes#dispute-reasons-and-evidence).
      sig {
        params(dispute: String, params: T.any(::Stripe::Issuing::DisputeSubmitParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Dispute)
       }
      def self.submit(dispute, params = {}, opts = {}); end

      # Updates the specified Issuing Dispute object by setting the values of the parameters passed. Any parameters not provided will be left unchanged. Properties on the evidence object can be unset by passing in an empty string.
      sig {
        params(dispute: String, params: T.any(::Stripe::Issuing::DisputeUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Dispute)
       }
      def self.update(dispute, params = {}, opts = {}); end
    end
  end
end