# typed: false
# frozen_string_literal: true

class Vaultx < Formula
  desc "The convenience of an env file. The power of a zero-trust vault."
  homepage "https://github.com/gautampachnanda101/mypass"
  version "0.1.0-rc4"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc4/vaultx_Darwin_x86_64.tar.gz"
      sha256 "a292a2819dc0281b64416ffe6ee3ba2321dd229ce6e085323ca6cd58556413c1"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc4/vaultx_Darwin_arm64.tar.gz"
      sha256 "eba32f52ad74a085a01e23fbf30934b0eef33ec21e25655f00c1d55fd67e6401"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc4/vaultx_Linux_x86_64.tar.gz"
        sha256 "833a8e06f56a994f736166c8aa7917ce36e6b1b980fc6b9eccdac506bfe5e6a5"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc4/vaultx_Linux_arm64.tar.gz"
        sha256 "5f792541580f58b4367f39e94ca2ed98b415ab24985149ef3f6964aa78ac2bd4"
      end
    end
  end

  def install
    bin.install "vaultx"
  end

  test do
    assert_match "zero-trust vault", shell_output("#{bin}/vaultx --help")
    assert_match "0.1.0-rc4", shell_output("#{bin}/vaultx version")
  end
end
