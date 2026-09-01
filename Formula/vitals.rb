# typed: false
# frozen_string_literal: true

# Template — the release workflow substitutes 0.3.1, https://github.com/gautampachnanda101/vitals/releases/download/v0.3.1 and the
# __SHA_*__ placeholders and commits the result to Formula/vitals.rb in the tap.
class Vitals < Formula
  desc "Local-first system diagnostics: names your bottleneck and the fix"
  homepage "https://github.com/gautampachnanda101/vitals"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.3.1/vitals_Darwin_x86_64.tar.gz"
      sha256 "7d8498d223c6a473aef32f0f7c60254679866ba6f7c805c428f3f81dcfb1f8da"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.3.1/vitals_Darwin_arm64.tar.gz"
      sha256 "96764d9e213f6f32474a0bfa14c44870254712bfc54ac3eb64607439a2d402a0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.3.1/vitals_Linux_x86_64.tar.gz"
      sha256 "ff50245535f9744b25965c47f1c05795fb0b5fc3f4af6ee9d7b4f5e889abb072"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.3.1/vitals_Linux_arm64.tar.gz"
      sha256 "30d311bca827799d84ddace907d4e8ff5da20a73e31c84e7783419761e9779cd"
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
