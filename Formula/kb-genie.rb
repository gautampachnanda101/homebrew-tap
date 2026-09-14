# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.6.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.6.1/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "b876c3a73674646c0120bcc206b916770d521edaaa50cf9e2be8535fe4ce2570"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.6.1/kb-genie_Darwin_arm64.tar.gz"
      sha256 "2f31e05cadadaa6233ca7d20b37671b6ca899e37006903299883545d3288179e"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.6.1/kb-genie_Linux_x86_64.tar.gz"
        sha256 "f3bfb28eff4e5fca7872dccda3017ba36cbe0c2abedba4aacb29c1aa4e8b8237"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.6.1/kb-genie_Linux_arm64.tar.gz"
        sha256 "199df3fbff9c9765df02757225bef4bfe6fe2394ccd7cc7f48fbc7cfa0b8301c"
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
