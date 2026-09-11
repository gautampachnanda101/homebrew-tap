<section class="catalog-hero">
	<h1>Choose the tool for the job.</h1>
	<p>Local tools for Kubernetes, AI-assisted development, knowledge, secrets, and diagnostics.</p>
</section>

<div class="catalog-list">
	<article class="catalog-item">
		<p class="catalog-number">01</p>
		<div>
			<h2><a href="https://gautampachnanda101.github.io/homebrew-tap/taps/k3d-local/">k3d-local</a></h2>
			<p>Build local Kubernetes clusters with k3d, Traefik, optional telemetry, and ready-to-deploy service recipes.</p>
		</div>
		<pre class="catalog-install"><code>brew install k3d-local
	k3d-local create --with-traefik</code></pre>
	</article>
	<article class="catalog-item">
		<p class="catalog-number">02</p>
		<div>
			<h2><a href="https://gautampachnanda101.github.io/homebrew-tap/taps/promptx/">Promptx</a></h2>
			<p>Keep AI coding context encrypted, searchable, and available across assistants, editors, and MCP clients.</p>
		</div>
		<pre class="catalog-install"><code>brew install promptx
	promptx setup</code></pre>
	</article>
	<article class="catalog-item">
		<p class="catalog-number">03</p>
		<div>
			<h2><a href="https://gautampachnanda101.github.io/homebrew-tap/taps/vaultx/">Vaultx</a></h2>
			<p>Inject secrets at runtime from an encrypted vault while keeping reference files safe to commit.</p>
		</div>
		<pre class="catalog-install"><code>brew install vaultx
	vaultx init --biometric</code></pre>
	</article>
	<article class="catalog-item">
		<p class="catalog-number">04</p>
		<div>
			<h2><a href="https://gautampachnanda101.github.io/homebrew-tap/taps/kb-genie/">kb-genie</a></h2>
			<p>Build a local knowledge base with pluggable embeddings and a browser chat interface.</p>
		</div>
		<pre class="catalog-install"><code>brew install kb-genie
	kb-genie doctor</code></pre>
	</article>
	<article class="catalog-item">
		<p class="catalog-number">05</p>
		<div>
			<h2><a href="https://gautampachnanda101.github.io/homebrew-tap/taps/ai-guardrails/">ai-guardrails</a></h2>
			<p>Standardize AI development guardrails, skills, tools, and CI/CD templates.</p>
		</div>
		<pre class="catalog-install"><code>brew install ai-guardrails
	ai-guardrails --help</code></pre>
	</article>
	<article class="catalog-item">
		<p class="catalog-number">06</p>
		<div>
			<h2><a href="https://gautampachnanda101.github.io/vitals/">vitals</a></h2>
			<p>Diagnose the bottleneck on your machine and get the next command to run.</p>
		</div>
		<pre class="catalog-install"><code>brew install vitals
	vitals doctor</code></pre>
	</article>
</div>

## Install the tap

```bash
brew tap gautampachnanda101/tap
brew search gautampachnanda101/tap/
```

## Verify an installation

```bash
brew list | grep -E "k3d-local|promptx|vaultx|kb-genie|ai-guardrails|vitals"
brew info <formula-name>
```

## Common troubleshooting

<div class="catalog-tools" markdown>

### Formula not found

```bash
brew untap gautampachnanda101/tap
brew tap gautampachnanda101/tap
brew update
```

### Binary not found after install

```bash
brew --prefix
which k3d-local || true
which promptx || true
which vaultx || true
exec $SHELL
```

</div>
