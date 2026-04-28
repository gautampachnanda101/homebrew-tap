# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.3.9"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.9/ai-guardrails_0.3.9_Darwin_x86_64.tar.gz"
      sha256 "9462fafd0c5d72757099106de9f33f60c0739952f3a832eca19b80b787556c42"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.9/ai-guardrails_0.3.9_Darwin_arm64.tar.gz"
      sha256 "7aecaad098be4b013a234e268854d2f4117527603e15f098eb2ff4b4b6213411"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.9/ai-guardrails_0.3.9_Linux_x86_64.tar.gz"
        sha256 "3210db77f6ae9920d836fdf9d788ef0992331ee6ae7e6223ffa28e801af22b8d"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.9/ai-guardrails_0.3.9_Linux_arm64.tar.gz"
        sha256 "8271b67b6cdc61dccae35dbf1813f03ae9bb785451a346fa4f6ac8e3e19c5139"
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
