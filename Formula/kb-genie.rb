# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.21.8"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.8/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "fa07ea64917941c536b3fa1a1076a48791f2ec4069ac63c69471b35553cfc8cf"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.8/kb-genie_Darwin_arm64.tar.gz"
      sha256 "6e933eac39a85bc395cd07f92d620f9e2740f9346950ee0ee12328a515a91779"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.8/kb-genie_Linux_x86_64.tar.gz"
        sha256 "1c35caf6c4de262ec951c7bc87e556a266f77f418485c75b9f865971a9f5aa53"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.8/kb-genie_Linux_arm64.tar.gz"
        sha256 "85645504bef08f67ef2aee5ed7ad7e409be86302cc59c3f6d85111e35bcd99da"
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
