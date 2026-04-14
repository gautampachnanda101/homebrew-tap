# typed: false
# frozen_string_literal: true

class Vaultx < Formula
  desc "The convenience of an env file. The power of a zero-trust vault."
  homepage "https://github.com/gautampachnanda101/mypass"
  version "0.1.0-rc1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc1/vaultx_Darwin_x86_64.tar.gz"
      sha256 "760ba141561a9488c4f5458b288e687114dcbe1980e691cf613dbeba153c51ea"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc1/vaultx_Darwin_arm64.tar.gz"
      sha256 "7712b7dd829c177212912935e6da1aee694fba56e8adbb4509d37448236efd0e"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc1/vaultx_Linux_x86_64.tar.gz"
        sha256 "35a4ea68bc2468c5c149655a7ec87f6521bead874bebb20c544a94905578964d"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc1/vaultx_Linux_arm64.tar.gz"
        sha256 "a13b6f1dee1a827f6e7a10092b46cb2333532ad89935408483f6d6e3557e836f"
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
