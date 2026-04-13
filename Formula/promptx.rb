# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc60"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc60/promptx_Darwin_x86_64.tar.gz"
      sha256 "4cf99fa88557a2aa3f6eb6ef482dbc596c6782588c7ccf51de390838ce79eb77"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc60/promptx_Darwin_arm64.tar.gz"
      sha256 "986cb1513987d142e742d11237fa9c0f67099720c87203d550fb94f63e888e9b"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc60/promptx_Linux_x86_64.tar.gz"
        sha256 "ecdbc934d9f1f846e9fb85b0a0a9942d390c4b6f565bc2e6eec111abc3bd0be6"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc60/promptx_Linux_arm64.tar.gz"
        sha256 "e3b156c08cdcf07be46ae3c1ab4557be04efb3a2bd78d5a143eb21a5f16565e3"
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
    assert_match "0.1.0-rc60", shell_output("#{bin}/promptx version")
  end
end
