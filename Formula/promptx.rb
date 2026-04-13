# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc54"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc54/promptx_Darwin_x86_64.tar.gz"
      sha256 "51eb4d8898f337a05f95ed5ea70ab9c784c30d15fffcc62f6abdadd9e1e4b11f"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc54/promptx_Darwin_arm64.tar.gz"
      sha256 "06d6bcc453f72828d88874ac03860da12ab3279032cf26334770b323d6db65ed"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc54/promptx_Linux_x86_64.tar.gz"
        sha256 "7cf07b73c47a2ec438e4d8a5908b81480ccce21739a541ee904ac216a58be6f8"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc54/promptx_Linux_arm64.tar.gz"
        sha256 "1e56b913c3b533b3043183e501f4cc4d0af4d5cceb5554c499840c80de64fa41"
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
    assert_match "0.1.0-rc54", shell_output("#{bin}/promptx version")
  end
end
