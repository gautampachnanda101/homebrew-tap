# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.5.7"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.7/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "bdeac0f57d00d274361e32c1b8938f5a4b2e27045cbda479352b4cd0cd2b38ab"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.7/kb-genie_Darwin_arm64.tar.gz"
      sha256 "a0caeabb142fccc1670a4bb412a8de518aa09cee251f35708ec5e52cfd9a0af0"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.7/kb-genie_Linux_x86_64.tar.gz"
        sha256 "8e647d41158a11b6c5380170a9b55ad4b477e5d901a0f3394b7fd5a33980eab5"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.7/kb-genie_Linux_arm64.tar.gz"
        sha256 "2536bca9f43da5ff60d3b67cd5aa8a2135e51e3459f358bcaf6a5b4b04f20ec5"
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
