# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.19.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.19.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "0b0c1328ea92dc7a69403b223c0c42f1e307760c8cc1f7e8bedbbbd06ecc31db"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.19.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "1b86d50fb36b57ae8bcb7e65105fa27f0663c2024966300e28aeb5b2e93ae30b"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.19.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "c6d2cb222a1544bb54ab822e9da7831e1ca563ff9928ea5afa70d16bd059ab88"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.19.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "bfc0f8afd883ad847621b9fb00ad6f7bce1fbbb50507947ad17c7e9fd8303f58"
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
