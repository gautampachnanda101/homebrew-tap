# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.1.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.1.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "b2ea9d4245ccaceaec4beeda947fca523dea7ef3e37fe80ced2c849dd7a2af2c"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.1.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "678bd5ef89f0dd41436645f6fb71d7c73e1ef513a87c13dd56c358714952a707"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.1.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "d6c2d56baf8bbe662b39cfbf02569629c2b246cf41931fb30c8bd01c897b0a30"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.1.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "2cd5f9840f82d4a01ea8ab320b4bef8080ed97fc12dc8febcca271f35d3e6bca"
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
