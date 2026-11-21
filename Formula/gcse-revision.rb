# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.7.7"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.7/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "d74833d6b3be4f4c338808320ddc4b4de1a7d739ebf17452b5be33dbd5d16ec8"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.7/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "48d2cc8582af56d8ca25985430fa568e3a46a45ab10acf962904dc9fc2ae66c5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.7/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "7a1c82d9b0502f6c924811a78615fe37a424e0f5ea7f3815e8d804aee76cf77f"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.7/gcse-revision_Linux_arm64.tar.gz"
      sha256 "99c3aeb09d50e6441c198a9999b67b81aa30c901765a8d7ca2fcd297a5614285"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  def post_install
    # One-time bridge for older running services; current versions also self-reconcile.
    system "#{bin}/gcse-revision", "service", "ensure"
  end

  def caveats
    <<~EOS
      If the background service was not already configured, start it with:
        #{bin}/gcse-revision service install

      The service opens at http://gcse-revision.localhost:8765/ and checks for upgrades automatically.
    EOS
  end

  test do
    assert_match "0.7.7", shell_output("#{bin}/gcse-revision version")
  end
end
