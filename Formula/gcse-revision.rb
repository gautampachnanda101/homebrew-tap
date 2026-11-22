# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.9.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.9.1/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "a88154ac85357fdcf91aef788984da422d0a8fda3e1b43ca714399c22370309a"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.9.1/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "95fd1d61d41d1eb5f31d73fefece107e933470ae401a543e391584fdbf860310"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.9.1/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "0853adb3b1702c38372d8f0b29288d1f8ff398038bff1fed4cc024bc4f06c79c"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.9.1/gcse-revision_Linux_arm64.tar.gz"
      sha256 "856cc0d1a9b0bee43ff1ccc61a6093d907acba2b8170ef9421b595e36a943328"
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
    assert_match "0.9.1", shell_output("#{bin}/gcse-revision version")
  end
end
