# Release template filled with the version and downloaded artifact digests.
cask "ark-emulator" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.1"
  sha256 arm:   "d37987db66f81e31236d76f8cec5ba5ac162a95d8d0951a6beb8a83c511da490",
         intel: "ec268501efb0e22c9ff9b8ea7fd881d6278cbef16ad47f5248b9c2c36e210bf4"

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
