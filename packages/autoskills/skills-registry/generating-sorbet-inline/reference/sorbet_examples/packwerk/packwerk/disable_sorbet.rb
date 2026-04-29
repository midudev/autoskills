# typed: true
# frozen_string_literal: true

require "sorbet-runtime"

begin
  T::Configuration.default_checked_level = :never

  T.singleton_class.prepend(
    Module.new do
      def cast(value, type, checked: true)
        value
      end

      def let(value, type, checked: true)
        value
      end

      def must(arg)
        arg
      end

      def absurd(value)
        value
      end

      def bind(value, type, checked: true)
        value
      end
    end
  )
rescue RuntimeError => error
  # From https://github.com/sorbet/sorbet/blob/dcf1b069cfb0d6624c027e45e59f4c6ca33de970/gems/sorbet-runtime/lib/types/private/runtime_levels.rb#L54
  # Sorbet has already evaluated a method call somewhere, so we can't disable it.
  # In this case, we want to log a warning so Packwerk can still be used (but will be slower).
  if /Set the default checked level earlier./.match?(error.message)
    warn("Packwerk couldn't disable Sorbet. Please ensure it isn't being used before Packwerk is loaded.")
  else
    raise error
  end
end
