# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.5.11"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.11/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "f7bb1cf5650a638dbfdd921c413f54a17ee719b6c52eb2a26816dce1f66eddce"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.11/kb-genie_Darwin_arm64.tar.gz"
      sha256 "e2af5f152b202c3422077bdeaaa6fffc97bb5dc51d81abddf0cec9a53700672e"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.11/kb-genie_Linux_x86_64.tar.gz"
        sha256 "eeaf4bdc38c8d62e76bb7ecf11a8dab404b66f985ed27acedce9d321eab4393b"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.11/kb-genie_Linux_arm64.tar.gz"
        sha256 "9f90b354825cf5661f0500745ec0b272fcd91c02a8acb2e52d61d8d5088a5ec3"
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
