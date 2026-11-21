# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.7.2"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.2/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "11ad78199912d89c6c1ba0aeeaad8f9d1bd603d876d1231164217834f3aefad1"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.2/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "c15d63ab9d7be9b0cd2a4223b20486827110127d5900ae296fd028ee1ec377b3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.2/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "f4e0b9b9ea724319ac25c0bee7baf5d89ddc780bc9f1001440b38a34d6297e04"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.2/gcse-revision_Linux_arm64.tar.gz"
      sha256 "b8f3bd3aa0baa8f7d7eaae8af4a1fc400e2d5bdd1024c8b537b290c2cc3a1aca"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  post_install_steps do
    on_macos do
      if_path_exists "Library/LaunchAgents/com.gautampachnanda101.gcse-revision.plist", base: :home do
        run "bin/gcse-revision",
            base: :prefix,
            args: ["service", "install"],
            writable_paths: ["Library/LaunchAgents"],
            writable_base: :home
      end
    end
  end

  def caveats
    <<~EOS
      If the background service was not already configured, start it with:
        #{bin}/gcse-revision service install

      The service opens at http://gcse-revision.localhost:8765/ and checks for upgrades automatically.
    EOS
  end

  test do
    assert_match "0.7.2", shell_output("#{bin}/gcse-revision version")
  end
end
