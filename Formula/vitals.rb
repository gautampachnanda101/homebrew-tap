# typed: false
# frozen_string_literal: true

# Template — the release workflow substitutes 0.9.0, https://github.com/gautampachnanda101/vitals/releases/download/v0.9.0 and the
# __SHA_*__ placeholders and commits the result to Formula/vitals.rb in the tap.
class Vitals < Formula
  desc "Local-first system diagnostics: names your bottleneck and the fix"
  homepage "https://github.com/gautampachnanda101/vitals"
  version "0.9.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.9.0/vitals_Darwin_x86_64.tar.gz"
      sha256 "15b3a5dd261847a181018ebe70ea2242dc80c8cf6e7f848bad49d92eddb394de"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.9.0/vitals_Darwin_arm64.tar.gz"
      sha256 "c44ebaf843de8e68dea631989d420336f678d4dbb5aa72891e2fbfe1797ae634"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.9.0/vitals_Linux_x86_64.tar.gz"
      sha256 "113ce9181e433a9c4ea1f7c2330f8716120c983ece9551648918a2c7244ebacc"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.9.0/vitals_Linux_arm64.tar.gz"
      sha256 "4b2f759da19c98792ab0b3242eea740c5f9c2b11decde80306a9736c9558ded7"
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
