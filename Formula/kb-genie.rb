# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.15.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.15.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "776cfa428b03ce016e3e7910c665e4e38c952614d3caa08d424319c8884d3230"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.15.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "2183ececc5a694ea6a5cc0281fd9c9f18417f596245dd74a56db1c47d082c8f1"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.15.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "f4239fc1c5c9c6d113f0805d3cc757a9537d748893120d1c7483725457e8de83"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.15.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "f33dbfd4ee199de9c6a3727523802b161b76207c68c6f628d5c8def89fa47489"
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
