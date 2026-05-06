# typed: false
# frozen_string_literal: true

class Vaultx < Formula
  desc "The convenience of an env file. The power of a zero-trust vault."
  homepage "https://github.com/gautampachnanda101/mypass"
  version "0.2.2"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.2.2/vaultx_Darwin_x86_64.tar.gz"
      sha256 "2928578472aed04f6a77107300adf9f85d9fb77b685a1c064d1ed21e5ed88797"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.2.2/vaultx_Darwin_arm64.tar.gz"
      sha256 "913cbc86988d4b40f02c52f4895435ed120da9a8f0e956eb16c31bb72931fb6f"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.2.2/vaultx_Linux_x86_64.tar.gz"
        sha256 "dd8c0b4d3edd5d36029f1eb0b81cbcb60ca3f8c57552b559dbf4e7bd4d9efb38"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.2.2/vaultx_Linux_arm64.tar.gz"
        sha256 "541f7de766bed831ba31f2fe925121f3dc645d8b7f7a104bf0b9e4709d1a844d"
      end
    end
  end

  def install
    bin.install "vaultx"
    pkgshare.install "VAULTX_USER_GUIDE.md"
  end

  test do
    assert_match "zero-trust vault", shell_output("#{bin}/vaultx --help")
    assert_match "0.2.2", shell_output("#{bin}/vaultx version")
  end
end
