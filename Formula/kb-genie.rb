# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.21.2"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.2/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "907ae7588f051a41e3e0a09372a1092149cac8b803ff5ab582662b7620e61958"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.2/kb-genie_Darwin_arm64.tar.gz"
      sha256 "eff229387687652439fd90cf5274eed390785c6ae8a480ce9a1dd303391cd940"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.2/kb-genie_Linux_x86_64.tar.gz"
        sha256 "d20176c4d57baac49c8ff55b0640cfb87fd348edad1f5596f50ad244e69cb0c4"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.2/kb-genie_Linux_arm64.tar.gz"
        sha256 "2e8275004745595100f7eeaa879b34df20e785f2a738801f577599481d6c33cf"
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
