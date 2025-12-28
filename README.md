# nar

[![CI](../../actions/workflows/ci.yaml/badge.svg)](../../actions/workflows/ci.yaml)

A Command-Line Interface (CLI) in Go for Generating Reproducible [Nix Archive (NAR)](https://nixos.org/manual/nix/stable/glossary#gloss-nar) Files and [Subresource Integrity (SRI)](https://en.wikipedia.org/wiki/Subresource_Integrity) Hashes

## Installation

### Using Nix

If you have Nix with flakes enabled:

```bash
nix run github:dxcontainer/nar#nar -- <directory>
```

Or install it to your profile:

```bash
nix profile install github:dxcontainer/nar
```

### Using Go

```bash
go install github.com/dxcontainer/nar@latest
```

### Building from Source

```bash
git clone https://github.com/dxcontainer/nar.git
cd nar
go build
```

## Usage

### Generate NAR File

Write a NAR archive of a directory to stdout:

```bash
nar /path/to/directory > output.nar
```

### Generate SRI Hash

Calculate the SRI hash of a directory without creating the NAR file:

```bash
nar --sri /path/to/directory
# Output: sha256-...base64...
```

### Real-World Example: Generating SRI Hashes for Go Vendored Dependencies

A common use case is generating reproducible hashes for vendored Go dependencies in Nix packages. Here's how [Tailscale uses nar](https://github.com/tailscale/tailscale/blob/d451cd54a70152a95ad708592a981cb5e37395a8/update-flake.sh):

```bash
# Create temporary directory for vendored dependencies
OUT=$(mktemp -d -t nar-hash-XXXXXX)

# Vendor Go modules to the temporary directory
go mod vendor -o "$OUT"

# Generate SRI hash and save to file
nar --sri "$OUT" > go.mod.sri

# Clean up temporary directory
rm -rf "$OUT"
```

The hash in `go.mod.sri` can then be used in Nix as the `vendorHash` of `buildGoModule`.

## Development

This project uses [Task](https://taskfile.dev) as a task runner.

### Available Tasks

```bash
# Run default tasks (lint, build and test)
task

# Build the project
task build

# Run Go tests
task test

# Format Go code
task fmt

# Run Go linter
task lint

# Clean build artifacts
task clean

# Run the tool
task run -- /path/to/directory
task run:sri -- /path/to/directory
```

## License

This project is licensed under the BSD-3-Clause License. See the [LICENSE](LICENSE) file for details.
