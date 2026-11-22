# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.7.14"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.14/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "13986a16dcdd6b256fba345a455450280de879bd73eb8e084f2e01284f0031cf"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.14/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "4885a0e928ae8984676e2391a190aac3fcdb1bc3ce79733a9fbdee4d720936b3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.14/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "6aa42aaa58ae979e21710c7d615aa032634eb8dab2bd11a27cef75eee194732c"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.14/gcse-revision_Linux_arm64.tar.gz"
      sha256 "68fb9ef4d6869d8c906dcf6593c66ba12ef253faf9e877ae8e1e340d0a764afc"
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
    assert_match "0.7.14", shell_output("#{bin}/gcse-revision version")
  end
end
