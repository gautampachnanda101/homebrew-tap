# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.6"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.6/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "204ade2e875783dcbc82a9b116d2e0bb88dfc0e44ad183d9944232e21319e2ee"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.6/kb-genie_Darwin_arm64.tar.gz"
      sha256 "dcfbdcdfc5ac23badf564dd9b794ff77b88b9be9e3bfa656132c4b3b044101c0"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.6/kb-genie_Linux_x86_64.tar.gz"
        sha256 "2e068c0959019acfdccd7928fd9f85efcf216db87caf0f48fcafd58033c945c5"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.6/kb-genie_Linux_arm64.tar.gz"
        sha256 "c83bd23c4d81b00952cf2bfe9f1360e86ccd5c12b59fc2e188b189f0e093246a"
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
