# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc62"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc62/promptx_Darwin_x86_64.tar.gz"
      sha256 "8143411f865644debc42b858ce906ad5a7f6fb77fdd6a2ee9775af16ac62a5b6"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc62/promptx_Darwin_arm64.tar.gz"
      sha256 "5199c97975f66d377030de751e400f2c36669a00ea7a8829df2f07575fa8fe1c"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc62/promptx_Linux_x86_64.tar.gz"
        sha256 "656894abce0b702bc61c11e814ec29d9ca204107de25f5c6b383be3095ccb21c"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc62/promptx_Linux_arm64.tar.gz"
        sha256 "31f2cea872f1be9fb51d3163e59dad43127249f15223ec23033bd1cb3e3e6955"
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
    assert_match "0.1.0-rc62", shell_output("#{bin}/promptx version")
  end
end
