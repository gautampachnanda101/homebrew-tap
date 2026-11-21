# typed: false
# frozen_string_literal: true

class GcseRevision < Formula
  desc "Offline GCSE revision app with a built-in AI helper"
  homepage "https://github.com/gautampachnanda101/gcse-revision-assistant"
  version "0.1.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.1.0/gcse-revision_Darwin_x86_64.tar.gz"
      sha256 "f7dfc9753475aaec7ab7d71a9fd68ad75d0f08319bb83e376359779c080c27a8"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.1.0/gcse-revision_Darwin_arm64.tar.gz"
      sha256 "60f000f25d13d6a76ba6ec2715be9dffd3237e3eaf9063d628b54fb2c6bf4a50"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.1.0/gcse-revision_Linux_x86_64.tar.gz"
      sha256 "2323b59d7d1709a2d2a86ad0919facfffd6072e2e55226d6a32c9f72e8618ce4"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/gcse-revision-v0.1.0/gcse-revision_Linux_arm64.tar.gz"
      sha256 "fd912e076d1a5fb2e2db7580d7ef06f30a04638dba86978fdbcf865c7bec1e5e"
    end
  end

  def install
    bin.install "gcse-revision"
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/gcse-revision version")
  end
end
