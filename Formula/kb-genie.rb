# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.3.2"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.2/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "fd6f7120549792e528824e8a7a23caf0204b5acc0caf175c4e2709df9d0f192c"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.2/kb-genie_Darwin_arm64.tar.gz"
      sha256 "bc72b4e27df876a4382cf552f0976373ab429b623acd205cc85105b18562b958"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.2/kb-genie_Linux_x86_64.tar.gz"
        sha256 "7bed893b8ee29077d63a93c0336c9332b7a516304a213816fc0668e2de54d771"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.2/kb-genie_Linux_arm64.tar.gz"
        sha256 "7d612198189bc578f3ddb9b93c18f4907c65c776e047ee94cfc8f0767616da5d"
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
