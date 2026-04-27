# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc88"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc88/promptx_Darwin_x86_64.tar.gz"
      sha256 "e39c4f154ce4104e1cdaef37f4907adda87e227e97592fc00004dd545e5cb8b9"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc88/promptx_Darwin_arm64.tar.gz"
      sha256 "4ff698f277768fb7950d2e305ec67ce2f7503aeeb452a99e8707336a30c38c88"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc88/promptx_Linux_x86_64.tar.gz"
        sha256 "0fa8b36042c5930a266ec43be809e21710b9305af6037c0a82b3ffe544c64ce3"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc88/promptx_Linux_arm64.tar.gz"
        sha256 "498a29e453d16bb3de8903fe9817008873daac1a544e8e5cf630351991374d62"
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
    assert_match "0.1.0-rc88", shell_output("#{bin}/promptx version")
  end
end
