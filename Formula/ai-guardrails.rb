# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "v0.2.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.2.0/ai-guardrails_v0.2.0_Darwin_x86_64.tar.gz"
      sha256 "8d6cdf8d2c546c6f335d7504f9cf9351bccbb087319b732fb7badf8ffd4b96e1"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.2.0/ai-guardrails_v0.2.0_Darwin_arm64.tar.gz"
      sha256 "e0b3b191d3e6638c62acb2c3e2c45a9c3f6f938cdb557c271fa3819d60c6ab7f"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.2.0/ai-guardrails_v0.2.0_Linux_x86_64.tar.gz"
        sha256 "9eff0d406d15caca47fb9ac126ea6f0a1ec001c5e9149c6c530fb48444a949f5"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.2.0/ai-guardrails_v0.2.0_Linux_arm64.tar.gz"
        sha256 "09894c20fc9e5a2cee71f9c45147fc387f7c888fc98725dec81e525071463309"
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
