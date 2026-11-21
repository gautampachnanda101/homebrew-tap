# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.7.10"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.10/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "d1a95c807862c6aed8b225fb0bed953f62fc047d5cf11751f67ac4c4db37656c"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.10/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "23e46f51afcc6276572344f811638235f80713d86b52f35570b50af2121791e6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.10/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "296ef9d566bcc12ef703915b62d8970021dc8fe31f7f3b7d54f75c34f2a1bca0"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.10/gcse-revision_Linux_arm64.tar.gz"
      sha256 "49a93c9895bcf1bed7e80b308e2b654ec95dd923c9944557d7b3c83bdc2d5fa2"
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
    assert_match "0.7.10", shell_output("#{bin}/gcse-revision version")
  end
end
