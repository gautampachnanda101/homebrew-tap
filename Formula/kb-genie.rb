# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.10.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.10.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "1d7c730296adf815ebea73cc94a4b30e83553651795040dc8a31fb1a25325a48"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.10.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "42630501ef0f3e2aabda065ad7f298b664390bfa1fd580422cff5e05042edc2f"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.10.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "17e8eb5443e4701acc00bbcc048ef6ea8caf83251132953a3d9da595eb0c8f9f"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.10.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "591c8bca7679ab951e219888acbb0abfd67f1db3e8e964fba84519a406dc1ada"
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
