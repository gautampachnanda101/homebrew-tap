# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.0.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v1.0.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "82114fda8ea53bfcd68df59c3b2091df7a761a180b4e52ba5fe35f16b7b6bffc"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v1.0.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "d19f5e8b9a4337a50ef015acf5bf9a550c5c504938eede140210d526bb307fce"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v1.0.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "9d64ac2577464539ba479a688b8d27e0f37f5f45bd469af692a100bc82ed0b23"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v1.0.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "9f675db4db3e6cd3ef3b130dde032f70a3c31cefdf2ab7181a2a1844c50b9a63"
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
