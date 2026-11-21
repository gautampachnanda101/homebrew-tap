# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.7.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.0/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "f65c88fa5a5e036a318ffedbb776f77c763e36baa67ba7225b26aaca30832e69"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.0/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "291c2390e61ff0c78c9b4116a1c8b7e56a34f3da3f225e9fbb352472e06758c3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.0/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "d8572a73affc7ce0276ce803e3f20a957c1d6266064f74fed26d01c7695e4c77"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.0/gcse-revision_Linux_arm64.tar.gz"
      sha256 "ea4945740ac59f9f20b4e4aaef70b286ba3b182c78a308076952634b86739bcd"
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
    assert_match "0.7.0", shell_output("#{bin}/gcse-revision version")
  end
end
