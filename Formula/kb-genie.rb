# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.5.5"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.5/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "2e4ecbd3a58ff327a77b2d8aeabe553300cb9d4ec8249102af929778c10f833e"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.5/kb-genie_Darwin_arm64.tar.gz"
      sha256 "ed9a61b47736624916f430e060ed665d2151c9f740f3de168ccc58ba485eba0a"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.5/kb-genie_Linux_x86_64.tar.gz"
        sha256 "2330a3701d1dcced946891893e153d7801bf35f9c78962e522af3729c3f061e2"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.5/kb-genie_Linux_arm64.tar.gz"
        sha256 "b9e367dfae889e7acf4cca59c9c4ab15676df3a23487a15a84a52cbb7cc47039"
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
