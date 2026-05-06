# typed: false
# frozen_string_literal: true

class Vaultx < Formula
  desc "The convenience of an env file. The power of a zero-trust vault."
  homepage "https://github.com/gautampachnanda101/mypass"
  version "0.2.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.2.1/vaultx_Darwin_x86_64.tar.gz"
      sha256 "2e698ada2a745b0978941b1fea951e6ec50d845cfe9afc10daa41e8ff1f4c4a1"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.2.1/vaultx_Darwin_arm64.tar.gz"
      sha256 "5faead23a6914252adfc4fd569f4f24df7c50e2d408cf5b1ee2ec26309cc16ef"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.2.1/vaultx_Linux_x86_64.tar.gz"
        sha256 "5afd772f173ccd2936657faf078b7e17bffdb39a00856d0d1f76188692830f6d"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.2.1/vaultx_Linux_arm64.tar.gz"
        sha256 "3c5b69337c7fd2b7782b21182207d471db9f30d15a1776d3e7d9165eed65431b"
      end
    end
  end

  def install
    bin.install "vaultx"
    pkgshare.install "VAULTX_USER_GUIDE.md"
  end

  test do
    assert_match "zero-trust vault", shell_output("#{bin}/vaultx --help")
    assert_match "0.2.1", shell_output("#{bin}/vaultx version")
  end
end
