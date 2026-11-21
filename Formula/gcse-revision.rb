# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.2.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.2.0/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "796aab4307f419aac179dd70f7467b079ac21219a19bdefee3938cb3d2148cfa"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.2.0/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "8aa8e64b76e0c2c91524c8a74dfe68c16cef038a24c2a1b70b72297c6d29ffa6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.2.0/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "774ab66e5f597b089b3d13713b8256c1f642ceda73d4ec737aafae0e9713b979"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.2.0/gcse-revision_Linux_arm64.tar.gz"
      sha256 "b6a77825b8cabac36ccfd22e84196d11c71b104d17252832388b2e256528e295"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  test do
    assert_match "0.2.0", shell_output("#{bin}/gcse-revision version")
  end
end
