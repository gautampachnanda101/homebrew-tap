# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc52"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc52/promptx_Darwin_x86_64.tar.gz"
      sha256 "586cb00f596770e85128b36aa902f3b7731275f1bcb33658514b635db4f85968"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc52/promptx_Darwin_arm64.tar.gz"
      sha256 "9e5ff04f8f6d23eadc81189cb70891bf61d9f63f0709354164d7155e352f0bfd"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc52/promptx_Linux_x86_64.tar.gz"
        sha256 "07e4e3b5888e1b954c1f7429d92a3fef38665dc433016e5a3c28af4bd1245e49"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc52/promptx_Linux_arm64.tar.gz"
        sha256 "47da6d925a54ffc66eda192183d2284fb6e85a61c1a80350426a3b99022fb791"
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
    assert_match "0.1.0-rc52", shell_output("#{bin}/promptx version")
  end
end
