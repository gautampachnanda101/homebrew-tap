# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.5.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "28d033633b61d7fbf4cd065fa300ab267b4eb53ccdcc8ddfeb188c0eb1298f3f"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "58f43068be42392197eaf0e12949d5c064f69aebaa2ed03520718a5c68c63759"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "d423ed2f30171f86558829585712b5efa3ff30a93553d2760c492bc7f1b12b81"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "f713839523e266c88f38fa074c114812929cff72502f446cdaf958ba279b205f"
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
