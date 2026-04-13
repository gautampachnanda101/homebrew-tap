# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc61"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc61/promptx_Darwin_x86_64.tar.gz"
      sha256 "db6f911a10395a4c18b5b172911c46267245ad33067a1e6ea46a20ec3534b81f"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc61/promptx_Darwin_arm64.tar.gz"
      sha256 "14540aba1c47b022540fe9aca124ed85145e042953eadaecd54da64e233758e0"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc61/promptx_Linux_x86_64.tar.gz"
        sha256 "33b9b56ab1dcb40931d202a7a11592c8c0e8f30f51081dfa11c36b1fd6dbb69d"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc61/promptx_Linux_arm64.tar.gz"
        sha256 "7435f06eb85fc8242496f4e2ee9ea11656a38e856e9cca8e5d508ed4111c5d6e"
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
    assert_match "0.1.0-rc61", shell_output("#{bin}/promptx version")
  end
end
