# Release template filled with the version and downloaded artifact digests.
cask "ark-emulator" do
  arch arm: "arm64", intel: "amd64"

  version "0.4.0"
  sha256 arm:   "e9f450ea1693ef2850f0975d2bdb76c67ef0a11581b6df93fb0dd92ec6ec8ca6",
         intel: "14f265beb7538b0c7179681b36f7de4c6781609ac3f3efeab765bd32084c0083"

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
