# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.4.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.4.1/ai-guardrails_0.4.1_Darwin_x86_64.tar.gz"
      sha256 "f2fcb26b778f8f5cd72165c72369c5871822b3637d73645f8b6c0eac5bd92a1a"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.4.1/ai-guardrails_0.4.1_Darwin_arm64.tar.gz"
      sha256 "dc6c0abf5fb1b04913d7e62124f8875706abf86b832ced8d82415218785dc553"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.4.1/ai-guardrails_0.4.1_Linux_x86_64.tar.gz"
        sha256 "0fc41097f424f0b053a516d3d49ba9931ac8f58aecf31386f9e68548fc7e2b97"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.4.1/ai-guardrails_0.4.1_Linux_arm64.tar.gz"
        sha256 "e2419d64059147c1ee780123cc1972201432e43bbf7f6d3d6e6d40a48035fca7"
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
