# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.4.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.4.1/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "6e6701a7f74995d6a41cba306c54f8daf120206f471b731dc131476708549b05"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.4.1/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "7106916f336d63954e1f70f1aab297604808219babf5299af3aa3866eaa8c52d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.4.1/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "8f6e3d2e323a6dd91b11f717d56e8aa5f123639337d8d81b8ca3c2d20238519f"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.4.1/gcse-revision_Linux_arm64.tar.gz"
      sha256 "769e25faf45861efb11f37a8de857a4367e631400c0de319fc43f89606c7fe2c"
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
    assert_match "0.4.1", shell_output("#{bin}/gcse-revision version")
  end
end
