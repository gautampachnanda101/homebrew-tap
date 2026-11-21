# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.7.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.1/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "4ef5340ee908a42ba4e225c832ef8813c5af7c9c79fc3b1960df65046165a592"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.1/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "78edc07d247f11d59a653030aa869a63cc486930a48cf68212eb9ff1e2b26a5e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.1/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "e6eee4f73b3bb36703051f49212ae069d99b890837ae19ea9d25c6373ea7ca05"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.1/gcse-revision_Linux_arm64.tar.gz"
      sha256 "7c6b601573858d692559956fd375e59f4cb9f329541e107be0d808c50de2b589"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  def post_install
    plist = "#{Dir.home}/Library/LaunchAgents/com.gautampachnanda101.gcse-revision.plist"
    system "#{bin}/gcse-revision", "service", "install" if File.exist?(plist)
  end

  def caveats
    <<~EOS
      Start the per-user background service with:
        #{bin}/gcse-revision service install

      The service opens at http://gcse-revision.localhost:8765/ and checks for upgrades automatically.
    EOS
  end

  test do
    assert_match "0.7.1", shell_output("#{bin}/gcse-revision version")
  end
end
