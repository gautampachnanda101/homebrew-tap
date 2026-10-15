# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.11.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.11.1/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "1318f43dbbb04dbf227e40ae4979562e3451eedc7749e110c7a5d8b65ccd1029"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.11.1/kb-genie_Darwin_arm64.tar.gz"
      sha256 "7105a4571b6815f9dbda22f91d978d8d71a7316265d600156e0db1c2609bc645"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.11.1/kb-genie_Linux_x86_64.tar.gz"
        sha256 "c974c86fbad02d605511ed1f5bc676b6d2aba5459faf4de5d1b30f07d19c0818"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.11.1/kb-genie_Linux_arm64.tar.gz"
        sha256 "7f9bc238f60ad782d882b17a2d067326c23e89e0368fbdbcc43358a6008a1d01"
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
