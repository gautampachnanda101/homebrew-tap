# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc24"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc24/promptx_Darwin_x86_64.tar.gz"
      sha256 "bd8260a7a7a6453d2477e489aafe106a7fbe8c67fdd44aa1d7d3dd8989a45cd4"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc24/promptx_Darwin_arm64.tar.gz"
      sha256 "a630b8254cbbac682e7adf4a18020938d4f3366380134c7810fcc48311b96296"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc24/promptx_Linux_x86_64.tar.gz"
        sha256 "3e6ff1403f14ae3fd309561a90b05505980f39c6b1d36b7167f0ada2c408ab12"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc24/promptx_Linux_arm64.tar.gz"
        sha256 "e033a853e7e03dcb5a0691df7b2f83d55543b61397dfb69352ad637c046691d0"

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
