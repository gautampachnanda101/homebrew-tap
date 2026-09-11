# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.5.6"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.6/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "e04fcb746e9eda98c261621dad1154879dc712f4ee1a499fef8937bd6647639e"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.6/kb-genie_Darwin_arm64.tar.gz"
      sha256 "e865398bbcc6548743271404b1a940b84beda39d6eb28ad5d51fec8e6b737532"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.6/kb-genie_Linux_x86_64.tar.gz"
        sha256 "88ec699182cfc842fb937e1ff57a77c4fedaf9260da9670ee7c7dd5e631da826"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.6/kb-genie_Linux_arm64.tar.gz"
        sha256 "9d3094524a1178323afe10529bcc1dc5d0efea7d32b9177d8575bfa5bc14b5dc"
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
