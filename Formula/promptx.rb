# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc30"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc30/promptx_Darwin_x86_64.tar.gz"
      sha256 "63c6ac9b087a61c4e80b649c5dec73af41c4f061705770f5eaab209590e36b1a"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc30/promptx_Darwin_arm64.tar.gz"
      sha256 "d98bbc3c5a9c5fcabd95a5514b1937f80fe46ec619ebb2623ed7a50c92f7430f"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc30/promptx_Linux_x86_64.tar.gz"
        sha256 "64080ebf50c6f41f5e15e9cbb565fe2e35bdac359f61db8f4b355c10421481dd"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc30/promptx_Linux_arm64.tar.gz"
        sha256 "e999f1cd29f23b4191820bb9a20ffb0f14265f7a55df404bb997a00dcf80b09a"

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
