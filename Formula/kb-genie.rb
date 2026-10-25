# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.21.6"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.6/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "06cf7c226303758f4fea063746f554aa8eaf2dad1f55a9fe039fac0e047aaaef"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.6/kb-genie_Darwin_arm64.tar.gz"
      sha256 "55ea116768e477278b8c9c4b649e0f0293c764ef96792b1ffc5857867b3c93d1"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.6/kb-genie_Linux_x86_64.tar.gz"
        sha256 "0803386cce6fac326da335d05d80a1c7399126fb68fb1fc6f5bce9cd39f8dbd1"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.6/kb-genie_Linux_arm64.tar.gz"
        sha256 "9a6b87eea47c6965c1e831e3a2283263eb6663b4091820bbf8b30462dec9618b"
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
