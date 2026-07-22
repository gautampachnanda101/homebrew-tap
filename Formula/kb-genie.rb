# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.16"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.16/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "fcb0e9cbb41076a23fd16c376af5551a9fb4347ad23aa09ec8dd97cf93ff41fc"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.16/kb-genie_Darwin_arm64.tar.gz"
      sha256 "aa626f67458d2947453f72ecac17946c021d72571dc67775b061b7cc2bcb2c57"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.16/kb-genie_Linux_x86_64.tar.gz"
        sha256 "1683f7172051d94ea56babb6eec2b79f46bb90db0a89b9188eab4ee7b849f54d"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.16/kb-genie_Linux_arm64.tar.gz"
        sha256 "d8f0d0959322562d5cbdb336812ccc09eafc48afbf2a560834cdfaf1c7039343"
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
