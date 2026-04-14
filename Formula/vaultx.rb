# typed: false
# frozen_string_literal: true

class Vaultx < Formula
  desc "The convenience of an env file. The power of a zero-trust vault."
  homepage "https://github.com/gautampachnanda101/mypass"
  version "0.1.0-rc8"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc8/vaultx_Darwin_x86_64.tar.gz"
      sha256 "417f8c8f655e60b1c8765d571bd762e6054aada54948250d91344b54ea438ddd"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc8/vaultx_Darwin_arm64.tar.gz"
      sha256 "c76a91aa35a5e681b48ce1954651a4529871e8bd2019d750b489d9c17ad4031e"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc8/vaultx_Linux_x86_64.tar.gz"
        sha256 "fa2f33cc9ebe4801c944915b482086887ff4e1cc975b545a28750a4c33fe720f"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc8/vaultx_Linux_arm64.tar.gz"
        sha256 "97e62c1e015ab968e8036f13b00a3ff33514d640e25864f1377cfaabbff5c74e"
      end
    end
  end

  def install
    bin.install "vaultx"
  end

  test do
    assert_match "zero-trust vault", shell_output("#{bin}/vaultx --help")
    assert_match "0.1.0-rc8", shell_output("#{bin}/vaultx version")
  end
end
