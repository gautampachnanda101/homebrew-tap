# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.14.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.14.1/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "8d606a4f67e2d098dd6ae8149067b2e4dec15cd21c9e135ed14f306429efb3d8"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.14.1/kb-genie_Darwin_arm64.tar.gz"
      sha256 "4bbbf92675fada79dca94ea90d8ce124f6535bf9fddd47cbe52628cf74743b3a"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.14.1/kb-genie_Linux_x86_64.tar.gz"
        sha256 "a7c0bcf541e27f96c5af1949228de80afedc5d33e7af58b2b68c237e4d2159b3"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.14.1/kb-genie_Linux_arm64.tar.gz"
        sha256 "7d79cdc74de2be65dedee62214148ce0ff7928e3cf9ee3c343195d4167e092a0"
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
