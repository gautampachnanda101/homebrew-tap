# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.8.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.8.1/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "6b11db03d578cd1cd345371e31e987bf6071701c6541b773ecd141b5304b418e"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.8.1/kb-genie_Darwin_arm64.tar.gz"
      sha256 "247f8d772d58db53d3853842980cc9197b3f6abfadedbbab577eeb290d9d64ae"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.8.1/kb-genie_Linux_x86_64.tar.gz"
        sha256 "c2fdaef2807f3b19b4d649eb87f5c7b56ceda3ec99de22496ff3caf00e982df3"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.8.1/kb-genie_Linux_arm64.tar.gz"
        sha256 "b8f33984d23d81e963644301785b58496d9fbd8a77a728f5b109f2951df0763b"
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
