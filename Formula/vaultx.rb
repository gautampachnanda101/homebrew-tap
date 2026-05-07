# typed: false
# frozen_string_literal: true

class Vaultx < Formula
  desc "The convenience of an env file. The power of a zero-trust vault."
  homepage "https://github.com/gautampachnanda101/mypass"
  version "0.3.1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.1/vaultx_Darwin_x86_64.tar.gz"
      sha256 "dd25473f7c09f8a6a3f0be17167d9300714297fac0a737db50398dbdb0aec0bf"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.1/vaultx_Darwin_arm64.tar.gz"
      sha256 "4d9a9e12924202363bcd4e0669065701a7933528b7a595abc6a605290cdf7f51"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.1/vaultx_Linux_x86_64.tar.gz"
        sha256 "d6471ddb82e8d377934b5bf77cc22eb5da1223561b4d74fb4d2fff209445045c"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.1/vaultx_Linux_arm64.tar.gz"
        sha256 "474ebf322f879abeb37abd3b3b6d8f6a81715160ccf76ba548e444e022672a1a"
      end
    end
  end

  def install
    bin.install "vaultx"
    pkgshare.install "VAULTX_USER_GUIDE.md"
  end

  test do
    assert_match "zero-trust vault", shell_output("#{bin}/vaultx --help")
    assert_match "0.3.1", shell_output("#{bin}/vaultx version")
  end
end
