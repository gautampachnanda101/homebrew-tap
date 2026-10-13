# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.6.2"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.6.2/ai-guardrails_0.6.2_Darwin_x86_64.tar.gz"
      sha256 "36925f6eb49099741cb9289e43aaec04f1dd3a6d24666f1515cdc87c8353cb81"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.6.2/ai-guardrails_0.6.2_Darwin_arm64.tar.gz"
      sha256 "c1aca4156e8329f27429f44d6bfe6865ea948b8f313bc90b2edd268170b694d8"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.6.2/ai-guardrails_0.6.2_Linux_x86_64.tar.gz"
        sha256 "56b177745f25a313afc85813381b89c6e633fb7747cfee70c144b7f55606f87e"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.6.2/ai-guardrails_0.6.2_Linux_arm64.tar.gz"
        sha256 "4373ade6bda962e3d4cdfca885e3a7e0977ed9a4ebeea4b302a07153d52fd829"
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
