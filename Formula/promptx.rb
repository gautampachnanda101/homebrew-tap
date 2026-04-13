# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc59"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc59/promptx_Darwin_x86_64.tar.gz"
      sha256 "f46b59c29167e9ef2db91cacb8a164c023ff4ecc6e2e27ff15f89b99e08af551"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc59/promptx_Darwin_arm64.tar.gz"
      sha256 "e8b53264730925d508183baefe017a5858fbbfca55bd43dc0c00d9b611fef0ab"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc59/promptx_Linux_x86_64.tar.gz"
        sha256 "fbe034c9e47b9fa14575deb305c7a34aef6cf2a517482ea6a915af2119f46271"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc59/promptx_Linux_arm64.tar.gz"
        sha256 "e6529fa01beebfc041864361ce102b150c4b844548d337cae493c92c80907569"
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
    assert_match "0.1.0-rc59", shell_output("#{bin}/promptx version")
  end
end
