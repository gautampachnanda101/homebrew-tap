# typed: false
# frozen_string_literal: true

# Template — the release workflow substitutes 0.7.0, https://github.com/gautampachnanda101/vitals/releases/download/v0.7.0 and the
# __SHA_*__ placeholders and commits the result to Formula/vitals.rb in the tap.
class Vitals < Formula
  desc "Local-first system diagnostics: names your bottleneck and the fix"
  homepage "https://github.com/gautampachnanda101/vitals"
  version "0.7.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.7.0/vitals_Darwin_x86_64.tar.gz"
      sha256 "b6de0502486d485d725ffe7eee5956ac1bbff89d36f85940d3a660bb3fe0ed1f"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.7.0/vitals_Darwin_arm64.tar.gz"
      sha256 "c917a981bfa7d02a98806c6b8d3a58060632ebc219439dd76bf9d2c162a01c10"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.7.0/vitals_Linux_x86_64.tar.gz"
      sha256 "430b0ec1b5391a29cdd256a2f6f0582f2ae27a8f79acd5735bd21b3cc28d263f"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.7.0/vitals_Linux_arm64.tar.gz"
      sha256 "74a92f286b0a46da85fef3e75418be840f19b0fe1c47e28fc80f4e2dfefb8c87"
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
