# typed: true
# frozen_string_literal: true

module Packwerk
  extend T::Sig

  ConstantContext = Struct.new(:name, :location, :package)
end
