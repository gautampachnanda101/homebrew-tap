# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc18"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc18/promptx_Darwin_x86_64.tar.gz"
      sha256 "2c300dd3e777f54d567634a37b07fc599252a2f668f430869d30b3e7a00f3a8c"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc18/promptx_Darwin_arm64.tar.gz"
      sha256 "184bb5a5c5e8de8a90a136e2cbbce32f4a859d0ba30c5ade5ff5d394f87bb83e"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc18/promptx_Linux_x86_64.tar.gz"
        sha256 "d5bb54b2300a300c3bf2e0cff340e54dc2ea744e79ad0c78c2c757b255a42d65"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc18/promptx_Linux_arm64.tar.gz"
        sha256 "190b4021ddc52bdd4f608ab1a800288e1e5db4e3d256ebc3e77ce033101afab8"

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
