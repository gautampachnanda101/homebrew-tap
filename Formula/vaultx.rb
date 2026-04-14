# typed: false
# frozen_string_literal: true

class Vaultx < Formula
  desc "The convenience of an env file. The power of a zero-trust vault."
  homepage "https://github.com/gautampachnanda101/mypass"
  version "0.1.0-rc6"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc6/vaultx_Darwin_x86_64.tar.gz"
      sha256 "1904e2540e7095f2db6db60c83319a99564c5c06f1a2254783adc30f7819292c"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc6/vaultx_Darwin_arm64.tar.gz"
      sha256 "f6f2299aae762ae3d1e1eeac7594fd2896bb72f38f841beb6f5c9d10d4f330e8"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc6/vaultx_Linux_x86_64.tar.gz"
        sha256 "e02d7d5f9ca6ca5c661a9c64690e142e9f431de159d2ef7ad94c479103c91bc9"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc6/vaultx_Linux_arm64.tar.gz"
        sha256 "761dec727a9450e91cebd92da4b39ca2b53decbfca73c3d05e58db27bd158ed1"
      end
    end
  end

  def install
    bin.install "vaultx"
  end

  test do
    assert_match "zero-trust vault", shell_output("#{bin}/vaultx --help")
    assert_match "0.1.0-rc6", shell_output("#{bin}/vaultx version")
  end
end
