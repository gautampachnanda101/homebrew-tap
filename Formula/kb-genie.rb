# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.5.3"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.3/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "b98d4a57149741feb95f3be26c026d5fa59cd9cafd28de8bb4eb7699b8ef3578"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.3/kb-genie_Darwin_arm64.tar.gz"
      sha256 "7404c47d5bcd42d19ba55819d79d0601ae981f5e3418058eee588b8fc61aaeb6"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.3/kb-genie_Linux_x86_64.tar.gz"
        sha256 "dbcb5ae28f253949be053ff8b3011c9773818c416c2a1bea41d97625b721314a"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.3/kb-genie_Linux_arm64.tar.gz"
        sha256 "adcecc424e961b56e8c206793d6b20c4340ed32fcd79ff883aaa5fe29ff4946c"
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
