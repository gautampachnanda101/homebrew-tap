# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc57"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc57/promptx_Darwin_x86_64.tar.gz"
      sha256 "2a232bfd5c602cb7c7fe5fb283297be45ae79dcac74474e107043258c18e96d5"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc57/promptx_Darwin_arm64.tar.gz"
      sha256 "b7034556dfdedbd36eabc1abf1a24716cca5fe977c775a3e04f4f9e63a576fb9"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc57/promptx_Linux_x86_64.tar.gz"
        sha256 "0e2948376855b8080016cbcd2fa8185eaf7dc88545413b29639b54049331fedc"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc57/promptx_Linux_arm64.tar.gz"
        sha256 "0143a318da43b7515a1adb22f31f465c951c937dc0d8fdc2dc409e7df27cb8e9"
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
    assert_match "0.1.0-rc57", shell_output("#{bin}/promptx version")
  end
end
