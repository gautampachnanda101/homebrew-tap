# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.7.12"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.12/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "41f6048a9b8a3de623b711c355bcfe34ba607ebbfb95439207e54715c2e519d6"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.12/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "dd80e8d5931b614359df4e1446b3a346a64a403b31db87e0b56020aee12cfb47"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.12/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "5ceb0c748a82ac752262f5e88bf314cd8f6e3e01d7f97dd0139f34a4d03aecf0"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.7.12/gcse-revision_Linux_arm64.tar.gz"
      sha256 "35ddf836651fcfc9cc3ef2a625867f610f9bf43a7143513e4282b9a38b6ad34e"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  service do
    run [opt_bin/"gcse-revision", "serve", "--service", "--no-browser", "--no-ai", "--port", "8765"]
    keep_alive true
    log_path var/"log/gcse-revision.log"
    error_log_path var/"log/gcse-revision.log"
    working_dir Dir.home
  end

  def caveats
    <<~EOS
      Start the background service with:
        brew services start gautampachnanda101/tap/gcse-revision

      Homebrew owns the service lifecycle and restarts it after upgrades.
      The service opens at http://gcse-revision.localhost:8765/.
    EOS
  end

  test do
    assert_match "0.7.12", shell_output("#{bin}/gcse-revision version")
  end
end
