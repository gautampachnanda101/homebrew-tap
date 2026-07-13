# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.5"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.5/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "9c4ff9ec71b8d7e14eeaca9ac17df35a2cd294afb89b148c10e8c91c9c68f9d4"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.5/kb-genie_Darwin_arm64.tar.gz"
      sha256 "0f2e4b8730689742d3786e0dc1a4657d9d82efb52f5c930a3f01174b9548dbe3"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.5/kb-genie_Linux_x86_64.tar.gz"
        sha256 "fa5419ce684481b09822ff73de7adf029952ed8bc921eeeeba548303eb5b1dc8"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.5/kb-genie_Linux_arm64.tar.gz"
        sha256 "c26db98d3885dbc2a1281059c537e942f094bb62d503f53c0538ce123dc13ba1"
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
