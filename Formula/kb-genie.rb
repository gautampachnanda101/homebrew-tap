# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.3.8"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.8/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "53e8d4918845dc29d4ece393c55b2a4ab2c08a1bf31a412f00f823821d3fa97e"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.8/kb-genie_Darwin_arm64.tar.gz"
      sha256 "55de9b84749ece7b0a6f3cb144a2bbfb0059e8fbf747f8f7b41e748693d1e294"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.8/kb-genie_Linux_x86_64.tar.gz"
        sha256 "314c667d9dd2b98127ac671fcf7c43470fd8cd0f32d8c34f01d5a87832c9cb2a"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.8/kb-genie_Linux_arm64.tar.gz"
        sha256 "a8788814ca09b68243c295d34572db9cc8254cfbb927d44825e2cdb323781286"
      end
    end
  end

  def install
    bin.install "kb-genie"
  end

  def caveats
    <<~EOS
      Run the prerequisites check:
        kb-genie doctor

      Start services and ingest:
        kb-genie start

      Open chat UI at http://localhost:3000

      Docs: kb-genie help  |  kb-genie <cmd> --help
    EOS
  end

  test do
    assert_match "kb-genie", shell_output("#{bin}/kb-genie help")
  end
end
