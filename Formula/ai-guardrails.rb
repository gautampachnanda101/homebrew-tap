# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.6.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.6.1/ai-guardrails_0.6.1_Darwin_x86_64.tar.gz"
      sha256 "6e87775c3c12c5b1e953faf67dad095e00172d0fd245a0ae26d54ae81d3d50b0"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.6.1/ai-guardrails_0.6.1_Darwin_arm64.tar.gz"
      sha256 "0ed17cdb5c57dc3098c84b60c0222db99d8026b195aacd9e01c7971c4beb3c4c"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.6.1/ai-guardrails_0.6.1_Linux_x86_64.tar.gz"
        sha256 "e603ef38a9f00d8f60845888be4540694aeb8ea36eff62993b428043259cdaee"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.6.1/ai-guardrails_0.6.1_Linux_arm64.tar.gz"
        sha256 "0b958148f4ebf041c3573e7f8ed5cde512bc8949cc3ad82a9666410e2e044cb6"
      end
    end
  end

  def install
    bin.install "ai-guardrails"
  end

  test do
    system "#{bin}/ai-guardrails --help"
  end
end
