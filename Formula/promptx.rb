# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc26"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc26/promptx_Darwin_x86_64.tar.gz"
      sha256 "2965b6dc54befef5ab41e2766d369248c30de712efd85d7b680c5c10e505331f"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc26/promptx_Darwin_arm64.tar.gz"
      sha256 "1a82612c529f122d0ddd3e6a225c05601c93cf8a674de623d19a6582717ce333"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc26/promptx_Linux_x86_64.tar.gz"
        sha256 "34b40112a5a1da734c42cbf54b8db48eb9767e10e589d5b63599056d8d30642e"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc26/promptx_Linux_arm64.tar.gz"
        sha256 "9cb2d2dc512a7065325146837f0ff52c6b9ed4070df40442aacff928c5de3c80"

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
