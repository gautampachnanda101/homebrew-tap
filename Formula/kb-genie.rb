# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.18"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.18/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "38f3d5a70d0bb71b6fc221657b9447f608afb1b54c3c8c687c2f483e9309719c"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.18/kb-genie_Darwin_arm64.tar.gz"
      sha256 "4011f4a9052e9934476c2d1700077c42d62a1940438f23e9a83f41a4135e119f"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.18/kb-genie_Linux_x86_64.tar.gz"
        sha256 "901beef55315841ccc712b2a83379f1f06f27d19e2b10e32f091e3af06fb0808"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.18/kb-genie_Linux_arm64.tar.gz"
        sha256 "f73cde1c49f4de73d5cdd9bf4bbe4a0411f842bdcf36afdbe9c3b24139e937b5"
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
