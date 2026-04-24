# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    # A Configurations object represents how features should be configured for terminal readers.
    # For information about how to use it, see the [Terminal configurations documentation](https://docs.stripe.com/terminal/fleet/configurations-overview).
    class Configuration < APIResource
      class BbposWisepad3 < ::Stripe::StripeObject
        # A File ID representing an image to display on the reader
        sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
        def splashscreen; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class BbposWiseposE < ::Stripe::StripeObject
        # A File ID representing an image to display on the reader
        sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
        def splashscreen; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Offline < ::Stripe::StripeObject
        # Determines whether to allow transactions to be collected while reader is offline. Defaults to false.
        sig { returns(T.nilable(T::Boolean)) }
        def enabled; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class RebootWindow < ::Stripe::StripeObject
        # Integer between 0 to 23 that represents the end hour of the reboot time window. The value must be different than the start_hour.
        sig { returns(Integer) }
        def end_hour; end
        # Integer between 0 to 23 that represents the start hour of the reboot time window.
        sig { returns(Integer) }
        def start_hour; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class StripeS700 < ::Stripe::StripeObject
        # A File ID representing an image to display on the reader
        sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
        def splashscreen; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Tipping < ::Stripe::StripeObject
        class Aed < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Aud < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Bgn < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Cad < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Chf < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Czk < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Dkk < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Eur < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Gbp < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Gip < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Hkd < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Huf < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Jpy < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Mxn < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Myr < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Nok < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Nzd < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Pln < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Ron < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Sek < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Sgd < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Usd < ::Stripe::StripeObject
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field aed
        sig { returns(T.nilable(Aed)) }
        def aed; end
        # Attribute for field aud
        sig { returns(T.nilable(Aud)) }
        def aud; end
        # Attribute for field bgn
        sig { returns(T.nilable(Bgn)) }
        def bgn; end
        # Attribute for field cad
        sig { returns(T.nilable(Cad)) }
        def cad; end
        # Attribute for field chf
        sig { returns(T.nilable(Chf)) }
        def chf; end
        # Attribute for field czk
        sig { returns(T.nilable(Czk)) }
        def czk; end
        # Attribute for field dkk
        sig { returns(T.nilable(Dkk)) }
        def dkk; end
        # Attribute for field eur
        sig { returns(T.nilable(Eur)) }
        def eur; end
        # Attribute for field gbp
        sig { returns(T.nilable(Gbp)) }
        def gbp; end
        # Attribute for field gip
        sig { returns(T.nilable(Gip)) }
        def gip; end
        # Attribute for field hkd
        sig { returns(T.nilable(Hkd)) }
        def hkd; end
        # Attribute for field huf
        sig { returns(T.nilable(Huf)) }
        def huf; end
        # Attribute for field jpy
        sig { returns(T.nilable(Jpy)) }
        def jpy; end
        # Attribute for field mxn
        sig { returns(T.nilable(Mxn)) }
        def mxn; end
        # Attribute for field myr
        sig { returns(T.nilable(Myr)) }
        def myr; end
        # Attribute for field nok
        sig { returns(T.nilable(Nok)) }
        def nok; end
        # Attribute for field nzd
        sig { returns(T.nilable(Nzd)) }
        def nzd; end
        # Attribute for field pln
        sig { returns(T.nilable(Pln)) }
        def pln; end
        # Attribute for field ron
        sig { returns(T.nilable(Ron)) }
        def ron; end
        # Attribute for field sek
        sig { returns(T.nilable(Sek)) }
        def sek; end
        # Attribute for field sgd
        sig { returns(T.nilable(Sgd)) }
        def sgd; end
        # Attribute for field usd
        sig { returns(T.nilable(Usd)) }
        def usd; end
        def self.inner_class_types
          @inner_class_types = {
            aed: Aed,
            aud: Aud,
            bgn: Bgn,
            cad: Cad,
            chf: Chf,
            czk: Czk,
            dkk: Dkk,
            eur: Eur,
            gbp: Gbp,
            gip: Gip,
            hkd: Hkd,
            huf: Huf,
            jpy: Jpy,
            mxn: Mxn,
            myr: Myr,
            nok: Nok,
            nzd: Nzd,
            pln: Pln,
            ron: Ron,
            sek: Sek,
            sgd: Sgd,
            usd: Usd,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class VerifoneP400 < ::Stripe::StripeObject
        # A File ID representing an image to display on the reader
        sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
        def splashscreen; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Wifi < ::Stripe::StripeObject
        class EnterpriseEapPeap < ::Stripe::StripeObject
          # A File ID representing a PEM file containing the server certificate
          sig { returns(T.nilable(String)) }
          def ca_certificate_file; end
          # Password for connecting to the WiFi network
          sig { returns(String) }
          def password; end
          # Name of the WiFi network
          sig { returns(String) }
          def ssid; end
          # Username for connecting to the WiFi network
          sig { returns(String) }
          def username; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class EnterpriseEapTls < ::Stripe::StripeObject
          # A File ID representing a PEM file containing the server certificate
          sig { returns(T.nilable(String)) }
          def ca_certificate_file; end
          # A File ID representing a PEM file containing the client certificate
          sig { returns(String) }
          def client_certificate_file; end
          # A File ID representing a PEM file containing the client RSA private key
          sig { returns(String) }
          def private_key_file; end
          # Password for the private key file
          sig { returns(T.nilable(String)) }
          def private_key_file_password; end
          # Name of the WiFi network
          sig { returns(String) }
          def ssid; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class PersonalPsk < ::Stripe::StripeObject
          # Password for connecting to the WiFi network
          sig { returns(String) }
          def password; end
          # Name of the WiFi network
          sig { returns(String) }
          def ssid; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field enterprise_eap_peap
        sig { returns(T.nilable(EnterpriseEapPeap)) }
        def enterprise_eap_peap; end
        # Attribute for field enterprise_eap_tls
        sig { returns(T.nilable(EnterpriseEapTls)) }
        def enterprise_eap_tls; end
        # Attribute for field personal_psk
        sig { returns(T.nilable(PersonalPsk)) }
        def personal_psk; end
        # Security type of the WiFi network. The hash with the corresponding name contains the credentials for this security type.
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {
            enterprise_eap_peap: EnterpriseEapPeap,
            enterprise_eap_tls: EnterpriseEapTls,
            personal_psk: PersonalPsk,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field bbpos_wisepad3
      sig { returns(T.nilable(BbposWisepad3)) }
      def bbpos_wisepad3; end
      # Attribute for field bbpos_wisepos_e
      sig { returns(T.nilable(BbposWiseposE)) }
      def bbpos_wisepos_e; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Whether this Configuration is the default for your account
      sig { returns(T.nilable(T::Boolean)) }
      def is_account_default; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # String indicating the name of the Configuration object, set by the user
      sig { returns(T.nilable(String)) }
      def name; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Attribute for field offline
      sig { returns(T.nilable(Offline)) }
      def offline; end
      # Attribute for field reboot_window
      sig { returns(T.nilable(RebootWindow)) }
      def reboot_window; end
      # Attribute for field stripe_s700
      sig { returns(T.nilable(StripeS700)) }
      def stripe_s700; end
      # Attribute for field tipping
      sig { returns(T.nilable(Tipping)) }
      def tipping; end
      # Attribute for field verifone_p400
      sig { returns(T.nilable(VerifoneP400)) }
      def verifone_p400; end
      # Attribute for field wifi
      sig { returns(T.nilable(Wifi)) }
      def wifi; end
      # Always true for a deleted object
      sig { returns(T.nilable(T::Boolean)) }
      def deleted; end
      # Creates a new Configuration object.
      sig {
        params(params: T.any(::Stripe::Terminal::ConfigurationCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Configuration)
       }
      def self.create(params = {}, opts = {}); end

      # Deletes a Configuration object.
      sig {
        params(configuration: String, params: T.any(::Stripe::Terminal::ConfigurationDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Configuration)
       }
      def self.delete(configuration, params = {}, opts = {}); end

      # Deletes a Configuration object.
      sig {
        params(params: T.any(::Stripe::Terminal::ConfigurationDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Configuration)
       }
      def delete(params = {}, opts = {}); end

      # Returns a list of Configuration objects.
      sig {
        params(params: T.any(::Stripe::Terminal::ConfigurationListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Updates a new Configuration object.
      sig {
        params(configuration: String, params: T.any(::Stripe::Terminal::ConfigurationUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Configuration)
       }
      def self.update(configuration, params = {}, opts = {}); end
    end
  end
end