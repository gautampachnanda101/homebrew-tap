# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.3.6"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.6/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "4433b7605d77bce9bf110eecad72dc8a82a9ff4d112dd0e2177d9bc1bbdec5f7"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.6/kb-genie_Darwin_arm64.tar.gz"
      sha256 "2b217f8fdcd7876495e2e6f45cd8ce14776c8854110cf419791cec1d6cd6d4b6"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.6/kb-genie_Linux_x86_64.tar.gz"
        sha256 "3c65fc781e4c71859cd2d73b8f756b4335121f8f63a8485d6d7a743a81811443"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.6/kb-genie_Linux_arm64.tar.gz"
        sha256 "eb9514c7548d6f72335c957b23705d1b5a5184c9eb681a9d2264af6f12bc1e20"
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
