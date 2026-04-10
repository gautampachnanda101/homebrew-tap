# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc20"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc20/promptx_Darwin_x86_64.tar.gz"
      sha256 "6bedd003a3408ed5e3bc6160ecd151c961f11a0a0aabd70a3c0f73dbd39dba0b"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc20/promptx_Darwin_arm64.tar.gz"
      sha256 "72c7c63fbd7e5c9fd5308aced878833fabc61633d53528297c1c0d11278bed7d"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc20/promptx_Linux_x86_64.tar.gz"
        sha256 "3b57f08840abda025a331f9222b994c58e4f00fd42ce54f6c324675e901371ea"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc20/promptx_Linux_arm64.tar.gz"
        sha256 "c17f51190176aa6c207baed1ad39dbcfdc60a302ef439230f9dcb02e7c9c8794"

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
