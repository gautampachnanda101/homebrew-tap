# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.16.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.16.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "afb40a1061807408a72874043f9683d5ec87cf4205f22af6b329584c5555a1fc"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.16.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "8bbbcb7c863fe096e43a2fbd41c6b6b91760cd36263840004ae3ee0229306561"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.16.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "1eceb846270eb6a3d85109cddee89a77d23e51d51bbba2123b8999a890df1846"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.16.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "4b0d19d202105b4a21e6faca188c64779d7d97dad8502d1d954936a6eba9040d"
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
