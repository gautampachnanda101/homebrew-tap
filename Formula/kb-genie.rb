# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.13.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.13.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "a4ef6b710ade56082f0975080eff7cdd3243e64eecda413a01a1cec5e11096c5"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.13.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "45d10f5238936900eddfed9eb44dee2e057f27b22884ca5728a825f1f281c584"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.13.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "36b4326b4a7b25a1deb80014009178a41794d13d86d15b7f03391d0cbb7f0d43"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.13.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "2d8ea71f965e5582954adf27ba0c3717960f4f4d85ac5cf2e7ebcc2f595755e2"
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
