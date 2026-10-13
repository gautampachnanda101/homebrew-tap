# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.6.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.6.0/ai-guardrails_0.6.0_Darwin_x86_64.tar.gz"
      sha256 "9449960694102d76b471032c9a97b60bb9f5b36fe668f9d66d0e7ebd86d76af3"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.6.0/ai-guardrails_0.6.0_Darwin_arm64.tar.gz"
      sha256 "29b43a8547c573031bd77b8ecdf9107b2cd9ff78d3dfd12788d41b5777424808"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.6.0/ai-guardrails_0.6.0_Linux_x86_64.tar.gz"
        sha256 "ebf73efa62d82d7f23ca1251625fa7ea103fe19fcbefc1d5c6ef691eb3268350"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.6.0/ai-guardrails_0.6.0_Linux_arm64.tar.gz"
        sha256 "dd6b21017458c2ae8c7f92ae36bba7718ac71272ac34dbdef3e83b42e35632d1"
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
