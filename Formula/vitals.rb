# typed: false
# frozen_string_literal: true

# Template — the release workflow substitutes 0.2.1, https://github.com/gautampachnanda101/vitals/releases/download/v0.2.1 and the
# __SHA_*__ placeholders and commits the result to Formula/vitals.rb in the tap.
class Vitals < Formula
  desc "Local-first system diagnostics: names your bottleneck and the fix"
  homepage "https://github.com/gautampachnanda101/vitals"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.2.1/vitals_Darwin_x86_64.tar.gz"
      sha256 "e03295b687f5cfaf122eeeb06d3f1053001838aa35c8664f01e3edc366664a7a"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.2.1/vitals_Darwin_arm64.tar.gz"
      sha256 "24b333078a451981f4fdf3a23b90ca3cff44d9ca51db60e400d926f9b38ae39a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.2.1/vitals_Linux_x86_64.tar.gz"
      sha256 "cb16727a005b7dfc537688d56769bca80a1eb108686a215770042758ea7a0575"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.2.1/vitals_Linux_arm64.tar.gz"
      sha256 "cae536ab6d4697c86c7191f122bedf429d312ca75b2adb05033582b9099e8b02"
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
