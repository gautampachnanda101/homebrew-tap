# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc9"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc9/promptx_Darwin_x86_64.tar.gz"
      sha256 "48619f69a6d72d8fe090cc42f648dd1ac64c43d4b12c1691cf4ebd8913c52a86"

      def install
        bin.install "promptx"
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc9/promptx_Darwin_arm64.tar.gz"
      sha256 "f26ae09467ad1d42e63281379ba90685d99593e1d32fa2f1e24997b240f3a5a3"

      def install
        bin.install "promptx"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc9/promptx_Linux_x86_64.tar.gz"
        sha256 "1cd1dd3992050633f96250b060a9f2c215ae8a2ec25cbf02f6898ed1c1635ea9"

        def install
          bin.install "promptx"
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc9/promptx_Linux_arm64.tar.gz"
        sha256 "d189dbc40d60d1284c50709437777225d200cd93f73879d2cee8c2a9ec5ec469"

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
