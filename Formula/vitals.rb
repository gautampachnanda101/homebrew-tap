# typed: false
# frozen_string_literal: true

# Template — the release workflow substitutes 0.5.0, https://github.com/gautampachnanda101/vitals/releases/download/v0.5.0 and the
# __SHA_*__ placeholders and commits the result to Formula/vitals.rb in the tap.
class Vitals < Formula
  desc "Local-first system diagnostics: names your bottleneck and the fix"
  homepage "https://github.com/gautampachnanda101/vitals"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.5.0/vitals_Darwin_x86_64.tar.gz"
      sha256 "867aa8e9826f5d81ea2e632c7ef9b6743f407eafda1873626fc8139ebce005bc"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.5.0/vitals_Darwin_arm64.tar.gz"
      sha256 "01e1814749c8d6b8a4c9786e624deaae53941a53060fb2127f9c9e32dc701bb3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.5.0/vitals_Linux_x86_64.tar.gz"
      sha256 "6368ba98a1bde724c8495838cf0890a316ba7764a3aa231c761e33aaf05a40b4"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.5.0/vitals_Linux_arm64.tar.gz"
      sha256 "0b4ecafecda16de3e36b752a4b1fb3c6c45a21f4b9e7bfaad4bab75d638330a8"
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
