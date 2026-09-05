# typed: false
# frozen_string_literal: true

# Template — the release workflow substitutes 0.8.0, https://github.com/gautampachnanda101/vitals/releases/download/v0.8.0 and the
# __SHA_*__ placeholders and commits the result to Formula/vitals.rb in the tap.
class Vitals < Formula
  desc "Local-first system diagnostics: names your bottleneck and the fix"
  homepage "https://github.com/gautampachnanda101/vitals"
  version "0.8.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.8.0/vitals_Darwin_x86_64.tar.gz"
      sha256 "c6bf8e1b77ff997b48ad77117af90d06c2d49d5a46faa63ca33bb7c24a451c9f"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.8.0/vitals_Darwin_arm64.tar.gz"
      sha256 "e14e9173c299994877f1539987123f4adca33c739ee42c5ee0390962387d7023"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.8.0/vitals_Linux_x86_64.tar.gz"
      sha256 "d6a4cbdf377be4e02db15371b492f16e3057435eb3f13928963b0d2fc0ddff84"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.8.0/vitals_Linux_arm64.tar.gz"
      sha256 "bb55b48c9e53652d9895144d1507412fb011de900e6c0c8375fc79355080d091"
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
