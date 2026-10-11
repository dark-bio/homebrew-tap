# Release template filled with the version and downloaded artifact digests.
cask "ark-emulator" do
  arch arm: "arm64", intel: "amd64"

  version "0.3.0"
  sha256 arm:   "62bfeb4ea8984f05f7657edb64ce4424c716c46f69199d2f72273fd061752be7",
         intel: "8d10de0d88e48de9e15b2e872e761393f22446124bd1433533ca912efdee6982"

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
