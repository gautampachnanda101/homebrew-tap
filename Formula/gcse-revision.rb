# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.3.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.3.1/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "99c1e40384952c9ba3c77a16b75ea70507d207b7e072a75163fd2432be3c288c"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.3.1/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "7574fbd040c952b317f702f3b1b6e5d2a41cc61d48223e1731be4ed2c7d5f614"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.3.1/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "3df4bbc2f6daaf77cff0228e9852e21235cf93418303e33008bc83f94542fd04"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.3.1/gcse-revision_Linux_arm64.tar.gz"
      sha256 "563e3944cca760cfa67f2a7e7dbf0ef8dd0245aed4f55416cb02aca920ef88c0"
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
    assert_match "0.3.1", shell_output("#{bin}/gcse-revision version")
  end
end
