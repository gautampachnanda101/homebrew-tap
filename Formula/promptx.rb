# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc100"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc100/promptx_Darwin_x86_64.tar.gz"
      sha256 "1c2662276e2593d371e0f9c9b5ede18d9e8a6e6e8c1c222a7e9035d49907ae10"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc100/promptx_Darwin_arm64.tar.gz"
      sha256 "6d6d596bba152953570a47650049b2cbea983041e22f75fa0abd2670738ae444"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc100/promptx_Linux_x86_64.tar.gz"
        sha256 "aed241fe95bd375d6a9a38b0039b0ee298e34ad3b6fcff5e1d834caf878887bb"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc100/promptx_Linux_arm64.tar.gz"
        sha256 "316b2ba9cf8289e2e6637d80b21806afb1994469abbeb8adfe53e7e285870333"
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
    assert_match "0.1.0-rc100", shell_output("#{bin}/promptx version")
  end
end
