# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.13.7"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.13.7/promptx_Darwin_x86_64.tar.gz"
      sha256 "04040a72b314c2571318b916d92639b8cdb874f5bbc192738aa0f644b4d14c0f"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.13.7/promptx_Darwin_arm64.tar.gz"
      sha256 "a281852a60c5ee39045cde17358bb86ca405da12f1cffa0bb9237910cef26509"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.13.7/promptx_Linux_x86_64.tar.gz"
        sha256 "226e09cb918bc6ed20874665cfa27542239a872daba5708a1072cb309439a0d9"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.13.7/promptx_Linux_arm64.tar.gz"
        sha256 "0c0703bed3aab57fea58bf88fadabf3781a029be187efff4e388d9b92a01e077"
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
    assert_match(/\d+\.\d+\.\d+/, shell_output("#{bin}/promptx --version"))
  end
end
