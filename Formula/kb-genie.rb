# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.12.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.12.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "04ea672c60f0172eaf001e78aa7771dfc9ea7c65bf55e67ec5e8f560ff863096"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.12.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "0d96eda492e9127123dca18fb1048e9c76e4afb3641b67243037e60d477ae303"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.12.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "565ece3b9bb911b3a26b053c5c82376c5c7601e9b27eb7c1de13801d1004d3e4"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.12.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "292cb5c4547b22b31fddb7054c3aa9c2625afdb38721d5469e1bae21e7e552dd"
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
