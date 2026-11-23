# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.10.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.10.0/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "13734ec5a2db5ca75c30b3364868ff2f9d6f1d5d00617fc04db274e6530055cb"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.10.0/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "4b54804071371345155b001ccff13fc91cbb07eba13d46d12dcfd2d8d1f20f58"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.10.0/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "2c06215d2f3a8ebaae43c8afcec12def4bfbdfa686c69ba6c27da53486f68fff"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.10.0/gcse-revision_Linux_arm64.tar.gz"
      sha256 "59c17b672c38e84feb1a3a96fb57661b16e742c7e471202c516b3e658241c9d8"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  service do
    run [opt_bin/"gcse-revision", "serve", "--service", "--no-browser", "--no-ai", "--port", "8765"]
    keep_alive true
    log_path var/"log/gcse-revision.log"
    error_log_path var/"log/gcse-revision.log"
    working_dir Dir.home
  end

  def caveats
    <<~EOS
      Start the background service with:
        brew services start gautampachnanda101/tap/gcse-revision

      Homebrew owns the service lifecycle and restarts it after upgrades.
      The service opens at http://gcse-revision.localhost:8765/.
    EOS
  end

  test do
    assert_match "0.10.0", shell_output("#{bin}/gcse-revision version")
  end
end
