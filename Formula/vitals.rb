# typed: false
# frozen_string_literal: true

# Template — the release workflow substitutes 0.2.0, https://github.com/gautampachnanda101/vitals/releases/download/v0.2.0 and the
# __SHA_*__ placeholders and commits the result to Formula/vitals.rb in the tap.
class Vitals < Formula
  desc "Local-first system diagnostics: names your bottleneck and the fix"
  homepage "https://github.com/gautampachnanda101/vitals"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.2.0/vitals_Darwin_x86_64.tar.gz"
      sha256 "6751e6b5761fa44fb57d1172b1738823acc827d37c82d2b95b9194a7d5564ce9"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.2.0/vitals_Darwin_arm64.tar.gz"
      sha256 "323c02cf7a5be1d128e431f9fbd69b8b1e3db34dce6cf3408b716dd98e48b244"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.2.0/vitals_Linux_x86_64.tar.gz"
      sha256 "0cf80bb5926d7b73609b9daa3331f405e32acf2d20f0bb6e9c6248d7242c266c"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.2.0/vitals_Linux_arm64.tar.gz"
      sha256 "a1fec818b0218351bce13bf11e03eb04b1d8552558fa8de3397f93a0a1281f77"
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
