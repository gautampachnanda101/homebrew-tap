# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.3.3"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.3/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "19076bcca0f35412c5cba2902fa60ae670b56c8aa6e831ef7d3d5dda6b22db24"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.3/kb-genie_Darwin_arm64.tar.gz"
      sha256 "faa870e73dfe61ac55f0c86a12b0998d134654991da364aa3826becf42211b67"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.3/kb-genie_Linux_x86_64.tar.gz"
        sha256 "ebff4d04bbd3cbbbef6e7fe7077b64a52a8ca48b3f95996d5bf11aad116e4e34"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.3/kb-genie_Linux_arm64.tar.gz"
        sha256 "39218dd8e91b0d886dc6092c56ea17999340e6d512713e74169d72207a677d67"
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
