# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.19"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.19/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "69c89f1d1a2fc0c9132c24a8893ac536c7c49e207b52bd730eab9bbaf780f929"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.19/kb-genie_Darwin_arm64.tar.gz"
      sha256 "fc8424e94821788689c80c43f85aa16c633dab1ac3b665bee783e45fcf35a7d8"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.19/kb-genie_Linux_x86_64.tar.gz"
        sha256 "b6f194a577928b74ebd572a73425ec77410eaef2315d4b763d58e34c008ff4c0"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.19/kb-genie_Linux_arm64.tar.gz"
        sha256 "9ff0809062171dbf4433d3aa229cb35f0392e814aee433551a31755472ae0d8b"
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
