# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.9.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.9.0/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "99deb101e4b3a2dcb60ab016e42daeb363563dd46bdc23fd98d5cb03cd7c4dd6"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.9.0/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "54ab5f915f2bed2a6c52496b6868a2483dce79b0b24b3b0c31a759b49d72717b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.9.0/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "41afd53d94e03e3a852eb1e81d367faf146f7e3f2caa48172c92ebbb85c01026"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.9.0/gcse-revision_Linux_arm64.tar.gz"
      sha256 "836226786e331ef7e073dc78ebf3fe1804eba96efc270c4cd1f61c31effc4b50"
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
    assert_match "0.9.0", shell_output("#{bin}/gcse-revision version")
  end
end
