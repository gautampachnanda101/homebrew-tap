# typed: false
# frozen_string_literal: true

class Vaultx < Formula
  desc "The convenience of an env file. The power of a zero-trust vault."
  homepage "https://github.com/gautampachnanda101/mypass"
  version "0.1.0-rc1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc1/vaultx_Darwin_x86_64.tar.gz"
      sha256 "f7ee801724ec69544f057395bc9a5a0b9581cfd65baa741a98ef4b30621de493"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc1/vaultx_Darwin_arm64.tar.gz"
      sha256 "fad388e7bf85f12470c287481da6891ccd5b2674f668259aa6aeea87920605e2"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc1/vaultx_Linux_x86_64.tar.gz"
        sha256 "99ec4af2c1d9f70bb1f4c008ee8bbe1662df2dff8152bdf7c2aacb8ed5f50e3d"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc1/vaultx_Linux_arm64.tar.gz"
        sha256 "9f68465566054e29c02c5a894400e35dd24e76883ee1cc7647b33418bfb55359"
      end
    end
  end

  def install
    bin.install "vaultx"
  end

  test do
    assert_match "zero-trust vault", shell_output("#{bin}/vaultx --help")
    assert_match "0.1.0-rc1", shell_output("#{bin}/vaultx version")
  end
end
