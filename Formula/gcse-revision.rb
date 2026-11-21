# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.7.4"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.4/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "56f91ceabc99b8c10a0cb5dc02ac6a46ce1ca745f8c4a13f9749e0a8fa32568c"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.4/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "3025f3ce818014d0d088c646f00288e96752866770d9b9932541b8df4fb7eef2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.4/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "a6efe78d2dbf3aa53bd720ea4da80c4baec159bf73df4f9e9314bde87401f76b"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.4/gcse-revision_Linux_arm64.tar.gz"
      sha256 "7d41932a1223a9702efb56c9ceefae5f3b21af7151f1e6c44791fedee7dcbc98"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  post_install_steps do
    run "bin/gcse-revision",
        base: :prefix,
        args: ["service", "ensure"],
        writable_paths: ["Library/LaunchAgents", ".config/systemd/user"],
        writable_base: :home
  end

  def caveats
    <<~EOS
      If the background service was not already configured, start it with:
        #{bin}/gcse-revision service install

      The service opens at http://gcse-revision.localhost:8765/ and checks for upgrades automatically.
    EOS
  end

  test do
    assert_match "0.7.4", shell_output("#{bin}/gcse-revision version")
  end
end
