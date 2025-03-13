# Repomix Nix

This repository contains Nix definitions for building, running, and installing the Repomix tool (https://Repomix.com/).

## Structure

- `default.nix` - The Nix definition for building Repomix
- `flake.nix` - Flake-based interface for Repomix
- `regenerate.sh` - Script to regenerate the Nix definitions when needed
- `home-manager-module.nix` - Module for installing Repomix via Home Manager

## Usage

### Running Repomix

There are several ways to run Repomix:

#### Using Nix Flakes (recommended)

```bash
nix run .
```

#### Using Traditional Nix

```bash
nix-build
./result/bin/repomix
```

Or:

```bash
nix-shell -p '(import ./default.nix {})' --run repomix
```

### Installation

#### Using Home Manager

Add the following to your Home Manager configuration:

```nix
imports = [
  /path/to/repomix-nix/home-manager-module.nix
];

programs.repomix.enable = true;
```

#### Manual Installation

You can build and install Repomix to your profile:

```bash
nix-env -f default.nix -i
```

Or with flakes:

```bash
nix profile install
```

## Development

To update repomix when new versions are published, run `./regenerate.sh` to rebuild nix definitions based
on the latest published version.

