# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.11"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.11/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "9dd82f2c8c5d9741097e51121b6b746485a989f8c2e955bf84e1c8f65597f5c6"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.11/kb-genie_Darwin_arm64.tar.gz"
      sha256 "700c73f4ce4a93ac8a95f7d4f0b05c8971a1000568e3d162897ef42f86a9e2ce"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.11/kb-genie_Linux_x86_64.tar.gz"
        sha256 "fd8a4b20024f14e33b4e835570d3f8447caeaafb2313472d1c09e6d4902cb67d"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.11/kb-genie_Linux_arm64.tar.gz"
        sha256 "d1fcd24f13ef7bf1292f654d6dd32d606fb938a161dea7c4e358a3eb09052c61"
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
