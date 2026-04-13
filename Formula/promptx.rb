# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc55"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc55/promptx_Darwin_x86_64.tar.gz"
      sha256 "f5d704f0b41d196e696405264caf20ca83f59baf550532ac77860ee0e533f2b5"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc55/promptx_Darwin_arm64.tar.gz"
      sha256 "2746a0466ae8855b0f6f89f52eaeac639ff08d171321667e9a508920e736bcfd"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc55/promptx_Linux_x86_64.tar.gz"
        sha256 "1d0a5346568df67ace629f84f017346c825536e8d48d472a52a965e1d92029b1"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc55/promptx_Linux_arm64.tar.gz"
        sha256 "a835b96608b92d0171437fa370aa0a9f0f331cb24fb2578429c072e8c7bbc9ba"
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
    assert_match "0.1.0-rc55", shell_output("#{bin}/promptx version")
  end
end
