# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.6.2"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.6.2/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "60187f3250886fecf532d49af8a70d16bcdba99fe5038b59a26100a16419e14e"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.6.2/kb-genie_Darwin_arm64.tar.gz"
      sha256 "f195955e63e6466342f827e2d5b3db4d5cd5bd9ded73fc3670d23da82b454bf3"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.6.2/kb-genie_Linux_x86_64.tar.gz"
        sha256 "7b84e91d86ed1f2340dec8b9c59c262ae068994aa6f1c5a0f2120da156b470a6"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.6.2/kb-genie_Linux_arm64.tar.gz"
        sha256 "82263f2f1708c7c80f8247a644bf70427185d4d6f466c8cce05574c9ce2d89ce"
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
