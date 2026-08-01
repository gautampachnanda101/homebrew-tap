# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.3.4"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.4/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "a22481ca1ad1885e0f4ad7b3c07a728b2a23a3f057d45a3c3238a7f7be130e6e"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.4/kb-genie_Darwin_arm64.tar.gz"
      sha256 "5ce4a0d57349862bbb6637c9b9b79add69ed2618d79ba72b87fb830ca9dd2a2f"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.4/kb-genie_Linux_x86_64.tar.gz"
        sha256 "7b32b796f4c6fc60f02fee1cc3757836b8ddedd07c5e5031185dce4c171c59fa"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.4/kb-genie_Linux_arm64.tar.gz"
        sha256 "75ed5bbbd03a69a5e601a9dc801d27e231aa3adc2caf0d8efd8307d55ef7431d"
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
