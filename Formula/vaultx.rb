# typed: false
# frozen_string_literal: true

class Vaultx < Formula
  desc "The convenience of an env file. The power of a zero-trust vault."
  homepage "https://github.com/gautampachnanda101/mypass"
  version "0.1.0-rc9"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc9/vaultx_Darwin_x86_64.tar.gz"
      sha256 "a16c0ec8cba713defe7f12ae05cc032d9bce19101c25e046af9d8dda1067c4ac"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc9/vaultx_Darwin_arm64.tar.gz"
      sha256 "e10c71a059d43b19649b46ae7ac7eb0e8cd2763b45e293cde6f5e0636bcc1cef"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc9/vaultx_Linux_x86_64.tar.gz"
        sha256 "dd211a66cf87a58759a998744e5b7a7cffb5503a5d35a6e06259ef23abb890fe"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc9/vaultx_Linux_arm64.tar.gz"
        sha256 "8b3bc79d8f2a6c6ce5abe298ea0623c87755e2d9d29d211110eedeaeb26111b7"
      end
    end
  end

  def install
    bin.install "vaultx"
    pkgshare.install "VAULTX_USER_GUIDE.md"
  end

  test do
    assert_match "zero-trust vault", shell_output("#{bin}/vaultx --help")
    assert_match "0.1.0-rc9", shell_output("#{bin}/vaultx version")
  end
end
