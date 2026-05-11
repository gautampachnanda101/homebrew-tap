# Troubleshooting

Solutions for common issues and errors.

## Installation Issues

### "brew: command not found"

Homebrew is not installed.

**Solution:**

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# On Apple Silicon Macs, add to PATH
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### "k3d-local: command not found" after installation

Homebrew installation path not in shell PATH.

**Solution:**

```bash
# Verify installation
which k3d-local

# If empty, reload shell
exec $SHELL

# Or manually add Homebrew to PATH
export PATH=/usr/local/bin:$PATH  # Intel Macs
export PATH=/opt/homebrew/bin:$PATH  # Apple Silicon
```

### Formula not found

Tap not properly added.

**Solution:**

```bash
# Remove and re-add tap
brew untap gautampachnanda101/tap
brew tap gautampachnanda101/tap
brew install k3d-local
```

## Cluster Creation Issues

### "Docker daemon not running"

Docker/Docker Desktop is not active.

**Solution:**

**macOS:**

```bash
open -a Docker
# or: brew services start docker
```

**Linux:**

```bash
sudo systemctl start docker
sudo systemctl enable docker  # auto-start on boot
```

### "Port 80 or 443 already in use"

Another service occupies the Traefik port.

**Solution:**

```bash
# Find process using port 80
lsof -i :80
lsof -i :443

# Kill the conflicting process
kill -9 <PID>

# Or use different ports
k3d-local create --with-traefik --http-port 8080 --https-port 8443
```

### "Insufficient disk space"

Docker has limited space for images/containers.

**Solution:**

```bash
# Check disk usage
docker system df

# Clean up unused images/containers
docker system prune -a

# Free up space on host machine
# Then retry: k3d-local create
```

### "Registry pull errors"

Network issues fetching images.

**Solution:**

```bash
# Test internet connectivity
ping 8.8.8.8

# Verify Docker can pull images
docker pull nginx:latest

# Retry cluster creation
k3d-local create --with-traefik --with-apps
```

## Runtime Issues

### Cluster won't start / nodes failing

**Solution:**

```bash
# Check cluster status
k3d-local status

# View k3d cluster details
k3d cluster list
k3d node list

# Check Docker logs
docker logs <container-name>

# Delete and recreate
k3d-local delete
k3d-local create
```

### kubectl not found / not configured

kubectl is not installed or misconfigured.

**Solution:**

```bash
# Install kubectl
brew install kubectl

# Verify cluster credentials
kubectl config get-contexts

# If needed, reset kubeconfig
rm ~/.kube/config
k3d-local create  # Recreates config
```

### Services not accessible at expected URL

DNS or network configuration issue.

**Solution:**

```bash
# Verify service is deployed
kubectl get svc --all-namespaces

# Check ingress configuration
kubectl get ingress --all-namespaces

# Test DNS resolution
nslookup app.127.0.0.1.sslip.io

# Try direct curl
curl -v http://127.0.0.1:8080

# Check Traefik dashboard
curl http://dashboard.127.0.0.1.sslip.io:8080/dashboard/
```

### Persistent volume mounting issues

Host path not accessible from container.

**Solution:**

```bash
# Verify host path exists and permissions
ls -la /path/to/volume

# Use absolute paths in volumes
# Example: /Users/username/data (not ~/data)

# Check Docker Desktop volume settings
# Settings > Resources > File Sharing
```

## Performance Issues

### Cluster is slow / unresponsive

Resource constraints.

**Solution:**

```bash
# Check resource usage
kubectl top nodes
kubectl top pods --all-namespaces

# Increase Docker resource limits
# Docker Desktop Settings > Resources > Memory/CPU

# Reduce number of sample apps
k3d-local create --with-traefik  # Skip --with-apps

# Check disk I/O
iotop  # Linux, requires 'sudo apt install iotop'
```

### High memory consumption

Too many containers or memory leaks.

**Solution:**

```bash
# List all containers
docker ps -a

# Remove unnecessary containers
docker rm <container-id>

# Monitor memory
docker stats

# Restart cluster
k3d-local delete
k3d-local create
```

## Networking Issues

### Cannot reach cluster from other machines

Firewall or Docker Desktop configuration.

**Solution:**

```bash
# Check firewall rules
sudo lsof -i :8080  # macOS/Linux

# Docker Desktop uses localhost only
# To allow external access, configure port forwarding or use VPN

# Check if service is actually bound
netstat -an | grep 8080
```

### DNS not resolving (sslip.io)

Internet connectivity or DNS resolver issue.

**Solution:**

```bash
# Test DNS directly
curl http://127.0.0.1:8080 -H "Host: app.127.0.0.1.sslip.io"

# Verify sslip.io is accessible
curl https://127.0.0.1.sslip.io

# Check DNS resolver
cat /etc/resolv.conf  # Linux
networksetup -getdnsservers en0  # macOS
```

## Cleanup & Reset

### Complete Reset

```bash
# Delete cluster
k3d-local delete

# Remove Docker artifacts
docker system prune -a --volumes

# Clear kubeconfig (use with caution!)
rm ~/.kube/config

# Reinstall
brew uninstall k3d-local
brew install k3d-local

# Start fresh
k3d-local create --with-traefik --with-apps
```

### Cleanup Stray Resources

```bash
# List all k3d clusters
k3d cluster list

# Delete specific cluster
k3d cluster delete <cluster-name>

# Remove all k3d resources
k3d cluster delete --all

# Prune Docker
docker system prune -a
```

## Promptx Issues

### "promptx: command not found" after installation

```bash
which promptx
exec $SHELL
brew --prefix promptx
```

### Vault locked / passkey error

```bash
# Set passkey explicitly
export PROMPTX_PASSKEY="your-secure-key"

# Or reinitialize (loses existing memory)
promptx setup
```

### Memory capture not persisting

```bash
# Run health checks
promptx doctor
promptx machine verify

# Check vault status
promptx info

# Force-store on next capture
promptx memory-watch --repo . --interval 5 --force-store
```

### MCP server not connecting

```bash
promptx mcp status
promptx mcp-guard   # restart with auto-restart
```

## Vaultx Issues

### "vaultx: command not found" after installation

```bash
which vaultx
exec $SHELL
brew reinstall vaultx
```

### Vault locked after failed unlock attempts

After 5 failed attempts the vault locks for 30 minutes. Use a recovery code if MFA is enabled, or wait out the lockout.

### Web UI not loading at port 7474

```bash
# Ensure daemon is running
vaultx serve

# Use a custom port if 7474 is taken
vaultx serve --port 8080
```

### Secrets not injecting into process

```bash
# Verify vault is unlocked first
vaultx unlock

# Check the secret exists
vaultx list

# Then inject
vaultx run -- your-command
```

## Getting Help

### Gather Debug Information

```bash
# System info
uname -a
docker --version
k3d version

# Cluster status
k3d-local status
kubernetes version

# Recent logs
docker logs <container-name>
kubectl describe pod <pod-name> -n <namespace>

# Full debug output
k3d-local create --verbose 2>&1 | tee debug.log
```

### Report Issues

- [GitHub Issues](https://github.com/gautampachnanda101/homebrew-tap/issues)

Include:

- System info (OS, Docker version)
- Full error output
- Steps to reproduce
- Output of debug commands above
