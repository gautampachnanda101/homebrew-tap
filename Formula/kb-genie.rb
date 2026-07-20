# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.15"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.15/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "3a074057f1c69808bc2231950e8d51fb174cdf440d704890f7d33e9367ef6b82"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.15/kb-genie_Darwin_arm64.tar.gz"
      sha256 "9ac7c5942937268606af608a77444f3eac832018fa4e137ebbd0176e704b9b35"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.15/kb-genie_Linux_x86_64.tar.gz"
        sha256 "ec15d6801fdc8526e6b4c1162886fec19d2e4857fd561282de3fa32db55c7fec"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.15/kb-genie_Linux_arm64.tar.gz"
        sha256 "7fe5c00014f496c86a5c3c01eafaf2d71138a2f74248a66910cd2bb57a3ba57c"
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
