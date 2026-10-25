# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.21.5"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.5/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "db796ce0203a973346ce31d15522d4ec82ce74be12785db9988b15ca4edff228"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.5/kb-genie_Darwin_arm64.tar.gz"
      sha256 "11b80332cef5ef67778d9931d8bcfe4617937ea1e1b0a2368f494d72a647be8e"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.5/kb-genie_Linux_x86_64.tar.gz"
        sha256 "ca0850dc61f0318d05072a73fd32d5381722b7c6b02616fbaad337d70b46c901"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.21.5/kb-genie_Linux_arm64.tar.gz"
        sha256 "d6136910da85b312ae2b00db0b37d65be4e77bab0f5319ff7f81541570a9271c"
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
