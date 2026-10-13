# typed: false
# frozen_string_literal: true

# Template — the release workflow substitutes 0.11.0, https://github.com/gautampachnanda101/vitals/releases/download/v0.11.0 and the
# __SHA_*__ placeholders and commits the result to Formula/vitals.rb in the tap.
class Vitals < Formula
  desc "Local-first system diagnostics: names your bottleneck and the fix"
  homepage "https://github.com/gautampachnanda101/vitals"
  version "0.11.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.11.0/vitals_Darwin_x86_64.tar.gz"
      sha256 "8a44bc6297757230bccae890c459b5f38d8e23392c67fa449333e0b075b5098d"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.11.0/vitals_Darwin_arm64.tar.gz"
      sha256 "3fbe59a68b8461cacf0a46252d545d3169f156f3b5b10442f57dfb339407b302"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.11.0/vitals_Linux_x86_64.tar.gz"
      sha256 "cb4679c20bcdaa32d24ec2649b1662d6db58188b57cee4ca320a80fcabb90a33"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.11.0/vitals_Linux_arm64.tar.gz"
      sha256 "e1612867467ed79cb8f1993cfe73ff4c01aa3e8154d67a9d5e2be54826057a6b"
    end
  end

  def install
    bin.install "vitals"
    generate_completions_from_executable(bin/"vitals", "completion")
    # Vitals.app (roadmap item 004, macOS archives only) isn't installed
    # to /Applications — that's a Homebrew Cask's job, not a Formula's;
    # dropped in the keg's prefix instead, see caveats for how to use it.
    prefix.install "Vitals.app" if File.directory?("Vitals.app")
  end

  def caveats
    <<~EOS
      Get a verdict for this machine:
        vitals doctor

      Full guide:  vitals guide   |   per-command help:  vitals help <cmd>

      A double-clickable dashboard launcher is at:
        #{opt_prefix}/Vitals.app
      Copy it to /Applications if you want it there — Homebrew Formulae
      don't install GUI apps to /Applications themselves. It's unsigned;
      the first open needs right-click -> Open to get past Gatekeeper.
    EOS
  end

  test do
    assert_match "vitals", shell_output("#{bin}/vitals version")
    assert_match "doctor", shell_output("#{bin}/vitals help")
  end
end
