# typed: false
# frozen_string_literal: true

# Template — the release workflow substitutes 0.3.0, https://github.com/gautampachnanda101/vitals/releases/download/v0.3.0 and the
# __SHA_*__ placeholders and commits the result to Formula/vitals.rb in the tap.
class Vitals < Formula
  desc "Local-first system diagnostics: names your bottleneck and the fix"
  homepage "https://github.com/gautampachnanda101/vitals"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.3.0/vitals_Darwin_x86_64.tar.gz"
      sha256 "b9de08300bf8ceac27cc376d30951ec6d98f98c7be9f6d4d17435552e4f6d857"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.3.0/vitals_Darwin_arm64.tar.gz"
      sha256 "d14e7f6c9504fc6fda64ce1391b6d24ac65b7573deb0a9f86ff203aeda037c24"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.3.0/vitals_Linux_x86_64.tar.gz"
      sha256 "6b90e77dadfaad63e6590a01f40bb73250c4ff09801bd807a0846cb3a5f10255"
    end
    on_arm do
      url "https://github.com/gautampachnanda101/vitals/releases/download/v0.3.0/vitals_Linux_arm64.tar.gz"
      sha256 "6272f5182ca89deb37f44aa229ce5addc1ebfe1ed82d3a3645e26d9bab0f6c5a"
    end
  end

  def install
    bin.install "vitals"
    generate_completions_from_executable(bin/"vitals", "completion")
  end

  def caveats
    <<~EOS
      Get a verdict for this machine:
        vitals doctor

      Full guide:  vitals guide   |   per-command help:  vitals help <cmd>
    EOS
  end

  test do
    assert_match "vitals", shell_output("#{bin}/vitals version")
    assert_match "doctor", shell_output("#{bin}/vitals help")
  end
end
