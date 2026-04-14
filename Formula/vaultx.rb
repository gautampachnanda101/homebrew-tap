# typed: false
# frozen_string_literal: true

class Vaultx < Formula
  desc "The convenience of an env file. The power of a zero-trust vault."
  homepage "https://github.com/gautampachnanda101/mypass"
  version "0.1.0-rc1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc1/vaultx_Darwin_x86_64.tar.gz"
      sha256 "ee1798e7bae6b77c61177004f99c0e9fa575c2d29894fcbd728ca0ae82a3489c"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc1/vaultx_Darwin_arm64.tar.gz"
      sha256 "0e074dd5b63c158332e67c89e09daa2c3e91e7a692df7a855815fc7d24987fa1"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc1/vaultx_Linux_x86_64.tar.gz"
        sha256 "50196dca297c59eca92415bc2456f891ca673174b2d0286b42f20d38805f788a"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc1/vaultx_Linux_arm64.tar.gz"
        sha256 "92b7f135b1529cab9b6c35834d3a7d9135824dab39c39d5f7e9fb0e462b99853"
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
