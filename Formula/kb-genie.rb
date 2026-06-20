# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.1.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.1.1/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "4dd36a1e442d1d47daffab6b2c9a15831c25902e9a43f637659914ffbc47db80"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.1.1/kb-genie_Darwin_arm64.tar.gz"
      sha256 "c87ab7a679eed38cf9ce57eaccc2cb4096510846cdb402442c6a76ac914c8277"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.1.1/kb-genie_Linux_x86_64.tar.gz"
        sha256 "6f1fff999605a8cded837bc57ce480868183dec0ef27320e6e65f2e66b45393f"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.1.1/kb-genie_Linux_arm64.tar.gz"
        sha256 "ab744071b5249203e7f16e1a4c46de69970fb3504ed97efcbbeb20e5133a1f0e"
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
