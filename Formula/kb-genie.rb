# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.9"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.9/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "1aebaa40d9906cedef68776dcedae91becb7ab46f9294c4be6d0013af839ca04"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.9/kb-genie_Darwin_arm64.tar.gz"
      sha256 "c4b189e95fd208fa350a607724b715cf7dc5b41d1045f842c2023594a77675fc"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.9/kb-genie_Linux_x86_64.tar.gz"
        sha256 "e38b2406eb9e59612c742791e438e772cd2d839a355542068ff5f205c6a922b9"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.9/kb-genie_Linux_arm64.tar.gz"
        sha256 "34a2b699c376ab1fd820a237c8d219cf3e1d3e50b891ad2bf30873c0a9ad7ace"
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
