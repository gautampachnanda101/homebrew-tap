# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc25"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc25/promptx_Darwin_x86_64.tar.gz"
      sha256 "d4375f132ca136113739000f78c5535a52df0238185a9fb09472b1d8948e78f5"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc25/promptx_Darwin_arm64.tar.gz"
      sha256 "33a1ac5d6e6e9363e5b9a8c7c837fa2c276be27c65d6bfd6abbfa10576a80ddb"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc25/promptx_Linux_x86_64.tar.gz"
        sha256 "8553e225eef6c32fe352514f3cb5048fceb0983bd417556a9c7751cef83625b4"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc25/promptx_Linux_arm64.tar.gz"
        sha256 "659f0470b3aa4a5a698b8fc45727987aa6a3146fac36f575c72713e64d9045be"

        def install
          bin.install "promptx"
        end
      end
    end
  end

  test do
    assert_match "Local-first encrypted prompt intelligence CLI", shell_output("#{bin}/promptx --help")
  end
end
