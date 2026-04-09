class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  url "https://github.com/gautampachnanda101/prompt-detective/archive/refs/tags/v0.1.0-rc3.tar.gz"
  sha256 "297e948e15747b5163520c3d56be4bc8eb6e3f881e82f003e21c098decaad693"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/promptx"
  end

  test do
    assert_match "Local-first encrypted prompt intelligence CLI", shell_output("#{bin}/promptx --help")
  end
end
