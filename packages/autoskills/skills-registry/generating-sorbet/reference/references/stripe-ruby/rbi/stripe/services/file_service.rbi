# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class FileService < StripeService
    # To upload a file to Stripe, you need to send a request of type multipart/form-data. Include the file you want to upload in the request, and the parameters for creating a file.
    #
    # All of Stripe's officially supported Client libraries support sending multipart/form-data.
    sig {
      params(params: T.any(::Stripe::FileCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::File)
     }
    def create(params = {}, opts = {}); end

    # Returns a list of the files that your account has access to. Stripe sorts and returns the files by their creation dates, placing the most recently created files at the top.
    sig {
      params(params: T.any(::Stripe::FileListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves the details of an existing file object. After you supply a unique file ID, Stripe returns the corresponding file object. Learn how to [access file contents](https://docs.stripe.com/docs/file-upload#download-file-contents).
    sig {
      params(file: String, params: T.any(::Stripe::FileRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::File)
     }
    def retrieve(file, params = {}, opts = {}); end
  end
end