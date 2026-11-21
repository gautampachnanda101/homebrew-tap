# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.5.2"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.5.2/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "af76ea0a8c3261d8c2588d5984cf174464e499576fa4afc141387bc8f4c01a7e"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.5.2/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "3325014229b1aaad1bd51a57f6cba864ff4b20d245dc92cbd45f4ae4f23d00ee"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.5.2/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "72e7ffc127026b1eebe5c66dbe4d21488cdf7d6d740af0f4952dc75a8a368e48"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.5.2/gcse-revision_Linux_arm64.tar.gz"
      sha256 "673a2cb1f551237a029c7492b053e27d2f1507356cd0772087695f16ea98ad68"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  def post_install
    if quiet_system("#{bin}/gcse-revision", "service", "status")
      system "#{bin}/gcse-revision", "service", "restart"
    else
      system "#{bin}/gcse-revision", "service", "install"
    end
  end

  def caveats
    <<~EOS
      Start the per-user background service with:
        #{bin}/gcse-revision service install

      The service opens at http://gcse-revision.localhost:8765/ and checks for upgrades automatically.
    EOS
  end

  test do
    assert_match "0.5.2", shell_output("#{bin}/gcse-revision version")
  end
end
