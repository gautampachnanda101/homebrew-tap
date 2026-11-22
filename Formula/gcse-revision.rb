# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.7.11"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.11/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "c6afc956aaa1e164d749d79027e05174d40730bf2297f735b175cbdd4629298c"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.11/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "a71fe9e2dbf79fa8c122ae2699c86cc028dbc4dae5b887a860da911ab78f2d10"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.11/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "5dba0319ad5a11beaa72b482cb5b0c02913f9e2620df6b15d55eac961c39f820"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.11/gcse-revision_Linux_arm64.tar.gz"
      sha256 "6cfe020048ddfe887da25f7e11c6a21ce5eb62f9ac248091964ec1da08a678dc"
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
    assert_match "0.7.11", shell_output("#{bin}/gcse-revision version")
  end
end
