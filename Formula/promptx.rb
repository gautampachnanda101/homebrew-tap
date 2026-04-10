# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc16"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc16/promptx_Darwin_x86_64.tar.gz"
      sha256 "00f6c0549014d07518c6e14e2efcde1d959534bf73d21988194b7a6f335ef4d0"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc16/promptx_Darwin_arm64.tar.gz"
      sha256 "7eba58bec5c9b0bfef8ec2c6b0ac85cde649f72a7d8a5bd3b7926abbb94b754d"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc16/promptx_Linux_x86_64.tar.gz"
        sha256 "0e8b2b129d99fcc1ad597ea6f17f53ce3a826c10718a016b9fcd4a8792eb3cbf"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc16/promptx_Linux_arm64.tar.gz"
        sha256 "1134f92a0cf89619ab887dd2d278c0bc575d02cf1aee84a41246ec089de7a5ea"

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
