# Tamebar

Tamebar is a macOS menu-bar app that keeps the Mac calm while AI agents run. It shows CPU, memory and disk in
the menu bar and pauses, slows or cleans up what is using them, with a read-only `tamebar` command line.

This repository holds the Homebrew cask, the install script and the downloads. The app's source is private.
Tamebar needs macOS 14 (Sonoma) or later, on Apple silicon or Intel.

## Install

With Homebrew:

```sh
brew install --cask pfournet/tamebar/tamebar
```

Or without Homebrew, into `~/Applications` (no admin password needed):

```sh
curl -fsSL https://raw.githubusercontent.com/pFournet/homebrew-tamebar/main/install.sh | sh
```

Both put the `tamebar` command on your PATH (`tamebar --help`). The script links it from `~/.local/bin` and
tells you if that folder isn't on your PATH yet. It checks the download against the SHA-256 published with
the release and stops on a mismatch.

## "Apple could not verify Tamebar"

Tamebar isn't notarized by Apple yet, so macOS can refuse to open it the first time with "Apple could not
verify 'Tamebar' is free of malware" or "Tamebar can't be opened". Both installers already clear the
download flag that causes this, so you shouldn't see it. If you do (for example after opening the DMG from
the Releases page yourself):

- Open System Settings, Privacy & Security, scroll down to the message about Tamebar and click Open Anyway, or
- run `xattr -dr com.apple.quarantine ~/Applications/Tamebar.app` (or `/Applications/Tamebar.app` for
  Homebrew), then open it again.

Tamebar then asks for the permissions it uses (Accessibility, and Calendar, if you let it quiet agents before meetings
). They stay granted across updates.

## Update

```sh
brew upgrade --cask tamebar
```

Or run the curl command again. The app doesn't update itself yet.

## Uninstall

```sh
brew uninstall --cask tamebar          # add --zap to also remove settings and data
```

Without Homebrew: choose "Stop monitoring and quit" in Tamebar's menu, then

```sh
rm -rf ~/Applications/Tamebar.app ~/.local/bin/tamebar
rm -rf ~/Library/Application\ Support/Tamebar ~/Library/Preferences/com.tamebar.Tamebar.plist  # data, optional
```
