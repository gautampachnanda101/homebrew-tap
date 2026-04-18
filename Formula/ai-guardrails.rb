# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.3.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.0/ai-guardrails_0.3.0_Darwin_x86_64.tar.gz"
      sha256 "b237cf6e002bc6ba773f09198ae5f491b6d4016a3d2e95b6ea832e8b5ff589b3"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.0/ai-guardrails_0.3.0_Darwin_arm64.tar.gz"
      sha256 "285f9bdf092dd77ba721a09d57567ed76d9da4f0dfaf4569107b77953ffcc7ea"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.0/ai-guardrails_0.3.0_Linux_x86_64.tar.gz"
        sha256 "9adb1c0fbb166c7af2a5c3cbc63a9a0210588ed209d583693f12630c27c40e8f"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.0/ai-guardrails_0.3.0_Linux_arm64.tar.gz"
        sha256 "3363d55013c4cf1d15ae96fa353cacbd4c3d13caec1122d925816a246e6395ee"
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
