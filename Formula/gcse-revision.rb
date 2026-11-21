# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.7.6"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.6/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "24e2ce996ff740f4450fd6d07b1cbc2a5f689873a1f929aeba2d3db6451df274"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.6/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "a708e37875bc1efa1a6132366aa6b2a93d2be8a410deb31e636bb52953045cd7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.6/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "af41d340c02c8f8f855b086b751480ec29656fe5a2c6a93fbaa656f275d2488d"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.6/gcse-revision_Linux_arm64.tar.gz"
      sha256 "52302411daf7e5d2ff491996642de77b5eba415ee54b3f1d75cfa73b84dec919"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  def post_install
    # One-time bridge for older running services; current versions also self-reconcile.
    system "#{bin}/gcse-revision", "service", "ensure"
  end

  def caveats
    <<~EOS
      If the background service was not already configured, start it with:
        #{bin}/gcse-revision service install

      The service opens at http://gcse-revision.localhost:8765/ and checks for upgrades automatically.
    EOS
  end

  test do
    assert_match "0.7.6", shell_output("#{bin}/gcse-revision version")
  end
end
