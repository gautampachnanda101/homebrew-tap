# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.6.2"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.6.2/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "6268b8b89e02205b9cb3de5364b7c37c297af828b7cb8106e5f94a04aa5f82fd"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.6.2/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "3d1cef347fef083e87f9102c46bedd1ec14120e34874c3dd7d738f12ed60e488"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.6.2/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "86aa455c980c7b3f159ad4e6a06973a69c52c1960e40a68f1c7b0e4f9958a691"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.6.2/gcse-revision_Linux_arm64.tar.gz"
      sha256 "84de70e8795c8eb1ad25e7c82eaf334ca44d59fe257642a9e204181146e3357a"
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
    assert_match "0.6.2", shell_output("#{bin}/gcse-revision version")
  end
end
