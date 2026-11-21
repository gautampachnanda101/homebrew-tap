# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.7.3"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.3/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "8f340030c2d42239792a61a9ac672ed4cba286ab4248aabad988fb32ab1e5816"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.3/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "70f2e257090d7d9e68ac7b313a6b0b071a4301686d5f06e8ba55103a2f75d49b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.3/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "182edab39d639408e865c082931e38f654e6568dde0a92eddefb2e854d9ad814"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.3/gcse-revision_Linux_arm64.tar.gz"
      sha256 "390b73856c69c00c060932f36b584980e8fbd74d96340d44e67404093a190ece"
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
    assert_match "0.7.3", shell_output("#{bin}/gcse-revision version")
  end
end
