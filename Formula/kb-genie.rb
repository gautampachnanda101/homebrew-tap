# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.4.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.4.1/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "06f9c2b25b3518d4ba122c5167a681f760dcef7e755655a0bda124ea9d1a4f0d"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.4.1/kb-genie_Darwin_arm64.tar.gz"
      sha256 "499bb698b2044d80fa8b8e00ee8df9f214d56697f1d233a15fc0599d1eca69ab"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.4.1/kb-genie_Linux_x86_64.tar.gz"
        sha256 "de00c009ed103178d706c5af25cb47715f52466c1c3869b449dffc7884900aa3"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.4.1/kb-genie_Linux_arm64.tar.gz"
        sha256 "925c8baf540aca46a5054f3d09f739556ea7115040a8f6629f93967b0d40e3ab"
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
