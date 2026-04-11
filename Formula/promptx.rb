# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc28"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc28/promptx_Darwin_x86_64.tar.gz"
      sha256 "93ff2d52d1d70a0d97476f52662a209a9bf4722d7222c7b69df5c4a8a941288a"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc28/promptx_Darwin_arm64.tar.gz"
      sha256 "f043bd29e6e298a01c04a732d55314a2167b28c03bc43c51172eccc15f4253c8"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc28/promptx_Linux_x86_64.tar.gz"
        sha256 "13a9e654e4b2578293e12a6cb6c4fe26671e1a26f870e7002f90533e111e3537"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc28/promptx_Linux_arm64.tar.gz"
        sha256 "3eee0bbe529565f0dcb57fda91909ddadbb0956cb35856de95d333ef6e8e3e99"

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
