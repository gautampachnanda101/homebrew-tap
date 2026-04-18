# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.3.4"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.4/ai-guardrails_0.3.4_Darwin_x86_64.tar.gz"
      sha256 "286b429d8a5c91af99693dde7d46d8327cfd7c15060c0ab63f4e183a0f83d6b0"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.4/ai-guardrails_0.3.4_Darwin_arm64.tar.gz"
      sha256 "0038435971d044d86992b1ce092d568e342a6d61931045942f1f1e7ff3f89c6c"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.4/ai-guardrails_0.3.4_Linux_x86_64.tar.gz"
        sha256 "fde66490277e80d1329d470d16cfa91d31cba9ccc1450ff6335a3d887e8af8f7"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.4/ai-guardrails_0.3.4_Linux_arm64.tar.gz"
        sha256 "a3abbbfa45feb361bed651861ac48fdf2d6751b1a013130ba262b519eca6adad"
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
