# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.3.7"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.7/ai-guardrails_0.3.7_Darwin_x86_64.tar.gz"
      sha256 "907ab11df7957ed2f840ccd24dc50b0e1a9e7e27a25cf67f639b165577b91e5d"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.7/ai-guardrails_0.3.7_Darwin_arm64.tar.gz"
      sha256 "e61f2bb8e99a6d04c75a29bb7d0ac5e4d3a253461e0916393897cb59ce5a29ea"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.7/ai-guardrails_0.3.7_Linux_x86_64.tar.gz"
        sha256 "7da243b5f81a9f15d4a07a49a68ef5667516bd9955aee5732cfe340e279fda88"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.7/ai-guardrails_0.3.7_Linux_arm64.tar.gz"
        sha256 "57f20e9cf630245d1ebf06681415b7a10e207fc840d0e9c21d6dbde6a2a01bf9"
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
