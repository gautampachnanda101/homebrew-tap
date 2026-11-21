# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.7.8"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.8/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "fb519ac273607ba0e9f3121d055e7f421e058124d1c5275046247738783ea6ee"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.8/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "d578cacc2867d1bec774692505930635113a6cf13a11af117805a4e2afcb48cd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.8/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "951010282267fa405b3a07f1c8ba405a24e8e9e63ed3859eb6415a7d27b2dd44"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.8/gcse-revision_Linux_arm64.tar.gz"
      sha256 "882e3d9cdf68103170252b5a5005a4cf98415e0884478c3735a91ef575420246"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  post_install_steps do
    run "bin/gcse-revision",
        base: :prefix,
        args: ["service", "ensure"],
        writable_paths: ["Library/LaunchAgents", ".config/systemd/user"],
        writable_base: :home
  end

  def caveats
    <<~EOS
      If the background service was not already configured, start it with:
        #{bin}/gcse-revision service install

      The service opens at http://gcse-revision.localhost:8765/ and checks for upgrades automatically.
    EOS
  end

  test do
    assert_match "0.7.8", shell_output("#{bin}/gcse-revision version")
  end
end
