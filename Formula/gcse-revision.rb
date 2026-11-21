# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.6.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.6.0/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "25a45aee67222e44212bace902309c767e0ec9709023c5d2407a6216c1a31f58"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.6.0/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "0b1a9d8317077e420cebc1c6d0b8554ddf1456e65b39f2c5093b9bbe1d63352c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.6.0/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "0f7761ca93b509f8a6520ec575740b27d2d5cd9c612498833cdc6bdeb7f40b0a"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.6.0/gcse-revision_Linux_arm64.tar.gz"
      sha256 "2814d54b0616c81da659d47414ea3c83ac52153d72240c04196d0705f5ca2a3a"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  def post_install
    system "#{bin}/gcse-revision", "service", "install"
  end

  def caveats
    <<~EOS
      Start the per-user background service with:
        #{bin}/gcse-revision service install

      The service opens at http://gcse-revision.localhost:8765/ and checks for upgrades automatically.
    EOS
  end

  test do
    assert_match "0.6.0", shell_output("#{bin}/gcse-revision version")
  end
end
