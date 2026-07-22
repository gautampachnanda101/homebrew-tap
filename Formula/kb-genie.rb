# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.22"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.22/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "3a044ab8216f796f39b15c8261fd6adb8e3e993611c0fc6dadd1f18cc3195043"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.22/kb-genie_Darwin_arm64.tar.gz"
      sha256 "db29dd74ad10fb8c5e07889b2dc5c70b9909e234365d8d307ca7a0e3c8a3baab"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.22/kb-genie_Linux_x86_64.tar.gz"
        sha256 "177674322def63b79aa3cfaca3e742009f9c2a162453ee3a444df7c83b2475c5"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.22/kb-genie_Linux_arm64.tar.gz"
        sha256 "9276dd41393ca02ee90d70421b535de296c9fe5afb245178dbd7808c48dba9c9"
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
