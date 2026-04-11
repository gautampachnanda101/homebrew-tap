# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc27"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc27/promptx_Darwin_x86_64.tar.gz"
      sha256 "28ec467c4a41b35326518e6f07e9e59a2c782a4a213ccafb4deaa8b04d66c708"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc27/promptx_Darwin_arm64.tar.gz"
      sha256 "f35218527013227893f6638b15b06c481a9dda153c61da95927d6111c534f3e5"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc27/promptx_Linux_x86_64.tar.gz"
        sha256 "057bdf389415afbb0df727b53b8eb831efe95ae03f7c949683f2ad94d0f12b98"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc27/promptx_Linux_arm64.tar.gz"
        sha256 "72deafe0049ebc3231d4c100c361b3fff2b2f7755ff15c83fd47df25d3fbd403"

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
