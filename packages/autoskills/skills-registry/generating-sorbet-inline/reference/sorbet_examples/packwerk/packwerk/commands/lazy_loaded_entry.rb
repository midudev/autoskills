# typed: strict
# frozen_string_literal: true

module Packwerk
  module Commands
    class LazyLoadedEntry
      extend T::Sig

      sig { returns(String) }
      attr_reader :name

      sig { params(name: String, aliases: T::Array[String]).void }
      def initialize(name, aliases: [])
        @name = name
        @aliases = aliases
      end

      sig { returns(T.class_of(BaseCommand)) }
      def command_class
        classname = @name.sub(" ", "_").underscore.classify + "Command"
        Commands.const_get(classname) # rubocop:disable Sorbet/ConstantsFromStrings
      end

      sig { returns(String) }
      def description
        command_class.description
      end

      sig { params(name_or_alias: String).returns(T::Boolean) }
      def matches_command?(name_or_alias)
        @name == name_or_alias || @aliases.include?(name_or_alias)
      end
    end

    private_constant :LazyLoadedEntry
  end
end
