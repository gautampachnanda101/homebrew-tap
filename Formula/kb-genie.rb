# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.12"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.12/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "9e92b1187abf1b3e41a6ef95f9d7967ef158349a40d75281d8fb5226fb787402"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.12/kb-genie_Darwin_arm64.tar.gz"
      sha256 "b3c1f033d7e6d6a6a9de0b478a74199c6ba3060548590bcf93f5b31341adeaa7"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.12/kb-genie_Linux_x86_64.tar.gz"
        sha256 "1d71aec5f0ed1edc8c4170e26b0aa61714b0a91fd95d5f537f04f0a7a93d0510"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.12/kb-genie_Linux_arm64.tar.gz"
        sha256 "a2b32db1b2e37b71bc9ce4976802c3e8bda91e6d777bb890e8ab6e524aede56c"
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
