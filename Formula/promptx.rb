# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc6"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc6/promptx_Darwin_x86_64.tar.gz"
      sha256 "3ce5b1aea570d5a029baba1e928814827fade8708d22d2d3afad392bcbb9244c"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc6/promptx_Darwin_arm64.tar.gz"
      sha256 "6301d3a8e9fe60ab4296c60ab778f517f4091f02bd98ac0e8e269ced1172c3de"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc6/promptx_Linux_x86_64.tar.gz"
        sha256 "6c9e9f2517b8a5ae72333ed15d14da294579ccd4c63ee1a77415097e8df6f847"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc6/promptx_Linux_arm64.tar.gz"
        sha256 "769e27274632c020dc56467efc86a34592d2f0ac034f9ac6c455516e2c2b2261"

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
