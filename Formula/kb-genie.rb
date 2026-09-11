# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.5.9"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.9/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "d35ace1dd3b77f80b5ae496dabda90f94100f69d4be0f1c79863c21e60c0f3bf"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.9/kb-genie_Darwin_arm64.tar.gz"
      sha256 "f019ff0a192f6b0323f83d64d89347377ccfcf78959534d439e67f9aca3ec942"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.9/kb-genie_Linux_x86_64.tar.gz"
        sha256 "17e1cb0aba15a2bfc1c33895ed6e3a7339c055147f768f39213d3235e55d6594"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.9/kb-genie_Linux_arm64.tar.gz"
        sha256 "183fae8e714ffe72db463ec88b402a852dafef4e27d41b75d90fe3917bccd09d"
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
