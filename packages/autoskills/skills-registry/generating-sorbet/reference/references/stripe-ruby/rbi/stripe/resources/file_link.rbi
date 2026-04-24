# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # To share the contents of a `File` object with non-Stripe users, you can
  # create a `FileLink`. `FileLink`s contain a URL that you can use to
  # retrieve the contents of the file without authentication.
  class FileLink < APIResource
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Returns if the link is already expired.
    sig { returns(T::Boolean) }
    def expired; end
    # Time that the link expires.
    sig { returns(T.nilable(Integer)) }
    def expires_at; end
    # The file object this link points to.
    sig { returns(T.any(String, ::Stripe::File)) }
    def file; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T::Hash[String, String]) }
    def metadata; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The publicly accessible URL to download the file.
    sig { returns(T.nilable(String)) }
    def url; end
    # Creates a new file link object.
    sig {
      params(params: T.any(::Stripe::FileLinkCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FileLink)
     }
    def self.create(params = {}, opts = {}); end

    # Returns a list of file links.
    sig {
      params(params: T.any(::Stripe::FileLinkListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Updates an existing file link object. Expired links can no longer be updated.
    sig {
      params(link: String, params: T.any(::Stripe::FileLinkUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FileLink)
     }
    def self.update(link, params = {}, opts = {}); end
  end
end