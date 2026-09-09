# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.8.0-rc1"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.8.0-rc1/promptx_Darwin_x86_64.tar.gz"
      sha256 "55061d4e4489292d8b4cf1d867b076d6d1cb84912bf0e18982909f96094830e1"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.8.0-rc1/promptx_Darwin_arm64.tar.gz"
      sha256 "2c88a1862f71f369aa80ff1d6680c16dd6056e8814e1c5a8a075f9ff9f76c4a6"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.8.0-rc1/promptx_Linux_x86_64.tar.gz"
        sha256 "e10085255cd4576e9e75e1af165c9c8df1bfad4c3663c7a59d4fd8f459e265da"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.8.0-rc1/promptx_Linux_arm64.tar.gz"
        sha256 "8448b53bd48ca2b91a5cf05e0ee5aa549d42292f4e1aec49a92383ba73c3d32f"
      end
    end
  end

  # Install prebuilt binaries from release tarball
  def install
    bin.install "promptx"
    (share/"promptx").install Dir["promptx-vscode-*.vsix"]
    doc.install "PROMPTX_USER_GUIDE.md" if File.exist?("PROMPTX_USER_GUIDE.md")
  end

  # Homebrew service enables brew services start promptx.
  # When active, launchd owns the lifecycle and auto-restarts after upgrade.
  service do
    run [opt_bin/"promptx", "serve"]
    keep_alive true
    log_path var/"log/promptx.log"
    error_log_path var/"log/promptx.log"
    working_dir Dir.home
  end

  def caveats
    <<~EOS
      ── Background service ────────────────────────────────────────────
        brew services start promptx    # start now and on every login
        brew services stop promptx     # stop
        brew services restart promptx  # restart after config change

      Or run once without launchd:
        #{opt_bin}/promptx serve

      Web UI opens at http://localhost:17171 once the service is running.

      ── Coding-assistant extension ────────────────────────────────────
      Install the bundled extension into every detected editor:
        promptx extension install

      It is published on Open VSX (VSCodium, Windsurf, Cursor, ...).
      Detected editors: VS Code · Cursor · VSCodium · VS Code Insiders · Windsurf · Kiro

      After each 'brew upgrade promptx', re-run 'promptx extension install'
      (or 'promptx update') so the extension matches the CLI.

      ── First run ─────────────────────────────────────────────────────
        promptx setup            # create encrypted vault + passkey
        promptx serve            # start the UI server
        promptx ui               # open http://localhost:17171 in browser
        promptx doctor           # verify everything is configured

      Docs: https://gautampachnanda101.github.io/homebrew-tap/
    EOS
  end

  test do
    assert_match "promptx", shell_output("#{bin}/promptx --help")
    assert_match(/\d+\.\d+\.\d+/, shell_output("#{bin}/promptx version"))
  end
end
