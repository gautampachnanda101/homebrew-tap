# typed: false
# frozen_string_literal: true

class Vaultx < Formula
  desc "The convenience of an env file. The power of a zero-trust vault."
  homepage "https://github.com/gautampachnanda101/mypass"
  version "0.2.0"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.2.0/vaultx_Darwin_x86_64.tar.gz"
      sha256 "793373f27b95755640f68087f536ec1af7f3199780aedbc1755c44be73e7c014"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.2.0/vaultx_Darwin_arm64.tar.gz"
      sha256 "024e5c22b8c5677252a75c8d0dcdca67fd6948238f472c04821ce0eb763b8fa9"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.2.0/vaultx_Linux_x86_64.tar.gz"
        sha256 "309f31f35cea1016aad555448bca452c5db59a528ce7f9d907bd0ae115b9861a"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.2.0/vaultx_Linux_arm64.tar.gz"
        sha256 "c2f359ae17d21e0f0034d294ebc6f5123e67f83d6ab61d0678130e535dcf3c19"
      end
    end
  end

  def install
    bin.install "vaultx"
    pkgshare.install "VAULTX_USER_GUIDE.md"
  end

  test do
    assert_match "zero-trust vault", shell_output("#{bin}/vaultx --help")
    assert_match "0.2.0", shell_output("#{bin}/vaultx version")
  end
end
