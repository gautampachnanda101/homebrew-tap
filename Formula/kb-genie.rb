# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.0.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.0.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "955b09f664b3ab7d3b05d60a534b5038e98b263c8f28f9c719b9eaeb10e8bfc6"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.0.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "185987c3f620e5a198166dab6ba10a5c123ba0d2862b5cdd229dda6fa573ee3c"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.0.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "4e5c9892e99b23440f90a03c4dce1ea7ccf1a200dad694693a64d9ce0746c7d1"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.0.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "d53258f544b499c01beaca0546ecda04b661c5178f4d703b78063e08ae0935b5"
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
