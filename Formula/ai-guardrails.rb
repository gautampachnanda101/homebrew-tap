# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.4.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.4.0/ai-guardrails_0.4.0_Darwin_x86_64.tar.gz"
      sha256 "64e68d00adfa3b6e5aa26f71c4f5b94858c399999261ac29c13dd714de993b23"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.4.0/ai-guardrails_0.4.0_Darwin_arm64.tar.gz"
      sha256 "57e0154b19e1c1bf38e6c921fc6afeefe9538b812409bcd2449ad48935430913"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.4.0/ai-guardrails_0.4.0_Linux_x86_64.tar.gz"
        sha256 "c204199f2196d136a7dd631288af0d9d968bea71617bfd588c6a0521864dfe4b"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.4.0/ai-guardrails_0.4.0_Linux_arm64.tar.gz"
        sha256 "117b54f1305d8e285e27b5b21f0923be2a63d22cb83877ebc2271989ef3104e4"
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
