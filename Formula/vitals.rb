# typed: false
# frozen_string_literal: true

# Template — the release workflow substitutes 0.1.0, https://github.com/gautampachnanda101/vitals/releases/download/v0.1.0 and the
# __SHA_*__ placeholders and commits the result to Formula/vitals.rb in the tap.
class Vitals < Formula
  desc "Local-first system diagnostics: names your bottleneck and the fix"
  homepage "https://github.com/gautampachnanda101/vitals"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.1.0/vitals_Darwin_x86_64.tar.gz"
      sha256 "7002b4f2f13bf964e3e1e1ba709b0a399cc5e7b848356f49b8b137bcc4e651c6"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.1.0/vitals_Darwin_arm64.tar.gz"
      sha256 "32970d9dcf11dba6ebba80cc055282d99aa1fdf7ea66581d4ef5cce99053fbcb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.1.0/vitals_Linux_x86_64.tar.gz"
      sha256 "bd79f1d2aedb66686d4e12d0a69ccb51a066cd36b70784a573e15fe472c5e537"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.1.0/vitals_Linux_arm64.tar.gz"
      sha256 "a478092bcd497c3d012342802cbdee797885f43c3ae34e7bcc118cfa3facccc2"
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
