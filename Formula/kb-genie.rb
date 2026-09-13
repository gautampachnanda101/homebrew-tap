# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.5.10"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.10/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "f37f0c91f62b3ee87cf3de773b3de647f2108cdef6196671c5808f8588787822"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.10/kb-genie_Darwin_arm64.tar.gz"
      sha256 "8f874ce3b2ce0a98b0cd49b885fc4f6069738b83864be4d169959d3bbd2d71df"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.10/kb-genie_Linux_x86_64.tar.gz"
        sha256 "9bec59f91055fd5677ff656fdcd18bc993ad511e911a83f967faf5f7ea00ca68"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.10/kb-genie_Linux_arm64.tar.gz"
        sha256 "13e74d85840b491794d85bbd63ce5e02341a024d48199f772427b5f16b7253bd"
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
