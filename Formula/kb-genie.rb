# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.21.7"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.7/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "005951ccf914f17583e1ce50e131854a37803d7600ab32fd51c15dbc3004a804"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.7/kb-genie_Darwin_arm64.tar.gz"
      sha256 "8591c1c67ba70902b5ce34612e2a1c36e84c4f007a7e1b02da06391aecf4d861"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.7/kb-genie_Linux_x86_64.tar.gz"
        sha256 "e015fd558cacae593e06b80230800f3a66d3751fe006d1b9117f5e435ec0e6a3"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.7/kb-genie_Linux_arm64.tar.gz"
        sha256 "7340b318fde07e50a9bcc5d286c52dec63b1aa96d360ed846bde107ce4c236b0"
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
