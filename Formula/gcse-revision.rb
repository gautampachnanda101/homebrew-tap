# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.5.3"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.5.3/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "b4dc24ef5e7b142104895fcc4c157ef18d410b3835e8de59818d7838fec60393"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.5.3/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "c68adad9615e84b9b8ee58dff34d4d705b246046abed2ca67e8406f7abeed203"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.5.3/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "95196779b8d788fdfaba0a852aec348cc18d25aff2d08eec267fcf6be2c3875c"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.5.3/gcse-revision_Linux_arm64.tar.gz"
      sha256 "582fb031e9508a86e8c730c9c3b553ce19851e17a1bebb75927e3d142907d933"
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
    assert_match "0.5.3", shell_output("#{bin}/gcse-revision version")
  end
end
