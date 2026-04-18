# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.3.3"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.3/ai-guardrails_0.3.3_Darwin_x86_64.tar.gz"
      sha256 "b29323623fb2a1b1fa8a1ccc88eee001654912c345c35d77e25673f49b1dc493"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.3/ai-guardrails_0.3.3_Darwin_arm64.tar.gz"
      sha256 "efff8d357c099845f82c83cb4839635237aa8ba256b9792ca1b3616c5715b64b"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.3/ai-guardrails_0.3.3_Linux_x86_64.tar.gz"
        sha256 "0c24b8f40e0824627d7dc501f4aaf4b96c86e5b3b91eceb6d48304c14131cedc"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.3/ai-guardrails_0.3.3_Linux_arm64.tar.gz"
        sha256 "8fdc49e6d87000f280eb9f3a37e672afde99770c91c81117d563f4c17e3fe7de"
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
