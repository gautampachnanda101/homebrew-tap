# typed: false
# frozen_string_literal: true

# Template — the release workflow substitutes 0.12.0, https://github.com/gautampachnanda101/vitals/releases/download/v0.12.0 and the
# __SHA_*__ placeholders and commits the result to Formula/vitals.rb in the tap.
class Vitals < Formula
  desc "Local-first system diagnostics: names your bottleneck and the fix"
  homepage "https://github.com/gautampachnanda101/vitals"
  version "0.12.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.12.0/vitals_Darwin_x86_64.tar.gz"
      sha256 "76a8260fe7b163d0f5831531543432ff3997066b3cd3e78b40d690ac6be76d7f"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.12.0/vitals_Darwin_arm64.tar.gz"
      sha256 "4ee13562d580ddc240bf71cd4101cc14d16e5c3d16b4ec50e77ed9affb89e5bd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.12.0/vitals_Linux_x86_64.tar.gz"
      sha256 "d79b9f4ab82cf79ca480f6e268645a0c0f4a0eef94131e1f70b2e9b6ed819521"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.12.0/vitals_Linux_arm64.tar.gz"
      sha256 "63ea1c4c8e32a30d0afb50e6a4aa8ddfcf04a94c2bd81b191c127cdcd1a38ebd"
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
