# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.7.5"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.5/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "2e43796f96ad39801e8f97c007af1e3477a6ee10a7ca6a6e259f2a4cbf413c9f"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.5/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "c62916a1e8c5bb5307536237cce5beceddbd9a052279ee86530f46d9f70582bc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.5/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "d7582c21ccaacc2fce459ec0623c01eaab72597a337b8e02f0fa4fb704d48bb7"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.5/gcse-revision_Linux_arm64.tar.gz"
      sha256 "6b42ab29790f38442fef7b5635056acbc4ab7500e501196e44030f84b627c40c"
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
    assert_match "0.7.5", shell_output("#{bin}/gcse-revision version")
  end
end
