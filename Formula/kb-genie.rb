# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.17.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.17.1/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "b88f929840c265db240047befb5ce774dbca3045d8be16722b27d70b104d316f"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.17.1/kb-genie_Darwin_arm64.tar.gz"
      sha256 "8cca61dd9c3b38e16858aeb19ce6f39ac35f84f126746cbd72f5f6867f634094"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.17.1/kb-genie_Linux_x86_64.tar.gz"
        sha256 "7d06a82c604b8db0e24c8d957f2e8b8fce9100d56aa2926c81cc7dd85d56459b"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.17.1/kb-genie_Linux_arm64.tar.gz"
        sha256 "2aa29853cf505bae7bd03b0e18a27550bb52f1f44bf905da6b8481beb17d8bc6"
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
