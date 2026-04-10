# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc15"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc15/promptx_Darwin_x86_64.tar.gz"
      sha256 "b9354039e22c8cfa28e19b14b84f0ed022dd650950b0a9ecf3f7b731bc57e8f7"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc15/promptx_Darwin_arm64.tar.gz"
      sha256 "b684b8bfa73420c8290d15da1e8b66a27b087dc68bec19a2dad6bad9bb3b8597"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc15/promptx_Linux_x86_64.tar.gz"
        sha256 "1f47bb0a149de78ee28547ca45923a70545d021dbb53016a27f11bfaa7650b94"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc15/promptx_Linux_arm64.tar.gz"
        sha256 "ee18e44ed337a0eb09e931afe9e62865adec54f7bdc91b034aae38fd2fb03ab1"

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
