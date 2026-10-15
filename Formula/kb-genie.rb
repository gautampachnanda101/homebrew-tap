# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.11.2"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.11.2/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "794595ba8b029c6549a33d404190a64d48767e385c7babf94848688a792e4180"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.11.2/kb-genie_Darwin_arm64.tar.gz"
      sha256 "9961c83eeee212de4cd142e607cae8bcbd03d457421b4c94bc6837b38c2b99de"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.11.2/kb-genie_Linux_x86_64.tar.gz"
        sha256 "1fa32e47127e207fd4a7b71066e176412f53815de8fbd2dc94adea365bf1af25"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.11.2/kb-genie_Linux_arm64.tar.gz"
        sha256 "10bc71df51ae1eadeb06429cbe2b9f5ebd961ed0ad28baf4435cc759d4b26878"
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
