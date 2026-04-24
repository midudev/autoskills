# typed: strict
# frozen_string_literal: true

module Packwerk
  module OutputStyle
    extend T::Sig
    extend T::Helpers

    interface!

    sig { abstract.returns(String) }
    def reset; end

    sig { abstract.returns(String) }
    def filename; end

    sig { abstract.returns(String) }
    def error; end
  end
end
