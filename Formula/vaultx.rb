# typed: false
# frozen_string_literal: true

class Vaultx < Formula
  desc "The convenience of an env file. The power of a zero-trust vault."
  homepage "https://github.com/gautampachnanda101/mypass"
  version "0.1.0-rc5"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc5/vaultx_Darwin_x86_64.tar.gz"
      sha256 "afab29106227dcae83d8cc99dc592562e5e4589cbca278d36db8e48bb3aec925"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc5/vaultx_Darwin_arm64.tar.gz"
      sha256 "f2af5a7cbf0ddb0b49aee5c570f56e0e050f23e93b5507aa3602dc124fd22271"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc5/vaultx_Linux_x86_64.tar.gz"
        sha256 "4aba20999124449919a93615ff1cc49d172e4cede6b8e10c247817fb474352c8"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc5/vaultx_Linux_arm64.tar.gz"
        sha256 "23ecb2289818088a7b0c7e8d89a4ae2c15714088de696734e5c81da8c38e2787"
      end
    end
  end

  def install
    bin.install "vaultx"
  end

  test do
    assert_match "zero-trust vault", shell_output("#{bin}/vaultx --help")
    assert_match "0.1.0-rc5", shell_output("#{bin}/vaultx version")
  end
end
