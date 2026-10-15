# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.12.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.12.1/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "d3b994ea3ab29683785f9345e75838ac13fd1b4d27f5ecb2b528c09efb75f161"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.12.1/kb-genie_Darwin_arm64.tar.gz"
      sha256 "01bf3386f1edddc9a9187e763b031abfe7ecd0693849ff82ede7ead8cf5250d7"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.12.1/kb-genie_Linux_x86_64.tar.gz"
        sha256 "0c343ed94013e1c557c94425af9d76a8ad6333f6f1ba3018b7787542daec47c2"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.12.1/kb-genie_Linux_arm64.tar.gz"
        sha256 "3cf3f1a56952ecd32448fffa1756d5e357231572cbf0e4242d7c7ad3feea649d"
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
