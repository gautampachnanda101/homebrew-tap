# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.21.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.1/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "382c53bc4b89e098ec3a8effab754cfe3b3555bfc4ff73b5a62c85083f10d9d6"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.1/kb-genie_Darwin_arm64.tar.gz"
      sha256 "55f74ff11b4e328af6a7731debc4230ef8af248c929f83d37f1eb1bc040df518"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.1/kb-genie_Linux_x86_64.tar.gz"
        sha256 "e5a59b2fbaae6cdcb0026ffda6ac5b52ee77952045b2cf45c90aa3e8bb60fd17"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.1/kb-genie_Linux_arm64.tar.gz"
        sha256 "e6878f05c9db8cbc6a39312be17f06710a25d0ce306917ac10cffaad7f3b1b3a"
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
