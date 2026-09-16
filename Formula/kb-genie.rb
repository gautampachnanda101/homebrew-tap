# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.7.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.7.1/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "ea2969eb993d553d22dd2e572152e78e4bc5b0719adb15aa50e9dee58f49df4c"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.7.1/kb-genie_Darwin_arm64.tar.gz"
      sha256 "d77b2bc3e7c9894a0511f0a45f868e28dc95f3e9580c4525a04832631eaeeab8"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.7.1/kb-genie_Linux_x86_64.tar.gz"
        sha256 "a3c7db3996cbc177cd0327ebf827f59c10c547d185521ba352e93005dfe324b2"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.7.1/kb-genie_Linux_arm64.tar.gz"
        sha256 "42bcc6a03d2e4f6e9352646aa18b3c192b8ddf8f6e68d0b339959dec4bf6d374"
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
