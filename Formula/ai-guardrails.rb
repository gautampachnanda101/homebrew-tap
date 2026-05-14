# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.5.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.5.0/ai-guardrails_0.5.0_Darwin_x86_64.tar.gz"
      sha256 "704b555e178e7269872215e53b18b227e778a06df23b9ae9545542b747581fc7"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.5.0/ai-guardrails_0.5.0_Darwin_arm64.tar.gz"
      sha256 "4ecbea87041f3543bd304406c3b0b6bef2c880cdc4bd06d8f5aafd51f9a6404c"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.5.0/ai-guardrails_0.5.0_Linux_x86_64.tar.gz"
        sha256 "95278257ab4917915238b78fde228b0636acbc0f6e4f4968dbb5125eda93d59b"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.5.0/ai-guardrails_0.5.0_Linux_arm64.tar.gz"
        sha256 "d52b567d33b4fe0e098390ad5627344a240b174d7a539ed4fbe1ceb70e013b06"
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
