# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.17.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.17.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "42539ce65c7f636ce01d65966cca5bffb5614c60c7a5ee961d2af5e521272c3b"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.17.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "6ef6ad3ac1a65dcbd7d749ad415922ddd082bd7db8f6c686eb8c1b9f58dc7efd"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.17.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "f81f0d936d07c1e1c1090b0ea66cded31253f13cb4c8b1c0b0cd63004c53cccf"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.17.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "6d7decd94e5c754e47c54c1f90ad2af8133937d17c2c03c520f0947ea4acab47"
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
