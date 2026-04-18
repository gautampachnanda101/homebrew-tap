# typed: false
# frozen_string_literal: true

class AiGuardrails < Formula
  desc "AI-assisted development guardrails: standardize guardrails, skills, tools, and CI/CD templates."
  homepage "https://github.com/gautampachnanda101/ai-guard-cli"
  version "0.1.0-rc.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/ai-guard-cli/releases/download/v0.1.0-rc.1/ai-guardrails-darwin-amd64-v0.1.0-rc.1"
      sha256 "d2198fb34f85d8c95dba1cebaf272ac196009442ae22cf99f818db610d7312c8"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/ai-guard-cli/releases/download/v0.1.0-rc.1/ai-guardrails-darwin-arm64-v0.1.0-rc.1"
      sha256 "29ff5c9c91a2b5b89f8ed08d71b2803a3891c62a1f2e57db0c56d0e92a19bf51"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/ai-guard-cli/releases/download/v0.1.0-rc.1/ai-guardrails-linux-amd64-v0.1.0-rc.1"
        sha256 "b15f3e484e7e89a9f942fe9fd02fb416af10a9e6f4dce847dc9e1121fa49fc0c"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/ai-guard-cli/releases/download/v0.1.0-rc.1/ai-guardrails-linux-arm64-v0.1.0-rc.1"
        sha256 "7c156d3e774616832a04193507cafc72fd3fe8b9c13ffdb633275b0768b45a9f"
      end
    end
  end

  def install
    bin.install "ai-guardrails-#{OS.mac? ? 'darwin' : 'linux'}-#{Hardware::CPU.arm? ? 'arm64' : Hardware::CPU.intel? ? (OS.mac? ? 'amd64' : 'amd64') : 'amd64'}-v0.1.0-rc.1" => "ai-guardrails"
    pkgshare.install "ENDUSER-GUIDE.md"
  end

  test do
    system "#{bin}/ai-guardrails --help"
  end
end
