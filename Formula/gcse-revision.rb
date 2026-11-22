# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.8.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.8.0/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "deb809b34df47baa9ec89621a9b41fc3951616f14ba5a0e2b210e3cf0bf01693"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.8.0/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "f920b05df31fcf977000fefc5bfcff9e4d4bbed5185f252bcd85312b24c27094"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.8.0/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "9f29d413b5234a9196284b000f28480a0933a79b9d756478527d36e43e24d540"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.8.0/gcse-revision_Linux_arm64.tar.gz"
      sha256 "02fe7880a9e7ddc4b25d2a5d3744b93be28fa75fa069a5557b1b0bd350241394"
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
    assert_match "0.8.0", shell_output("#{bin}/gcse-revision version")
  end
end
