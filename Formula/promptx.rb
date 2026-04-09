# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc4"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc4/promptx_Darwin_x86_64.tar.gz"
      sha256 "ebdffc37b625baa993fc3595c4013705337882d3ad6aa0f70e1e15fd04efa97a"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc4/promptx_Darwin_arm64.tar.gz"
      sha256 "31f0d1bdce5238732ed881bc73e101155344a8412acc38b3686cf6c0c5df901e"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc4/promptx_Linux_x86_64.tar.gz"
        sha256 "64605e8bb065064bd67087b644ed1bfbdd564d9f62419bf0fd7480b249fe8736"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc4/promptx_Linux_arm64.tar.gz"
        sha256 "75843461822f0dd52e5071562477676073e5f926d30857402a0931ca2ead7ca3"

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
