# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.5.8"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.8/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "3f48d200d4662eb913e26c9b63ad8f5a0bbdebf4d4e13bd0e0d7bbeadc420c44"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.8/kb-genie_Darwin_arm64.tar.gz"
      sha256 "48ce416409862e5bb496445a5388b6a546fd03edef9c86fb864a93146d1cf13d"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.8/kb-genie_Linux_x86_64.tar.gz"
        sha256 "52d14d7d3419f8458a76d5b2a71726f309792629abbb0293bf5f68bf0967a922"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.8/kb-genie_Linux_arm64.tar.gz"
        sha256 "be9deb8fc297afe1dd23c01fb5007cc32092b3dcd0712592e9982e4579351f6b"
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
