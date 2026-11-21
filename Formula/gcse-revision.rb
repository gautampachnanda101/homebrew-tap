# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.1.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.1.0/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "0a8eb5423a58d8db342b5b76f2c8ffec29c7c37806f3d91644fe6edf1c1cd548"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.1.0/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "6833f3fcfd7f69561bca5da3396a8da9683cf0e270ba80ad4024be3d470697eb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.1.0/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "09621ea6be9b40a05f83831b15add2a27e81f325bfb2c4aec087c9c4bf804e6e"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.1.0/gcse-revision_Linux_arm64.tar.gz"
      sha256 "391d102c132ade4caed16af2c7a840ea937d6ed03ae8b875be4b66c5644efa13"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/gcse-revision version")
  end
end
