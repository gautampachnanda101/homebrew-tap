# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.24"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.24/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "a5f678315bfea8d2da37c017212f1b925e20f7eee65d93a2c699480b54722300"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.24/kb-genie_Darwin_arm64.tar.gz"
      sha256 "df4c6473b3b6306221ea6e8c60529a958205c00ff6ddb5c0a6a7b89ece96be16"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.24/kb-genie_Linux_x86_64.tar.gz"
        sha256 "78a6e8838bb79345596e2493e669d1ab24de81e7f7e00aad20548dc527f63cd4"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.24/kb-genie_Linux_arm64.tar.gz"
        sha256 "dc5c662b4c5d62c5d7513806eca940a2973c7570485e699f60c7c3c178338b29"
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
