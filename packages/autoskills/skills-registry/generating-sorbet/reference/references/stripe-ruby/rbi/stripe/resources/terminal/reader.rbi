# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    # A Reader represents a physical device for accepting payment details.
    #
    # Related guide: [Connecting to a reader](https://docs.stripe.com/terminal/payments/connect-reader)
    class Reader < APIResource
      class Action < ::Stripe::StripeObject
        class CollectInputs < ::Stripe::StripeObject
          class Input < ::Stripe::StripeObject
            class CustomText < ::Stripe::StripeObject
              # Customize the default description for this input
              sig { returns(T.nilable(String)) }
              def description; end
              # Customize the default label for this input's skip button
              sig { returns(T.nilable(String)) }
              def skip_button; end
              # Customize the default label for this input's submit button
              sig { returns(T.nilable(String)) }
              def submit_button; end
              # Customize the default title for this input
              sig { returns(T.nilable(String)) }
              def title; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Email < ::Stripe::StripeObject
              # The collected email address
              sig { returns(T.nilable(String)) }
              def value; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Numeric < ::Stripe::StripeObject
              # The collected number
              sig { returns(T.nilable(String)) }
              def value; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Phone < ::Stripe::StripeObject
              # The collected phone number
              sig { returns(T.nilable(String)) }
              def value; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Selection < ::Stripe::StripeObject
              class Choice < ::Stripe::StripeObject
                # The identifier for the selected choice. Maximum 50 characters.
                sig { returns(T.nilable(String)) }
                def id; end
                # The button style for the choice. Can be `primary` or `secondary`.
                sig { returns(T.nilable(String)) }
                def style; end
                # The text to be selected. Maximum 30 characters.
                sig { returns(String) }
                def text; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # List of possible choices to be selected
              sig { returns(T::Array[Choice]) }
              def choices; end
              # The id of the selected choice
              sig { returns(T.nilable(String)) }
              def id; end
              # The text of the selected choice
              sig { returns(T.nilable(String)) }
              def text; end
              def self.inner_class_types
                @inner_class_types = {choices: Choice}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Signature < ::Stripe::StripeObject
              # The File ID of a collected signature image
              sig { returns(T.nilable(String)) }
              def value; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Text < ::Stripe::StripeObject
              # The collected text value
              sig { returns(T.nilable(String)) }
              def value; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            class Toggle < ::Stripe::StripeObject
              # The toggle's default value. Can be `enabled` or `disabled`.
              sig { returns(T.nilable(String)) }
              def default_value; end
              # The toggle's description text. Maximum 50 characters.
              sig { returns(T.nilable(String)) }
              def description; end
              # The toggle's title text. Maximum 50 characters.
              sig { returns(T.nilable(String)) }
              def title; end
              # The toggle's collected value. Can be `enabled` or `disabled`.
              sig { returns(T.nilable(String)) }
              def value; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Default text of input being collected.
            sig { returns(T.nilable(CustomText)) }
            def custom_text; end
            # Information about a email being collected using a reader
            sig { returns(T.nilable(Email)) }
            def email; end
            # Information about a number being collected using a reader
            sig { returns(T.nilable(Numeric)) }
            def numeric; end
            # Information about a phone number being collected using a reader
            sig { returns(T.nilable(Phone)) }
            def phone; end
            # Indicate that this input is required, disabling the skip button.
            sig { returns(T.nilable(T::Boolean)) }
            def required; end
            # Information about a selection being collected using a reader
            sig { returns(T.nilable(Selection)) }
            def selection; end
            # Information about a signature being collected using a reader
            sig { returns(T.nilable(Signature)) }
            def signature; end
            # Indicate that this input was skipped by the user.
            sig { returns(T.nilable(T::Boolean)) }
            def skipped; end
            # Information about text being collected using a reader
            sig { returns(T.nilable(Text)) }
            def text; end
            # List of toggles being collected. Values are present if collection is complete.
            sig { returns(T.nilable(T::Array[Toggle])) }
            def toggles; end
            # Type of input being collected.
            sig { returns(String) }
            def type; end
            def self.inner_class_types
              @inner_class_types = {
                custom_text: CustomText,
                email: Email,
                numeric: Numeric,
                phone: Phone,
                selection: Selection,
                signature: Signature,
                text: Text,
                toggles: Toggle,
              }
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # List of inputs to be collected.
          sig { returns(T::Array[Input]) }
          def inputs; end
          # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
          sig { returns(T.nilable(T::Hash[String, String])) }
          def metadata; end
          def self.inner_class_types
            @inner_class_types = {inputs: Input}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class CollectPaymentMethod < ::Stripe::StripeObject
          class CollectConfig < ::Stripe::StripeObject
            class Tipping < ::Stripe::StripeObject
              # Amount used to calculate tip suggestions on tipping selection screen for this transaction. Must be a positive integer in the smallest currency unit (e.g., 100 cents to represent $1.00 or 100 to represent ¥100, a zero-decimal currency).
              sig { returns(T.nilable(Integer)) }
              def amount_eligible; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Enable customer-initiated cancellation when processing this payment.
            sig { returns(T.nilable(T::Boolean)) }
            def enable_customer_cancellation; end
            # Override showing a tipping selection screen on this transaction.
            sig { returns(T.nilable(T::Boolean)) }
            def skip_tipping; end
            # Represents a per-transaction tipping configuration
            sig { returns(T.nilable(Tipping)) }
            def tipping; end
            def self.inner_class_types
              @inner_class_types = {tipping: Tipping}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Represents a per-transaction override of a reader configuration
          sig { returns(T.nilable(CollectConfig)) }
          def collect_config; end
          # Most recent PaymentIntent processed by the reader.
          sig { returns(T.any(String, ::Stripe::PaymentIntent)) }
          def payment_intent; end
          # PaymentMethod objects represent your customer's payment instruments.
          # You can use them with [PaymentIntents](https://docs.stripe.com/payments/payment-intents) to collect payments or save them to
          # Customer objects to store instrument details for future payments.
          #
          # Related guides: [Payment Methods](https://docs.stripe.com/payments/payment-methods) and [More Payment Scenarios](https://docs.stripe.com/payments/more-payment-scenarios).
          sig { returns(T.nilable(::Stripe::PaymentMethod)) }
          def payment_method; end
          def self.inner_class_types
            @inner_class_types = {collect_config: CollectConfig}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class ConfirmPaymentIntent < ::Stripe::StripeObject
          class ConfirmConfig < ::Stripe::StripeObject
            # If the customer doesn't abandon authenticating the payment, they're redirected to this URL after completion.
            sig { returns(T.nilable(String)) }
            def return_url; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Represents a per-transaction override of a reader configuration
          sig { returns(T.nilable(ConfirmConfig)) }
          def confirm_config; end
          # Most recent PaymentIntent processed by the reader.
          sig { returns(T.any(String, ::Stripe::PaymentIntent)) }
          def payment_intent; end
          def self.inner_class_types
            @inner_class_types = {confirm_config: ConfirmConfig}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class ProcessPaymentIntent < ::Stripe::StripeObject
          class ProcessConfig < ::Stripe::StripeObject
            class Tipping < ::Stripe::StripeObject
              # Amount used to calculate tip suggestions on tipping selection screen for this transaction. Must be a positive integer in the smallest currency unit (e.g., 100 cents to represent $1.00 or 100 to represent ¥100, a zero-decimal currency).
              sig { returns(T.nilable(Integer)) }
              def amount_eligible; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Enable customer-initiated cancellation when processing this payment.
            sig { returns(T.nilable(T::Boolean)) }
            def enable_customer_cancellation; end
            # If the customer doesn't abandon authenticating the payment, they're redirected to this URL after completion.
            sig { returns(T.nilable(String)) }
            def return_url; end
            # Override showing a tipping selection screen on this transaction.
            sig { returns(T.nilable(T::Boolean)) }
            def skip_tipping; end
            # Represents a per-transaction tipping configuration
            sig { returns(T.nilable(Tipping)) }
            def tipping; end
            def self.inner_class_types
              @inner_class_types = {tipping: Tipping}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Most recent PaymentIntent processed by the reader.
          sig { returns(T.any(String, ::Stripe::PaymentIntent)) }
          def payment_intent; end
          # Represents a per-transaction override of a reader configuration
          sig { returns(T.nilable(ProcessConfig)) }
          def process_config; end
          def self.inner_class_types
            @inner_class_types = {process_config: ProcessConfig}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class ProcessSetupIntent < ::Stripe::StripeObject
          class ProcessConfig < ::Stripe::StripeObject
            # Enable customer-initiated cancellation when processing this SetupIntent.
            sig { returns(T.nilable(T::Boolean)) }
            def enable_customer_cancellation; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # ID of a card PaymentMethod generated from the card_present PaymentMethod that may be attached to a Customer for future transactions. Only present if it was possible to generate a card PaymentMethod.
          sig { returns(T.nilable(String)) }
          def generated_card; end
          # Represents a per-setup override of a reader configuration
          sig { returns(T.nilable(ProcessConfig)) }
          def process_config; end
          # Most recent SetupIntent processed by the reader.
          sig { returns(T.any(String, ::Stripe::SetupIntent)) }
          def setup_intent; end
          def self.inner_class_types
            @inner_class_types = {process_config: ProcessConfig}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class RefundPayment < ::Stripe::StripeObject
          class RefundPaymentConfig < ::Stripe::StripeObject
            # Enable customer-initiated cancellation when refunding this payment.
            sig { returns(T.nilable(T::Boolean)) }
            def enable_customer_cancellation; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # The amount being refunded.
          sig { returns(T.nilable(Integer)) }
          def amount; end
          # Charge that is being refunded.
          sig { returns(T.nilable(T.any(String, ::Stripe::Charge))) }
          def charge; end
          # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
          sig { returns(T.nilable(T::Hash[String, String])) }
          def metadata; end
          # Payment intent that is being refunded.
          sig { returns(T.nilable(T.any(String, ::Stripe::PaymentIntent))) }
          def payment_intent; end
          # The reason for the refund.
          sig { returns(T.nilable(String)) }
          def reason; end
          # Unique identifier for the refund object.
          sig { returns(T.nilable(T.any(String, ::Stripe::Refund))) }
          def refund; end
          # Boolean indicating whether the application fee should be refunded when refunding this charge. If a full charge refund is given, the full application fee will be refunded. Otherwise, the application fee will be refunded in an amount proportional to the amount of the charge refunded. An application fee can be refunded only by the application that created the charge.
          sig { returns(T.nilable(T::Boolean)) }
          def refund_application_fee; end
          # Represents a per-transaction override of a reader configuration
          sig { returns(T.nilable(RefundPaymentConfig)) }
          def refund_payment_config; end
          # Boolean indicating whether the transfer should be reversed when refunding this charge. The transfer will be reversed proportionally to the amount being refunded (either the entire or partial amount). A transfer can be reversed only by the application that created the charge.
          sig { returns(T.nilable(T::Boolean)) }
          def reverse_transfer; end
          def self.inner_class_types
            @inner_class_types = {refund_payment_config: RefundPaymentConfig}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class SetReaderDisplay < ::Stripe::StripeObject
          class Cart < ::Stripe::StripeObject
            class LineItem < ::Stripe::StripeObject
              # The amount of the line item. A positive integer in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
              sig { returns(Integer) }
              def amount; end
              # Description of the line item.
              sig { returns(String) }
              def description; end
              # The quantity of the line item.
              sig { returns(Integer) }
              def quantity; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
            sig { returns(String) }
            def currency; end
            # List of line items in the cart.
            sig { returns(T::Array[LineItem]) }
            def line_items; end
            # Tax amount for the entire cart. A positive integer in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
            sig { returns(T.nilable(Integer)) }
            def tax; end
            # Total amount for the entire cart, including tax. A positive integer in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
            sig { returns(Integer) }
            def total; end
            def self.inner_class_types
              @inner_class_types = {line_items: LineItem}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Cart object to be displayed by the reader, including line items, amounts, and currency.
          sig { returns(T.nilable(Cart)) }
          def cart; end
          # Type of information to be displayed by the reader. Only `cart` is currently supported.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {cart: Cart}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Represents a reader action to collect customer inputs
        sig { returns(T.nilable(CollectInputs)) }
        def collect_inputs; end
        # Represents a reader action to collect a payment method
        sig { returns(T.nilable(CollectPaymentMethod)) }
        def collect_payment_method; end
        # Represents a reader action to confirm a payment
        sig { returns(T.nilable(ConfirmPaymentIntent)) }
        def confirm_payment_intent; end
        # Failure code, only set if status is `failed`.
        sig { returns(T.nilable(String)) }
        def failure_code; end
        # Detailed failure message, only set if status is `failed`.
        sig { returns(T.nilable(String)) }
        def failure_message; end
        # Represents a reader action to process a payment intent
        sig { returns(T.nilable(ProcessPaymentIntent)) }
        def process_payment_intent; end
        # Represents a reader action to process a setup intent
        sig { returns(T.nilable(ProcessSetupIntent)) }
        def process_setup_intent; end
        # Represents a reader action to refund a payment
        sig { returns(T.nilable(RefundPayment)) }
        def refund_payment; end
        # Represents a reader action to set the reader display
        sig { returns(T.nilable(SetReaderDisplay)) }
        def set_reader_display; end
        # Status of the action performed by the reader.
        sig { returns(String) }
        def status; end
        # Type of action performed by the reader.
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {
            collect_inputs: CollectInputs,
            collect_payment_method: CollectPaymentMethod,
            confirm_payment_intent: ConfirmPaymentIntent,
            process_payment_intent: ProcessPaymentIntent,
            process_setup_intent: ProcessSetupIntent,
            refund_payment: RefundPayment,
            set_reader_display: SetReaderDisplay,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The most recent action performed by the reader.
      sig { returns(T.nilable(Action)) }
      def action; end
      # The current software version of the reader.
      sig { returns(T.nilable(String)) }
      def device_sw_version; end
      # Device type of the reader.
      sig { returns(String) }
      def device_type; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # The local IP address of the reader.
      sig { returns(T.nilable(String)) }
      def ip_address; end
      # Custom label given to the reader for easier identification.
      sig { returns(String) }
      def label; end
      # The last time this reader reported to Stripe backend. Timestamp is measured in milliseconds since the Unix epoch. Unlike most other Stripe timestamp fields which use seconds, this field uses milliseconds.
      sig { returns(T.nilable(Integer)) }
      def last_seen_at; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # The location identifier of the reader.
      sig { returns(T.nilable(T.any(String, ::Stripe::Terminal::Location))) }
      def location; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T::Hash[String, String]) }
      def metadata; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Serial number of the reader.
      sig { returns(String) }
      def serial_number; end
      # The networking status of the reader. We do not recommend using this field in flows that may block taking payments.
      sig { returns(T.nilable(String)) }
      def status; end
      # Always true for a deleted object
      sig { returns(T.nilable(T::Boolean)) }
      def deleted; end
      # Cancels the current reader action. See [Programmatic Cancellation](https://docs.stripe.com/docs/terminal/payments/collect-card-payment?terminal-sdk-platform=server-driven#programmatic-cancellation) for more details.
      sig {
        params(params: T.any(::Stripe::Terminal::ReaderCancelActionParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def cancel_action(params = {}, opts = {}); end

      # Cancels the current reader action. See [Programmatic Cancellation](https://docs.stripe.com/docs/terminal/payments/collect-card-payment?terminal-sdk-platform=server-driven#programmatic-cancellation) for more details.
      sig {
        params(reader: String, params: T.any(::Stripe::Terminal::ReaderCancelActionParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def self.cancel_action(reader, params = {}, opts = {}); end

      # Initiates an [input collection flow](https://docs.stripe.com/docs/terminal/features/collect-inputs) on a Reader to display input forms and collect information from your customers.
      sig {
        params(params: T.any(::Stripe::Terminal::ReaderCollectInputsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def collect_inputs(params = {}, opts = {}); end

      # Initiates an [input collection flow](https://docs.stripe.com/docs/terminal/features/collect-inputs) on a Reader to display input forms and collect information from your customers.
      sig {
        params(reader: String, params: T.any(::Stripe::Terminal::ReaderCollectInputsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def self.collect_inputs(reader, params = {}, opts = {}); end

      # Initiates a payment flow on a Reader and updates the PaymentIntent with card details before manual confirmation. See [Collecting a Payment method](https://docs.stripe.com/docs/terminal/payments/collect-card-payment?terminal-sdk-platform=server-driven&process=inspect#collect-a-paymentmethod) for more details.
      sig {
        params(params: T.any(::Stripe::Terminal::ReaderCollectPaymentMethodParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def collect_payment_method(params = {}, opts = {}); end

      # Initiates a payment flow on a Reader and updates the PaymentIntent with card details before manual confirmation. See [Collecting a Payment method](https://docs.stripe.com/docs/terminal/payments/collect-card-payment?terminal-sdk-platform=server-driven&process=inspect#collect-a-paymentmethod) for more details.
      sig {
        params(reader: String, params: T.any(::Stripe::Terminal::ReaderCollectPaymentMethodParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def self.collect_payment_method(reader, params = {}, opts = {}); end

      # Finalizes a payment on a Reader. See [Confirming a Payment](https://docs.stripe.com/docs/terminal/payments/collect-card-payment?terminal-sdk-platform=server-driven&process=inspect#confirm-the-paymentintent) for more details.
      sig {
        params(params: T.any(::Stripe::Terminal::ReaderConfirmPaymentIntentParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def confirm_payment_intent(params = {}, opts = {}); end

      # Finalizes a payment on a Reader. See [Confirming a Payment](https://docs.stripe.com/docs/terminal/payments/collect-card-payment?terminal-sdk-platform=server-driven&process=inspect#confirm-the-paymentintent) for more details.
      sig {
        params(reader: String, params: T.any(::Stripe::Terminal::ReaderConfirmPaymentIntentParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def self.confirm_payment_intent(reader, params = {}, opts = {}); end

      # Creates a new Reader object.
      sig {
        params(params: T.any(::Stripe::Terminal::ReaderCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def self.create(params = {}, opts = {}); end

      # Deletes a Reader object.
      sig {
        params(reader: String, params: T.any(::Stripe::Terminal::ReaderDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def self.delete(reader, params = {}, opts = {}); end

      # Deletes a Reader object.
      sig {
        params(params: T.any(::Stripe::Terminal::ReaderDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def delete(params = {}, opts = {}); end

      # Returns a list of Reader objects.
      sig {
        params(params: T.any(::Stripe::Terminal::ReaderListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Initiates a payment flow on a Reader. See [process the payment](https://docs.stripe.com/docs/terminal/payments/collect-card-payment?terminal-sdk-platform=server-driven&process=immediately#process-payment) for more details.
      sig {
        params(params: T.any(::Stripe::Terminal::ReaderProcessPaymentIntentParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def process_payment_intent(params = {}, opts = {}); end

      # Initiates a payment flow on a Reader. See [process the payment](https://docs.stripe.com/docs/terminal/payments/collect-card-payment?terminal-sdk-platform=server-driven&process=immediately#process-payment) for more details.
      sig {
        params(reader: String, params: T.any(::Stripe::Terminal::ReaderProcessPaymentIntentParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def self.process_payment_intent(reader, params = {}, opts = {}); end

      # Initiates a SetupIntent flow on a Reader. See [Save directly without charging](https://docs.stripe.com/docs/terminal/features/saving-payment-details/save-directly) for more details.
      sig {
        params(params: T.any(::Stripe::Terminal::ReaderProcessSetupIntentParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def process_setup_intent(params = {}, opts = {}); end

      # Initiates a SetupIntent flow on a Reader. See [Save directly without charging](https://docs.stripe.com/docs/terminal/features/saving-payment-details/save-directly) for more details.
      sig {
        params(reader: String, params: T.any(::Stripe::Terminal::ReaderProcessSetupIntentParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def self.process_setup_intent(reader, params = {}, opts = {}); end

      # Initiates an in-person refund on a Reader. See [Refund an Interac Payment](https://docs.stripe.com/docs/terminal/payments/regional?integration-country=CA#refund-an-interac-payment) for more details.
      sig {
        params(params: T.any(::Stripe::Terminal::ReaderRefundPaymentParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def refund_payment(params = {}, opts = {}); end

      # Initiates an in-person refund on a Reader. See [Refund an Interac Payment](https://docs.stripe.com/docs/terminal/payments/regional?integration-country=CA#refund-an-interac-payment) for more details.
      sig {
        params(reader: String, params: T.any(::Stripe::Terminal::ReaderRefundPaymentParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def self.refund_payment(reader, params = {}, opts = {}); end

      # Sets the reader display to show [cart details](https://docs.stripe.com/docs/terminal/features/display).
      sig {
        params(params: T.any(::Stripe::Terminal::ReaderSetReaderDisplayParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def set_reader_display(params = {}, opts = {}); end

      # Sets the reader display to show [cart details](https://docs.stripe.com/docs/terminal/features/display).
      sig {
        params(reader: String, params: T.any(::Stripe::Terminal::ReaderSetReaderDisplayParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def self.set_reader_display(reader, params = {}, opts = {}); end

      # Updates a Reader object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
      sig {
        params(reader: String, params: T.any(::Stripe::Terminal::ReaderUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
       }
      def self.update(reader, params = {}, opts = {}); end
    end
  end
end