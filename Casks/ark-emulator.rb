# Release template filled with the version and downloaded artifact digests.
cask "ark-emulator" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.0"
  sha256 arm:   "e09a0b1745aa03cf14fc5c830e48861c9b3e92747c07536ae12b28b51d4fbf15",
         intel: "97dc3b6aff749f600e3850fd3d808edffea4e0266c5dc66983efbb105635d96c"

  url "https://github.com/dark-bio/emulator/releases/download/v#{version}/ark-emulator-#{version}-macos-#{arch}.dmg"
  name "Ark Emulator"
  desc "Emulated Ark enclave"
  homepage "https://dark.bio"

  depends_on macos: :sequoia

  app "Ark Emulator.app"
  # The launcher resolves its bundled QEMU and firmware from the path it was
  # started by, which a plain symlink would break.
  command_wrapper "ark-emulator",
                  executable: "#{appdir}/Ark Emulator.app/Contents/MacOS/ark-emulator"
end
