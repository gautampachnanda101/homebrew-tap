# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "a5dccfcbab8a049ebc53e7af61cadf42eefe69abf527f2162e1dd3cef64da3ec"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "22662d207b78131284be0aa424d4f13575ddd58f669888b605a5570491f7b2ef"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "a1afd6e8a7094f273165c2d55908b3fc510cf7c2ae77d91f30f16635924b812e"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "5d806d7ff92ec0bb7114af079390a5955d6e6a99806312437e347e79c8764798"
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
