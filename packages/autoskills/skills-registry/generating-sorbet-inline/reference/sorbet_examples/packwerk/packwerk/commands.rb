# typed: strict
# frozen_string_literal: true

module Packwerk
  module Commands
    extend T::Sig
    extend ActiveSupport::Autoload

    autoload :BaseCommand
    autoload :CheckCommand
    autoload :HelpCommand
    autoload :InitCommand
    autoload :LazyLoadedEntry
    autoload :UpdateTodoCommand
    autoload :UsesParseRun
    autoload :ValidateCommand
    autoload :VersionCommand

    class << self
      extend T::Sig

      sig { params(name: String, aliases: T::Array[String]).void }
      def register(name, aliases: [])
        registry << LazyLoadedEntry.new(name, aliases: aliases)
      end

      sig { params(name_or_alias: String).returns(T.nilable(T.class_of(BaseCommand))) }
      def for(name_or_alias)
        registry
          .find { |command| command.matches_command?(name_or_alias) }
          &.command_class
      end

      sig { returns(T::Array[LazyLoadedEntry]) }
      def all
        registry.dup
      end

      private

      sig { returns(T::Array[LazyLoadedEntry]) }
      def registry
        @registry ||= T.let([], T.nilable(T::Array[LazyLoadedEntry]))
      end
    end

    register("init")
    register("check")
    register("update-todo", aliases: ["update"])
    register("validate")
    register("version")
    register("help")
  end
end
