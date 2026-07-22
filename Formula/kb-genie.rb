# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.21"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.21/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "9b00dd97608b6eae65998f95f4cfe4396ed0d81aa630beafb31e590d47735646"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.21/kb-genie_Darwin_arm64.tar.gz"
      sha256 "b53d68b99880018446044c67de79ad31a8caf9c7d6f9c63d29cfc505e37dbf6c"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.21/kb-genie_Linux_x86_64.tar.gz"
        sha256 "9cd54d0d290c35ea37c6c7e4ba724777c2e995ef5576c1c01be22ed55a8defa2"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.21/kb-genie_Linux_arm64.tar.gz"
        sha256 "3e228fb8c6296ac68660c83642a9d96de1a02f4b1c7083a79bb3a6b3b4ea0a16"
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
