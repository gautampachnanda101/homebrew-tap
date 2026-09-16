# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.7.2"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.7.2/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "cee5fed8ed33ee266336f8fb2ca965b92d0dd58fc6a7619fcc70b41ba558cae0"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.7.2/kb-genie_Darwin_arm64.tar.gz"
      sha256 "aa9a23a3042dab44c6a40047a5c2afd953c481913fc61be9838957369f0823c4"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.7.2/kb-genie_Linux_x86_64.tar.gz"
        sha256 "17ccf5ebbf0edb4a994289c4809c669411c8512d474457bf00efacaa42c0aeb4"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.7.2/kb-genie_Linux_arm64.tar.gz"
        sha256 "7627fc50bbc84de1540c168c35b9097d363dbf3ec0925ea328d8f84d6f682c11"
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
