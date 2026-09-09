<section class="tap-hero">
  <p class="tap-eyebrow">HOMEBREW TAP · LOCAL TOOLS · CROSS-PLATFORM</p>
  <h1>Tools for the work happening on your machine.</h1>
  <p class="tap-lede">One tap for local Kubernetes, AI-assisted development, and encrypted secrets. Install a focused tool, run it locally, and keep your workflow moving.</p>
  <div class="tap-actions">
    <a class="tap-button tap-button-primary" href="getting-started/">Get started</a>
    <a class="tap-button tap-button-secondary" href="taps/">Browse formulas</a>
  </div>
</section>

<section class="tap-terminal" aria-label="Homebrew installation example">
  <div class="terminal-bar"><span></span><span></span><span></span><strong>~/workspace</strong></div>
  <pre><code><span class="terminal-prompt">$</span> brew tap gautampachnanda101/tap
<span class="terminal-prompt">$</span> brew install k3d-local
<span class="terminal-prompt">$</span> k3d-local create --with-traefik
<span class="terminal-success">ready</span>  local cluster available at https://dashboard.127.0.0.1.sslip.io</code></pre>
</section>

## One tap. Three useful binaries.

The catalog is intentionally small: tools that remove repeated setup work from local development without requiring an account or a hosted control plane.

<div class="formula-grid">
  <article class="formula-item">
    <p class="formula-number">01</p>
    <h3>k3d-local</h3>
    <p>Build a local Kubernetes environment with k3d, Traefik, optional telemetry, and ready-to-deploy service recipes.</p>
    <code>brew install k3d-local</code>
    <a href="taps/k3d-local/">Read the k3d-local guide <span aria-hidden="true">-&gt;</span></a>
  </article>
  <article class="formula-item">
    <p class="formula-number">02</p>
    <h3>Promptx</h3>
    <p>Keep AI coding context encrypted, searchable, and available across assistants, editors, and MCP clients.</p>
    <code>brew install promptx</code>
    <a href="taps/promptx/">Read the Promptx guide <span aria-hidden="true">-&gt;</span></a>
  </article>
  <article class="formula-item">
    <p class="formula-number">03</p>
    <h3>Vaultx</h3>
    <p>Inject secrets at runtime from an encrypted vault while keeping reference files safe to commit.</p>
    <code>brew install vaultx</code>
    <a href="taps/vaultx/">Read the Vaultx guide <span aria-hidden="true">-&gt;</span></a>
  </article>
</div>

## Start with the job in front of you

| You need to... | Go here |
| --- | --- |
| Install one or more formulas | [Installation](installation.md) |
| Create your first local cluster | [Getting started](getting-started.md) |
| Deploy a service into k3d | [Examples and recipes](examples.md) |
| Learn common workflows | [Usage](usage.md) |
| Find a command or flag | [Command reference](reference/commands.md) |
| Fix a setup problem | [Troubleshooting](troubleshooting.md) |

## Built to stay local

No accounts, hosted dashboard, or telemetry requirement. The tools run on your machine and the guides show the exact commands they expect.

[Source on GitHub](https://github.com/gautampachnanda101/homebrew-tap) · [Report an issue](https://github.com/gautampachnanda101/homebrew-tap/issues) · [Contributing guide](https://github.com/gautampachnanda101/homebrew-tap/blob/main/CONTRIBUTING.md)
