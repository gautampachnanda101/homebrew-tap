# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.4"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.4/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "371e60c7931d4f427cd92847b56803ab18cd133a5401f0fcc112f17525e74473"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.4/kb-genie_Darwin_arm64.tar.gz"
      sha256 "863aaa97b385f72ba30766b44250e876ee2dfa85f4c2c49cf0084d835b1459f8"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.4/kb-genie_Linux_x86_64.tar.gz"
        sha256 "147a452d329d81d8ababfbfc48eac4ec4d58dc8ae3da5837cee01cb40ba28c4b"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.4/kb-genie_Linux_arm64.tar.gz"
        sha256 "8f5254f0138b3ad440573b0238ef61652c58fa311ee973fa380eeb0bc7784980"
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
