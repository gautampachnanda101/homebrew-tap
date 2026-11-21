# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.6.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.6.1/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "a87477be8aa05a5248062ad1b1615878b581fb1127da1afb83e981b5a76843f9"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.6.1/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "c2bfb11bfa5faed471ec7f3b62e368233694ebcca1f94fd3fea165b2d9fdc1d6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.6.1/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "a7605cbb80bc0065868d795f8bfe85a46744be027aa2c044827984fbbd34885b"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.6.1/gcse-revision_Linux_arm64.tar.gz"
      sha256 "9c6ad5ad1548cb90232e922714210d7aa39d3bd8129f713929224ab2cb1cb0d8"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  def post_install
    system "#{bin}/gcse-revision", "service", "install"
  end

  def caveats
    <<~EOS
      Start the per-user background service with:
        #{bin}/gcse-revision service install

      The service opens at http://gcse-revision.localhost:8765/ and checks for upgrades automatically.
    EOS
  end

  test do
    assert_match "0.6.1", shell_output("#{bin}/gcse-revision version")
  end
end
