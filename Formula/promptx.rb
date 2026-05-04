# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc118"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc118/promptx_Darwin_x86_64.tar.gz"
      sha256 "53f275d4e707680f58231ff4d08a80b5117ab9625cbe617c78963a05e0da7e1f"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc118/promptx_Darwin_arm64.tar.gz"
      sha256 "7d09310d258393c034708f0986ddf0900112b4bf6a921b4b90dca8491d92cf8a"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc118/promptx_Linux_x86_64.tar.gz"
        sha256 "cb756cef13fdc348cd62c9857e2e194be81710d6aeee2eec1b4e2fa3bfed55f2"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc118/promptx_Linux_arm64.tar.gz"
        sha256 "9fc3ba84461d7c95d2da3320ef478b26d445bf048ea1a7af708586853f7c2aee"
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
    assert_match "0.1.0-rc118", shell_output("#{bin}/promptx version")
  end
end
