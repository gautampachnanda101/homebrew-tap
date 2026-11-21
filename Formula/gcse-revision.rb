# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.4.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.4.0/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "3c5d8bf2748484a12ef2d4b15c9248663d64b82ff84fbfb951f51964e9c1f378"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.4.0/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "41b64e8efae3f2faa39b7d92f1328aecbe1d62802b147915371e4fc98ff4d06b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.4.0/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "b4646f9bbf52c9b0f4b1bb3162722d36b786cf4664f1534b33b515a37e85ee23"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.4.0/gcse-revision_Linux_arm64.tar.gz"
      sha256 "bf05d3703abfbc17a671ca8e4ef32ff7ba194272850dadb67bb4909151319622"
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
    assert_match "0.4.0", shell_output("#{bin}/gcse-revision version")
  end
end
