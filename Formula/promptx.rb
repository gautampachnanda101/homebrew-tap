# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc8"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc8/promptx_Darwin_x86_64.tar.gz"
      sha256 "8b23fc47ea4b77aa32fcf3e7bdb67ee9d4c7d68dc27214674d0a8c516a010fcd"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc8/promptx_Darwin_arm64.tar.gz"
      sha256 "bb3ef4836d7cbe2308dce8297c46b0f1bed3bda6e119fc6768fbdc2b4706bb7a"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc8/promptx_Linux_x86_64.tar.gz"
        sha256 "010ad18d30de028d55776a615543f730fa4861a573eaa0a4e5e36e133eafda76"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc8/promptx_Linux_arm64.tar.gz"
        sha256 "5eacaa00bb532f983f76df1de211dfa7a9a94503490c4131f3e7ad00420e4f08"

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
