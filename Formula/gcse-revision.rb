# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.2.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.2.0/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "798bc98ae6dd26f74a09c593146841877f6d10ee895b253868d554c563d2805e"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.2.0/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "6f3fc81adfcf50e8a6dc1ae302d30892cf5a38aa44189f53e661aea6e37e8965"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.2.0/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "2e75d0da5ebd087b4e242ff4bcd25d4c111c0d8d70f707115b222bc6e5998292"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.2.0/gcse-revision_Linux_arm64.tar.gz"
      sha256 "72f96bb60602583ebeacb5a2cb24bb09f7c303c605348c5421a9e8c376099ee4"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  def caveats
    <<~EOS
      Start the per-user background service with:
        #{bin}/gcse-revision service install

      The service opens at http://gcse-revision.localhost:8765/ and checks for upgrades automatically.
    EOS
  end

  test do
    assert_match "0.2.0", shell_output("#{bin}/gcse-revision version")
  end
end
