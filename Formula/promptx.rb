# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc51"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc51/promptx_Darwin_x86_64.tar.gz"
      sha256 "63c0242138b78d2f4f25be5a786c5531f8d8795309be9463e8b8306d1a5a30f6"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc51/promptx_Darwin_arm64.tar.gz"
      sha256 "ea799af9715a4411f91f7dfbeab71cb32f01bf300cef1523ed5f2cfd25a3304e"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc51/promptx_Linux_x86_64.tar.gz"
        sha256 "69d20fc4ba43b7906e4210b68d3ed126ff14088a21d9f99eed3da6e4b00ad25d"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc51/promptx_Linux_arm64.tar.gz"
        sha256 "339c9e8956048c9903f80745a0f8287e041bb8f2251037d3541b4f807cabcacf"
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
    assert_match "0.1.0-rc51", shell_output("#{bin}/promptx version")
  end
end
