# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.20.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.20.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "a3c50d0a27d6383620e223c807a94c117ed55c58a6c13601a12f2f3d42fba0d5"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.20.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "a2c770f28f05928585671f368a34678132213f6604820da0a24b6793f37b41d3"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.20.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "f04f8dfe0e3b9b8d78cfa78fa5f991472115197c97f2d965be3e4457c089b197"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.20.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "4c7ca1143b556e7f32834ccda4b237a12f85fd3d44d597df95f2b3cd676f2a28"
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
