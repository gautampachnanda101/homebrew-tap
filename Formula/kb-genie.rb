# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.6.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.6.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "62fb16fd31a53f63dd857ec2b39655bba5505ab9af437190092087390524d3a0"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.6.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "b3a57a4e7eb04a581760f8a8c259d63e1a0cbd751a8541e02f9a4effbd3a6b15"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.6.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "57c788ac01c4b86457c139493fc153d9305b47091f0fef3b8302e75573cc8527"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.6.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "21cc57326974da019be833e6f8a8abfff78df214467a55f8a687fc0e3e110be8"
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
