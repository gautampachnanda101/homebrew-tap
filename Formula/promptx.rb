# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc5"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc5/promptx_Darwin_x86_64.tar.gz"
      sha256 "814772697bacd6efa2b753572eaa7b788918f65f6f5f4aec5cff7cdd501b141c"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc5/promptx_Darwin_arm64.tar.gz"
      sha256 "e8ba085e54fcb4f10290723331382ac177106a6eb502aa86661d49475b3c531f"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc5/promptx_Linux_x86_64.tar.gz"
        sha256 "99ad29f43b95855d7d2f5f0e689da7d2d803231b956e2d3d13b54166427b9046"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc5/promptx_Linux_arm64.tar.gz"
        sha256 "f14b0cc9ecff3611016953ec27ec2e5f3533032852abb36df85c42fffb619117"

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
