# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc21"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc21/promptx_Darwin_x86_64.tar.gz"
      sha256 "8e9e6ed37949790b3aa20d0f2221301a32d5b8b1c33ea8f944649ff5113039c9"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc21/promptx_Darwin_arm64.tar.gz"
      sha256 "4e9b02bf2abe0bbcd85a2576912cc95be49d7364d9600fbb218dab2a0bbf3f94"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc21/promptx_Linux_x86_64.tar.gz"
        sha256 "3f9415f4ebd9c8a56d402cc372fae917c075ead8200991f84edcb24eb4ca4bea"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc21/promptx_Linux_arm64.tar.gz"
        sha256 "ebc6bb43ca0f60df176cdda99782ca65744e067d02c41e052ddae5e4af04cc7c"

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
