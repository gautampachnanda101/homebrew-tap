# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.5.4"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.4/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "29e26a9ca899b75d369b07153c3106087df3255f51f50341a66421fe63e3b65b"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.4/kb-genie_Darwin_arm64.tar.gz"
      sha256 "4f12b755487d803a8cbe6045685164d241b2c12677f7116f10fe9ebc6d18182c"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.4/kb-genie_Linux_x86_64.tar.gz"
        sha256 "9b7d7fe6ea8cbb7bc40f15e529e14a8ee574dc2025d9efbae94ea97adf610c73"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.4/kb-genie_Linux_arm64.tar.gz"
        sha256 "eb3554d183886e0bd6d4110294fe99d8e80069266e9bd47696f8287176efee19"
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
