# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.2.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.2.1/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "581ea86e4cf924f50709e5b5290a157db5970414f8e9a64b9e71a3b1d5e76b5f"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.2.1/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "1864d783a3d25a55c8b809a2ec20c378ce0b72d234382e9674bc62502f1fa491"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.2.1/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "d54395bc1139efeb1498490e9e6c567174e29422d81e3c93c9a67e622ecfb142"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.2.1/gcse-revision_Linux_arm64.tar.gz"
      sha256 "64f66bfed05b6124c367cd570e8c715411a13c29ac2377c81184eb5bbe6d4c96"
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
    assert_match "0.2.1", shell_output("#{bin}/gcse-revision version")
  end
end
