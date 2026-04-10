# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc23"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc23/promptx_Darwin_x86_64.tar.gz"
      sha256 "cd211b76a44c1587d3c73b283e71ae7d09e2fffea879473c97a1940b9b01dd66"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc23/promptx_Darwin_arm64.tar.gz"
      sha256 "9d492d1ebd92b0abaf49e5a72205f294a1aa755890de1768497bd0ad6f27ae9f"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc23/promptx_Linux_x86_64.tar.gz"
        sha256 "ee24834b29b04a35c73fc1cdb41f06f3459a427a47eb70ac32f09df8aa0c643d"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc23/promptx_Linux_arm64.tar.gz"
        sha256 "28b18a78afa29eeb86bcba32302dabded272af470be997ae1d266651e008bbad"

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
