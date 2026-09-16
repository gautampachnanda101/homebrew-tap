# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.7.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.7.0/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "2fd58d00fda11354c398e5712469069241c1e0435893ec38e9b880c1f66d47ed"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.7.0/kb-genie_Darwin_arm64.tar.gz"
      sha256 "5ae0c38313e737415138b8d691e4eab5691fe1175c90e187da09c8ba9af93613"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.7.0/kb-genie_Linux_x86_64.tar.gz"
        sha256 "c4e186b1892da4fe773725106435993c885f1015ffa1d91d3d68a68fbe14b8cc"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.7.0/kb-genie_Linux_arm64.tar.gz"
        sha256 "ff869de5475b1a94325939f2fd1b9b67378d8590e1ce896a3066f2b65ced6de8"
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
