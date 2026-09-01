# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.5.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.1/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "e1fa1b79d692b8ce8bdd584fa9c9ab5c4fa0e76f44fc19e54c9eab719b6f927b"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.1/kb-genie_Darwin_arm64.tar.gz"
      sha256 "9500363ae66fb8fc5b371fb321b88cf919a4fdd0c359484bd394460ae7edf17b"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.1/kb-genie_Linux_x86_64.tar.gz"
        sha256 "47195503cc03eadc0c7caa7c80327e6a182f9dadf18f2c1ffdf8951a3b3f424c"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.1/kb-genie_Linux_arm64.tar.gz"
        sha256 "7dc6c9dec07103cab7851f8418101a272ba8119e3d629dbd0872dafce565cb3b"
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
