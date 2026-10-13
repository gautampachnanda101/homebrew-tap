# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.6.2"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.6.2/ai-guardrails_0.6.2_Darwin_x86_64.tar.gz"
      sha256 "91e2723b9786579a4455025f461d5f2e699dc736df31249e19bc24804c79722f"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.6.2/ai-guardrails_0.6.2_Darwin_arm64.tar.gz"
      sha256 "45b8f0408886632732e211535c73e6405d727f1b0d05950024495c940aea3e7b"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.6.2/ai-guardrails_0.6.2_Linux_x86_64.tar.gz"
        sha256 "a51fd861fb5ae954b1e77eca446f81e7d98353c8763b87c67edba2bd3a602c6c"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.6.2/ai-guardrails_0.6.2_Linux_arm64.tar.gz"
        sha256 "60684cb92bbeeb8c42977f3baba919d3f5cc3a5166fee879c12aa5dc641e5e73"
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
