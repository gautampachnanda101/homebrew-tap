# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.8.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.8.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "63fe9d9e8fa9cf0332fa9644d6d48d501ddb8dfa7d8fc6477d8436420f35db3f"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.8.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "6ef75d26fffc535d2577a41e02688c36038a3b2eaf1b8513339b6cb18ac8d037"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.8.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "23e8cb32e86d22d01ee579a55ddfe9164a7b267e7420356f4bcd4b2c500a8be4"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.8.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "04cb51d718f8c5b885cd4c34165aa5afe6600f1cc38cc050ccc3eb11d9c93acd"
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
