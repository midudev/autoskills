# typed: strict
# frozen_string_literal: true

module Packwerk
  module OutputStyles
    class Plain
      extend T::Sig
      include OutputStyle

      sig { override.returns(String) }
      def reset
        ""
      end

      sig { override.returns(String) }
      def filename
        ""
      end

      sig { override.returns(String) }
      def error
        ""
      end
    end
  end
end
