# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.20"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.20/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "bbb38dcb861fa2613203a4b85da40efa787d6c92fc62e4c7144eabe26bbf7457"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.20/kb-genie_Darwin_arm64.tar.gz"
      sha256 "c094c623156c1b9e81445a1570479158519b307d8ec1e43f33d0f1d972efcd90"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.20/kb-genie_Linux_x86_64.tar.gz"
        sha256 "e2c5d39bb2d4c87edb06c296adf710fdcac19b7ece0792c347dff169c69b8992"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.20/kb-genie_Linux_arm64.tar.gz"
        sha256 "3a2ea4709927c4a4820f1226f71cb99a1198c4307a2073d9745a816cb9e6735e"
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
