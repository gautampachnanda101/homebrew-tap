# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc40"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc40/promptx_Darwin_x86_64.tar.gz"
      sha256 "27c154219185ad5557407a8ad33fd62a0feb8315bdbefa2be127c94e9713563f"

      def install
        bin.install "promptx"
        (share/"promptx").install Dir["promptx-vscode-*.vsix"]
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc40/promptx_Darwin_arm64.tar.gz"
      sha256 "7792b14a54729d960c92946d7b2e7e8ce17421d0a5fde99a0a46759b2061fa28"

      def install
        bin.install "promptx"
        (share/"promptx").install Dir["promptx-vscode-*.vsix"]
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc40/promptx_Linux_x86_64.tar.gz"
        sha256 "e184b57caab98d98ffc766394c7d75ecf53a38955b5d0012380c5de45e31851d"

        def install
          bin.install "promptx"
          (share/"promptx").install Dir["promptx-vscode-*.vsix"]
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc40/promptx_Linux_arm64.tar.gz"
        sha256 "886dfe5e6dfb6315d5b5ad119a984b7a1eb6100d6763f2d5bf88d6df20d9698a"

        def install
          bin.install "promptx"
          (share/"promptx").install Dir["promptx-vscode-*.vsix"]
        end
      end
    end
  end

  def caveats
    vsix = Dir["#{share}/promptx/promptx-vscode-*.vsix"].first
    return if vsix.nil?
    <<~EOS
      To install the Promptx VS Code extension, run:
        code --install-extension #{vsix}

      The extension provides the @promptx chat participant, memory
      sidebar, passkey management, and cross-tool handoff commands.
    EOS
  end

  test do
    assert_match "Local-first encrypted prompt intelligence CLI", shell_output("#{bin}/promptx --help")
  end
end
