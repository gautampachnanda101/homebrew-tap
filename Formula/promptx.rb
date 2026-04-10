# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc19"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc19/promptx_Darwin_x86_64.tar.gz"
      sha256 "a04eb4d187bf4f2835e1edc2df223610016de96ba8776052f506469e6078515b"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc19/promptx_Darwin_arm64.tar.gz"
      sha256 "8598ef2b775a9104af954df9dc4ff6ff461d6567c48147d1d2e1b4c4ac5b0184"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc19/promptx_Linux_x86_64.tar.gz"
        sha256 "3267d5c694b2ff4659dac4554e66dcb3de8d584f349bff7f544717ec2329edfd"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc19/promptx_Linux_arm64.tar.gz"
        sha256 "b4e5419aef5f449ffd8b071a6a357445c09ec93459e8698b67f0669b67eb72bd"

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
