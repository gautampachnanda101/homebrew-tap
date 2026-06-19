# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.0.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.0.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "51c766f1b9575e7557eeaed5ff78927e2f535e8a647878ebd64b5e1663b3c4b9"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.0.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "90886641efccd97909cc2f231a7e920e1eba18612b13e3cc2ce91773d9ea9c94"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.0.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "4a41a5437c4d1e494b2fb011c709816753b1c56e11e12b3aa8cf6087599b6a34"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.0.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "40d8a28c01ee374ec78266d7a1ef5f771afe4f28d5b922f4206a9ee87d07c97f"
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
