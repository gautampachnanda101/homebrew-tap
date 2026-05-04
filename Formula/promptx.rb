# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc117"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc117/promptx_Darwin_x86_64.tar.gz"
      sha256 "1bf3b5a71420956b59810728bff2ea364c2b0ce151c7aa4c91c5db8296711f94"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc117/promptx_Darwin_arm64.tar.gz"
      sha256 "34263c4a3b37a787163a40fbef61467787b4cd8992109ac0e7ce2a29ecd2b654"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc117/promptx_Linux_x86_64.tar.gz"
        sha256 "3233d0620f8d5664679df4e7058dea997725a5898c8f40f93c90e36e13c07c4f"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc117/promptx_Linux_arm64.tar.gz"
        sha256 "ef2a8465afd35a714fbf2e98bc9dd42db50d5e25d3a92d6fc8c33670065dedfe"
      end
    end
  end

  # Install prebuilt binaries from release tarball
  def install
    bin.install "promptx"
    (share/"promptx").install Dir["promptx-vscode-*.vsix"]
    doc.install "PROMPTX_USER_GUIDE.md" if File.exist?("PROMPTX_USER_GUIDE.md")
  end

  # Homebrew service — enables .
  # When active, launchd owns the lifecycle and auto-restarts after upgrade.
  service do
    run [opt_bin/"promptx", "serve"]
    keep_alive true
    log_path var/"log/promptx.log"
    error_log_path var/"log/promptx.log"
    working_dir Dir.home
  end

  def post_install
    # Bounce any running serve process so the new binary takes over immediately.
    IO.popen(["lsof", "-ti", "tcp:17171"], err: [:child, :out]) do |io|
      io.read.split.each { |pid| Process.kill("TERM", pid.to_i) rescue nil }
    end
    sleep 1
    # If not managed by brew services, restart manually in background.
    unless system("launchctl", "list", "homebrew.mxcl.promptx",
                  out: File::NULL, err: File::NULL)
      pid = spawn((opt_bin/"promptx").to_s, "serve", [:out, :err] => "/dev/null")
      Process.detach(pid)
    end
    # Auto-install VS Code extension for all detected editors.
    vsix = Dir["#{share}/promptx/promptx-vscode-*.vsix"].first
    return if vsix.nil?
    %w[code cursor codium code-insiders windsurf].each do |editor|
      next unless (ep = which(editor))
      system ep.to_s, "--install-extension", vsix, "--force",
             out: File::NULL, err: File::NULL
    end
  end

  def caveats
    <<~EOS
      To manage the Promptx UI server as a background service:
        brew services start promptx   # start and persist across reboots
        brew services stop promptx    # stop
        brew services restart promptx # restart

      The VS Code extension is installed automatically on upgrade.
      If it was not detected, install manually:
        #{Dir["#{share}/promptx/promptx-vscode-*.vsix"].first}
    EOS
  end

  test do
    assert_match "Local-first encrypted prompt intelligence CLI", shell_output("#{bin}/promptx --help")
    assert_match "0.1.0-rc117", shell_output("#{bin}/promptx version")
  end
end
