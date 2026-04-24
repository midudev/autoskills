# typed: true
# frozen_string_literal: true

module Packwerk
  # An unresolved reference from a file in one package to a constant that may be defined in a different package.
  # Unresolved means that we know how it's referred to in the file,
  # and we have enough context on that reference to figure out the fully qualified reference such that we
  # can produce a Reference in a separate pass. However, we have not yet resolved it to its fully qualified version.
  UnresolvedReference = Struct.new(
    :constant_name,
    :namespace_path,
    :relative_path,
    :source_location,
    keyword_init: true,
  )

  private_constant :UnresolvedReference
end
