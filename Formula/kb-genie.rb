# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.18.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.18.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "23cdd7049e770d09030dc67cec2006a98e44391f95918085c065601bed0f3631"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.18.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "3234194753055479842f8083719af719ec5452c2de9824698d685be33080a93a"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.18.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "63f54d1bc6346b67f6258164d8f0bb13d187352bd114beda1769c010c0a12795"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.18.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "e4eff4edc71fc076d46bd8c3f834028c43a9286f8f18ea77654c24cb0e569855"
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
