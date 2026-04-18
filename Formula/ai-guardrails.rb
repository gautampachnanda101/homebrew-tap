# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.3.2"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.2/ai-guardrails_0.3.2_Darwin_x86_64.tar.gz"
      sha256 "d0f3a7d20340c8b599c1ae3833cfb326c0045af57f433eba4696768a4191af15"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.2/ai-guardrails_0.3.2_Darwin_arm64.tar.gz"
      sha256 "882d237b5484be02f600ca881e685ace45146e71c1f67baccfd984410f1bcfbb"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.2/ai-guardrails_0.3.2_Linux_x86_64.tar.gz"
        sha256 "58eb732d6473cc9fdfa4cb262e7572389ec2b24bb66aad81b1569bae795efa85"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.2/ai-guardrails_0.3.2_Linux_arm64.tar.gz"
        sha256 "f4fdff2f096c814895018e8ab85751e8466c1d4c2b2ef8309469af6bf4391114"
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
