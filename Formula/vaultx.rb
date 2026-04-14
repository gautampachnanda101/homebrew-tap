# typed: false
# frozen_string_literal: true

class Vaultx < Formula
  desc "The convenience of an env file. The power of a zero-trust vault."
  homepage "https://github.com/gautampachnanda101/mypass"
  version "0.1.0-rc2"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc2/vaultx_Darwin_x86_64.tar.gz"
      sha256 "c371f3b22d0227b47339e434f0d081fb094d5211b4e86a58c52edf3f6fec6755"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc2/vaultx_Darwin_arm64.tar.gz"
      sha256 "16a6e495b07494e81cf7fb96eef75b9fe119896edcd588ca0743ccf1c13a091a"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc2/vaultx_Linux_x86_64.tar.gz"
        sha256 "63c72dee4d2fc6494bb4fc5a8edfd0f1a67daa81665c9031d739b6c8333c62ad"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc2/vaultx_Linux_arm64.tar.gz"
        sha256 "5c83cbe3a6d6adcf44d672120233cfb4013f02888b40f0664f37f29b08a5ec7a"
      end
    end
  end

  def install
    bin.install "vaultx"
  end

  test do
    assert_match "zero-trust vault", shell_output("#{bin}/vaultx --help")
    assert_match "0.1.0-rc2", shell_output("#{bin}/vaultx version")
  end
end
