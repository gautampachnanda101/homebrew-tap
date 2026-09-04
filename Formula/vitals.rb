# typed: false
# frozen_string_literal: true

# Template — the release workflow substitutes 0.6.0, https://github.com/gautampachnanda101/vitals/releases/download/v0.6.0 and the
# __SHA_*__ placeholders and commits the result to Formula/vitals.rb in the tap.
class Vitals < Formula
  desc "Local-first system diagnostics: names your bottleneck and the fix"
  homepage "https://github.com/gautampachnanda101/vitals"
  version "0.6.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.6.0/vitals_Darwin_x86_64.tar.gz"
      sha256 "910429241990ed988f8b8d129c3e354335f8e44b5c6dc762f53b54667cfc4ea3"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.6.0/vitals_Darwin_arm64.tar.gz"
      sha256 "bfc3190e908ee5b2875db5814030308b20979ca4140a16ceff8706fdc0ed46e5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.6.0/vitals_Linux_x86_64.tar.gz"
      sha256 "649795d8b220296e8effd12d84774e09883ea625371008421d6c667a0cba6ff8"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.6.0/vitals_Linux_arm64.tar.gz"
      sha256 "516beea6f189a6ec9f523223e710766b19e186a6bf2d9199496bbd620c55f08c"
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
