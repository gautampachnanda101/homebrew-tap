# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.3.6"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.6/ai-guardrails_0.3.6_Darwin_x86_64.tar.gz"
      sha256 "73d9ecf189d6e27491f2cf388b49fdf65c28bf9fff80554c901337843b0a9da9"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.6/ai-guardrails_0.3.6_Darwin_arm64.tar.gz"
      sha256 "79d0f5d16779bc63b64875213ac1619d54f9545cf690e82be3421e7aea6f96e5"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.6/ai-guardrails_0.3.6_Linux_x86_64.tar.gz"
        sha256 "3459cbb075810d942356b7d37c31bbf65c325438e9ecf58a1d7d0f86c76113ea"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.6/ai-guardrails_0.3.6_Linux_arm64.tar.gz"
        sha256 "d7eb7b90504f0da2d61a7887b8eee05d9a5cfa200c46ca0eb0eec7c828dc24be"
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
