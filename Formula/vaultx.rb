# typed: false
# frozen_string_literal: true

class Vaultx < Formula
  desc "The convenience of an env file. The power of a zero-trust vault."
  homepage "https://github.com/gautampachnanda101/mypass"
  version "0.3.3"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.3/vaultx_Darwin_x86_64.tar.gz"
      sha256 "3d1476c5e1ad9e86331ac51e970b56235f5ae817fca3d33dcac0ef867c88766a"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.3/vaultx_Darwin_arm64.tar.gz"
      sha256 "d937e9c87a1fdd7cbae434eca6d760d04c83c17c91c43bbcbf0c6347da6e9d71"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.3/vaultx_Linux_x86_64.tar.gz"
        sha256 "49f5c8c83796a371bdbf46121a00f6c232de189e2eb6430f27c074d9a21b7587"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.3/vaultx_Linux_arm64.tar.gz"
        sha256 "4cd3c667361b7f7212ee4d42c5040dd8f06cc8a907a2eab69a295a0d363561d8"
      end
    end
  end

  def install
    bin.install "vaultx"
    pkgshare.install "VAULTX_USER_GUIDE.md"
  end

  test do
    assert_match "zero-trust vault", shell_output("#{bin}/vaultx --help")
    assert_match "0.3.3", shell_output("#{bin}/vaultx version")
  end
end
