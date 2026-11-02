cask "tamebar" do
  version "0.2.0"
  sha256 "e0d7cb21384ebf7eb03f616fb8b6020b560521b81a4f7e5ad806e8ed17db1f36"

  url "https://github.com/pFournet/tamebar/releases/download/v#{version}/Tamebar-#{version}.dmg"
  name "Tamebar"
  desc "Menu bar monitor that keeps AI coding agents from overwhelming the computer"
  homepage "https://github.com/pFournet/tamebar"

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
