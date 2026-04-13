# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc53"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc53/promptx_Darwin_x86_64.tar.gz"
      sha256 "2d4c5bab50a5bfd56f091d00e91820c4e1dc320f9792b10fc758c0110f64c8b6"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc53/promptx_Darwin_arm64.tar.gz"
      sha256 "d181fa82c33e17fbed126ee61185388ee3028fe96c7a4c1b8e9981c272586663"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc53/promptx_Linux_x86_64.tar.gz"
        sha256 "f2cf81730c6c1536e5db0ca5b62e71cc6f5a2dde5054d77c3c704be8a7aa3ae9"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc53/promptx_Linux_arm64.tar.gz"
        sha256 "4be31038ab6b95e442940b0504ad0a68bfb644c781452b6c370463be0bf3da57"
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
    assert_match "0.1.0-rc53", shell_output("#{bin}/promptx version")
  end
end
