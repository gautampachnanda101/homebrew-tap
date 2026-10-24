# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.21.3"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.3/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "dcf44ca8dbaa90aa095cc78b865eba3ee9b0266020216bf5027b59b800c5a30b"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.3/kb-genie_Darwin_arm64.tar.gz"
      sha256 "e87db3cba3427c56ae46b930710ec8470722bdf1f65b81c4d3b158b1dc6807a1"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.3/kb-genie_Linux_x86_64.tar.gz"
        sha256 "5ac3ca6410b0226a2122d09aa41f5e7e21140c46b3b5f901568937afe43b5eaf"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.3/kb-genie_Linux_arm64.tar.gz"
        sha256 "fa6c8133ca3b2d523e67dd6e7a2f929a0a7ef2c44b820ed4a2780a9e1f90f771"
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
