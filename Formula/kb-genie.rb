# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.23"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.23/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "80bcd007f9f262746c83164a447267faabaf9ed1c479df463d04e583cc61ef73"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.23/kb-genie_Darwin_arm64.tar.gz"
      sha256 "75c9820e9fbc1c6fbabd3eca8f83e0a94135882258099ee25191ee44b51c622e"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.23/kb-genie_Linux_x86_64.tar.gz"
        sha256 "15218f794087af55b2cc2dc8e928d3e03a4b340e0d92bc87a78827be1a07a61c"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.23/kb-genie_Linux_arm64.tar.gz"
        sha256 "21a12519f7dbf716807e871c272a00222e5ca1cac2b1885e0b276503dc799c3e"
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
