# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.7.9"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.9/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "8cbf9f5514b7558dbfb09a627f83f322f945cead358bd952ca1daaa99043680a"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.9/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "d64c7dd61872b92ec04b79587aee2c742003d77c373a2b16a78bb1345b6e6613"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.9/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "d08e9c1ed45616704f03f2c65339363863a61ca5827d4eae9a8377c74b70594c"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.9/gcse-revision_Linux_arm64.tar.gz"
      sha256 "96a0489a92b2ddb01ce9ef22aebe4658d91ee8e5b806cffe14b91d2824d09959"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  def caveats
    <<~EOS
      If the background service was not already configured, start it with:
        #{bin}/gcse-revision service install

      The service opens at http://gcse-revision.localhost:8765/ and checks for upgrades automatically.
    EOS
  end

  test do
    assert_match "0.7.9", shell_output("#{bin}/gcse-revision version")
  end
end
