# typed: strict
# frozen_string_literal: true

module Packwerk
  module Commands
    class UpdateTodoCommand < BaseCommand
      extend T::Sig
      include UsesParseRun

      description "update package_todo.yml files"

      sig { override.returns(T::Boolean) }
      def run
        if @files_for_processing.files_specified?
          out.puts(<<~MSG.squish)
            ⚠️ update-todo must be called without any file arguments.
          MSG

          return false
        end
        if @files_for_processing.files.empty?
          out.puts(<<~MSG.squish)
            No files found or given.
            Specify files or check the include and exclude glob in the config file.
          MSG

          return true
        end

        run_context = RunContext.from_configuration(configuration)
        offenses = T.let([], T::Array[Offense])
        progress_formatter.started_inspection(@files_for_processing.files) do
          offenses = parse_run.find_offenses(run_context, on_interrupt: -> { progress_formatter.interrupted }) do
            progress_formatter.increment_progress
          end
        end

        offense_collection = OffenseCollection.new(configuration.root_path)
        offense_collection.add_offenses(offenses)
        offense_collection.persist_package_todo_files(run_context.package_set)

        unlisted_strict_mode_violations = offense_collection.unlisted_strict_mode_violations

        messages = [
          offenses_formatter.show_offenses(offense_collection.errors + unlisted_strict_mode_violations),
        ]

        messages << if unlisted_strict_mode_violations.any?
          "⚠️ `package_todo.yml` has been updated, but unlisted strict mode violations were not added."
        else
          "✅ `package_todo.yml` has been updated."
        end

        out.puts(messages.select(&:present?).join("\n") + "\n")

        unlisted_strict_mode_violations.empty? && offense_collection.errors.empty?
      end
    end
  end
end
