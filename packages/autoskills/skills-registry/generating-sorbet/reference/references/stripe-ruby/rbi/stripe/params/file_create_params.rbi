# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class FileCreateParams < ::Stripe::RequestParams
    class FileLinkData < ::Stripe::RequestParams
      # Set this to `true` to create a file link for the newly created file. Creating a link is only possible when the file's `purpose` is one of the following: `business_icon`, `business_logo`, `customer_signature`, `dispute_evidence`, `issuing_regulatory_reporting`, `pci_document`, `tax_document_user_upload`, `terminal_android_apk`, or `terminal_reader_splashscreen`.
      sig { returns(T::Boolean) }
      def create; end
      sig { params(_create: T::Boolean).returns(T::Boolean) }
      def create=(_create); end
      # The link isn't available after this future timestamp.
      sig { returns(T.nilable(Integer)) }
      def expires_at; end
      sig { params(_expires_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def expires_at=(_expires_at); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
       }
      def metadata=(_metadata); end
      sig {
        params(create: T::Boolean, expires_at: T.nilable(Integer), metadata: T.nilable(T.any(String, T::Hash[String, String]))).void
       }
      def initialize(create: nil, expires_at: nil, metadata: nil); end
    end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # A file to upload. Make sure that the specifications follow RFC 2388, which defines file transfers for the `multipart/form-data` protocol.
    sig { returns(T.untyped) }
    def file; end
    sig { params(_file: T.untyped).returns(T.untyped) }
    def file=(_file); end
    # Optional parameters that automatically create a [file link](https://api.stripe.com#file_links) for the newly created file.
    sig { returns(T.nilable(FileCreateParams::FileLinkData)) }
    def file_link_data; end
    sig {
      params(_file_link_data: T.nilable(FileCreateParams::FileLinkData)).returns(T.nilable(FileCreateParams::FileLinkData))
     }
    def file_link_data=(_file_link_data); end
    # The [purpose](https://docs.stripe.com/file-upload#uploading-a-file) of the uploaded file.
    sig { returns(String) }
    def purpose; end
    sig { params(_purpose: String).returns(String) }
    def purpose=(_purpose); end
    sig {
      params(expand: T.nilable(T::Array[String]), file: T.untyped, file_link_data: T.nilable(FileCreateParams::FileLinkData), purpose: String).void
     }
    def initialize(expand: nil, file: nil, file_link_data: nil, purpose: nil); end
  end
end