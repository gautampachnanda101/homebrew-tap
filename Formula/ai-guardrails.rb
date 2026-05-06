# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.4.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.4.1/ai-guardrails_0.4.1_Darwin_x86_64.tar.gz"
      sha256 "05b482a87cd7a25d3651d9ea1c04ac517d89ded80ef13a83cbd3d7d02dda6b2e"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.4.1/ai-guardrails_0.4.1_Darwin_arm64.tar.gz"
      sha256 "3231cbc1052508abd6b842847ffb577bb1cb00387307679a32f1f64ccbe206c9"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.4.1/ai-guardrails_0.4.1_Linux_x86_64.tar.gz"
        sha256 "97d915bb78f19aa3fc0405f0a85ad3ad188e1f5974cd3030998954d6b8ec2f25"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.4.1/ai-guardrails_0.4.1_Linux_arm64.tar.gz"
        sha256 "6618c8b7f0fd0792b96d17019e128d3cadf85bc4faa2993d0ac28fa4512d6f4b"
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
