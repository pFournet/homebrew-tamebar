cask "tamebar" do
  version "0.1.0"
  sha256 "18d3b1f95e01bd5a5470b2113d279fe2d04bd105d48fcd42496158ffb328b80c"

  url "https://github.com/pFournet/homebrew-tamebar/releases/download/v#{version}/Tamebar-#{version}.dmg"
  name "Tamebar"
  desc "Menu bar monitor that keeps AI coding agents from overwhelming the computer"
  homepage "https://github.com/pFournet/homebrew-tamebar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Tamebar.app"
  binary "#{appdir}/Tamebar.app/Contents/MacOS/Tamebar", target: "tamebar"

  # Tamebar is signed but not notarized yet, so Gatekeeper refuses to open a quarantined copy.
  # Clear the quarantine flag Homebrew sets, on the installed app only. Notarized releases
  # will replace this.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-d", "-r", "com.apple.quarantine", "{{appdir}}/Tamebar.app"],
        must_succeed: false
  end

  # Tamebar answers a plain Quit by closing its window and keeping on monitoring, so the quit
  # request is followed by SIGTERM.
  uninstall quit:   "com.tamebar.Tamebar",
            signal: [
              ["TERM", "com.tamebar.Tamebar"],
              ["TERM", "com.tamebar.Tamebar.Emergency"],
            ]

  zap trash: [
    "~/Library/Application Support/Tamebar",
    "~/Library/Caches/com.tamebar.Tamebar",
    "~/Library/HTTPStorages/com.tamebar.Tamebar",
    "~/Library/Preferences/com.tamebar.Tamebar.plist",
  ]
end
