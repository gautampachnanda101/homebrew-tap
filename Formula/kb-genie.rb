# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.6.3"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.6.3/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "a3cafbe8b8aadcdccd110c598d4170b4d5ad1afdee4f45103dc1e1e4d5cb8e58"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.6.3/kb-genie_Darwin_arm64.tar.gz"
      sha256 "d183e168a69d6003979911350bdfe12e311df9c6d9b6120da6c3b6619dd3c70c"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.6.3/kb-genie_Linux_x86_64.tar.gz"
        sha256 "dc3217b67d8dc825d45bb74eaff74b029bfd04f421b69806e9451a4a2952b47b"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.6.3/kb-genie_Linux_arm64.tar.gz"
        sha256 "cef05f07562435b73a833c35ba6e507dd5239c2150d27afaeb17af43adab9b95"
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
