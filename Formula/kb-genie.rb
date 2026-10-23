# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.20.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.20.1/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "043949d5beed04f85e1c7ddab4ab911effacf0ec712268a031e4dd447ef78435"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.20.1/kb-genie_Darwin_arm64.tar.gz"
      sha256 "c3ac66e60f61aa18d8a262ac59fd5177e13dd7488de22931293e2e6d343bed5e"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.20.1/kb-genie_Linux_x86_64.tar.gz"
        sha256 "f400a1322b0761a8db0752dd03843306c3f2c27247564d4650759944967356a6"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.20.1/kb-genie_Linux_arm64.tar.gz"
        sha256 "997da79b66bb4535b055b10251206f4049891de8c3ee93ec7f024145ea63fe80"
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
