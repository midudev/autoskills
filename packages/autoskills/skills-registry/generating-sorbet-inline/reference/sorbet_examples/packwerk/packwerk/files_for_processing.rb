# typed: strict
# frozen_string_literal: true

module Packwerk
  class FilesForProcessing
    extend T::Sig

    RelativeFileSet = T.type_alias { T::Set[String] }

    class << self
      extend T::Sig

      sig do
        params(
          relative_file_paths: T::Array[String],
          configuration: Configuration,
          ignore_nested_packages: T::Boolean
        ).returns(FilesForProcessing)
      end
      def fetch(relative_file_paths:, configuration:, ignore_nested_packages: false)
        new(relative_file_paths, configuration, ignore_nested_packages)
      end
    end

    sig do
      params(
        relative_file_paths: T::Array[String],
        configuration: Configuration,
        ignore_nested_packages: T::Boolean
      ).void
    end
    def initialize(relative_file_paths, configuration, ignore_nested_packages)
      @relative_file_paths = relative_file_paths
      @configuration = configuration
      @ignore_nested_packages = ignore_nested_packages
      @specified_files = T.let(nil, T.nilable(RelativeFileSet))
      @files = T.let(nil, T.nilable(RelativeFileSet))
    end

    sig { returns(RelativeFileSet) }
    def files
      @files ||= files_for_processing
    end

    sig { returns(T::Boolean) }
    def files_specified?
      specified_files.any?
    end

    private

    sig { returns(RelativeFileSet) }
    def files_for_processing
      all_included_files = if specified_files.empty?
        configured_included_files
      else
        configured_included_files & specified_files
      end

      all_included_files - configured_excluded_files
    end

    sig { returns(RelativeFileSet) }
    def specified_files
      @specified_files ||= Set.new(
        @relative_file_paths.map do |relative_file_path|
          if File.file?(relative_file_path)
            relative_file_path
          else
            specified_included_files(relative_file_path)
          end
        end
      ).flatten
    end

    sig { params(relative_file_path: String).returns(RelativeFileSet) }
    def specified_included_files(relative_file_path)
      # Note, assuming include globs are always relative paths
      relative_includes = @configuration.include
      relative_files = Dir.glob([File.join(relative_file_path, "**", "*")]).select do |relative_path|
        relative_includes.any? do |pattern|
          File.fnmatch?(pattern, relative_path, File::FNM_EXTGLOB)
        end
      end

      if @ignore_nested_packages
        nested_packages_relative_file_paths = Dir.glob(File.join(relative_file_path, "*", "**", "package.yml"))
        nested_packages_relative_globs = nested_packages_relative_file_paths.map do |npp|
          npp.gsub("package.yml", "**/*")
        end
        nested_packages_relative_globs.each do |relative_glob|
          relative_files -= Dir.glob(relative_glob)
        end
      end

      Set.new(relative_files)
    end

    sig { returns(RelativeFileSet) }
    def configured_included_files
      relative_files_for_globs(@configuration.include)
    end

    sig { returns(RelativeFileSet) }
    def configured_excluded_files
      relative_files_for_globs(@configuration.exclude)
    end

    sig { params(relative_globs: T::Array[String]).returns(RelativeFileSet) }
    def relative_files_for_globs(relative_globs)
      Set.new(relative_globs.flat_map { |glob| Dir[glob] })
    end
  end

  private_constant :FilesForProcessing
end
