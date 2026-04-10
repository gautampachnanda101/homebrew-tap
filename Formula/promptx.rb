# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc17"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc17/promptx_Darwin_x86_64.tar.gz"
      sha256 "46694679765b021d5963d813e3d9e88b2aa02ba29b7e27963247733b6d69b5a6"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc17/promptx_Darwin_arm64.tar.gz"
      sha256 "b50a262ae356d0025915d650db0dbb34ac5c416520dfdeca3bc5a2d697ec44ac"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc17/promptx_Linux_x86_64.tar.gz"
        sha256 "c156421993eac2bd03a01d86cace853239c19cc1244b578acadf17125ba40e3c"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc17/promptx_Linux_arm64.tar.gz"
        sha256 "e6f7adfaf62e5b63b9047a7cb45f7b9170cb40bafa3b3e5838a373471eb79cd0"

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
