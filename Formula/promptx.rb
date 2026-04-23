# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc70"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc70/promptx_Darwin_x86_64.tar.gz"
      sha256 "a676736b3f4626c311fd691d9df7efd20189796ee8a8715739452b2a75c7ddb4"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc70/promptx_Darwin_arm64.tar.gz"
      sha256 "58375a8c5098633c0d913dbe5d1fe502b1be37ed5e42560564f34e6aa8587d94"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc70/promptx_Linux_x86_64.tar.gz"
        sha256 "76ca133a4080bf19f1c54723e6429e181fb0a3a53fd8c7f2d08bdb6add9603e7"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc70/promptx_Linux_arm64.tar.gz"
        sha256 "e051763d4aea36a1a169fbe55e3a1fde509131572fb9dfe47169ef8f72e2c046"
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
    assert_match "0.1.0-rc70", shell_output("#{bin}/promptx version")
  end
end
