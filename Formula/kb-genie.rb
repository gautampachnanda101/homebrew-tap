# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.3.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.1/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "ebb778f410f7605d2a641fb2df8121442514484709fca27e89a2873ec6c60fd5"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.1/kb-genie_Darwin_arm64.tar.gz"
      sha256 "4011797ae71e3cd98a75c59ad891164d223234afcdda91dcfe9690336ef502ef"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.1/kb-genie_Linux_x86_64.tar.gz"
        sha256 "f3ec8379f2bebc6ddd4139bba374109eb2c074ff8cbd61f6f05d1f3e2a4d7aeb"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.1/kb-genie_Linux_arm64.tar.gz"
        sha256 "3aa7017f77828c4ac989029782c48d7626d72e38bc2424d8bcfbcc7d5b554914"
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
