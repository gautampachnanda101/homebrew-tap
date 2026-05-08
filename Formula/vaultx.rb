# typed: false
# frozen_string_literal: true

class Vaultx < Formula
  desc "The convenience of an env file. The power of a zero-trust vault."
  homepage "https://github.com/gautampachnanda101/mypass"
  version "0.3.2"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.2/vaultx_Darwin_x86_64.tar.gz"
      sha256 "b835bbadf6389277697d6b328ebc78fb75d08eea5fdf82f892bda24ff87cd295"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.2/vaultx_Darwin_arm64.tar.gz"
      sha256 "77678927b7766a0b7cc062c2cd1e79f89edc932ae9aff9c56fd247b1e18185c6"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.2/vaultx_Linux_x86_64.tar.gz"
        sha256 "969250543aea5b5cb567f365816d0c957e7c16d9b18ed709e302647c792e5223"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.3.2/vaultx_Linux_arm64.tar.gz"
        sha256 "0a4d91be57ad9e8d869719f521144985a2a411ac61d40ea9ec7fcbf3b71b67cd"
      end
    end
  end

  def install
    bin.install "vaultx"
    pkgshare.install "VAULTX_USER_GUIDE.md"
  end

  test do
    assert_match "zero-trust vault", shell_output("#{bin}/vaultx --help")
    assert_match "0.3.2", shell_output("#{bin}/vaultx version")
  end
end
