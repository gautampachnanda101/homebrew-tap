# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc58"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc58/promptx_Darwin_x86_64.tar.gz"
      sha256 "b94ca2659361a8c0725d09c7e786989c1688f98e4658fd823f77fe50a2feb1bd"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc58/promptx_Darwin_arm64.tar.gz"
      sha256 "a2f3379ea5d54fb4d2cae759d48b249f0d52e043bc96688432f4cb01546bed92"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc58/promptx_Linux_x86_64.tar.gz"
        sha256 "ee22bbcc7604b1fbd08faa11caac72c778759de01dba40c6f581d0acf6b85286"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc58/promptx_Linux_arm64.tar.gz"
        sha256 "ad9331b5c21bbc74bd92b4cd602851d3339d996d9b8734b16bd033b8a9ad1edf"
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
    assert_match "0.1.0-rc58", shell_output("#{bin}/promptx version")
  end
end
