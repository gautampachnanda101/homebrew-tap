# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.9.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.9.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "15bc36a407fb6a40c947580ac1b100f320e691d91739a603ff69568b775b6679"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.9.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "d0b159bd7d37d2359d7ee925de8f07a5078328b12b8036c17c39c12038146058"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.9.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "ce6b91207a306c7e781d3cbccd1ba4ec28e78713bef78990ea7ccdcaa1cbf03c"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.9.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "0a9470d255b4ede666675d7209f096fd8a3ad269208236b7a7de7021fc0a0f01"
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
