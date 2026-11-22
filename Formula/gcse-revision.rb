# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.7.13"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.13/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "f1521b72794e20434ffd17ec0c180c25f61354b19cea08cb6b9ee61fff15e0e1"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.13/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "8491b2e7e9c000b4677f5a04b2369c90653f504ac9739619821467a124bb180f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.13/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "0313f14adbf0c7a37303ef28cdae6306b9523d28725d695f8ddaaed05be6266c"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.13/gcse-revision_Linux_arm64.tar.gz"
      sha256 "f96a005fdc3781ed18bd58ff4e1d2548def29349d50088e6d178e10ae2615cbe"
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
    assert_match "0.7.13", shell_output("#{bin}/gcse-revision version")
  end
end
