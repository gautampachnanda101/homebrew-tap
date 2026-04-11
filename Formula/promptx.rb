# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc34"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc34/promptx_Darwin_x86_64.tar.gz"
      sha256 "605308d01908adcec26035c6ccbc953725e4854283befe8495fe49b29f3db748"

      def install
        bin.install "promptx"
        (share/"promptx").install Dir["promptx-vscode-*.vsix"]
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc34/promptx_Darwin_arm64.tar.gz"
      sha256 "68e60d3c770fdd69eb09d89f79642dcc26e39f28ada8b70ea48573941710bd26"

      def install
        bin.install "promptx"
        (share/"promptx").install Dir["promptx-vscode-*.vsix"]
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc34/promptx_Linux_x86_64.tar.gz"
        sha256 "59b0eb6c0b9209342e974f5e6edaa13c0c012ba4c6ddd4d175d128fd8fe64700"

        def install
          bin.install "promptx"
          (share/"promptx").install Dir["promptx-vscode-*.vsix"]
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc34/promptx_Linux_arm64.tar.gz"
        sha256 "6ebdc5cd84fb160106905ceae6eb213c028084391b26090643740958c03bc699"

        def install
          bin.install "promptx"
          (share/"promptx").install Dir["promptx-vscode-*.vsix"]
        end
      end
    end
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
  end
end
