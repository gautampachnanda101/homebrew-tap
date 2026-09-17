# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.7.3"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.7.3/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "a97604ebc4f2c1e8548b46ff077b8e73fcdbb780e49bd442b60c34a7ed465b2b"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.7.3/kb-genie_Darwin_arm64.tar.gz"
      sha256 "7d7e195720c3ab9a35a5c5b3df2cb4767a5a578c81b06925657e7314063d988c"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.7.3/kb-genie_Linux_x86_64.tar.gz"
        sha256 "c3d5330bd9c0369476c056425a064c31005dae613601367791724b9f3bc95fac"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.7.3/kb-genie_Linux_arm64.tar.gz"
        sha256 "f6a071b486e4fcb08edef797457628336849de6ef49dd4908a2277aa508f40c5"
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
