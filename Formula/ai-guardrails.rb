# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.3.5"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.5/ai-guardrails_0.3.5_Darwin_x86_64.tar.gz"
      sha256 "b9570fe8d1bdf8dd0629026a2b5ae8a7c8591827be97aa4129760ce379cc438e"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.5/ai-guardrails_0.3.5_Darwin_arm64.tar.gz"
      sha256 "9cee65d1e3d4f2bf0f6a1ebddcdac42890e2eb45215c3232d2f8611b2b4a96b0"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.5/ai-guardrails_0.3.5_Linux_x86_64.tar.gz"
        sha256 "8dd73db963df91aa514e582049b138f3d6ed67a63b732ad0c3b772c013edb49b"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.5/ai-guardrails_0.3.5_Linux_arm64.tar.gz"
        sha256 "4bdb45cb5c92980b0b097e0f692911a2bbebf16911bb624dbbb135a0a83acc8e"
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
