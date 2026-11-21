# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.5.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.5.1/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "29d1f6a07908d90829640ce1501cc3695976e31ce82d1c531062de0a840f6f6c"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.5.1/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "611b2992ec109e6266f2314cf374f8562da5f2417363b88180d57acac85690fc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.5.1/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "b2f8de41854e53626b408a563a22f9ea263f7550cbe5817cf1652b0863c1730c"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.5.1/gcse-revision_Linux_arm64.tar.gz"
      sha256 "311696ee930f80bac56c9e7d4b7095a511e1247cc96774253cfe93518067789a"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  def post_install
    system "#{bin}/gcse-revision", "service", "restart" if quiet_system("#{bin}/gcse-revision", "service", "status")
  end

  def caveats
    <<~EOS
      Start the per-user background service with:
        #{bin}/gcse-revision service install

      The service opens at http://gcse-revision.localhost:8765/ and checks for upgrades automatically.
    EOS
  end

  test do
    assert_match "0.5.1", shell_output("#{bin}/gcse-revision version")
  end
end
