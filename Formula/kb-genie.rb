# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.3.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "37d6ab4b51f6b523a5971d07c4f8c58c5b7bbd11eeaddc0cce7722fb48eda61a"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "06d80e17a3fb9f633d41bb8481b5cdde167795df702a5641d7205fc0681a45a0"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "b2ba9e0f2c50ade6d99324877a833843311856d6f7c72dd9c5ae6444d11c19a5"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "a5c3e605d1b1a28a6e2f0166e44a0ba8443e8e0b9764f3ab81eafd344d542836"
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
