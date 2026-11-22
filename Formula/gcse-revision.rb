# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.7.16"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.16/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "eeea3536367293f4be6998c8f55be5ac29dc569da05ade9e35bba85324c59e5e"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.16/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "c8ef8930e6d4f0c7460e45700180f5a4d43a1543e223a3679443917f4eb34b56"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.16/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "69f66b9e3d580ebbc5e605ee6c72800e43473138f506d3b59f640f3f6d16e6b0"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.16/gcse-revision_Linux_arm64.tar.gz"
      sha256 "d84af983a976a36e04b814907c5c68db645704fc0e48a8f1adb222985d2f3516"
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
    assert_match "0.7.16", shell_output("#{bin}/gcse-revision version")
  end
end
