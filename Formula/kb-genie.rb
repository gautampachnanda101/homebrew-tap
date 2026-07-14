# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.8"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.8/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "1a0562e6fb691144d7cff27004036152eaf63466f5116da4ed2e81d696552a81"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.8/kb-genie_Darwin_arm64.tar.gz"
      sha256 "6edb4286322d31515303f37ed71cfa3b8f23fca57fcff170a0085e031897666c"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.8/kb-genie_Linux_x86_64.tar.gz"
        sha256 "4345588ee4b218cf1dc820dd8765cf79b9d0a592c4bdb0c1fe0dfc0aab3eb4ba"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.8/kb-genie_Linux_arm64.tar.gz"
        sha256 "f2ae98c6bd3a807ad2b5d45245a050296174240ab4d8ae47ad4461d0f7aad886"
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
