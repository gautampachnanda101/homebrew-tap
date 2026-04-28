# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc96"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc96/promptx_Darwin_x86_64.tar.gz"
      sha256 "1a952157e3c9f92f2d233dd71ecc358e1c17303ffd54b7fec46f2ae467e255f6"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc96/promptx_Darwin_arm64.tar.gz"
      sha256 "0a42c0b1560d1ffff2b4c8dacdde3dbd60be3621614048c02c9efc5509915943"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc96/promptx_Linux_x86_64.tar.gz"
        sha256 "65e63443a3e2ad4a1996f39ae59ac1e8bc9f9988952af58248deb5d977093d38"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc96/promptx_Linux_arm64.tar.gz"
        sha256 "ae419066a8c415c8f762127bbe23f296c5ac76a1d7c11bbb9f216f177e8b66a4"
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
      To install the Promptx extension in VS Code-family editors:
        for editor in code cursor codium code-insiders; do
          if command -v $editor >/dev/null 2>&1; then
            $editor --install-extension #{vsix} --force
          fi
        done

      If no editor CLI was found, install manually in your editor UI using:
        #{vsix}

      The extension provides the @promptx chat participant, memory
      sidebar, passkey management, and cross-tool handoff commands.
    EOS
  end

  test do
    assert_match "Local-first encrypted prompt intelligence CLI", shell_output("#{bin}/promptx --help")
    assert_match "0.1.0-rc96", shell_output("#{bin}/promptx version")
  end
end
