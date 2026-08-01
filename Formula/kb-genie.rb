# typed: false
# frozen_string_literal: true

class KbGenie < Formula
  desc "Local-first RAG knowledge base builder with pluggable embedding backends"
  homepage "https://github.com/gautampachnanda101/kb-genie"
  version "1.3.5"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.5/kb-genie_Darwin_x86_64.tar.gz"
      sha256 "3545563ff6e31c96387bfe269d272690fb7ad00c6a366d3ffb8404032310779e"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.5/kb-genie_Darwin_arm64.tar.gz"
      sha256 "f93198fbbecd9f0f958627a771e94920e3e180dea0d99fee130c6129121c918d"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.5/kb-genie_Linux_x86_64.tar.gz"
        sha256 "96646ad0181b611fff3589b40a6b1446c85951c4aeeb3826f2f70d964e03a951"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/kb-genie-v1.3.5/kb-genie_Linux_arm64.tar.gz"
        sha256 "640763b4ca8908050247582bac59adcb0db04b51e48d17bd02dc01c1399d92a6"
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
