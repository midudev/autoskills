# typed: strict
# frozen_string_literal: true

module Packwerk
  module Validator
    class Result < T::Struct
      extend T::Sig

      const :ok, T::Boolean
      const :error_value, T.nilable(String)

      sig { returns(T::Boolean) }
      def ok?
        ok
      end
    end
  end
end
