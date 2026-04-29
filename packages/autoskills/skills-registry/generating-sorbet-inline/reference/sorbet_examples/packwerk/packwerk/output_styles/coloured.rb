# typed: strict
# frozen_string_literal: true

module Packwerk
  module OutputStyles
    # See https://en.wikipedia.org/wiki/ANSI_escape_code#3/4_bit for ANSI escape colour codes
    class Coloured
      extend T::Sig
      include OutputStyle

      sig { override.returns(String) }
      def reset
        "\033[m"
      end

      sig { override.returns(String) }
      def filename
        # 36 is foreground cyan
        "\033[36m"
      end

      sig { override.returns(String) }
      def error
        # 31 is foreground red
        "\033[31m"
      end
    end
  end
end
