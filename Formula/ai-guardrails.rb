# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.3.8"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.8/ai-guardrails_0.3.8_Darwin_x86_64.tar.gz"
      sha256 "48e896a08c8d63d74ffa58287b53340d4f9ef4bbe56c52a88a9a52b15702a495"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.8/ai-guardrails_0.3.8_Darwin_arm64.tar.gz"
      sha256 "28549429de7b17e062e15e8c6accc4134f48d208f0ac194e37057e8c948a55e4"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.8/ai-guardrails_0.3.8_Linux_x86_64.tar.gz"
        sha256 "5401bad37ba69d6886461f07209594a0c1d7b45e8b3f64685b86928a4ac12526"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.8/ai-guardrails_0.3.8_Linux_arm64.tar.gz"
        sha256 "e37077adb5987c69408ced6cd415b7403fcc67613d826a1d38b721199600c39f"
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
