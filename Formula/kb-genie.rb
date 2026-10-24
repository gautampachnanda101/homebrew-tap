# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.21.4"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.4/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "9a32c89dccc5e9097a5f46ac3af7e167783cec9b1f655afe490f9afa328eae9d"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.4/kb-genie_Darwin_arm64.tar.gz"
      sha256 "11a0152247826b75937162d4e192f3b1509143062156be1200e3bf2a682c34d1"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.4/kb-genie_Linux_x86_64.tar.gz"
        sha256 "44782a603cee886d8940c18b23f5286d721f35704fe53c07f173fc909ad30f2e"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.4/kb-genie_Linux_arm64.tar.gz"
        sha256 "03cdd168d9d2a9d7a8cd48fd709297f43d47375b77231925616a769a363fc145"
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
