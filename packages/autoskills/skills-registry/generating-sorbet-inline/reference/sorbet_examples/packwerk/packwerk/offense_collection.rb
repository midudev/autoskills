# typed: strict
# frozen_string_literal: true

require "pathname"

module Packwerk
  class OffenseCollection
    extend T::Sig
    extend T::Helpers

    sig do
      params(
        root_path: String,
        package_todos: T::Hash[Packwerk::Package, Packwerk::PackageTodo]
      ).void
    end
    def initialize(root_path, package_todos = {})
      @root_path = root_path
      @package_todos = T.let(package_todos, T::Hash[Packwerk::Package, Packwerk::PackageTodo])
      @new_violations = T.let([], T::Array[Packwerk::ReferenceOffense])
      @strict_mode_violations = T.let([], T::Array[Packwerk::ReferenceOffense])
      @errors = T.let([], T::Array[Packwerk::Offense])
    end

    sig { returns(T::Array[Packwerk::ReferenceOffense]) }
    attr_reader :new_violations

    sig { returns(T::Array[Packwerk::Offense]) }
    attr_reader :errors

    sig { returns(T::Array[Packwerk::ReferenceOffense]) }
    attr_reader :strict_mode_violations

    sig do
      params(offense: Packwerk::Offense)
        .returns(T::Boolean)
    end
    def listed?(offense)
      return false unless offense.is_a?(ReferenceOffense)

      already_listed?(offense)
    end

    sig { params(offenses: T::Array[Offense]).void }
    def add_offenses(offenses)
      offenses.each { |offense| add_offense(offense) }
    end

    sig do
      params(offense: Packwerk::Offense).void
    end
    def add_offense(offense)
      unless offense.is_a?(ReferenceOffense)
        @errors << offense
        return
      end

      already_listed = already_listed?(offense)

      new_violations << offense unless already_listed

      if strict_mode_violation?(offense)
        add_to_package_todo(offense) if already_listed
        strict_mode_violations << offense
      else
        add_to_package_todo(offense)
      end
    end

    sig { params(for_files: T::Set[String]).returns(T::Boolean) }
    def stale_violations?(for_files)
      @package_todos.values.any? do |package_todo|
        package_todo.stale_violations?(for_files)
      end
    end

    sig { params(package_set: Packwerk::PackageSet).void }
    def persist_package_todo_files(package_set)
      dump_package_todo_files
      cleanup_extra_package_todo_files(package_set)
    end

    sig { returns(T::Array[Packwerk::Offense]) }
    def outstanding_offenses
      errors + new_violations
    end

    sig { returns(T::Array[Packwerk::ReferenceOffense]) }
    def unlisted_strict_mode_violations
      strict_mode_violations.reject { |offense| already_listed?(offense) }
    end

    private

    sig { params(offense: ReferenceOffense).returns(T::Boolean) }
    def already_listed?(offense)
      package_todo_for(offense.reference.package).listed?(offense.reference,
        violation_type: offense.violation_type)
    end

    sig { params(offense: ReferenceOffense).returns(T::Boolean) }
    def add_to_package_todo(offense)
      package_todo_for(offense.reference.package).add_entries(offense.reference,
        offense.violation_type)
    end

    sig { params(offense: ReferenceOffense).returns(T::Boolean) }
    def strict_mode_violation?(offense)
      checker = Checker.find(offense.violation_type)
      checker.strict_mode_violation?(offense)
    end

    sig { params(package_set: Packwerk::PackageSet).void }
    def cleanup_extra_package_todo_files(package_set)
      packages_without_todos = (package_set.packages.values - @package_todos.keys)

      packages_without_todos.each do |package|
        Packwerk::PackageTodo.new(
          package,
          package_todo_file_for(package),
        ).delete_if_exists
      end
    end

    sig { void }
    def dump_package_todo_files
      @package_todos.each_value(&:dump)
    end

    sig { params(package: Packwerk::Package).returns(Packwerk::PackageTodo) }
    def package_todo_for(package)
      @package_todos[package] ||= Packwerk::PackageTodo.new(
        package,
        package_todo_file_for(package),
      )
    end

    sig { params(package: Packwerk::Package).returns(String) }
    def package_todo_file_for(package)
      File.join(@root_path, package.name, "package_todo.yml")
    end
  end
end
