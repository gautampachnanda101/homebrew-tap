# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.5.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.5.0/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "e6bbb89cdc22ea2b476528321027abab617d8ab5156c2fb446a4900771cddcaf"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.5.0/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "cc3432663e7122c2add157f4a186aa5a7e89ed9e2c7b742a86869691535f45a3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.5.0/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "5f2dac81977adddb818edcb58ded8dfd123f40e87cb2792d06dba708f63a74ac"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.5.0/gcse-revision_Linux_arm64.tar.gz"
      sha256 "2e8004491c588fe81bdf741ca31385cbd65b83b7ce4e35fc977f5b4c3b4a6267"
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
    assert_match "0.5.0", shell_output("#{bin}/gcse-revision version")
  end
end
