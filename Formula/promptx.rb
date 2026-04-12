# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc42"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc42/promptx_Darwin_x86_64.tar.gz"
      sha256 "90ee5f422e3a03ef991f2ef00a181fab3d2f2be14ad10afd74bc5e11e40e7953"

      def install
        bin.install "promptx"
        (share/"promptx").install Dir["promptx-vscode-*.vsix"]
      end
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc42/promptx_Darwin_arm64.tar.gz"
      sha256 "9f6e0d0c6cfb90721a110a37128c5319bcdb51c56969501e20326dcc46f3f37b"

      def install
        bin.install "promptx"
        (share/"promptx").install Dir["promptx-vscode-*.vsix"]
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc42/promptx_Linux_x86_64.tar.gz"
        sha256 "9191a9c1ba1a3e7ede852133795c7bf152da1a9b375ed69d7a23b75754eda29f"

        def install
          bin.install "promptx"
          (share/"promptx").install Dir["promptx-vscode-*.vsix"]
        end
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc42/promptx_Linux_arm64.tar.gz"
        sha256 "c39653fdcd013d971e8dce6e0d335dcf05d1d52351f9c4d347cf02ce8a1f8fce"

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
