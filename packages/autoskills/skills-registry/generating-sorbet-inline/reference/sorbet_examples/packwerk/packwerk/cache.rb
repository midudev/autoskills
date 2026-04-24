# typed: strict
# frozen_string_literal: true

require "digest"

module Packwerk
  class Cache
    extend T::Sig

    class CacheContents < T::Struct
      extend T::Sig

      const :file_contents_digest, String
      const :unresolved_references, T::Array[UnresolvedReference]

      class << self
        extend T::Sig

        sig { params(serialized_cache_contents: String).returns(CacheContents) }
        def deserialize(serialized_cache_contents)
          cache_contents_json = JSON.parse(serialized_cache_contents)
          unresolved_references = cache_contents_json["unresolved_references"].map do |json|
            UnresolvedReference.new(
              constant_name: json["constant_name"],
              namespace_path: json["namespace_path"],
              relative_path: json["relative_path"],
              source_location: Node::Location.new(json["source_location"]["line"], json["source_location"]["column"],)
            )
          end

          CacheContents.new(
            file_contents_digest: cache_contents_json["file_contents_digest"],
            unresolved_references: unresolved_references,
          )
        end
      end

      sig { returns(String) }
      def serialize
        to_json
      end
    end

    CacheShape = T.type_alias do
      T::Hash[
        String,
        CacheContents
      ]
    end

    sig { params(enable_cache: T::Boolean, cache_directory: Pathname, config_path: T.nilable(String)).void }
    def initialize(enable_cache:, cache_directory:, config_path:)
      @enable_cache = enable_cache
      @cache = T.let({}, CacheShape)
      @files_by_digest = T.let({}, T::Hash[String, String])
      @config_path = config_path
      @cache_directory = cache_directory

      if @enable_cache
        create_cache_directory!
        bust_cache_if_packwerk_yml_has_changed!
        bust_cache_if_inflections_have_changed!
      end
    end

    sig { void }
    def bust_cache!
      FileUtils.rm_rf(@cache_directory)
    end

    sig do
      params(
        file_path: String,
        block: T.proc.returns(T::Array[UnresolvedReference])
      ).returns(T::Array[UnresolvedReference])
    end
    def with_cache(file_path, &block)
      return yield unless @enable_cache

      cache_location = @cache_directory.join(digest_for_string(file_path))

      cache_contents = if cache_location.exist?
        T.let(CacheContents.deserialize(cache_location.read),
          CacheContents)
      end

      file_contents_digest = digest_for_file(file_path)

      if !cache_contents.nil? && cache_contents.file_contents_digest == file_contents_digest
        Debug.out("Cache hit for #{file_path}")

        cache_contents.unresolved_references
      else
        Debug.out("Cache miss for #{file_path}")

        unresolved_references = yield

        cache_contents = CacheContents.new(
          file_contents_digest: file_contents_digest,
          unresolved_references: unresolved_references,
        )
        cache_location.write(cache_contents.serialize)

        unresolved_references
      end
    end

    sig { params(file: String).returns(String) }
    def digest_for_file(file)
      digest_for_string(File.read(file))
    end

    sig { params(str: String).returns(String) }
    def digest_for_string(str)
      # MD5 appears to be the fastest
      # https://gist.github.com/morimori/1330095
      Digest::MD5.hexdigest(str)
    end

    sig { void }
    def bust_cache_if_packwerk_yml_has_changed!
      return nil if @config_path.nil?

      bust_cache_if_contents_have_changed(File.read(@config_path), :packwerk_yml)
    end

    sig { void }
    def bust_cache_if_inflections_have_changed!
      bust_cache_if_contents_have_changed(YAML.dump(ActiveSupport::Inflector.inflections), :inflections)
    end

    sig { params(contents: String, contents_key: Symbol).void }
    def bust_cache_if_contents_have_changed(contents, contents_key)
      current_digest = digest_for_string(contents)
      cached_digest_path = @cache_directory.join(contents_key.to_s)

      if !cached_digest_path.exist?
        # In this case, we have nothing cached
        # We save the current digest. This way the next time we compare current digest to cached digest,
        # we can accurately determine if we should bust the cache
        cached_digest_path.write(current_digest)

        nil
      elsif cached_digest_path.read == current_digest
        Debug.out("#{contents_key} contents have NOT changed, preserving cache")
      else
        Debug.out("#{contents_key} contents have changed, busting cache")

        bust_cache!
        create_cache_directory!

        cached_digest_path.write(current_digest)
      end
    end

    sig { void }
    def create_cache_directory!
      FileUtils.mkdir_p(@cache_directory)
    end
  end

  class Debug
    class << self
      extend T::Sig

      sig { params(out: String).void }
      def out(out)
        if ENV["DEBUG_PACKWERK_CACHE"]
          puts(out)
        end
      end
    end
  end

  private_constant :Cache
  private_constant :Debug
end
