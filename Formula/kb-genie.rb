# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.16.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.16.1/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "6e29924be6351ed9e9a3ac847a7389398e1c867bbda6651380a9f4ee235f0d51"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.16.1/kb-genie_Darwin_arm64.tar.gz"
      sha256 "842b36e0b8a1a9335e8910e0ea126d6d9c2ac46083b4d405e4070961d7a0db8e"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.16.1/kb-genie_Linux_x86_64.tar.gz"
        sha256 "626c431bf430f6faff69d15fe363bb9dd7d1803ac56e646cf01b05e5bcd5f84b"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.16.1/kb-genie_Linux_arm64.tar.gz"
        sha256 "14b7a7b06bd32b3eec8e9865e1bab792757b1e846c718f59f355bff7377b1d92"
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
