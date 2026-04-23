# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc66"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc66/promptx_Darwin_x86_64.tar.gz"
      sha256 "004cfad7f1ab4112f8d311e7b2f36ccd399564efde49f9289ca5a092794bf930"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc66/promptx_Darwin_arm64.tar.gz"
      sha256 "aff6cb766be301626e18997d80a0002ff37b0a34bf64550eba9dc98ea843f5d0"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc66/promptx_Linux_x86_64.tar.gz"
        sha256 "c25a56cc9936cda99a8df1e81422a750425911d818ca6d0bb0ae99b4dd39f7bb"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc66/promptx_Linux_arm64.tar.gz"
        sha256 "987149311a9248ed687983c3dbe0a571e3ca6c849fe6f6754623cc0189f8f441"
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
    assert_match "0.1.0-rc66", shell_output("#{bin}/promptx version")
  end
end
