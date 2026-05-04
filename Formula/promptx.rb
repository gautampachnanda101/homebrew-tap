# typed: false
# frozen_string_literal: true

class Promptx < Formula
  desc "Local-first prompt intelligence connector for AI coding assistants"
  homepage "https://github.com/gautampachnanda101/prompt-detective"
  version "0.1.0-rc119"

  on_macos do
    on_intel do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc119/promptx_Darwin_x86_64.tar.gz"
      sha256 "1d5f52fa5bb97c29baec62e43ca8c1ba8b33a6dd89f9fe3f84c4a48b8d06dc17"
    end

    on_arm do
      url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc119/promptx_Darwin_arm64.tar.gz"
      sha256 "0ce210f831c5cb1149098292c2c3601bfeb08edef46c15c69591f35398fedc0c"
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc119/promptx_Linux_x86_64.tar.gz"
        sha256 "04e6bb6e057b14516a909f357896e3652c69444999fb0a9acd859e0d8b8f1c0d"
      end
    end

    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gautampachnanda101/homebrew-tap/releases/download/v0.1.0-rc119/promptx_Linux_arm64.tar.gz"
        sha256 "9c54a30cab4475a01a538224f1487229fb873cdb10b670753d08d346ac2e3174"
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
    # Auto-install extension into every detected VS Code-compatible editor.
    vsix = Dir["#{share}/promptx/promptx-vscode-*.vsix"].first
    return if vsix.nil?
    installed = []
    %w[code cursor codium code-insiders windsurf trae void].each do |editor|
      next unless (ep = which(editor))
      if system(ep.to_s, "--install-extension", vsix, "--force",
                 out: File::NULL, err: File::NULL)
        installed << editor
      end
    end
    unless installed.empty?
      opoo "Promptx extension installed into: #{installed.join(", ")}"
    end
  end

  def caveats
    vsix = Dir["#{share}/promptx/promptx-vscode-*.vsix"].first
    vsix_name = vsix ? File.basename(vsix) : "promptx-vscode-<version>.vsix"
    vsix_path = vsix || "#{share}/promptx/#{vsix_name}"
    <<~EOS
      ── Background service ────────────────────────────────────────────
        brew services start promptx    # start now and on every login
        brew services stop promptx     # stop
        brew services restart promptx  # restart after config change

      Or run once without launchd:
        #{opt_bin}/promptx serve

      Web UI opens at http://localhost:17171 once the service is running.

      ── Coding-assistant extension ────────────────────────────────────
      The extension is installed automatically into any detected editor.
      Supported editors (VS Code-compatible CLI install):
        VS Code · Cursor · VSCodium · VS Code Insiders · Windsurf · Trae · Void

      If your editor was not detected, install manually:
        code      --install-extension #{vsix_path} --force
        cursor    --install-extension #{vsix_path} --force
        codium    --install-extension #{vsix_path} --force
        windsurf  --install-extension #{vsix_path} --force
        trae      --install-extension #{vsix_path} --force

      For JetBrains IDEs, install the VS Code extension via the
      JetBrains Marketplace or use the Promptx CLI directly.

      ── First run ─────────────────────────────────────────────────────
        promptx setup            # create encrypted vault + passkey
        promptx serve            # start the UI server
        promptx ui               # open http://localhost:17171 in browser
        promptx doctor           # verify everything is configured

      Docs: promptx help  |  promptx <cmd> --help
    EOS
  end

  test do
    assert_match "Local-first encrypted prompt intelligence CLI", shell_output("#{bin}/promptx --help")
    assert_match "0.1.0-rc119", shell_output("#{bin}/promptx version")
  end
end
