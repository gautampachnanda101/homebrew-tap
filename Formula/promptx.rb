# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc49"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc49/promptx_Darwin_x86_64.tar.gz"
      sha256 "91c1572151674a242684e86ed7e46d256e66ef3fc8b06e5564f830fd87e5aac1"

      def install
        bin.install "promptx"
        (share/"promptx").install Dir["promptx-vscode-*.vsix"]
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc49/promptx_Darwin_arm64.tar.gz"
      sha256 "944240f232e2f924d7279174b43066882779077056233294409bfcdae1d67b3b"

      def install
        bin.install "promptx"
        (share/"promptx").install Dir["promptx-vscode-*.vsix"]
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc49/promptx_Linux_x86_64.tar.gz"
        sha256 "04463f891994da86a6a8347e60a58d88b6b8bfb13f678553bf67b1634edaa460"

        def install
          bin.install "promptx"
          (share/"promptx").install Dir["promptx-vscode-*.vsix"]
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc49/promptx_Linux_arm64.tar.gz"
        sha256 "fbe91731d4eceddc73f7dc571ce67f19acee5f4d2d0cfac4f49f47236da2aebe"

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
