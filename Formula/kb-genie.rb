# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.17"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.17/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "c04666e3d31a5ba41c8a7ac8dde545afd61c3474aca86591f526aa9d58b70751"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.17/kb-genie_Darwin_arm64.tar.gz"
      sha256 "4d7768dc1fdf911c7216e6daa36f96ef19f52933b6a961c7685518b90f2ce2e9"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.17/kb-genie_Linux_x86_64.tar.gz"
        sha256 "b864413b9fb1e52fda58958e3b27924f0c6c8769df7cf9b26bc0d0520c7542c4"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.17/kb-genie_Linux_arm64.tar.gz"
        sha256 "b5a54454c5bae652f3d48346f40e2ce2582f01fc3ea6a90c54c25d802343695f"
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
