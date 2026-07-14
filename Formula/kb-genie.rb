# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.10"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.10/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "01cfe652925736c5d92fed0d57b543804ed54700b478d7e22f816382417f0f1a"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.10/kb-genie_Darwin_arm64.tar.gz"
      sha256 "cc76e400ee225c397511133f39d81248b83f47e7cf0c75b1475d01b5eeb6ff9e"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.10/kb-genie_Linux_x86_64.tar.gz"
        sha256 "9628dadba9de438fffc70632cdbca232e7367c2547b8fdce4bca80a137dcb08d"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.10/kb-genie_Linux_arm64.tar.gz"
        sha256 "a0d7540b3d5c92257350a7ac29d60b919125aea7225004cbeaf987e404c470e5"
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
