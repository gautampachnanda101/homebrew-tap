# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.3.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.1/ai-guardrails_0.3.1_Darwin_x86_64.tar.gz"
      sha256 "7f762085c29eefe961b526479df861c755d64766e3ba15edae743e534c09c94e"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.1/ai-guardrails_0.3.1_Darwin_arm64.tar.gz"
      sha256 "d7101e628cd5bbeb585948bb3b3ee21cbe3169c66115f3c9ae0f19cf657b5cdf"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.1/ai-guardrails_0.3.1_Linux_x86_64.tar.gz"
        sha256 "56c7f7c4541f645a58b6cec84b1850acc9319c699c8b3bdbf773139e2767c2ca"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.1/ai-guardrails_0.3.1_Linux_arm64.tar.gz"
        sha256 "4ea353a85262f612cb713657d75c6eb5b9c95ef9232678698e0d0f34c9f7fd73"
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
