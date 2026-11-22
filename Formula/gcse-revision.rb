# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.7.15"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.15/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "2d16cf1caf869dfa74eade8d1b91643972982670824c197a7381c390e932827d"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.15/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "1e220bbaeb0076708995567aa865139cf4ac1105eba10c7a1e805ac5eed615c4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.15/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "0cf370975e4abba6be6cd583281907d96cbea4332ea8f06acd114fefe04185da"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.15/gcse-revision_Linux_arm64.tar.gz"
      sha256 "5bea438ee2ebd73d0784f6604e4bb1015be1824431cdba52c44b5b97757ff70e"
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
    assert_match "0.7.15", shell_output("#{bin}/gcse-revision version")
  end
end
