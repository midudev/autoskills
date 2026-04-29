# typed: strict
# frozen_string_literal: true

module Packwerk
  module ReferenceChecking
    class ReferenceChecker
      extend T::Sig

      sig { params(checkers: T::Array[Checker]).void }
      def initialize(checkers)
        @checkers = checkers
      end

      sig do
        params(
          reference: Reference
        ).returns(T::Array[Packwerk::Offense])
      end
      def call(reference)
        @checkers.each_with_object([]) do |checker, violations|
          next unless checker.invalid_reference?(reference)

          offense = Packwerk::ReferenceOffense.new(
            location: reference.source_location,
            reference: reference,
            violation_type: checker.violation_type,
            message: checker.message(reference)
          )
          violations << offense
        end
      end
    end
  end
end
