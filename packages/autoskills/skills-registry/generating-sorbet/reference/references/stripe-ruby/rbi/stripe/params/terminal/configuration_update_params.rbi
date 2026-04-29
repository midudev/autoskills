# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    class ConfigurationUpdateParams < ::Stripe::RequestParams
      class BbposWisepad3 < ::Stripe::RequestParams
        # A File ID representing an image you want to display on the reader.
        sig { returns(T.nilable(String)) }
        def splashscreen; end
        sig { params(_splashscreen: T.nilable(String)).returns(T.nilable(String)) }
        def splashscreen=(_splashscreen); end
        sig { params(splashscreen: T.nilable(String)).void }
        def initialize(splashscreen: nil); end
      end
      class BbposWiseposE < ::Stripe::RequestParams
        # A File ID representing an image to display on the reader
        sig { returns(T.nilable(String)) }
        def splashscreen; end
        sig { params(_splashscreen: T.nilable(String)).returns(T.nilable(String)) }
        def splashscreen=(_splashscreen); end
        sig { params(splashscreen: T.nilable(String)).void }
        def initialize(splashscreen: nil); end
      end
      class Offline < ::Stripe::RequestParams
        # Determines whether to allow transactions to be collected while reader is offline. Defaults to false.
        sig { returns(T::Boolean) }
        def enabled; end
        sig { params(_enabled: T::Boolean).returns(T::Boolean) }
        def enabled=(_enabled); end
        sig { params(enabled: T::Boolean).void }
        def initialize(enabled: nil); end
      end
      class RebootWindow < ::Stripe::RequestParams
        # Integer between 0 to 23 that represents the end hour of the reboot time window. The value must be different than the start_hour.
        sig { returns(Integer) }
        def end_hour; end
        sig { params(_end_hour: Integer).returns(Integer) }
        def end_hour=(_end_hour); end
        # Integer between 0 to 23 that represents the start hour of the reboot time window.
        sig { returns(Integer) }
        def start_hour; end
        sig { params(_start_hour: Integer).returns(Integer) }
        def start_hour=(_start_hour); end
        sig { params(end_hour: Integer, start_hour: Integer).void }
        def initialize(end_hour: nil, start_hour: nil); end
      end
      class StripeS700 < ::Stripe::RequestParams
        # A File ID representing an image you want to display on the reader.
        sig { returns(T.nilable(String)) }
        def splashscreen; end
        sig { params(_splashscreen: T.nilable(String)).returns(T.nilable(String)) }
        def splashscreen=(_splashscreen); end
        sig { params(splashscreen: T.nilable(String)).void }
        def initialize(splashscreen: nil); end
      end
      class Tipping < ::Stripe::RequestParams
        class Aed < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Aud < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Bgn < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Cad < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Chf < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Czk < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Dkk < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Eur < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Gbp < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Gip < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Hkd < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Huf < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Jpy < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Mxn < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Myr < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Nok < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Nzd < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Pln < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Ron < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Sek < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Sgd < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        class Usd < ::Stripe::RequestParams
          # Fixed amounts displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def fixed_amounts; end
          sig {
            params(_fixed_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def fixed_amounts=(_fixed_amounts); end
          # Percentages displayed when collecting a tip
          sig { returns(T.nilable(T::Array[Integer])) }
          def percentages; end
          sig {
            params(_percentages: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def percentages=(_percentages); end
          # Below this amount, fixed amounts will be displayed; above it, percentages will be displayed
          sig { returns(T.nilable(Integer)) }
          def smart_tip_threshold; end
          sig { params(_smart_tip_threshold: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def smart_tip_threshold=(_smart_tip_threshold); end
          sig {
            params(fixed_amounts: T.nilable(T::Array[Integer]), percentages: T.nilable(T::Array[Integer]), smart_tip_threshold: T.nilable(Integer)).void
           }
          def initialize(fixed_amounts: nil, percentages: nil, smart_tip_threshold: nil); end
        end
        # Tipping configuration for AED
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Aed)) }
        def aed; end
        sig {
          params(_aed: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Aed)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Aed))
         }
        def aed=(_aed); end
        # Tipping configuration for AUD
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Aud)) }
        def aud; end
        sig {
          params(_aud: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Aud)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Aud))
         }
        def aud=(_aud); end
        # Tipping configuration for BGN
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Bgn)) }
        def bgn; end
        sig {
          params(_bgn: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Bgn)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Bgn))
         }
        def bgn=(_bgn); end
        # Tipping configuration for CAD
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Cad)) }
        def cad; end
        sig {
          params(_cad: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Cad)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Cad))
         }
        def cad=(_cad); end
        # Tipping configuration for CHF
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Chf)) }
        def chf; end
        sig {
          params(_chf: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Chf)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Chf))
         }
        def chf=(_chf); end
        # Tipping configuration for CZK
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Czk)) }
        def czk; end
        sig {
          params(_czk: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Czk)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Czk))
         }
        def czk=(_czk); end
        # Tipping configuration for DKK
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Dkk)) }
        def dkk; end
        sig {
          params(_dkk: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Dkk)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Dkk))
         }
        def dkk=(_dkk); end
        # Tipping configuration for EUR
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Eur)) }
        def eur; end
        sig {
          params(_eur: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Eur)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Eur))
         }
        def eur=(_eur); end
        # Tipping configuration for GBP
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Gbp)) }
        def gbp; end
        sig {
          params(_gbp: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Gbp)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Gbp))
         }
        def gbp=(_gbp); end
        # Tipping configuration for GIP
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Gip)) }
        def gip; end
        sig {
          params(_gip: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Gip)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Gip))
         }
        def gip=(_gip); end
        # Tipping configuration for HKD
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Hkd)) }
        def hkd; end
        sig {
          params(_hkd: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Hkd)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Hkd))
         }
        def hkd=(_hkd); end
        # Tipping configuration for HUF
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Huf)) }
        def huf; end
        sig {
          params(_huf: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Huf)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Huf))
         }
        def huf=(_huf); end
        # Tipping configuration for JPY
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Jpy)) }
        def jpy; end
        sig {
          params(_jpy: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Jpy)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Jpy))
         }
        def jpy=(_jpy); end
        # Tipping configuration for MXN
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Mxn)) }
        def mxn; end
        sig {
          params(_mxn: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Mxn)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Mxn))
         }
        def mxn=(_mxn); end
        # Tipping configuration for MYR
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Myr)) }
        def myr; end
        sig {
          params(_myr: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Myr)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Myr))
         }
        def myr=(_myr); end
        # Tipping configuration for NOK
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Nok)) }
        def nok; end
        sig {
          params(_nok: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Nok)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Nok))
         }
        def nok=(_nok); end
        # Tipping configuration for NZD
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Nzd)) }
        def nzd; end
        sig {
          params(_nzd: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Nzd)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Nzd))
         }
        def nzd=(_nzd); end
        # Tipping configuration for PLN
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Pln)) }
        def pln; end
        sig {
          params(_pln: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Pln)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Pln))
         }
        def pln=(_pln); end
        # Tipping configuration for RON
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Ron)) }
        def ron; end
        sig {
          params(_ron: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Ron)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Ron))
         }
        def ron=(_ron); end
        # Tipping configuration for SEK
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Sek)) }
        def sek; end
        sig {
          params(_sek: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Sek)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Sek))
         }
        def sek=(_sek); end
        # Tipping configuration for SGD
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Sgd)) }
        def sgd; end
        sig {
          params(_sgd: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Sgd)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Sgd))
         }
        def sgd=(_sgd); end
        # Tipping configuration for USD
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Usd)) }
        def usd; end
        sig {
          params(_usd: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Usd)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Usd))
         }
        def usd=(_usd); end
        sig {
          params(aed: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Aed), aud: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Aud), bgn: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Bgn), cad: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Cad), chf: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Chf), czk: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Czk), dkk: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Dkk), eur: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Eur), gbp: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Gbp), gip: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Gip), hkd: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Hkd), huf: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Huf), jpy: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Jpy), mxn: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Mxn), myr: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Myr), nok: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Nok), nzd: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Nzd), pln: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Pln), ron: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Ron), sek: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Sek), sgd: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Sgd), usd: T.nilable(Terminal::ConfigurationUpdateParams::Tipping::Usd)).void
         }
        def initialize(
          aed: nil,
          aud: nil,
          bgn: nil,
          cad: nil,
          chf: nil,
          czk: nil,
          dkk: nil,
          eur: nil,
          gbp: nil,
          gip: nil,
          hkd: nil,
          huf: nil,
          jpy: nil,
          mxn: nil,
          myr: nil,
          nok: nil,
          nzd: nil,
          pln: nil,
          ron: nil,
          sek: nil,
          sgd: nil,
          usd: nil
        ); end
      end
      class VerifoneP400 < ::Stripe::RequestParams
        # A File ID representing an image you want to display on the reader.
        sig { returns(T.nilable(String)) }
        def splashscreen; end
        sig { params(_splashscreen: T.nilable(String)).returns(T.nilable(String)) }
        def splashscreen=(_splashscreen); end
        sig { params(splashscreen: T.nilable(String)).void }
        def initialize(splashscreen: nil); end
      end
      class Wifi < ::Stripe::RequestParams
        class EnterpriseEapPeap < ::Stripe::RequestParams
          # A File ID representing a PEM file containing the server certificate
          sig { returns(T.nilable(String)) }
          def ca_certificate_file; end
          sig { params(_ca_certificate_file: T.nilable(String)).returns(T.nilable(String)) }
          def ca_certificate_file=(_ca_certificate_file); end
          # Password for connecting to the WiFi network
          sig { returns(String) }
          def password; end
          sig { params(_password: String).returns(String) }
          def password=(_password); end
          # Name of the WiFi network
          sig { returns(String) }
          def ssid; end
          sig { params(_ssid: String).returns(String) }
          def ssid=(_ssid); end
          # Username for connecting to the WiFi network
          sig { returns(String) }
          def username; end
          sig { params(_username: String).returns(String) }
          def username=(_username); end
          sig {
            params(ca_certificate_file: T.nilable(String), password: String, ssid: String, username: String).void
           }
          def initialize(ca_certificate_file: nil, password: nil, ssid: nil, username: nil); end
        end
        class EnterpriseEapTls < ::Stripe::RequestParams
          # A File ID representing a PEM file containing the server certificate
          sig { returns(T.nilable(String)) }
          def ca_certificate_file; end
          sig { params(_ca_certificate_file: T.nilable(String)).returns(T.nilable(String)) }
          def ca_certificate_file=(_ca_certificate_file); end
          # A File ID representing a PEM file containing the client certificate
          sig { returns(String) }
          def client_certificate_file; end
          sig { params(_client_certificate_file: String).returns(String) }
          def client_certificate_file=(_client_certificate_file); end
          # A File ID representing a PEM file containing the client RSA private key
          sig { returns(String) }
          def private_key_file; end
          sig { params(_private_key_file: String).returns(String) }
          def private_key_file=(_private_key_file); end
          # Password for the private key file
          sig { returns(T.nilable(String)) }
          def private_key_file_password; end
          sig { params(_private_key_file_password: T.nilable(String)).returns(T.nilable(String)) }
          def private_key_file_password=(_private_key_file_password); end
          # Name of the WiFi network
          sig { returns(String) }
          def ssid; end
          sig { params(_ssid: String).returns(String) }
          def ssid=(_ssid); end
          sig {
            params(ca_certificate_file: T.nilable(String), client_certificate_file: String, private_key_file: String, private_key_file_password: T.nilable(String), ssid: String).void
           }
          def initialize(
            ca_certificate_file: nil,
            client_certificate_file: nil,
            private_key_file: nil,
            private_key_file_password: nil,
            ssid: nil
          ); end
        end
        class PersonalPsk < ::Stripe::RequestParams
          # Password for connecting to the WiFi network
          sig { returns(String) }
          def password; end
          sig { params(_password: String).returns(String) }
          def password=(_password); end
          # Name of the WiFi network
          sig { returns(String) }
          def ssid; end
          sig { params(_ssid: String).returns(String) }
          def ssid=(_ssid); end
          sig { params(password: String, ssid: String).void }
          def initialize(password: nil, ssid: nil); end
        end
        # Credentials for a WPA-Enterprise WiFi network using the EAP-PEAP authentication method.
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Wifi::EnterpriseEapPeap)) }
        def enterprise_eap_peap; end
        sig {
          params(_enterprise_eap_peap: T.nilable(Terminal::ConfigurationUpdateParams::Wifi::EnterpriseEapPeap)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Wifi::EnterpriseEapPeap))
         }
        def enterprise_eap_peap=(_enterprise_eap_peap); end
        # Credentials for a WPA-Enterprise WiFi network using the EAP-TLS authentication method.
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Wifi::EnterpriseEapTls)) }
        def enterprise_eap_tls; end
        sig {
          params(_enterprise_eap_tls: T.nilable(Terminal::ConfigurationUpdateParams::Wifi::EnterpriseEapTls)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Wifi::EnterpriseEapTls))
         }
        def enterprise_eap_tls=(_enterprise_eap_tls); end
        # Credentials for a WPA-Personal WiFi network.
        sig { returns(T.nilable(Terminal::ConfigurationUpdateParams::Wifi::PersonalPsk)) }
        def personal_psk; end
        sig {
          params(_personal_psk: T.nilable(Terminal::ConfigurationUpdateParams::Wifi::PersonalPsk)).returns(T.nilable(Terminal::ConfigurationUpdateParams::Wifi::PersonalPsk))
         }
        def personal_psk=(_personal_psk); end
        # Security type of the WiFi network. Fill out the hash with the corresponding name to provide the set of credentials for this security type.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        sig {
          params(enterprise_eap_peap: T.nilable(Terminal::ConfigurationUpdateParams::Wifi::EnterpriseEapPeap), enterprise_eap_tls: T.nilable(Terminal::ConfigurationUpdateParams::Wifi::EnterpriseEapTls), personal_psk: T.nilable(Terminal::ConfigurationUpdateParams::Wifi::PersonalPsk), type: String).void
         }
        def initialize(
          enterprise_eap_peap: nil,
          enterprise_eap_tls: nil,
          personal_psk: nil,
          type: nil
        ); end
      end
      # An object containing device type specific settings for BBPOS WisePad 3 readers.
      sig { returns(T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::BbposWisepad3))) }
      def bbpos_wisepad3; end
      sig {
        params(_bbpos_wisepad3: T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::BbposWisepad3))).returns(T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::BbposWisepad3)))
       }
      def bbpos_wisepad3=(_bbpos_wisepad3); end
      # An object containing device type specific settings for BBPOS WisePOS E readers.
      sig { returns(T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::BbposWiseposE))) }
      def bbpos_wisepos_e; end
      sig {
        params(_bbpos_wisepos_e: T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::BbposWiseposE))).returns(T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::BbposWiseposE)))
       }
      def bbpos_wisepos_e=(_bbpos_wisepos_e); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Name of the configuration
      sig { returns(T.nilable(String)) }
      def name; end
      sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
      def name=(_name); end
      # Configurations for collecting transactions offline.
      sig { returns(T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::Offline))) }
      def offline; end
      sig {
        params(_offline: T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::Offline))).returns(T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::Offline)))
       }
      def offline=(_offline); end
      # Reboot time settings for readers. that support customized reboot time configuration.
      sig { returns(T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::RebootWindow))) }
      def reboot_window; end
      sig {
        params(_reboot_window: T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::RebootWindow))).returns(T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::RebootWindow)))
       }
      def reboot_window=(_reboot_window); end
      # An object containing device type specific settings for Stripe S700 readers.
      sig { returns(T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::StripeS700))) }
      def stripe_s700; end
      sig {
        params(_stripe_s700: T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::StripeS700))).returns(T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::StripeS700)))
       }
      def stripe_s700=(_stripe_s700); end
      # Tipping configurations for readers. supporting on-reader tips
      sig { returns(T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::Tipping))) }
      def tipping; end
      sig {
        params(_tipping: T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::Tipping))).returns(T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::Tipping)))
       }
      def tipping=(_tipping); end
      # An object containing device type specific settings for Verifone P400 readers.
      sig { returns(T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::VerifoneP400))) }
      def verifone_p400; end
      sig {
        params(_verifone_p400: T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::VerifoneP400))).returns(T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::VerifoneP400)))
       }
      def verifone_p400=(_verifone_p400); end
      # Configurations for connecting to a WiFi network.
      sig { returns(T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::Wifi))) }
      def wifi; end
      sig {
        params(_wifi: T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::Wifi))).returns(T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::Wifi)))
       }
      def wifi=(_wifi); end
      sig {
        params(bbpos_wisepad3: T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::BbposWisepad3)), bbpos_wisepos_e: T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::BbposWiseposE)), expand: T.nilable(T::Array[String]), name: T.nilable(String), offline: T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::Offline)), reboot_window: T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::RebootWindow)), stripe_s700: T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::StripeS700)), tipping: T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::Tipping)), verifone_p400: T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::VerifoneP400)), wifi: T.nilable(T.any(String, Terminal::ConfigurationUpdateParams::Wifi))).void
       }
      def initialize(
        bbpos_wisepad3: nil,
        bbpos_wisepos_e: nil,
        expand: nil,
        name: nil,
        offline: nil,
        reboot_window: nil,
        stripe_s700: nil,
        tipping: nil,
        verifone_p400: nil,
        wifi: nil
      ); end
    end
  end
end