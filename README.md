# Dark Bio Homebrew Tap

[Homebrew](https://brew.sh/) formulae and casks for macOS, maintained by
[Dark Bio](https://dark.bio).

## Packages

| Package | Description |
| --- | --- |
| [`ark-cli`](https://github.com/dark-bio/cli) | Command-line interface for Ark devices and emulators |
| [`ark-emulator`](https://github.com/dark-bio/emulator) | Desktop Ark emulator for development and testing |

## Installation

With the following commands, you can install the latest version of each product:

```sh
# Formulae
brew install dark-bio/tap/ark-cli # note, the command will be ark

# Casks
brew install --cask dark-bio/tap/ark-emulator
```

## Updating

Refresh Homebrew's package definitions, then upgrade the installed package:

```sh
# Homebrew
brew update

# Formulae
brew upgrade dark-bio/tap/ark-cli

# Casks
brew upgrade --cask dark-bio/tap/ark-emulator
```

## Reporting issues

Report installation issues in [this repository](https://github.com/dark-bio/homebrew-tap/issues).
For issues with the software itself, use the
[Dark Bio: Ark CLI](https://github.com/dark-bio/cli/issues) or
[Dark Bio: Ark Emulator](https://github.com/dark-bio/emulator/issues) issue trackers.

For help with Homebrew, see the [Homebrew documentation](https://docs.brew.sh/).
