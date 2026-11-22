# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.9.2"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.9.2/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "64803b21eb6c38b2fe8f56dd85e5b7eee6584693dd651be8034a2b63a3c58e34"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.9.2/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "e25a7f23c21432a424eecbcd67216b592ada41ea4e51f6a239a7a5d4d01f8c03"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.9.2/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "9342023fb24bd81a02504621cef88b717ea3aad43dd314a5010cc07bdf5d968a"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.9.2/gcse-revision_Linux_arm64.tar.gz"
      sha256 "5c2b9e34847bd9c812d9aec914c8f982590ea9a35b100b5149d6e0b69c5e5cbf"
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
    assert_match "0.9.2", shell_output("#{bin}/gcse-revision version")
  end
end
