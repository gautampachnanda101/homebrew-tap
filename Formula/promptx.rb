# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc12"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc12/promptx_Darwin_x86_64.tar.gz"
      sha256 "cc8650a34b25f6798621b32ce5fbbb6fe1bda2a3a8bba7fb90f78b8471130de9"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc12/promptx_Darwin_arm64.tar.gz"
      sha256 "1df5142d4c13100c76eb11bab787e3200e6be0d1ad12a6ce595d11d52c37166d"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc12/promptx_Linux_x86_64.tar.gz"
        sha256 "90f0152032c7d64c69326baaadc1cd5915d81c05e8f466cb9e71deaf6c8c3d67"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc12/promptx_Linux_arm64.tar.gz"
        sha256 "2a799805e7374f53de8597925ee699d45f5ea17220b016b355f324a6265bc5ec"

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
