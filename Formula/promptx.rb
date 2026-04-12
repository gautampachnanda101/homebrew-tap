# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc37"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc37/promptx_Darwin_x86_64.tar.gz"
      sha256 "a5eb8a86cbec4f6a33190d424ace030e1d2cbba979441f08a13a2f5f3c65f7ed"

      def install
        bin.install "promptx"
        (share/"promptx").install Dir["promptx-vscode-*.vsix"]
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc37/promptx_Darwin_arm64.tar.gz"
      sha256 "18ac5c1a6cd0b8a242502ed6127a1ed164690e03a33dad2982759fd3c86187a7"

      def install
        bin.install "promptx"
        (share/"promptx").install Dir["promptx-vscode-*.vsix"]
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc37/promptx_Linux_x86_64.tar.gz"
        sha256 "3409dece9a31478b587998bc0126d3cb870a8b18891c3c967b0047bdacf99dbe"

        def install
          bin.install "promptx"
          (share/"promptx").install Dir["promptx-vscode-*.vsix"]
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc37/promptx_Linux_arm64.tar.gz"
        sha256 "ebcbd36046d0a4b06829e5ed029254b4ac33be0248f0d44da14c0703aad32e8e"

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
