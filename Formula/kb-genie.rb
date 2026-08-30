# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.4.2"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.4.2/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "c1018e972df2530f4e921e141b78ce5cdc847c181dc9cde29400f1ae9f47c1a8"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.4.2/kb-genie_Darwin_arm64.tar.gz"
      sha256 "0d39bf4b48edcff19f43cc368a731b95e71500d4769ca6ae793e838088b6f93c"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.4.2/kb-genie_Linux_x86_64.tar.gz"
        sha256 "15a823c7e9e4d214764a690fcf78c2f4816344042416a545b4d810d5370be5a7"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.4.2/kb-genie_Linux_arm64.tar.gz"
        sha256 "d12e40db16ea38b48ca4f54dbbe74116d9da467777d423d18056b466d2942155"
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
