# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc56"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc56/promptx_Darwin_x86_64.tar.gz"
      sha256 "b50a90d8411216d5b0598cbcf73f53938345ba927665a35eb4eb33accaf06970"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc56/promptx_Darwin_arm64.tar.gz"
      sha256 "0989b02d89d80f89d9c94985e6cc1ecde326ef8ee9cfbf7c7df6e6f80b52567b"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc56/promptx_Linux_x86_64.tar.gz"
        sha256 "1a9de5d98d591e98d32ed5bd54e4ac677e503e0ac4c14ff30f9f8794d659e36d"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc56/promptx_Linux_arm64.tar.gz"
        sha256 "8b3e5f854360a0657e1fee32b324672e2be9d5ce21f656d34ec73c7053b44f7e"
      end
    end
  end

  # Install prebuilt binaries from release tarball
  def install
    bin.install "promptx"
    (share/"promptx").install Dir["promptx-vscode-*.vsix"]
    doc.install "PROMPTX_USER_GUIDE.md" if File.exist?("PROMPTX_USER_GUIDE.md")
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
    assert_match "0.1.0-rc56", shell_output("#{bin}/promptx version")
  end
end
