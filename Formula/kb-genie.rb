# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.1/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "449e36ff1bebb7baef1a075e904ffa5b8f848960a4eab8915d0fac916a3a9282"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.1/kb-genie_Darwin_arm64.tar.gz"
      sha256 "0c2403a326058294604d6a1f14e5643477544d1ac9253879ae911da5a8167fb9"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.1/kb-genie_Linux_x86_64.tar.gz"
        sha256 "4165cb59457cca8b1ea3ac38ef98fc5d99e74be6695eb11592ca901d8ef935d3"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.1/kb-genie_Linux_arm64.tar.gz"
        sha256 "497d5ce03c0de737f6db46754e6056a6b38c51a25a4768e5f4774b69d0ddd59b"
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
