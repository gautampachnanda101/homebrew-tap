# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.14.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.14.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "ca6310ce206f6734cd47a4417b459402f448f32cfcb1c2f98e55cb4fd16c478a"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.14.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "413d27cc632816be0e0df5593d072632f7153033494fcd33926f8269184e3c4d"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.14.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "bf80a92bbc855fa4acb4998ad4989b732094d6a01a2a86937c180feaef2ceee8"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.14.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "3fe1c2fc4b48d4796bf2ea5686098cd133b4fac0cbaccee655dcd6b62af42b41"
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
