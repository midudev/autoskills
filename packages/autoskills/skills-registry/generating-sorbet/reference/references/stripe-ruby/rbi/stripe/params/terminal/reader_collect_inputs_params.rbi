# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    class ReaderCollectInputsParams < ::Stripe::RequestParams
      class Input < ::Stripe::RequestParams
        class CustomText < ::Stripe::RequestParams
          # The description which will be displayed when collecting this input
          sig { returns(T.nilable(String)) }
          def description; end
          sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
          def description=(_description); end
          # Custom text for the skip button. Maximum 14 characters.
          sig { returns(T.nilable(String)) }
          def skip_button; end
          sig { params(_skip_button: T.nilable(String)).returns(T.nilable(String)) }
          def skip_button=(_skip_button); end
          # Custom text for the submit button. Maximum 30 characters.
          sig { returns(T.nilable(String)) }
          def submit_button; end
          sig { params(_submit_button: T.nilable(String)).returns(T.nilable(String)) }
          def submit_button=(_submit_button); end
          # The title which will be displayed when collecting this input
          sig { returns(String) }
          def title; end
          sig { params(_title: String).returns(String) }
          def title=(_title); end
          sig {
            params(description: T.nilable(String), skip_button: T.nilable(String), submit_button: T.nilable(String), title: String).void
           }
          def initialize(description: nil, skip_button: nil, submit_button: nil, title: nil); end
        end
        class Selection < ::Stripe::RequestParams
          class Choice < ::Stripe::RequestParams
            # The unique identifier for this choice
            sig { returns(String) }
            def id; end
            sig { params(_id: String).returns(String) }
            def id=(_id); end
            # The style of the button which will be shown for this choice. Can be `primary` or `secondary`.
            sig { returns(T.nilable(String)) }
            def style; end
            sig { params(_style: T.nilable(String)).returns(T.nilable(String)) }
            def style=(_style); end
            # The text which will be shown on the button for this choice
            sig { returns(String) }
            def text; end
            sig { params(_text: String).returns(String) }
            def text=(_text); end
            sig { params(id: String, style: T.nilable(String), text: String).void }
            def initialize(id: nil, style: nil, text: nil); end
          end
          # List of choices for the `selection` input
          sig { returns(T::Array[Terminal::ReaderCollectInputsParams::Input::Selection::Choice]) }
          def choices; end
          sig {
            params(_choices: T::Array[Terminal::ReaderCollectInputsParams::Input::Selection::Choice]).returns(T::Array[Terminal::ReaderCollectInputsParams::Input::Selection::Choice])
           }
          def choices=(_choices); end
          sig {
            params(choices: T::Array[Terminal::ReaderCollectInputsParams::Input::Selection::Choice]).void
           }
          def initialize(choices: nil); end
        end
        class Toggle < ::Stripe::RequestParams
          # The default value of the toggle. Can be `enabled` or `disabled`.
          sig { returns(T.nilable(String)) }
          def default_value; end
          sig { params(_default_value: T.nilable(String)).returns(T.nilable(String)) }
          def default_value=(_default_value); end
          # The description which will be displayed for the toggle. Maximum 50 characters. At least one of title or description must be provided.
          sig { returns(T.nilable(String)) }
          def description; end
          sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
          def description=(_description); end
          # The title which will be displayed for the toggle. Maximum 50 characters. At least one of title or description must be provided.
          sig { returns(T.nilable(String)) }
          def title; end
          sig { params(_title: T.nilable(String)).returns(T.nilable(String)) }
          def title=(_title); end
          sig {
            params(default_value: T.nilable(String), description: T.nilable(String), title: T.nilable(String)).void
           }
          def initialize(default_value: nil, description: nil, title: nil); end
        end
        # Customize the text which will be displayed while collecting this input
        sig { returns(Terminal::ReaderCollectInputsParams::Input::CustomText) }
        def custom_text; end
        sig {
          params(_custom_text: Terminal::ReaderCollectInputsParams::Input::CustomText).returns(Terminal::ReaderCollectInputsParams::Input::CustomText)
         }
        def custom_text=(_custom_text); end
        # Indicate that this input is required, disabling the skip button
        sig { returns(T.nilable(T::Boolean)) }
        def required; end
        sig { params(_required: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def required=(_required); end
        # Options for the `selection` input
        sig { returns(T.nilable(Terminal::ReaderCollectInputsParams::Input::Selection)) }
        def selection; end
        sig {
          params(_selection: T.nilable(Terminal::ReaderCollectInputsParams::Input::Selection)).returns(T.nilable(Terminal::ReaderCollectInputsParams::Input::Selection))
         }
        def selection=(_selection); end
        # List of toggles to be displayed and customization for the toggles
        sig { returns(T.nilable(T::Array[Terminal::ReaderCollectInputsParams::Input::Toggle])) }
        def toggles; end
        sig {
          params(_toggles: T.nilable(T::Array[Terminal::ReaderCollectInputsParams::Input::Toggle])).returns(T.nilable(T::Array[Terminal::ReaderCollectInputsParams::Input::Toggle]))
         }
        def toggles=(_toggles); end
        # The type of input to collect
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        sig {
          params(custom_text: Terminal::ReaderCollectInputsParams::Input::CustomText, required: T.nilable(T::Boolean), selection: T.nilable(Terminal::ReaderCollectInputsParams::Input::Selection), toggles: T.nilable(T::Array[Terminal::ReaderCollectInputsParams::Input::Toggle]), type: String).void
         }
        def initialize(
          custom_text: nil,
          required: nil,
          selection: nil,
          toggles: nil,
          type: nil
        ); end
      end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # List of inputs to be collected from the customer using the Reader. Maximum 5 inputs.
      sig { returns(T::Array[Terminal::ReaderCollectInputsParams::Input]) }
      def inputs; end
      sig {
        params(_inputs: T::Array[Terminal::ReaderCollectInputsParams::Input]).returns(T::Array[Terminal::ReaderCollectInputsParams::Input])
       }
      def inputs=(_inputs); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      sig {
        params(expand: T.nilable(T::Array[String]), inputs: T::Array[Terminal::ReaderCollectInputsParams::Input], metadata: T.nilable(T::Hash[String, String])).void
       }
      def initialize(expand: nil, inputs: nil, metadata: nil); end
    end
  end
end