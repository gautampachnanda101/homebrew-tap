# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc31"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc31/promptx_Darwin_x86_64.tar.gz"
      sha256 "6adff6746ee6122019262b277cff83a0c08efb9616121e09e7491a661e3a9830"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc31/promptx_Darwin_arm64.tar.gz"
      sha256 "9067e95c25bdef9b10f2e49d3ed0b6bdcca2c28a4190104f0f1b2b950d153532"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc31/promptx_Linux_x86_64.tar.gz"
        sha256 "3061074ed23aff79fcf077efeea74838fe9d77676d79d2ad363a0a89c9257f45"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc31/promptx_Linux_arm64.tar.gz"
        sha256 "329e004315cc4747fb28a29a85c9df2aff44335f0bf95728f63db425f21941e4"

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
