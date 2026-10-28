# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.21.9"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.9/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "d45165335b8b409d07cafd62f9f141639ea6fab996930965c0c87e10ac8e1aa5"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.9/kb-genie_Darwin_arm64.tar.gz"
      sha256 "8901080d97526db3087c40a96a130b37426523d8fa1b066fdfcc6e0fb8ba0d1d"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.9/kb-genie_Linux_x86_64.tar.gz"
        sha256 "d9939864552ed33ad2cdccb886f85209e757a8b2811cd339887d8e08c4b7f0cf"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.9/kb-genie_Linux_arm64.tar.gz"
        sha256 "e524bea52e05e419480dff2777212190808645ac18a8a2fb09b217947117308b"
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
