# typed: false
# frozen_string_literal: true

# Template — the release workflow substitutes 0.10.0, https://github.com/gautampachnanda101/vitals/releases/download/v0.10.0 and the
# __SHA_*__ placeholders and commits the result to Formula/vitals.rb in the tap.
class Vitals < Formula
  desc "Local-first system diagnostics: names your bottleneck and the fix"
  homepage "https://github.com/gautampachnanda101/vitals"
  version "0.10.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.10.0/vitals_Darwin_x86_64.tar.gz"
      sha256 "95ef0df22c554232ad5f76fddc5bf25632b82b4066a6ba3332dc64571cf77e0b"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.10.0/vitals_Darwin_arm64.tar.gz"
      sha256 "15ea24f49cc62e08f8c8700d454bad7b638c9d86580502cabd7aa75554ea1e4f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.10.0/vitals_Linux_x86_64.tar.gz"
      sha256 "2bbdef175060a95b1f37fedd4ab5cebe4b618d8c15ea91ebe79669620a08a98b"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.10.0/vitals_Linux_arm64.tar.gz"
      sha256 "85575e191dbad5ab348911dc94fdeb43d21ba5d42e55732a27a5a5a8de25ee44"
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
