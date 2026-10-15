# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.11.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.11.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "018972e931a838b9534eb5824f3cecd39f3f5e69c1daae13bfa9ddc2eaef0feb"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.11.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "a1886d14fcbcd1dfbc1739e1e731e87bd7f5842599009347b1f451f840fe1ef5"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.11.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "45660caab37e3b895b2d90882bb4e670432430be33b98ade6e691bae5c728478"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.11.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "216c034c62ad945095403d323e0d4cae44c8df0e0e6630c3515b7840dac5078c"
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
