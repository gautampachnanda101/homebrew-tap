# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.3.7"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.7/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "b8b3535dc6c76b3c5d7466bed5b8c923ca54973ffc0501c391928ab0f3273fae"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.7/kb-genie_Darwin_arm64.tar.gz"
      sha256 "29e7ef4e6d13e2d8afbcfbcda36f9483da644eee102e97e973f35344000a744e"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.7/kb-genie_Linux_x86_64.tar.gz"
        sha256 "25a56cbf0880fd1de7f028d3721f49c23273f266b063d88477cb28e65b6d8051"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.7/kb-genie_Linux_arm64.tar.gz"
        sha256 "1a69f1fd48d3d2760004613658c4a1eb88cf135b7430440b637d07a149b81cd8"
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
