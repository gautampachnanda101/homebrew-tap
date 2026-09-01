# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.5.2"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.2/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "b77210f9339f56fd7f617949043447067f31bbd71edd8a905cf6924449196a7b"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.2/kb-genie_Darwin_arm64.tar.gz"
      sha256 "b6a0b96fb09521bae04e93ac2376747a93c07a3ca40ab4b9ccfb14056abf779e"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.2/kb-genie_Linux_x86_64.tar.gz"
        sha256 "6b7b7f21df42bf36603ecf0c3d53bbec38d6f5e874c08973b55f9d56240e5892"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.5.2/kb-genie_Linux_arm64.tar.gz"
        sha256 "1ee55b56d30ff0810531705a7d3ae65f7986c7551468d40713fcdcb5c132940a"
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
