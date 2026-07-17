# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.13"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.13/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "be3401e7d3b08d79ac45c7695a66df06dd1d6cb2d4352b8ba3cd99f5448cd7de"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.13/kb-genie_Darwin_arm64.tar.gz"
      sha256 "b028762d43db9c9315ff4b4cd0b8232e73c889111dee4ee0a5c22b573a2e62e8"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.13/kb-genie_Linux_x86_64.tar.gz"
        sha256 "bfdb661dc15c8d3b8a6f3469e0048cba459668c00a63a89bfacc3949966f0e71"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.13/kb-genie_Linux_arm64.tar.gz"
        sha256 "784a012c1d7ff0f983eb2c07b81996d26f58618b0bbf63d119f9ac5558c86765"
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
