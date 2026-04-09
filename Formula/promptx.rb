# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc7"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc7/promptx_Darwin_x86_64.tar.gz"
      sha256 "cb414b3e375fa7ba4c9a869e93d8224af67239864bfc5090d3ab2ac003afae67"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc7/promptx_Darwin_arm64.tar.gz"
      sha256 "e6e8d36ee8af58c7f96b4f94f8f7633e0338ee049214c1860d2d82afa870a2ff"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc7/promptx_Linux_x86_64.tar.gz"
        sha256 "0acf67437e83059cc78521192e19d0eb41ea8fd150244a89a955ad9902855b11"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc7/promptx_Linux_arm64.tar.gz"
        sha256 "905cb95ab7d25d0931b50719be5fe964abbc4e2b3b689b558cfb558bde832d3c"

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
