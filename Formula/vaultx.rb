# typed: false
# frozen_string_literal: true

class Vaultx < Formula
  desc "The convenience of an env file. The power of a zero-trust vault."
  homepage "https://github.com/gautampachnanda101/mypass"
  version "0.1.0-rc3"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc3/vaultx_Darwin_x86_64.tar.gz"
      sha256 "82693db8e0fea3de01ee3dc7c2b388179ec343a6ae88224bf167b655b3dce0ee"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc3/vaultx_Darwin_arm64.tar.gz"
      sha256 "6601f269d9182234dfeb3213e0c2f556e0fe5d0c34f14a710bf1693d6ab119e3"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc3/vaultx_Linux_x86_64.tar.gz"
        sha256 "e63a92c84295e8c53c1a9417634359f05a9fcb53f6f6e4a1377a5617cd6cd935"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc3/vaultx_Linux_arm64.tar.gz"
        sha256 "9c8253653d2ecf438243988a7ed0e3b8759b161d9c29abaf7be530a1d4f88458"
      end
    end
  end

  def install
    bin.install "vaultx"
  end

  test do
    assert_match "zero-trust vault", shell_output("#{bin}/vaultx --help")
    assert_match "0.1.0-rc3", shell_output("#{bin}/vaultx version")
  end
end
