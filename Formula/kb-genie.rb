# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.2.14"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.14/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "714d60220bebe2524903cda35341968213051b4454b4e187159a4227e935d86c"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.14/kb-genie_Darwin_arm64.tar.gz"
      sha256 "e12138ebff663068f4561aa0e68bff86e524359c03b9d96ea67e7a6016aa8ff2"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.14/kb-genie_Linux_x86_64.tar.gz"
        sha256 "4e1d48e235516959c0fcf5c85f1f330fba331a7bce884c85266bb775d9e76ee6"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.2.14/kb-genie_Linux_arm64.tar.gz"
        sha256 "ed82a3013f4d7ea4012aa19b6c634a94290ae019ac1dbadb51d6a5700c83dead"
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
