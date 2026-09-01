# typed: false
# frozen_string_literal: true

# Template — the release workflow substitutes 0.4.0, https://github.com/gautampachnanda101/vitals/releases/download/v0.4.0 and the
# __SHA_*__ placeholders and commits the result to Formula/vitals.rb in the tap.
class Vitals < Formula
  desc "Local-first system diagnostics: names your bottleneck and the fix"
  homepage "https://github.com/gautampachnanda101/vitals"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.4.0/vitals_Darwin_x86_64.tar.gz"
      sha256 "4ad03cc2126d85be12648b3c6419879d550286fa0e26796edfe30ee8b0320385"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.4.0/vitals_Darwin_arm64.tar.gz"
      sha256 "225a71a16df971b01105fc4ad4c96b968e9c52496c90cb9a19e78748d873056f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.4.0/vitals_Linux_x86_64.tar.gz"
      sha256 "035f139bef16320d597aa98db031a0fd74f64f681dbb2cf03d94d1821f1c3b1f"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.4.0/vitals_Linux_arm64.tar.gz"
      sha256 "07d916a133d89b1559ff05a2155d67365072709cebf2c5e3f0029d1e01c48b81"
    end
  end

  def install
    bin.install "vitals"
    generate_completions_from_executable(bin/"vitals", "completion")
  end

  def caveats
    <<~EOS
      Get a verdict for this machine:
        vitals doctor

      Full guide:  vitals guide   |   per-command help:  vitals help <cmd>
    EOS
  end

  test do
    assert_match "vitals", shell_output("#{bin}/vitals version")
    assert_match "doctor", shell_output("#{bin}/vitals help")
  end
end
