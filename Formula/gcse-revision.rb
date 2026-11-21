# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.3.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.3.0/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "5a1312b786a38307da9576ec41673a2c46cfc27af5e2ad0a4a8713811a7f1316"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.3.0/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "9f2b36813f30548382ab341d6b396c246382b9e868944e7ec7ac60d111895586"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.3.0/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "7a05b0a106a615eb5ee9937eee78bea1a84c593f45c379e155caa01a92d2464c"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.3.0/gcse-revision_Linux_arm64.tar.gz"
      sha256 "c2dc4b7dce09a00059c770b249d4d5493a28d3c3f2d877ebfe99a1c44fb70a4d"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  def caveats
    <<~EOS
      Start the per-user background service with:
        #{bin}/gcse-revision service install

      The service opens at http://gcse-revision.localhost:8765/ and checks for upgrades automatically.
    EOS
  end

  test do
    assert_match "0.3.0", shell_output("#{bin}/gcse-revision version")
  end
end
