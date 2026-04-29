# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # This object represents files hosted on Stripe's servers. You can upload
  # files with the [create file](https://api.stripe.com#create_file) request
  # (for example, when uploading dispute evidence). Stripe also
  # creates files independently (for example, the results of a [Sigma scheduled
  # query](https://docs.stripe.com/api#scheduled_queries)).
  #
  # Related guide: [File upload guide](https://docs.stripe.com/file-upload)
  class File < APIResource
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # The file expires and isn't available at this time in epoch seconds.
    sig { returns(T.nilable(Integer)) }
    def expires_at; end
    # The suitable name for saving the file to a filesystem.
    sig { returns(T.nilable(String)) }
    def filename; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # A list of [file links](https://api.stripe.com#file_links) that point at this file.
    sig { returns(T.nilable(::Stripe::ListObject)) }
    def links; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The [purpose](https://docs.stripe.com/file-upload#uploading-a-file) of the uploaded file.
    sig { returns(String) }
    def purpose; end
    # The size of the file object in bytes.
    sig { returns(Integer) }
    def size; end
    # A suitable title for the document.
    sig { returns(T.nilable(String)) }
    def title; end
    # The returned file type (for example, `csv`, `pdf`, `jpg`, or `png`).
    sig { returns(T.nilable(String)) }
    def type; end
    # Use your live secret API key to download the file from this URL.
    sig { returns(T.nilable(String)) }
    def url; end
    # To upload a file to Stripe, you need to send a request of type multipart/form-data. Include the file you want to upload in the request, and the parameters for creating a file.
    #
    # All of Stripe's officially supported Client libraries support sending multipart/form-data.
    sig {
      params(params: T.any(::Stripe::FileCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::File)
     }
    def self.create(params = {}, opts = {}); end

    # Returns a list of the files that your account has access to. Stripe sorts and returns the files by their creation dates, placing the most recently created files at the top.
    sig {
      params(params: T.any(::Stripe::FileListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end
  end
end